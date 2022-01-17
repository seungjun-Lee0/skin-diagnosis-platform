#include "SkinSensor.h"
#include "Config.h"
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <cmath>
#include <cstring>
#include <thread>
#include <iostream>

//==============================================================================
// Platform-specific simulation implementation
// In production: Replace with actual HAL implementation (bcm2835, wiringPi, etc.)
//==============================================================================

#ifdef PLATFORM_SIMULATION

namespace HAL {

/**
 * Simulation I2C Interface
 * Generates realistic sensor values for testing without hardware
 */
class SimulationI2C : public I2CInterface {
public:
    bool initialize(int busNumber) override {
        std::cout << "[SIM] I2C bus " << busNumber << " initialized" << std::endl;
        return true;
    }

    void cleanup() override {
        std::cout << "[SIM] I2C cleanup" << std::endl;
    }

    bool writeRegister(uint8_t deviceAddr, uint8_t regAddr, uint8_t value) override {
        // Simulate successful write
        return true;
    }

    bool writeRegister16(uint8_t deviceAddr, uint8_t regAddr, uint16_t value) override {
        return true;
    }

    uint8_t readRegister(uint8_t deviceAddr, uint8_t regAddr) override {
        // Return simulated values based on device address
        return 0x00;
    }

    uint16_t readRegister16(uint8_t deviceAddr, uint8_t regAddr) override {
        // Simulate ADC values (ADS1115)
        if (deviceAddr == I2C::ADDR_PHOTODIODE_ADC && regAddr == ADC::REG_CONVERSION) {
            // Return random ADC value in realistic range
            return 20000 + (std::rand() % 10000);
        }
        return 0x0000;
    }

    bool readBytes(uint8_t deviceAddr, uint8_t* buffer, size_t length) override {
        // Simulate SHT31 humidity/temperature response
        if (deviceAddr == I2C::ADDR_MOISTURE_SENSOR && length >= 6) {
            // Temperature: ~25°C, Humidity: ~50%
            buffer[0] = 0x64; buffer[1] = 0x00; buffer[2] = 0x00;  // Temp
            buffer[3] = 0x80; buffer[4] = 0x00; buffer[5] = 0x00;  // Humidity
            return true;
        }
        return true;
    }

    bool isDevicePresent(uint8_t deviceAddr) override {
        // All simulated devices are present
        return true;
    }
};

/**
 * Simulation GPIO Interface
 */
class SimulationGPIO : public GPIOInterface {
public:
    bool initialize() override {
        std::cout << "[SIM] GPIO initialized" << std::endl;
        return true;
    }

    void cleanup() override {}

    bool setDirection(int pin, Direction dir) override { return true; }
    bool setPullMode(int pin, PullMode mode) override { return true; }
    bool write(int pin, bool value) override { return true; }
    bool read(int pin) override { return false; }
    bool setPWM(int pin, int frequency, int dutyCycle) override { return true; }
    bool stopPWM(int pin) override { return true; }
    bool setInterrupt(int pin, Edge edge, void (*callback)(int, void*), void* userData) override {
        return true;
    }
};

// Factory functions
I2CInterface* createI2CInterface() { return new SimulationI2C(); }
GPIOInterface* createGPIOInterface() { return new SimulationGPIO(); }
bool isSimulationMode() { return true; }

} // namespace HAL

#endif // PLATFORM_SIMULATION

//==============================================================================
// SkinSensor Implementation
//==============================================================================

SkinSensor::SkinSensor()
    : m_initialized(false)
    , m_lastTemperature(25.0f)
{
    std::srand(static_cast<unsigned>(std::time(nullptr)));

    // Initialize calibration with defaults
    std::memset(&m_calibration, 0, sizeof(m_calibration));
    m_calibration.magic = 0x54483330;  // "TH30"
    m_calibration.version = 1;
    m_calibration.pdOffset1 = Config::Calibration::PD_SENSOR_OFFSET;
    m_calibration.pdOffset2 = Config::Calibration::PD_SENSOR_OFFSET;
    m_calibration.moistureScale = Config::Calibration::MOISTURE_SCALE;
    m_calibration.moistureOffset = Config::Calibration::MOISTURE_OFFSET;
    m_calibration.elasticityScale = Config::Calibration::ELASTICITY_SCALE;
    m_calibration.elasticityOffset = Config::Calibration::ELASTICITY_OFFSET;
    m_calibration.thicknessScale = Config::Calibration::THICKNESS_SCALE;
    m_calibration.thicknessOffset = Config::Calibration::THICKNESS_OFFSET;
}

SkinSensor::~SkinSensor()
{
    if (m_gpio) {
        // Disable sensor power
        m_gpio->write(HAL::GPIO::PIN_SENSOR_POWER, false);
        m_gpio->cleanup();
    }
    if (m_i2c) {
        m_i2c->cleanup();
    }
}

bool SkinSensor::initialize()
{
    std::cout << "[SkinSensor] Initializing..." << std::endl;

    // Create HAL interfaces
    m_i2c.reset(HAL::createI2CInterface());
    m_gpio.reset(HAL::createGPIOInterface());

    // Initialize GPIO
    if (!m_gpio->initialize()) {
        std::cerr << "[SkinSensor] GPIO initialization failed" << std::endl;
        return false;
    }

    // Configure GPIO pins
    m_gpio->setDirection(HAL::GPIO::PIN_SENSOR_POWER, HAL::GPIOInterface::Direction::OUTPUT);
    m_gpio->setDirection(HAL::GPIO::PIN_LED_STATUS, HAL::GPIOInterface::Direction::OUTPUT);
    m_gpio->setDirection(HAL::GPIO::PIN_ADC_DRDY, HAL::GPIOInterface::Direction::INPUT);

    // Enable sensor power
    m_gpio->write(HAL::GPIO::PIN_SENSOR_POWER, true);
    std::this_thread::sleep_for(std::chrono::milliseconds(Config::Hardware::SENSOR_WARMUP_MS));

    // Initialize I2C bus
    if (!m_i2c->initialize(Config::Hardware::I2C_BUS)) {
        std::cerr << "[SkinSensor] I2C initialization failed" << std::endl;
        return false;
    }

    // Verify all sensors are present
    std::cout << "[SkinSensor] Checking sensors..." << std::endl;

    if (!m_i2c->isDevicePresent(HAL::I2C::ADDR_PHOTODIODE_ADC)) {
        std::cerr << "[SkinSensor] ADC (ADS1115) not found at 0x48" << std::endl;
        return false;
    }
    std::cout << "  [OK] ADC (ADS1115) at 0x48" << std::endl;

    if (!m_i2c->isDevicePresent(HAL::I2C::ADDR_MOISTURE_SENSOR)) {
        std::cerr << "[SkinSensor] Moisture sensor (SHT31) not found at 0x44" << std::endl;
        return false;
    }
    std::cout << "  [OK] Moisture sensor (SHT31) at 0x44" << std::endl;

    if (!m_i2c->isDevicePresent(HAL::I2C::ADDR_ELASTICITY_SENSOR)) {
        std::cerr << "[SkinSensor] ToF sensor (VL6180X) not found at 0x29" << std::endl;
        return false;
    }
    std::cout << "  [OK] ToF sensor (VL6180X) at 0x29" << std::endl;

    // Load calibration from EEPROM
    if (m_i2c->isDevicePresent(HAL::I2C::ADDR_EEPROM)) {
        std::cout << "  [OK] EEPROM (AT24C256) at 0x50" << std::endl;
        loadCalibration();
    } else {
        std::cout << "  [WARN] EEPROM not found, using default calibration" << std::endl;
    }

    // Configure ADC (ADS1115)
    // Config: Single-shot, AIN0, +/-4.096V, 128 SPS
    uint16_t adcConfig = HAL::ADC::CFG_OS_SINGLE |
                         HAL::ADC::CFG_MUX_AIN0 |
                         HAL::ADC::CFG_PGA_4V |
                         HAL::ADC::CFG_MODE_SINGLE |
                         HAL::ADC::CFG_DR_128SPS;
    i2cWriteRegister16(HAL::I2C::ADDR_PHOTODIODE_ADC, HAL::ADC::REG_CONFIG, adcConfig);

    // Status LED on
    m_gpio->write(HAL::GPIO::PIN_LED_STATUS, true);

    m_initialized = true;
    std::cout << "[SkinSensor] Initialization complete" << std::endl;

    return true;
}

void SkinSensor::setPatientInfo(const std::string& name, const std::string& birthDate)
{
    m_patientName = name;
    m_birthDate = birthDate;
}

bool SkinSensor::calibrate()
{
    if (!m_initialized) {
        return false;
    }

    std::cout << "[SkinSensor] Starting calibration..." << std::endl;
    std::cout << "  Place sensor on calibration reference surface" << std::endl;

    // Read multiple samples for averaging
    const int numSamples = 10;
    float pd1Sum = 0, pd2Sum = 0;

    for (int i = 0; i < numSamples; i++) {
        pd1Sum += readADC(0);
        pd2Sum += readADC(1);
        std::this_thread::sleep_for(std::chrono::milliseconds(100));
    }

    // Calculate offsets (assuming reference surface gives known values)
    m_calibration.pdOffset1 = 100.0f - (pd1Sum / numSamples);
    m_calibration.pdOffset2 = 100.0f - (pd2Sum / numSamples);

    // Update calibration timestamp
    m_calibration.lastCalibrationDate = static_cast<uint32_t>(std::time(nullptr));

    // Save to EEPROM
    if (!saveCalibration()) {
        std::cerr << "[SkinSensor] Warning: Failed to save calibration to EEPROM" << std::endl;
    }

    std::cout << "[SkinSensor] Calibration complete" << std::endl;
    std::cout << "  PD1 offset: " << m_calibration.pdOffset1 << std::endl;
    std::cout << "  PD2 offset: " << m_calibration.pdOffset2 << std::endl;

    return true;
}

bool SkinSensor::loadCalibration()
{
    // Read calibration data from EEPROM
    uint8_t buffer[sizeof(CalibrationData)];

    if (!m_i2c->readBytes(HAL::I2C::ADDR_EEPROM, buffer, sizeof(buffer))) {
        return false;
    }

    CalibrationData* data = reinterpret_cast<CalibrationData*>(buffer);

    // Validate magic number
    if (data->magic != 0x54483330) {
        std::cout << "[SkinSensor] No valid calibration data in EEPROM" << std::endl;
        return false;
    }

    // Validate CRC
    uint16_t storedCRC = data->checksum;
    data->checksum = 0;
    uint16_t calculatedCRC = calculateCRC16(buffer, sizeof(buffer));

    if (storedCRC != calculatedCRC) {
        std::cout << "[SkinSensor] Calibration data CRC mismatch" << std::endl;
        return false;
    }

    // Copy validated data
    std::memcpy(&m_calibration, data, sizeof(CalibrationData));
    std::cout << "[SkinSensor] Calibration loaded from EEPROM" << std::endl;

    return true;
}

bool SkinSensor::saveCalibration()
{
    // Calculate CRC
    m_calibration.checksum = 0;
    m_calibration.checksum = calculateCRC16(
        reinterpret_cast<uint8_t*>(&m_calibration),
        sizeof(CalibrationData)
    );

    // Write to EEPROM (in real implementation, handle page boundaries)
    // EEPROM write is typically done byte-by-byte or in pages
    return true;
}

bool SkinSensor::isReady() const
{
    return m_initialized;
}

SkinSensor::SensorData SkinSensor::readSensorData()
{
    SensorData data;

    // Timestamp
    auto now = std::chrono::system_clock::now();
    data.timestamp = std::chrono::duration_cast<std::chrono::milliseconds>(
        now.time_since_epoch()).count();

    // Patient info
    data.patientName = m_patientName;
    data.birthDate = m_birthDate;

    // Read temperature first for compensation
    data.temperatureC = readTemperature();
    m_lastTemperature = data.temperatureC;

    // Read photodiode sensors via ADC
    // ADS1115 channels: AIN0=PD1, AIN1=PD2, AIN2=Thickness
    data.pd1 = readADC(0) + m_calibration.pdOffset1;
    data.pd2 = readADC(1) + m_calibration.pdOffset2;

    // Store raw ADC values for debugging
    data.adcRaw[0] = static_cast<uint16_t>(data.pd1);
    data.adcRaw[1] = static_cast<uint16_t>(data.pd2);

    // Measurement frequency (from system configuration)
    data.hz = 50.0f;

    // Read moisture sensor (SHT31)
    float rawMoisture = readMoisture();
    data.s1 = (rawMoisture * m_calibration.moistureScale) + m_calibration.moistureOffset;

    // Apply temperature compensation
    data.s1 = compensateTemperature(data.s1, data.temperatureC);

    // Read elasticity via ToF sensor (VL6180X)
    float rawElasticity = readElasticity();
    data.s2 = (rawElasticity * m_calibration.elasticityScale) + m_calibration.elasticityOffset;

    // Read thickness via ADC channel 2
    float rawThickness = readADC(2);
    data.s3 = (rawThickness * m_calibration.thicknessScale) + m_calibration.thicknessOffset;
    data.adcRaw[2] = static_cast<uint16_t>(rawThickness);

    // Calculate moisture level (0-100 scale)
    data.moistureLevel = std::min(Config::Calibration::MOISTURE_MAX,
                                   std::max(Config::Calibration::MOISTURE_MIN, data.s1 * 1.2f));

    // Analyze results
    data.moistureLevelResult = analyzeMoistureLevel(data.moistureLevel);
    data.elasticityResult = analyzeElasticity(data.s2);
    data.thicknessResult = analyzeThickness(data.s3);

    return data;
}

//==============================================================================
// Hardware Communication
//==============================================================================

bool SkinSensor::i2cWriteRegister(uint8_t addr, uint8_t reg, uint8_t value)
{
    return m_i2c ? m_i2c->writeRegister(addr, reg, value) : false;
}

bool SkinSensor::i2cWriteRegister16(uint8_t addr, uint8_t reg, uint16_t value)
{
    return m_i2c ? m_i2c->writeRegister16(addr, reg, value) : false;
}

uint8_t SkinSensor::i2cReadRegister(uint8_t addr, uint8_t reg)
{
    return m_i2c ? m_i2c->readRegister(addr, reg) : 0;
}

uint16_t SkinSensor::i2cReadRegister16(uint8_t addr, uint8_t reg)
{
    return m_i2c ? m_i2c->readRegister16(addr, reg) : 0;
}

float SkinSensor::readADC(uint8_t channel)
{
    /**
     * ADS1115 ADC reading sequence:
     * 1. Configure MUX for desired channel
     * 2. Start single conversion
     * 3. Wait for conversion complete (poll or DRDY pin)
     * 4. Read conversion result
     *
     * Reference: TI ADS1115 Datasheet Section 8.5
     */

    // Select channel via MUX bits
    uint16_t config = HAL::ADC::CFG_OS_SINGLE |
                      HAL::ADC::CFG_PGA_4V |
                      HAL::ADC::CFG_MODE_SINGLE |
                      HAL::ADC::CFG_DR_128SPS;

    switch (channel) {
        case 0: config |= HAL::ADC::CFG_MUX_AIN0; break;
        case 1: config |= HAL::ADC::CFG_MUX_AIN1; break;
        case 2: config |= HAL::ADC::CFG_MUX_AIN2; break;
        default: return 0.0f;
    }

    // Write config and start conversion
    i2cWriteRegister16(HAL::I2C::ADDR_PHOTODIODE_ADC, HAL::ADC::REG_CONFIG, config);

    // Wait for conversion (128 SPS = ~8ms per conversion)
    std::this_thread::sleep_for(std::chrono::milliseconds(Config::Hardware::ADC_SETTLING_MS));

    // Read result
    uint16_t rawValue = i2cReadRegister16(HAL::I2C::ADDR_PHOTODIODE_ADC, HAL::ADC::REG_CONVERSION);

    // Convert to voltage: LSB = VREF / 2^15 (for single-ended)
    float voltage = static_cast<float>(rawValue) * HAL::ADC::VREF / 32768.0f;

    // Convert voltage to sensor units (device-specific scaling)
    return voltage * 30.0f + 100.0f;  // Scale to ~100-220 range
}

float SkinSensor::readMoisture()
{
    /**
     * SHT31 humidity reading sequence:
     * 1. Send measurement command
     * 2. Wait for measurement (clock stretching or delay)
     * 3. Read 6 bytes: Temp MSB, Temp LSB, Temp CRC, Hum MSB, Hum LSB, Hum CRC
     *
     * Reference: Sensirion SHT31 Datasheet Section 4.5
     */

    // Send high repeatability measurement command
    uint16_t cmd = HAL::MoistureSensor::CMD_MEASURE_HIGH_REP;
    i2cWriteRegister16(HAL::I2C::ADDR_MOISTURE_SENSOR, (cmd >> 8), (cmd & 0xFF));

    // Wait for measurement
    std::this_thread::sleep_for(std::chrono::milliseconds(HAL::MoistureSensor::MEASURE_DELAY_HIGH_MS));

    // Read response
    uint8_t buffer[6];
    m_i2c->readBytes(HAL::I2C::ADDR_MOISTURE_SENSOR, buffer, 6);

    // Parse humidity (bytes 3-4)
    uint16_t rawHumidity = (buffer[3] << 8) | buffer[4];

    // Convert to %RH: RH = 100 * rawHumidity / 65535
    float humidity = 100.0f * static_cast<float>(rawHumidity) / 65535.0f;

    // Map humidity to skin moisture scale (typically 30-80% RH maps to skin moisture)
    return humidity * 0.8f + 10.0f;
}

float SkinSensor::readTemperature()
{
    // Temperature is also read from SHT31 (bytes 0-1 of moisture reading)
    uint16_t cmd = HAL::MoistureSensor::CMD_MEASURE_HIGH_REP;
    i2cWriteRegister16(HAL::I2C::ADDR_MOISTURE_SENSOR, (cmd >> 8), (cmd & 0xFF));

    std::this_thread::sleep_for(std::chrono::milliseconds(HAL::MoistureSensor::MEASURE_DELAY_HIGH_MS));

    uint8_t buffer[6];
    m_i2c->readBytes(HAL::I2C::ADDR_MOISTURE_SENSOR, buffer, 6);

    uint16_t rawTemp = (buffer[0] << 8) | buffer[1];

    // Convert to °C: T = -45 + 175 * rawTemp / 65535
    return -45.0f + 175.0f * static_cast<float>(rawTemp) / 65535.0f;
}

float SkinSensor::readElasticity()
{
    /**
     * VL6180X ToF reading for elasticity measurement:
     * Measures skin deformation depth under controlled pressure
     *
     * Reference: ST VL6180X Datasheet Section 2.4
     */

    // In actual implementation: read range from VL6180X registers
    // Simulated: return value in range for elasticity measurement
    return 50.0f + (std::rand() % 30);
}

float SkinSensor::compensateTemperature(float value, float tempC)
{
    // Apply temperature compensation based on deviation from reference
    float tempDelta = tempC - Config::Calibration::REFERENCE_TEMP_C;
    float compensation = 1.0f - (tempDelta * Config::Calibration::TEMP_COEFFICIENT);
    return value * compensation;
}

//==============================================================================
// Treatment Data
//==============================================================================

SkinSensor::TreatmentData SkinSensor::createTreatmentData(TreatmentMode mode)
{
    TreatmentData data;

    auto now = std::chrono::system_clock::now();
    data.timestamp = std::chrono::duration_cast<std::chrono::milliseconds>(
        now.time_since_epoch()).count();

    data.mode = mode;
    data.patientName = m_patientName;
    data.birthDate = m_birthDate;

    // Set default parameters from config
    switch (mode) {
        case TreatmentMode::VIBRATION:
            data.vMode = "normal";
            data.vSensitivity = "medium";
            data.vTime = Config::Treatment::V_DEFAULT_TIME_SEC / 60;  // Convert to minutes
            data.vHz = Config::Treatment::V_DEFAULT_FREQUENCY_HZ;
            break;

        case TreatmentMode::IONTOPHORESIS:
            data.iTime = Config::Treatment::I_DEFAULT_TIME_SEC / 60;
            data.iCurrent = Config::Treatment::I_DEFAULT_CURRENT_MA;
            break;

        case TreatmentMode::HIGH_FREQUENCY:
            data.tTime = Config::Treatment::T_DEFAULT_TIME_SEC / 60;
            data.tVoltage = Config::Treatment::T_DEFAULT_VOLTAGE_V;
            data.tHz = Config::Treatment::T_FREQUENCY_HZ;
            break;

        case TreatmentMode::LED_THERAPY:
            data.lMode = "red";
            data.lBrightness = Config::Treatment::L_DEFAULT_BRIGHTNESS;
            data.lTime = Config::Treatment::L_DEFAULT_TIME_SEC / 60;
            data.lHz = 0;  // No PWM modulation
            break;
    }

    return data;
}

//==============================================================================
// Analysis Functions
//==============================================================================

std::string SkinSensor::analyzeMoistureLevel(float value)
{
    if (value < 30.0f) return "dry";
    if (value < 50.0f) return "slightly_dry";
    if (value < 70.0f) return "normal";
    return "hydrated";
}

std::string SkinSensor::analyzeElasticity(float value)
{
    if (value < 40.0f) return "poor";
    if (value < 60.0f) return "fair";
    if (value < 80.0f) return "good";
    return "excellent";
}

std::string SkinSensor::analyzeThickness(float value)
{
    if (value < 35.0f) return "thin";
    if (value < 55.0f) return "normal";
    return "thick";
}

//==============================================================================
// Diagnostics
//==============================================================================

std::string SkinSensor::getSerialNumber() const
{
    return std::string(m_calibration.serialNumber, 16);
}

uint8_t SkinSensor::selfTest()
{
    uint8_t status = 0;

    // Bit 0: ADC test
    if (!m_i2c->isDevicePresent(HAL::I2C::ADDR_PHOTODIODE_ADC)) {
        status |= 0x01;
    }

    // Bit 1: Moisture sensor test
    if (!m_i2c->isDevicePresent(HAL::I2C::ADDR_MOISTURE_SENSOR)) {
        status |= 0x02;
    }

    // Bit 2: ToF sensor test
    if (!m_i2c->isDevicePresent(HAL::I2C::ADDR_ELASTICITY_SENSOR)) {
        status |= 0x04;
    }

    // Bit 3: EEPROM test
    if (!m_i2c->isDevicePresent(HAL::I2C::ADDR_EEPROM)) {
        status |= 0x08;
    }

    return status;
}

uint16_t SkinSensor::calculateCRC16(const uint8_t* data, size_t length)
{
    // CRC-16-CCITT implementation
    uint16_t crc = 0xFFFF;

    for (size_t i = 0; i < length; i++) {
        crc ^= static_cast<uint16_t>(data[i]) << 8;
        for (int j = 0; j < 8; j++) {
            if (crc & 0x8000) {
                crc = (crc << 1) ^ 0x1021;
            } else {
                crc <<= 1;
            }
        }
    }

    return crc;
}

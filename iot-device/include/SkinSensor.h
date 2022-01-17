#ifndef SKIN_SENSOR_H
#define SKIN_SENSOR_H

#include <string>
#include <cstdint>
#include <memory>
#include "HardwareAbstraction.h"

/**
 * SkinSensor - 피부 측정 센서 모듈
 *
 * THE 3.0 피부과 진단 기기의 센서 데이터를 읽고 처리하는 클래스
 *
 * Hardware Components:
 * - Photodiode sensors (PD1, PD2): Skin reflectance measurement
 *   - Connected via ADS1115 16-bit ADC (I2C addr: 0x48)
 *   - Reference: Texas Instruments ADS1115 Datasheet (SBAS444B)
 *
 * - Moisture sensor: Skin hydration level measurement
 *   - SHT31 compatible sensor (I2C addr: 0x44)
 *   - Reference: Sensirion SHT31 Datasheet
 *
 * - Elasticity sensor: Skin elasticity measurement via ToF
 *   - VL6180X Time-of-Flight sensor (I2C addr: 0x29)
 *   - Reference: ST VL6180X Datasheet (DocID025086)
 *
 * - EEPROM: Calibration data storage
 *   - AT24C256 256Kbit EEPROM (I2C addr: 0x50)
 */
class SkinSensor {
public:
    //==========================================================================
    // Data Structures
    //==========================================================================

    /**
     * Raw sensor readings and processed results
     */
    struct SensorData {
        // Raw ADC values from photodiode sensors
        float pd1;              // Photodiode 1 (ADS1115 AIN0)
        float pd2;              // Photodiode 2 (ADS1115 AIN1)
        float hz;               // Measurement frequency

        // Raw sensor values
        float s1;               // Moisture sensor raw value
        float s2;               // Elasticity sensor raw value (ToF distance)
        float s3;               // Thickness sensor raw value (ADS1115 AIN2)

        // Processed results (0-100 scale)
        float moistureLevel;
        std::string thicknessResult;    // "thin", "normal", "thick"
        std::string elasticityResult;   // "poor", "fair", "good", "excellent"
        std::string moistureLevelResult; // "dry", "slightly_dry", "normal", "hydrated"

        // Metadata
        std::string patientName;
        std::string birthDate;
        uint64_t timestamp;

        // Diagnostic info
        float temperatureC;     // Ambient temperature for compensation
        uint16_t adcRaw[4];     // Raw ADC values for debugging
    };

    /**
     * Treatment modes supported by the device
     */
    enum class TreatmentMode {
        VIBRATION,      // V - 진동 치료 (Vibration therapy)
        IONTOPHORESIS,  // I - 이온토포레시스 (Ion penetration)
        HIGH_FREQUENCY, // T - 고주파 (Radio frequency)
        LED_THERAPY     // L - LED 치료 (Phototherapy)
    };

    /**
     * Treatment session data
     */
    struct TreatmentData {
        TreatmentMode mode;
        std::string patientName;
        std::string birthDate;

        // V Mode parameters
        std::string vMode;          // "soft", "normal", "strong"
        std::string vSensitivity;   // "low", "medium", "high"
        int vTime;                  // Duration in seconds
        int vHz;                    // Vibration frequency (Hz)

        // I Mode parameters
        int iTime;                  // Duration in seconds
        float iCurrent;             // Current in mA (0.1 - 1.0)

        // T Mode parameters
        int tTime;                  // Duration in seconds
        float tVoltage;             // Voltage (V)
        int tHz;                    // Frequency (Hz)

        // L Mode parameters
        std::string lMode;          // "red", "blue", "infrared"
        int lBrightness;            // Brightness (0-100%)
        int lTime;                  // Duration in seconds
        int lHz;                    // PWM frequency (Hz)

        uint64_t timestamp;
    };

    /**
     * Calibration data stored in EEPROM
     */
    struct CalibrationData {
        uint32_t magic;             // Magic number for validation (0x54483330 = "TH30")
        uint16_t version;           // Calibration data version
        uint16_t checksum;          // CRC16 checksum

        // Per-device calibration offsets
        float pdOffset1;
        float pdOffset2;
        float moistureScale;
        float moistureOffset;
        float elasticityScale;
        float elasticityOffset;
        float thicknessScale;
        float thicknessOffset;

        // Manufacturing info
        char serialNumber[16];
        uint32_t manufacturingDate; // Unix timestamp
        uint32_t lastCalibrationDate;
    };

public:
    SkinSensor();
    ~SkinSensor();

    //==========================================================================
    // Initialization
    //==========================================================================

    /**
     * Initialize sensor hardware
     * @return true if all sensors initialized successfully
     */
    bool initialize();

    /**
     * Check if all sensors are ready
     */
    bool isReady() const;

    /**
     * Perform sensor calibration
     * Requires sensor to be placed on calibration reference
     * @return true if calibration successful
     */
    bool calibrate();

    /**
     * Load calibration data from EEPROM
     */
    bool loadCalibration();

    /**
     * Save calibration data to EEPROM
     */
    bool saveCalibration();

    //==========================================================================
    // Patient Management
    //==========================================================================

    void setPatientInfo(const std::string& name, const std::string& birthDate);

    //==========================================================================
    // Sensor Operations
    //==========================================================================

    /**
     * Read all sensor values and process results
     * @return Processed sensor data with analysis results
     */
    SensorData readSensorData();

    /**
     * Create treatment data for specified mode
     * @param mode Treatment mode to create data for
     * @return Treatment data with default parameters
     */
    TreatmentData createTreatmentData(TreatmentMode mode);

    //==========================================================================
    // Diagnostics
    //==========================================================================

    /**
     * Get device serial number from EEPROM
     */
    std::string getSerialNumber() const;

    /**
     * Perform self-test of all sensors
     * @return Bitmask of sensor status (0 = OK, bit set = failure)
     */
    uint8_t selfTest();

private:
    //==========================================================================
    // Hardware Communication (platform-specific)
    //==========================================================================

    // I2C communication helpers
    bool i2cWriteRegister(uint8_t addr, uint8_t reg, uint8_t value);
    bool i2cWriteRegister16(uint8_t addr, uint8_t reg, uint16_t value);
    uint8_t i2cReadRegister(uint8_t addr, uint8_t reg);
    uint16_t i2cReadRegister16(uint8_t addr, uint8_t reg);

    // Sensor-specific read functions
    float readADC(uint8_t channel);     // ADS1115 ADC reading
    float readMoisture();                // SHT31 humidity reading
    float readTemperature();             // SHT31 temperature reading
    float readElasticity();              // VL6180X ToF reading

    //==========================================================================
    // Data Processing
    //==========================================================================

    std::string analyzeMoistureLevel(float value);
    std::string analyzeElasticity(float value);
    std::string analyzeThickness(float value);

    // Apply temperature compensation
    float compensateTemperature(float value, float tempC);

    // CRC calculation for EEPROM validation
    uint16_t calculateCRC16(const uint8_t* data, size_t length);

    //==========================================================================
    // Internal State
    //==========================================================================

    bool m_initialized;
    std::string m_patientName;
    std::string m_birthDate;

    // HAL interfaces
    std::unique_ptr<HAL::I2CInterface> m_i2c;
    std::unique_ptr<HAL::GPIOInterface> m_gpio;

    // Calibration data (loaded from EEPROM)
    CalibrationData m_calibration;

    // Last temperature reading for compensation
    float m_lastTemperature;
};

#endif // SKIN_SENSOR_H

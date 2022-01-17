#ifndef HARDWARE_ABSTRACTION_H
#define HARDWARE_ABSTRACTION_H

#include <cstdint>
#include <string>

/**
 * Hardware Abstraction Layer (HAL) for THE 3.0 Skin Analysis Device
 *
 * This layer abstracts hardware-specific operations to allow:
 * 1. Platform portability (Raspberry Pi, STM32, ESP32, etc.)
 * 2. Simulation mode for development/testing
 * 3. Easy hardware replacement without changing business logic
 *
 * Supported platforms:
 * - PLATFORM_RPI: Raspberry Pi (bcm2835 library)
 * - PLATFORM_STM32: STM32 microcontroller (HAL library)
 * - PLATFORM_SIMULATION: Software simulation for testing
 */

// Platform selection (set via CMake or compiler flag)
#ifndef PLATFORM_TYPE
    #define PLATFORM_SIMULATION  // Default to simulation mode
#endif

namespace HAL {

//==============================================================================
// I2C Bus Configuration
//==============================================================================

/**
 * I2C Bus addresses for connected sensors
 * Reference: THE3.0 Hardware Design Document v2.1
 */
namespace I2C {
    // I2C Bus configuration
    constexpr int BUS_NUMBER = 1;           // /dev/i2c-1 on Raspberry Pi
    constexpr int BUS_SPEED_HZ = 400000;    // 400kHz Fast Mode

    // Sensor I2C addresses (7-bit)
    constexpr uint8_t ADDR_MOISTURE_SENSOR  = 0x44;  // SHT31 compatible moisture sensor
    constexpr uint8_t ADDR_PHOTODIODE_ADC   = 0x48;  // ADS1115 16-bit ADC for PD1/PD2
    constexpr uint8_t ADDR_ELASTICITY_SENSOR = 0x29; // VL6180X ToF sensor for elasticity
    constexpr uint8_t ADDR_EEPROM           = 0x50;  // AT24C256 for calibration data
}

//==============================================================================
// GPIO Pin Configuration
//==============================================================================

/**
 * GPIO pin assignments for THE 3.0 device
 * Reference: THE3.0 PCB Schematic Rev 3.0
 */
namespace GPIO {
    // LED indicators
    constexpr int PIN_LED_POWER     = 17;   // BCM GPIO 17
    constexpr int PIN_LED_STATUS    = 27;   // BCM GPIO 27
    constexpr int PIN_LED_ERROR     = 22;   // BCM GPIO 22

    // Treatment module control
    constexpr int PIN_VIBRATION_EN  = 23;   // Vibration motor enable
    constexpr int PIN_VIBRATION_PWM = 18;   // PWM for vibration intensity
    constexpr int PIN_IONTO_EN      = 24;   // Iontophoresis enable
    constexpr int PIN_HF_EN         = 25;   // High-frequency enable
    constexpr int PIN_LED_THERAPY   = 12;   // LED therapy PWM

    // Sensor control
    constexpr int PIN_SENSOR_POWER  = 5;    // Sensor power enable
    constexpr int PIN_ADC_DRDY      = 6;    // ADC data ready interrupt

    // User interface
    constexpr int PIN_BUTTON_START  = 16;   // Start measurement button
    constexpr int PIN_BUTTON_MODE   = 20;   // Mode selection button
}

//==============================================================================
// ADC Configuration
//==============================================================================

/**
 * ADC register addresses for ADS1115
 * Reference: Texas Instruments ADS1115 Datasheet (SBAS444B)
 */
namespace ADC {
    // Register addresses
    constexpr uint8_t REG_CONVERSION = 0x00;
    constexpr uint8_t REG_CONFIG     = 0x01;
    constexpr uint8_t REG_LO_THRESH  = 0x02;
    constexpr uint8_t REG_HI_THRESH  = 0x03;

    // Config register bits
    constexpr uint16_t CFG_OS_SINGLE     = 0x8000;  // Start single conversion
    constexpr uint16_t CFG_MUX_AIN0      = 0x4000;  // AIN0 (PD1)
    constexpr uint16_t CFG_MUX_AIN1      = 0x5000;  // AIN1 (PD2)
    constexpr uint16_t CFG_MUX_AIN2      = 0x6000;  // AIN2 (Thickness sensor)
    constexpr uint16_t CFG_PGA_4V        = 0x0200;  // +/-4.096V range
    constexpr uint16_t CFG_MODE_SINGLE   = 0x0100;  // Single-shot mode
    constexpr uint16_t CFG_DR_128SPS     = 0x0080;  // 128 samples per second

    // Voltage reference
    constexpr float VREF = 4.096f;
    constexpr int RESOLUTION_BITS = 16;
}

//==============================================================================
// Moisture Sensor Configuration (SHT31 compatible)
//==============================================================================

/**
 * SHT31 moisture/temperature sensor registers
 * Reference: Sensirion SHT31 Datasheet
 */
namespace MoistureSensor {
    // Commands (MSB first)
    constexpr uint16_t CMD_MEASURE_HIGH_REP   = 0x2400;  // High repeatability
    constexpr uint16_t CMD_MEASURE_MED_REP    = 0x240B;  // Medium repeatability
    constexpr uint16_t CMD_MEASURE_LOW_REP    = 0x2416;  // Low repeatability
    constexpr uint16_t CMD_SOFT_RESET         = 0x30A2;
    constexpr uint16_t CMD_HEATER_ENABLE      = 0x306D;
    constexpr uint16_t CMD_HEATER_DISABLE     = 0x3066;
    constexpr uint16_t CMD_READ_STATUS        = 0xF32D;
    constexpr uint16_t CMD_CLEAR_STATUS       = 0x3041;

    // Measurement timing (ms)
    constexpr int MEASURE_DELAY_HIGH_MS = 15;
    constexpr int MEASURE_DELAY_MED_MS  = 6;
    constexpr int MEASURE_DELAY_LOW_MS  = 4;
}

//==============================================================================
// HAL Interface Classes
//==============================================================================

/**
 * I2C communication interface
 */
class I2CInterface {
public:
    virtual ~I2CInterface() = default;

    virtual bool initialize(int busNumber) = 0;
    virtual void cleanup() = 0;

    virtual bool writeRegister(uint8_t deviceAddr, uint8_t regAddr, uint8_t value) = 0;
    virtual bool writeRegister16(uint8_t deviceAddr, uint8_t regAddr, uint16_t value) = 0;
    virtual uint8_t readRegister(uint8_t deviceAddr, uint8_t regAddr) = 0;
    virtual uint16_t readRegister16(uint8_t deviceAddr, uint8_t regAddr) = 0;
    virtual bool readBytes(uint8_t deviceAddr, uint8_t* buffer, size_t length) = 0;

    virtual bool isDevicePresent(uint8_t deviceAddr) = 0;
};

/**
 * GPIO control interface
 */
class GPIOInterface {
public:
    enum class Direction { INPUT, OUTPUT };
    enum class PullMode { NONE, UP, DOWN };
    enum class Edge { NONE, RISING, FALLING, BOTH };

    virtual ~GPIOInterface() = default;

    virtual bool initialize() = 0;
    virtual void cleanup() = 0;

    virtual bool setDirection(int pin, Direction dir) = 0;
    virtual bool setPullMode(int pin, PullMode mode) = 0;
    virtual bool write(int pin, bool value) = 0;
    virtual bool read(int pin) = 0;

    // PWM support
    virtual bool setPWM(int pin, int frequency, int dutyCycle) = 0;
    virtual bool stopPWM(int pin) = 0;

    // Interrupt support
    virtual bool setInterrupt(int pin, Edge edge, void (*callback)(int, void*), void* userData) = 0;
};

//==============================================================================
// Platform-specific factory
//==============================================================================

/**
 * Factory function to create platform-specific HAL instances
 */
I2CInterface* createI2CInterface();
GPIOInterface* createGPIOInterface();

/**
 * Check if running in simulation mode
 */
bool isSimulationMode();

} // namespace HAL

#endif // HARDWARE_ABSTRACTION_H

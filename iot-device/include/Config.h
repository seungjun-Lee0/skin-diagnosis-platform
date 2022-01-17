#ifndef CONFIG_H
#define CONFIG_H

#include <string>
#include <cstdlib>

/**
 * THE 3.0 IoT Device Configuration
 *
 * Security-sensitive values are loaded from environment variables.
 * Hardware-specific values are defined as compile-time constants.
 *
 * Required environment variables:
 * - THE3_API_KEY: API authentication key
 * - THE3_SERVER_URL: Backend server URL (optional, has default)
 * - THE3_DEVICE_ID: Device identifier (optional, has default)
 */

namespace Config {

//==============================================================================
// Environment Variable Helpers
//==============================================================================

inline std::string getEnvOrDefault(const char* envName, const std::string& defaultValue) {
    const char* value = std::getenv(envName);
    return (value != nullptr) ? std::string(value) : defaultValue;
}

inline int getEnvOrDefault(const char* envName, int defaultValue) {
    const char* value = std::getenv(envName);
    return (value != nullptr) ? std::stoi(value) : defaultValue;
}

//==============================================================================
// Server Configuration (from environment variables)
//==============================================================================

// API endpoints
inline std::string getServerUrl() {
    return getEnvOrDefault("THE3_SERVER_URL", "http://localhost:8080");
}

inline std::string getApiKey() {
    // SECURITY: API key MUST be set via environment variable in production
    std::string key = getEnvOrDefault("THE3_API_KEY", "");
    if (key.empty()) {
        // Development fallback - remove in production build
        #ifdef DEVELOPMENT_MODE
            return "THE3-DEV-KEY-DO-NOT-USE-IN-PROD";
        #else
            throw std::runtime_error("THE3_API_KEY environment variable not set");
        #endif
    }
    return key;
}

// API endpoint paths
const std::string API_ENDPOINT_SKIN = "/api/iot/skin-analysis";
const std::string API_ENDPOINT_TREATMENT = "/api/iot/treatment";
const std::string API_ENDPOINT_HEALTH = "/api/iot/health";
const std::string API_ENDPOINT_TELEMETRY = "/api/iot/telemetry/batch";

//==============================================================================
// Device Configuration
//==============================================================================

inline std::string getDeviceId() {
    return getEnvOrDefault("THE3_DEVICE_ID", "THE3-SKIN-DEVICE-001");
}

// Firmware version
const std::string FIRMWARE_VERSION = "1.0.0";
const std::string HARDWARE_VERSION = "3.0";

//==============================================================================
// Timing Configuration
//==============================================================================

// Sensor reading intervals (milliseconds)
const int SENSOR_READ_INTERVAL_MS = 1000;       // Read sensor every 1 second
const int DATA_SEND_INTERVAL_MS = 5000;         // Send to server every 5 seconds
const int HEALTH_CHECK_INTERVAL_MS = 30000;     // Health check every 30 seconds
const int RETRY_INTERVAL_MS = 3000;             // Retry failed requests after 3 seconds
const int MAX_RETRY_COUNT = 3;                  // Maximum retry attempts

// Treatment timeouts (seconds)
const int TREATMENT_MAX_DURATION_SEC = 1800;    // 30 minutes max treatment
const int TREATMENT_IDLE_TIMEOUT_SEC = 300;     // 5 minutes idle timeout

//==============================================================================
// Hardware Configuration
//==============================================================================

namespace Hardware {
    // I2C bus configuration
    const int I2C_BUS = 1;                      // /dev/i2c-1
    const int I2C_SPEED_HZ = 400000;            // 400kHz Fast Mode

    // ADC configuration (ADS1115)
    const int ADC_RESOLUTION_BITS = 16;
    const float ADC_VREF = 4.096f;              // Reference voltage
    const int ADC_SAMPLES_PER_READ = 4;         // Oversampling for noise reduction

    // Sensor power-on delay (milliseconds)
    const int SENSOR_WARMUP_MS = 100;
    const int ADC_SETTLING_MS = 10;
}

//==============================================================================
// Sensor Calibration Defaults
//==============================================================================

namespace Calibration {
    // Photodiode sensor offsets (calibrated per device)
    const float PD_SENSOR_OFFSET = 0.0f;

    // Moisture sensor calibration
    const float MOISTURE_SCALE = 1.0f;
    const float MOISTURE_OFFSET = 0.0f;
    const float MOISTURE_MIN = 0.0f;
    const float MOISTURE_MAX = 100.0f;

    // Elasticity sensor calibration
    const float ELASTICITY_SCALE = 1.0f;
    const float ELASTICITY_OFFSET = 0.0f;

    // Thickness sensor calibration
    const float THICKNESS_SCALE = 1.0f;
    const float THICKNESS_OFFSET = 0.0f;

    // Temperature compensation coefficient
    const float TEMP_COEFFICIENT = 0.02f;       // 2% per degree C
    const float REFERENCE_TEMP_C = 25.0f;       // Reference temperature
}

//==============================================================================
// Treatment Parameters
//==============================================================================

namespace Treatment {
    // Vibration mode (V)
    const int V_DEFAULT_TIME_SEC = 900;         // 15 minutes
    const int V_MIN_FREQUENCY_HZ = 30;
    const int V_MAX_FREQUENCY_HZ = 120;
    const int V_DEFAULT_FREQUENCY_HZ = 60;

    // Iontophoresis mode (I)
    const int I_DEFAULT_TIME_SEC = 1200;        // 20 minutes
    const float I_MIN_CURRENT_MA = 0.1f;
    const float I_MAX_CURRENT_MA = 1.0f;
    const float I_DEFAULT_CURRENT_MA = 0.5f;

    // High-frequency mode (T)
    const int T_DEFAULT_TIME_SEC = 600;         // 10 minutes
    const float T_MIN_VOLTAGE_V = 5.0f;
    const float T_MAX_VOLTAGE_V = 15.0f;
    const float T_DEFAULT_VOLTAGE_V = 12.0f;
    const int T_FREQUENCY_HZ = 1000;

    // LED therapy mode (L)
    const int L_DEFAULT_TIME_SEC = 900;         // 15 minutes
    const int L_MIN_BRIGHTNESS = 0;
    const int L_MAX_BRIGHTNESS = 100;
    const int L_DEFAULT_BRIGHTNESS = 80;
}

//==============================================================================
// Logging Configuration
//==============================================================================

namespace Logging {
    inline std::string getLogLevel() {
        return getEnvOrDefault("THE3_LOG_LEVEL", "INFO");
    }

    inline std::string getLogFile() {
        return getEnvOrDefault("THE3_LOG_FILE", "/var/log/the3-device.log");
    }

    const bool ENABLE_CONSOLE_LOG = true;
    const bool ENABLE_FILE_LOG = true;
    const int MAX_LOG_SIZE_MB = 10;
    const int LOG_ROTATION_COUNT = 5;
}

} // namespace Config

#endif // CONFIG_H

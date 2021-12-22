#ifndef CONFIG_H
#define CONFIG_H

#include <string>

namespace Config {
    // Server Configuration
    const std::string SERVER_URL = "http://localhost:8080";
    const std::string API_ENDPOINT_SKIN = "/api/iot/skin-analysis";
    const std::string API_ENDPOINT_TREATMENT = "/api/iot/treatment";
    const std::string API_ENDPOINT_HEALTH = "/api/iot/health";

    // Authentication
    const std::string API_KEY = "THE3-IOT-API-KEY-2024";

    // Device Configuration
    const std::string DEVICE_ID = "THE3-SKIN-DEVICE-001";
    const int SENSOR_READ_INTERVAL_MS = 1000;
    const int DATA_SEND_INTERVAL_MS = 5000;

    // Sensor Calibration
    const float PD_SENSOR_OFFSET = 0.0f;
    const float MOISTURE_CALIBRATION = 1.0f;
    const float ELASTICITY_CALIBRATION = 1.0f;
}

#endif // CONFIG_H

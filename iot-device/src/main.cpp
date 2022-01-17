/**
 * THE 3.0 피부과 IoT 피부 측정 기기 - 메인 프로그램
 *
 * 이 프로그램은 피부 측정 기기에서 실행되며,
 * 센서 데이터를 읽어 백엔드 서버로 전송합니다.
 *
 * 통신 프로토콜: HTTP REST API (JSON)
 * 인증: X-API-Key 헤더 (환경변수 THE3_API_KEY에서 로드)
 *
 * Required environment variables:
 * - THE3_API_KEY: API authentication key (REQUIRED)
 * - THE3_SERVER_URL: Backend server URL (optional, default: http://localhost:8080)
 * - THE3_DEVICE_ID: Device identifier (optional, default: THE3-SKIN-DEVICE-001)
 */

#include <iostream>
#include <string>
#include <sstream>
#include <thread>
#include <chrono>
#include <csignal>
#include <iomanip>
#include <stdexcept>

#include "Config.h"
#include "HttpClient.h"
#include "SkinSensor.h"

// 전역 변수 (종료 플래그)
volatile bool g_running = true;

// 시그널 핸들러
void signalHandler(int signum)
{
    std::cout << "\nShutdown signal received. Exiting..." << std::endl;
    g_running = false;
}

// JSON 빌더 헬퍼 함수
std::string buildSkinAnalysisJson(const SkinSensor::SensorData& data, const std::string& deviceId)
{
    std::ostringstream json;
    json << "{"
         << "\"deviceId\":\"" << deviceId << "\","
         << "\"patientName\":\"" << data.patientName << "\","
         << "\"birthDate\":\"" << data.birthDate << "\","
         << "\"pd1\":\"" << std::fixed << std::setprecision(2) << data.pd1 << "\","
         << "\"pd2\":\"" << data.pd2 << "\","
         << "\"hz\":\"" << data.hz << "\","
         << "\"s1\":\"" << data.s1 << "\","
         << "\"s2\":\"" << data.s2 << "\","
         << "\"s3\":\"" << data.s3 << "\","
         << "\"moistureLevel\":\"" << data.moistureLevel << "\","
         << "\"thicknessResult\":\"" << data.thicknessResult << "\","
         << "\"elasticityResult\":\"" << data.elasticityResult << "\","
         << "\"moistureLevelResult\":\"" << data.moistureLevelResult << "\""
         << "}";
    return json.str();
}

std::string buildTreatmentJson(const SkinSensor::TreatmentData& data, const std::string& deviceId)
{
    std::ostringstream json;
    json << "{"
         << "\"deviceId\":\"" << deviceId << "\","
         << "\"patientName\":\"" << data.patientName << "\","
         << "\"birthDate\":\"" << data.birthDate << "\",";

    switch (data.mode) {
        case SkinSensor::TreatmentMode::VIBRATION:
            json << "\"treatmentType\":\"V\","
                 << "\"vMode\":\"" << data.vMode << "\","
                 << "\"vSensitivity\":\"" << data.vSensitivity << "\","
                 << "\"vTime\":\"" << data.vTime << "\","
                 << "\"vHz\":\"" << data.vHz << "\"";
            break;

        case SkinSensor::TreatmentMode::IONTOPHORESIS:
            json << "\"treatmentType\":\"I\","
                 << "\"iTime\":\"" << data.iTime << "\","
                 << "\"iCurrent\":\"" << std::fixed << std::setprecision(2) << data.iCurrent << "\"";
            break;

        case SkinSensor::TreatmentMode::HIGH_FREQUENCY:
            json << "\"treatmentType\":\"T\","
                 << "\"tTime\":\"" << data.tTime << "\","
                 << "\"tVoltage\":\"" << data.tVoltage << "\","
                 << "\"tHz\":\"" << data.tHz << "\"";
            break;

        case SkinSensor::TreatmentMode::LED_THERAPY:
            json << "\"treatmentType\":\"L\","
                 << "\"lMode\":\"" << data.lMode << "\","
                 << "\"lBrightness\":\"" << data.lBrightness << "\","
                 << "\"lTime\":\"" << data.lTime << "\","
                 << "\"lHz\":\"" << data.lHz << "\"";
            break;
    }

    json << "}";
    return json.str();
}

void printUsage()
{
    std::cout << "THE 3.0 Skin Analysis IoT Device\n"
              << "================================\n\n"
              << "Commands:\n"
              << "  1. Measure skin      - Perform skin analysis\n"
              << "  2. Treatment V       - Vibration therapy\n"
              << "  3. Treatment I       - Iontophoresis therapy\n"
              << "  4. Treatment T       - High frequency therapy\n"
              << "  5. Treatment L       - LED therapy\n"
              << "  6. Check connection  - Test server connection\n"
              << "  7. Auto mode         - Continuous measurement\n"
              << "  8. Self test         - Run sensor diagnostics\n"
              << "  0. Exit\n"
              << std::endl;
}

void printEnvironmentInfo()
{
    std::cout << "Environment Configuration:\n"
              << "  THE3_SERVER_URL: " << Config::getServerUrl() << "\n"
              << "  THE3_DEVICE_ID:  " << Config::getDeviceId() << "\n"
              << "  THE3_API_KEY:    " << (std::getenv("THE3_API_KEY") ? "[SET]" : "[NOT SET]") << "\n"
              << "  THE3_LOG_LEVEL:  " << Config::Logging::getLogLevel() << "\n"
              << std::endl;
}

int main(int argc, char* argv[])
{
    // 시그널 핸들러 등록
    std::signal(SIGINT, signalHandler);
    std::signal(SIGTERM, signalHandler);

    std::cout << "========================================\n"
              << "  THE 3.0 Skin Analysis IoT Device\n"
              << "  Firmware: " << Config::FIRMWARE_VERSION << "\n"
              << "  Hardware: " << Config::HARDWARE_VERSION << "\n"
              << "========================================\n\n";

    // Print environment configuration
    printEnvironmentInfo();

    // Load configuration from environment variables
    std::string serverUrl;
    std::string apiKey;
    std::string deviceId;

    try {
        serverUrl = Config::getServerUrl();
        apiKey = Config::getApiKey();
        deviceId = Config::getDeviceId();
    } catch (const std::runtime_error& e) {
        std::cerr << "[ERROR] Configuration error: " << e.what() << std::endl;
        std::cerr << "\nPlease set required environment variables:\n"
                  << "  export THE3_API_KEY=your_api_key\n"
                  << "  export THE3_SERVER_URL=http://your-server:8080 (optional)\n"
                  << std::endl;
        return 1;
    }

    std::cout << "[OK] Configuration loaded\n";
    std::cout << "  Server: " << serverUrl << "\n";
    std::cout << "  Device: " << deviceId << "\n\n";

    // HTTP 클라이언트 초기화
    HttpClient httpClient(serverUrl, apiKey);
    if (!httpClient.initialize()) {
        std::cerr << "[ERROR] Failed to initialize HTTP client" << std::endl;
        return 1;
    }
    std::cout << "[OK] HTTP client initialized\n";

    // 센서 초기화
    SkinSensor sensor;
    if (!sensor.initialize()) {
        std::cerr << "[ERROR] Failed to initialize sensor" << std::endl;
        return 1;
    }
    std::cout << "[OK] Sensor initialized\n";

    // 센서 캘리브레이션
    if (!sensor.calibrate()) {
        std::cerr << "[WARN] Sensor calibration failed, using defaults" << std::endl;
    } else {
        std::cout << "[OK] Sensor calibrated\n";
    }
    std::cout << "\n";

    // 환자 정보 설정 (테스트용)
    std::string patientName, birthDate;
    std::cout << "Enter patient name: ";
    std::getline(std::cin, patientName);
    std::cout << "Enter birth date (YYYY-MM-DD): ";
    std::getline(std::cin, birthDate);
    sensor.setPatientInfo(patientName, birthDate);
    std::cout << "\n";

    // 메인 루프
    while (g_running) {
        printUsage();

        std::cout << "Select command: ";
        std::string input;
        std::getline(std::cin, input);

        if (input.empty()) continue;

        int command;
        try {
            command = std::stoi(input);
        } catch (...) {
            std::cout << "Invalid input\n\n";
            continue;
        }

        switch (command) {
            case 1: {
                // 피부 측정
                std::cout << "\n[Measuring skin...]\n";
                auto data = sensor.readSensorData();
                std::string json = buildSkinAnalysisJson(data, deviceId);

                std::cout << "Sending data to server...\n";
                auto response = httpClient.post(Config::API_ENDPOINT_SKIN, json);

                if (response.success && response.statusCode == 200) {
                    std::cout << "[SUCCESS] Data sent successfully\n";
                    std::cout << "Response: " << response.body << "\n";
                } else {
                    std::cout << "[ERROR] Failed to send data: " << response.errorMessage << "\n";
                    std::cout << "Status code: " << response.statusCode << "\n";
                }
                break;
            }

            case 2:
            case 3:
            case 4:
            case 5: {
                // 치료 모드
                SkinSensor::TreatmentMode mode;
                std::string modeName;

                switch (command) {
                    case 2: mode = SkinSensor::TreatmentMode::VIBRATION; modeName = "Vibration"; break;
                    case 3: mode = SkinSensor::TreatmentMode::IONTOPHORESIS; modeName = "Iontophoresis"; break;
                    case 4: mode = SkinSensor::TreatmentMode::HIGH_FREQUENCY; modeName = "High Frequency"; break;
                    case 5: mode = SkinSensor::TreatmentMode::LED_THERAPY; modeName = "LED"; break;
                }

                std::cout << "\n[Starting " << modeName << " therapy...]\n";
                auto treatmentData = sensor.createTreatmentData(mode);
                std::string json = buildTreatmentJson(treatmentData, deviceId);

                std::cout << "Sending treatment data to server...\n";
                auto response = httpClient.post(Config::API_ENDPOINT_TREATMENT, json);

                if (response.success && response.statusCode == 200) {
                    std::cout << "[SUCCESS] Treatment data sent successfully\n";
                    std::cout << "Response: " << response.body << "\n";
                } else {
                    std::cout << "[ERROR] Failed to send data: " << response.errorMessage << "\n";
                }
                break;
            }

            case 6: {
                // 연결 확인
                std::cout << "\n[Checking server connection...]\n";
                if (httpClient.checkConnection()) {
                    std::cout << "[SUCCESS] Server is online\n";
                } else {
                    std::cout << "[ERROR] Cannot connect to server\n";
                }
                break;
            }

            case 7: {
                // 자동 모드
                std::cout << "\n[Auto mode started. Press Ctrl+C to stop.]\n";
                int successCount = 0;
                int failCount = 0;

                while (g_running) {
                    auto data = sensor.readSensorData();
                    std::string json = buildSkinAnalysisJson(data, deviceId);
                    auto response = httpClient.post(Config::API_ENDPOINT_SKIN, json);

                    if (response.success) {
                        std::cout << ".";
                        successCount++;
                    } else {
                        std::cout << "x";
                        failCount++;
                    }
                    std::cout.flush();

                    std::this_thread::sleep_for(
                        std::chrono::milliseconds(Config::DATA_SEND_INTERVAL_MS));
                }

                std::cout << "\n[Auto mode stopped]\n";
                std::cout << "  Sent: " << successCount << ", Failed: " << failCount << "\n";
                break;
            }

            case 8: {
                // Self test
                std::cout << "\n[Running self-test...]\n";
                uint8_t status = sensor.selfTest();

                if (status == 0) {
                    std::cout << "[SUCCESS] All sensors OK\n";
                } else {
                    std::cout << "[WARN] Sensor issues detected:\n";
                    if (status & 0x01) std::cout << "  - ADC (ADS1115) failure\n";
                    if (status & 0x02) std::cout << "  - Moisture sensor (SHT31) failure\n";
                    if (status & 0x04) std::cout << "  - ToF sensor (VL6180X) failure\n";
                    if (status & 0x08) std::cout << "  - EEPROM (AT24C256) failure\n";
                }

                std::cout << "\nSerial number: " << sensor.getSerialNumber() << "\n";
                break;
            }

            case 0:
                g_running = false;
                break;

            default:
                std::cout << "Unknown command\n";
                break;
        }

        std::cout << "\n";
    }

    std::cout << "Shutting down...\n";
    httpClient.cleanup();

    return 0;
}

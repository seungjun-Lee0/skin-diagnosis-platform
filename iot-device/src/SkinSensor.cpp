#include "SkinSensor.h"
#include "Config.h"
#include <cstdlib>
#include <ctime>
#include <chrono>
#include <cmath>

SkinSensor::SkinSensor()
    : m_initialized(false)
    , m_pdOffset(Config::PD_SENSOR_OFFSET)
    , m_moistureCalibration(Config::MOISTURE_CALIBRATION)
    , m_elasticityCalibration(Config::ELASTICITY_CALIBRATION)
{
    std::srand(static_cast<unsigned>(std::time(nullptr)));
}

SkinSensor::~SkinSensor()
{
    // 센서 리소스 해제
}

bool SkinSensor::initialize()
{
    // 실제 하드웨어에서는 GPIO, I2C, SPI 등 초기화
    // 시뮬레이션에서는 초기화 성공으로 처리

    m_initialized = true;
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

    // 캘리브레이션 수행
    // 실제 하드웨어에서는 기준값 측정 후 오프셋 계산
    m_pdOffset = 0.0f;
    m_moistureCalibration = 1.0f;
    m_elasticityCalibration = 1.0f;

    return true;
}

bool SkinSensor::isReady() const
{
    return m_initialized;
}

SkinSensor::SensorData SkinSensor::readSensorData()
{
    SensorData data;

    // 현재 타임스탬프
    auto now = std::chrono::system_clock::now();
    data.timestamp = std::chrono::duration_cast<std::chrono::milliseconds>(
        now.time_since_epoch()).count();

    // 환자 정보
    data.patientName = m_patientName;
    data.birthDate = m_birthDate;

    // 센서 값 읽기 (시뮬레이션)
    // 실제 하드웨어에서는 ADC 값 읽기
    data.pd1 = 100.0f + (std::rand() % 50) + m_pdOffset;
    data.pd2 = 100.0f + (std::rand() % 50) + m_pdOffset;
    data.hz = 50.0f + (std::rand() % 10);

    // 피부 상태 센서 값
    data.s1 = 40.0f + (std::rand() % 30);  // 수분 센서
    data.s2 = 50.0f + (std::rand() % 30);  // 탄력 센서
    data.s3 = 45.0f + (std::rand() % 20);  // 두께 센서

    // 캘리브레이션 적용
    data.s1 *= m_moistureCalibration;
    data.s2 *= m_elasticityCalibration;

    // 수분 레벨 계산 (0-100 스케일)
    data.moistureLevel = std::min(100.0f, std::max(0.0f, data.s1 * 1.2f));

    // 결과 분석
    data.moistureLevelResult = analyzeMoistureLevel(data.moistureLevel);
    data.elasticityResult = analyzeElasticity(data.s2);
    data.thicknessResult = analyzeThickness(data.s3);

    return data;
}

SkinSensor::TreatmentData SkinSensor::createTreatmentData(TreatmentMode mode)
{
    TreatmentData data;

    // 현재 타임스탬프
    auto now = std::chrono::system_clock::now();
    data.timestamp = std::chrono::duration_cast<std::chrono::milliseconds>(
        now.time_since_epoch()).count();

    data.mode = mode;
    data.patientName = m_patientName;
    data.birthDate = m_birthDate;

    // 모드별 기본값 설정
    switch (mode) {
        case TreatmentMode::VIBRATION:
            data.vMode = "normal";
            data.vSensitivity = "medium";
            data.vTime = 15;
            data.vHz = 60;
            break;

        case TreatmentMode::IONTOPHORESIS:
            data.iTime = 20;
            data.iCurrent = 0.5f;
            break;

        case TreatmentMode::HIGH_FREQUENCY:
            data.tTime = 10;
            data.tVoltage = 12.0f;
            data.tHz = 1000;
            break;

        case TreatmentMode::LED_THERAPY:
            data.lMode = "red";
            data.lBrightness = 80;
            data.lTime = 15;
            data.lHz = 0;
            break;
    }

    return data;
}

std::string SkinSensor::analyzeMoistureLevel(float value)
{
    if (value < 30.0f) {
        return "dry";
    } else if (value < 50.0f) {
        return "slightly_dry";
    } else if (value < 70.0f) {
        return "normal";
    } else {
        return "hydrated";
    }
}

std::string SkinSensor::analyzeElasticity(float value)
{
    if (value < 40.0f) {
        return "poor";
    } else if (value < 60.0f) {
        return "fair";
    } else if (value < 80.0f) {
        return "good";
    } else {
        return "excellent";
    }
}

std::string SkinSensor::analyzeThickness(float value)
{
    if (value < 35.0f) {
        return "thin";
    } else if (value < 55.0f) {
        return "normal";
    } else {
        return "thick";
    }
}

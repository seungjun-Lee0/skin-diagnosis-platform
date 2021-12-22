#ifndef SKIN_SENSOR_H
#define SKIN_SENSOR_H

#include <string>
#include <cstdint>

/**
 * SkinSensor - 피부 측정 센서 모듈
 *
 * 피부과 진단 기기의 센서 데이터를 읽고 처리하는 클래스
 * - 광센서 (PD1, PD2): 피부 반사율 측정
 * - 수분 센서: 피부 수분량 측정
 * - 탄력 센서: 피부 탄력도 측정
 * - 두께 센서: 피부 두께 측정
 */
class SkinSensor {
public:
    // 센서 데이터 구조체
    struct SensorData {
        // Raw sensor values
        float pd1;              // 광센서 1 값
        float pd2;              // 광센서 2 값
        float hz;               // 측정 주파수
        float s1;               // 센서 1 (수분)
        float s2;               // 센서 2 (탄력)
        float s3;               // 센서 3 (두께)

        // Processed results
        float moistureLevel;    // 수분 레벨 (0-100)
        std::string thicknessResult;    // 두께 결과
        std::string elasticityResult;   // 탄력 결과
        std::string moistureLevelResult; // 수분 레벨 결과

        // Metadata
        std::string patientName;
        std::string birthDate;
        uint64_t timestamp;
    };

    // 치료 모드 열거형
    enum class TreatmentMode {
        VIBRATION,      // V - 진동 치료
        IONTOPHORESIS,  // I - 이온토포레시스
        HIGH_FREQUENCY, // T - 고주파
        LED_THERAPY     // L - LED 치료
    };

    // 치료 데이터 구조체
    struct TreatmentData {
        TreatmentMode mode;
        std::string patientName;
        std::string birthDate;

        // V Mode
        std::string vMode;
        std::string vSensitivity;
        int vTime;
        int vHz;

        // I Mode
        int iTime;
        float iCurrent;

        // T Mode
        int tTime;
        float tVoltage;
        int tHz;

        // L Mode
        std::string lMode;
        int lBrightness;
        int lTime;
        int lHz;

        uint64_t timestamp;
    };

public:
    SkinSensor();
    ~SkinSensor();

    // 센서 초기화
    bool initialize();

    // 센서 데이터 읽기
    SensorData readSensorData();

    // 치료 데이터 생성
    TreatmentData createTreatmentData(TreatmentMode mode);

    // 환자 정보 설정
    void setPatientInfo(const std::string& name, const std::string& birthDate);

    // 센서 캘리브레이션
    bool calibrate();

    // 센서 상태 확인
    bool isReady() const;

private:
    // 센서 값 분석
    std::string analyzeMoistureLevel(float value);
    std::string analyzeElasticity(float value);
    std::string analyzeThickness(float value);

    // 내부 상태
    bool m_initialized;
    std::string m_patientName;
    std::string m_birthDate;

    // 캘리브레이션 값
    float m_pdOffset;
    float m_moistureCalibration;
    float m_elasticityCalibration;
};

#endif // SKIN_SENSOR_H

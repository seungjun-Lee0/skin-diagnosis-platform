package lsj.spring.project.dto;

/**
 * IoT 피부 측정 기기에서 전송하는 피부 분석 데이터 DTO
 * C++ 임베디드 모듈에서 JSON 형태로 전송
 */
public class SkinAnalysisRequest {
    private String deviceId;        // 기기 고유 ID
    private String patientName;     // 환자 이름
    private String birthDate;       // 생년월일

    // 피부 측정 센서 데이터
    private String pd1;             // 광센서 1
    private String pd2;             // 광센서 2
    private String hz;              // 주파수
    private String s1;              // 센서 1
    private String s2;              // 센서 2
    private String s3;              // 센서 3

    // 피부 상태 분석 결과
    private String moistureLevel;       // 수분 레벨
    private String thicknessResult;     // 두께 측정 결과
    private String elasticityResult;    // 탄력 측정 결과
    private String moistureLevelResult; // 수분 레벨 결과

    public String getDeviceId() {
        return deviceId;
    }

    public void setDeviceId(String deviceId) {
        this.deviceId = deviceId;
    }

    public String getPatientName() {
        return patientName;
    }

    public void setPatientName(String patientName) {
        this.patientName = patientName;
    }

    public String getBirthDate() {
        return birthDate;
    }

    public void setBirthDate(String birthDate) {
        this.birthDate = birthDate;
    }

    public String getPd1() {
        return pd1;
    }

    public void setPd1(String pd1) {
        this.pd1 = pd1;
    }

    public String getPd2() {
        return pd2;
    }

    public void setPd2(String pd2) {
        this.pd2 = pd2;
    }

    public String getHz() {
        return hz;
    }

    public void setHz(String hz) {
        this.hz = hz;
    }

    public String getS1() {
        return s1;
    }

    public void setS1(String s1) {
        this.s1 = s1;
    }

    public String getS2() {
        return s2;
    }

    public void setS2(String s2) {
        this.s2 = s2;
    }

    public String getS3() {
        return s3;
    }

    public void setS3(String s3) {
        this.s3 = s3;
    }

    public String getMoistureLevel() {
        return moistureLevel;
    }

    public void setMoistureLevel(String moistureLevel) {
        this.moistureLevel = moistureLevel;
    }

    public String getThicknessResult() {
        return thicknessResult;
    }

    public void setThicknessResult(String thicknessResult) {
        this.thicknessResult = thicknessResult;
    }

    public String getElasticityResult() {
        return elasticityResult;
    }

    public void setElasticityResult(String elasticityResult) {
        this.elasticityResult = elasticityResult;
    }

    public String getMoistureLevelResult() {
        return moistureLevelResult;
    }

    public void setMoistureLevelResult(String moistureLevelResult) {
        this.moistureLevelResult = moistureLevelResult;
    }
}

package lsj.spring.project.dto;

/**
 * IoT 치료 기기에서 전송하는 치료 데이터 DTO
 * 치료 모드: V(진동), I(이온토포레시스), T(고주파), L(LED)
 */
public class TreatmentDataRequest {
    private String deviceId;        // 기기 고유 ID
    private String patientName;     // 환자 이름
    private String birthDate;       // 생년월일
    private String treatmentType;   // 치료 타입: V, I, T, L

    // V Mode (진동 치료)
    private String vMode;           // 진동 모드
    private String vSensitivity;    // 진동 민감도
    private String vTime;           // 진동 시간
    private String vHz;             // 진동 주파수

    // I Mode (이온토포레시스)
    private String iTime;           // 치료 시간
    private String iCurrent;        // 전류량

    // T Mode (고주파)
    private String tTime;           // 치료 시간
    private String tVoltage;        // 전압
    private String tHz;             // 주파수

    // L Mode (LED 치료)
    private String lMode;           // LED 모드
    private String lBrightness;     // 밝기
    private String lTime;           // 치료 시간
    private String lHz;             // 주파수

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

    public String getTreatmentType() {
        return treatmentType;
    }

    public void setTreatmentType(String treatmentType) {
        this.treatmentType = treatmentType;
    }

    public String getvMode() {
        return vMode;
    }

    public void setvMode(String vMode) {
        this.vMode = vMode;
    }

    public String getvSensitivity() {
        return vSensitivity;
    }

    public void setvSensitivity(String vSensitivity) {
        this.vSensitivity = vSensitivity;
    }

    public String getvTime() {
        return vTime;
    }

    public void setvTime(String vTime) {
        this.vTime = vTime;
    }

    public String getvHz() {
        return vHz;
    }

    public void setvHz(String vHz) {
        this.vHz = vHz;
    }

    public String getiTime() {
        return iTime;
    }

    public void setiTime(String iTime) {
        this.iTime = iTime;
    }

    public String getiCurrent() {
        return iCurrent;
    }

    public void setiCurrent(String iCurrent) {
        this.iCurrent = iCurrent;
    }

    public String gettTime() {
        return tTime;
    }

    public void settTime(String tTime) {
        this.tTime = tTime;
    }

    public String gettVoltage() {
        return tVoltage;
    }

    public void settVoltage(String tVoltage) {
        this.tVoltage = tVoltage;
    }

    public String gettHz() {
        return tHz;
    }

    public void settHz(String tHz) {
        this.tHz = tHz;
    }

    public String getlMode() {
        return lMode;
    }

    public void setlMode(String lMode) {
        this.lMode = lMode;
    }

    public String getlBrightness() {
        return lBrightness;
    }

    public void setlBrightness(String lBrightness) {
        this.lBrightness = lBrightness;
    }

    public String getlTime() {
        return lTime;
    }

    public void setlTime(String lTime) {
        this.lTime = lTime;
    }

    public String getlHz() {
        return lHz;
    }

    public void setlHz(String lHz) {
        this.lHz = lHz;
    }
}

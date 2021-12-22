package lsj.spring.project.controller;

import lsj.spring.project.dto.ApiResponse;
import lsj.spring.project.dto.SkinAnalysisRequest;
import lsj.spring.project.dto.TreatmentDataRequest;
import lsj.spring.project.service.AdminDataService;
import lsj.spring.project.vo.AdminData;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * IoT 피부 측정 기기와 통신하는 REST API 컨트롤러
 * C++ 임베디드 모듈에서 HTTP POST로 JSON 데이터 전송
 */
@RestController
@RequestMapping("/api/iot")
public class IoTApiController {

    private static final Logger logger = LoggerFactory.getLogger(IoTApiController.class);

    @Autowired
    private AdminDataService adminDataService;

    /**
     * 기기 연결 상태 확인 (Health Check)
     * GET /api/iot/health
     */
    @GetMapping("/health")
    public ResponseEntity<ApiResponse<Map<String, Object>>> healthCheck() {
        Map<String, Object> data = new HashMap<>();
        data.put("status", "online");
        data.put("serverTime", System.currentTimeMillis());
        data.put("version", "1.0.0");

        return ResponseEntity.ok(ApiResponse.success("Server is running", data));
    }

    /**
     * 피부 분석 데이터 수신
     * POST /api/iot/skin-analysis
     *
     * C++ IoT 기기에서 전송하는 JSON 예시:
     * {
     *   "deviceId": "DEVICE001",
     *   "patientName": "홍길동",
     *   "birthDate": "1990-01-01",
     *   "pd1": "125",
     *   "pd2": "130",
     *   "hz": "50",
     *   "s1": "45",
     *   "s2": "52",
     *   "s3": "48",
     *   "moistureLevel": "65",
     *   "thicknessResult": "normal",
     *   "elasticityResult": "good",
     *   "moistureLevelResult": "adequate"
     * }
     */
    @PostMapping("/skin-analysis")
    public ResponseEntity<ApiResponse<Map<String, Object>>> receiveSkinAnalysis(
            @RequestBody SkinAnalysisRequest request,
            @RequestHeader(value = "X-API-Key", required = false) String apiKey) {

        logger.info("Received skin analysis data from device: {}", request.getDeviceId());

        try {
            // DTO를 AdminData VO로 변환
            AdminData adminData = new AdminData();
            adminData.setUname(request.getPatientName());
            adminData.setUbdate(request.getBirthDate());
            adminData.setPd1(request.getPd1());
            adminData.setPd2(request.getPd2());
            adminData.setHz(request.getHz());
            adminData.setS1(request.getS1());
            adminData.setS2(request.getS2());
            adminData.setS3(request.getS3());
            adminData.setMoistureLev(request.getMoistureLevel());
            adminData.setThicknessRes(request.getThicknessResult());
            adminData.setElasticityRes(request.getElasticityResult());
            adminData.setMoistureLevRes(request.getMoistureLevelResult());

            // DB에 저장
            adminDataService.newAdminDataLog(adminData);

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("deviceId", request.getDeviceId());
            responseData.put("receivedAt", System.currentTimeMillis());
            responseData.put("status", "stored");

            logger.info("Skin analysis data stored successfully for patient: {}", request.getPatientName());

            return ResponseEntity.ok(ApiResponse.success("Data received and stored successfully", responseData));

        } catch (Exception e) {
            logger.error("Error processing skin analysis data: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error("Failed to process data: " + e.getMessage()));
        }
    }

    /**
     * 치료 데이터 수신
     * POST /api/iot/treatment
     *
     * 치료 타입별 JSON 예시:
     *
     * V Mode (진동):
     * {
     *   "deviceId": "DEVICE001",
     *   "patientName": "홍길동",
     *   "birthDate": "1990-01-01",
     *   "treatmentType": "V",
     *   "vMode": "soft",
     *   "vSensitivity": "medium",
     *   "vTime": "15",
     *   "vHz": "60"
     * }
     */
    @PostMapping("/treatment")
    public ResponseEntity<ApiResponse<Map<String, Object>>> receiveTreatmentData(
            @RequestBody TreatmentDataRequest request,
            @RequestHeader(value = "X-API-Key", required = false) String apiKey) {

        logger.info("Received treatment data - Type: {}, Device: {}",
                request.getTreatmentType(), request.getDeviceId());

        try {
            AdminData adminData = new AdminData();
            adminData.setUname(request.getPatientName());
            adminData.setUbdate(request.getBirthDate());

            String treatmentType = request.getTreatmentType();

            // 치료 타입에 따라 다른 서비스 메소드 호출
            switch (treatmentType) {
                case "V": // 진동 치료
                    adminData.setvMode(request.getvMode());
                    adminData.setvSensitivity(request.getvSensitivity());
                    adminData.setvTime(request.getvTime());
                    adminData.setvHz(request.getvHz());
                    adminDataService.newAdminDataCureV(adminData);
                    break;

                case "I": // 이온토포레시스
                    adminData.setiTime(request.getiTime());
                    adminData.setiCurrent(request.getiCurrent());
                    adminDataService.newAdminDataCureI(adminData);
                    break;

                case "T": // 고주파
                    adminData.settTime(request.gettTime());
                    adminData.settVoltage(request.gettVoltage());
                    adminData.settHz(request.gettHz());
                    adminDataService.newAdminDataCureT(adminData);
                    break;

                case "L": // LED
                    adminData.setlMode(request.getlMode());
                    adminData.setlBrightness(request.getlBrightness());
                    adminData.setlTime(request.getlTime());
                    adminData.setlHz(request.getlHz());
                    adminDataService.newAdminDataCureL(adminData);
                    break;

                default:
                    return ResponseEntity.badRequest()
                            .body(ApiResponse.error("Invalid treatment type: " + treatmentType));
            }

            Map<String, Object> responseData = new HashMap<>();
            responseData.put("deviceId", request.getDeviceId());
            responseData.put("treatmentType", treatmentType);
            responseData.put("receivedAt", System.currentTimeMillis());
            responseData.put("status", "stored");

            logger.info("Treatment data stored successfully - Type: {}, Patient: {}",
                    treatmentType, request.getPatientName());

            return ResponseEntity.ok(ApiResponse.success("Treatment data stored successfully", responseData));

        } catch (Exception e) {
            logger.error("Error processing treatment data: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error("Failed to process data: " + e.getMessage()));
        }
    }

    /**
     * 실시간 텔레메트리 데이터 수신 (Batch)
     * POST /api/iot/telemetry/batch
     *
     * 여러 측정 데이터를 한번에 전송할 때 사용
     */
    @PostMapping("/telemetry/batch")
    public ResponseEntity<ApiResponse<Map<String, Object>>> receiveBatchTelemetry(
            @RequestBody List<SkinAnalysisRequest> requests,
            @RequestHeader(value = "X-API-Key", required = false) String apiKey) {

        logger.info("Received batch telemetry data - Count: {}", requests.size());

        int successCount = 0;
        int failCount = 0;

        for (SkinAnalysisRequest request : requests) {
            try {
                AdminData adminData = new AdminData();
                adminData.setUname(request.getPatientName());
                adminData.setUbdate(request.getBirthDate());
                adminData.setPd1(request.getPd1());
                adminData.setPd2(request.getPd2());
                adminData.setHz(request.getHz());
                adminData.setS1(request.getS1());
                adminData.setS2(request.getS2());
                adminData.setS3(request.getS3());
                adminData.setMoistureLev(request.getMoistureLevel());
                adminData.setThicknessRes(request.getThicknessResult());
                adminData.setElasticityRes(request.getElasticityResult());
                adminData.setMoistureLevRes(request.getMoistureLevelResult());

                adminDataService.newAdminDataLog(adminData);
                successCount++;
            } catch (Exception e) {
                logger.error("Failed to process telemetry for device {}: {}",
                        request.getDeviceId(), e.getMessage());
                failCount++;
            }
        }

        Map<String, Object> responseData = new HashMap<>();
        responseData.put("totalReceived", requests.size());
        responseData.put("successCount", successCount);
        responseData.put("failCount", failCount);
        responseData.put("processedAt", System.currentTimeMillis());

        if (failCount > 0) {
            return ResponseEntity.ok(ApiResponse.success(
                    String.format("Batch processing completed with %d failures", failCount), responseData));
        }

        return ResponseEntity.ok(ApiResponse.success("All telemetry data processed successfully", responseData));
    }

    /**
     * 기기별 데이터 조회
     * GET /api/iot/data?patientName=홍길동
     */
    @GetMapping("/data")
    public ResponseEntity<ApiResponse<List<AdminData>>> getPatientData(
            @RequestParam(required = false) String patientName,
            @RequestHeader(value = "X-API-Key", required = false) String apiKey) {

        try {
            List<AdminData> dataList = adminDataService.readAllAdminData();

            return ResponseEntity.ok(ApiResponse.success("Data retrieved successfully", dataList));

        } catch (Exception e) {
            logger.error("Error retrieving data: {}", e.getMessage());
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body(ApiResponse.error("Failed to retrieve data: " + e.getMessage()));
        }
    }
}

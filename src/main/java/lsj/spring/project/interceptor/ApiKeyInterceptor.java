package lsj.spring.project.interceptor;

import com.fasterxml.jackson.databind.ObjectMapper;
import lsj.spring.project.dto.ApiResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.HandlerInterceptor;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * IoT API 인증을 위한 인터셉터
 * X-API-Key 헤더를 검증하여 인증된 기기만 접근 허용
 */
public class ApiKeyInterceptor implements HandlerInterceptor {

    private static final Logger logger = LoggerFactory.getLogger(ApiKeyInterceptor.class);
    private static final ObjectMapper objectMapper = new ObjectMapper();

    // API Key - 환경변수(IOT_API_KEY)에서 읽고, 없으면 기본값 사용
    private static final String VALID_API_KEY =
            System.getenv("IOT_API_KEY") != null ? System.getenv("IOT_API_KEY") : "THE3-IOT-API-KEY-2021";

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler)
            throws Exception {

        String requestUri = request.getRequestURI();
        String method = request.getMethod();

        // Health check는 인증 없이 허용
        if (requestUri.endsWith("/health") && "GET".equals(method)) {
            return true;
        }

        // OPTIONS 요청은 CORS preflight이므로 허용
        if ("OPTIONS".equals(method)) {
            return true;
        }

        // API Key 검증
        String apiKey = request.getHeader("X-API-Key");

        if (apiKey == null || apiKey.isEmpty()) {
            logger.warn("API request without API key - URI: {}, IP: {}",
                    requestUri, request.getRemoteAddr());
            sendUnauthorizedResponse(response, "API key is required");
            return false;
        }

        if (!VALID_API_KEY.equals(apiKey)) {
            logger.warn("Invalid API key attempt - URI: {}, IP: {}, Key: {}",
                    requestUri, request.getRemoteAddr(), apiKey);
            sendUnauthorizedResponse(response, "Invalid API key");
            return false;
        }

        logger.info("API request authenticated - URI: {}, IP: {}",
                requestUri, request.getRemoteAddr());

        return true;
    }

    private void sendUnauthorizedResponse(HttpServletResponse response, String message) throws IOException {
        response.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
        response.setContentType("application/json;charset=UTF-8");

        ApiResponse<Object> apiResponse = ApiResponse.error(message);
        response.getWriter().write(objectMapper.writeValueAsString(apiResponse));
    }
}

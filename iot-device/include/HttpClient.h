#ifndef HTTP_CLIENT_H
#define HTTP_CLIENT_H

#include <string>
#include <map>
#include <functional>

/**
 * HttpClient - HTTP 통신 클라이언트
 *
 * libcurl을 사용하여 서버와 HTTP 통신을 수행하는 클래스
 * - REST API 호출 (GET, POST)
 * - JSON 데이터 송수신
 * - API Key 인증 지원
 */
class HttpClient {
public:
    // HTTP 응답 구조체
    struct Response {
        int statusCode;
        std::string body;
        std::map<std::string, std::string> headers;
        bool success;
        std::string errorMessage;
    };

    // 콜백 타입 정의
    using ResponseCallback = std::function<void(const Response&)>;

public:
    HttpClient();
    HttpClient(const std::string& baseUrl, const std::string& apiKey);
    ~HttpClient();

    // 초기화
    bool initialize();
    void cleanup();

    // 기본 URL 설정
    void setBaseUrl(const std::string& url);

    // API Key 설정
    void setApiKey(const std::string& apiKey);

    // 헤더 추가
    void addHeader(const std::string& key, const std::string& value);

    // HTTP GET 요청
    Response get(const std::string& endpoint);
    void getAsync(const std::string& endpoint, ResponseCallback callback);

    // HTTP POST 요청 (JSON)
    Response post(const std::string& endpoint, const std::string& jsonBody);
    void postAsync(const std::string& endpoint, const std::string& jsonBody, ResponseCallback callback);

    // 서버 연결 상태 확인
    bool checkConnection();

    // 타임아웃 설정 (초)
    void setTimeout(int seconds);

private:
    // CURL 콜백 함수
    static size_t writeCallback(void* contents, size_t size, size_t nmemb, std::string* userp);

    // 내부 요청 처리
    Response performRequest(const std::string& url, const std::string& method, const std::string& body = "");

    // 멤버 변수
    std::string m_baseUrl;
    std::string m_apiKey;
    std::map<std::string, std::string> m_headers;
    int m_timeout;
    bool m_initialized;
};

#endif // HTTP_CLIENT_H

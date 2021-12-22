#include "HttpClient.h"
#include <curl/curl.h>
#include <iostream>
#include <thread>

HttpClient::HttpClient()
    : m_timeout(30)
    , m_initialized(false)
{
}

HttpClient::HttpClient(const std::string& baseUrl, const std::string& apiKey)
    : m_baseUrl(baseUrl)
    , m_apiKey(apiKey)
    , m_timeout(30)
    , m_initialized(false)
{
}

HttpClient::~HttpClient()
{
    cleanup();
}

bool HttpClient::initialize()
{
    CURLcode res = curl_global_init(CURL_GLOBAL_DEFAULT);
    if (res != CURLE_OK) {
        std::cerr << "Failed to initialize CURL: " << curl_easy_strerror(res) << std::endl;
        return false;
    }

    m_initialized = true;

    // 기본 헤더 설정
    m_headers["Content-Type"] = "application/json";
    m_headers["Accept"] = "application/json";

    if (!m_apiKey.empty()) {
        m_headers["X-API-Key"] = m_apiKey;
    }

    return true;
}

void HttpClient::cleanup()
{
    if (m_initialized) {
        curl_global_cleanup();
        m_initialized = false;
    }
}

void HttpClient::setBaseUrl(const std::string& url)
{
    m_baseUrl = url;
}

void HttpClient::setApiKey(const std::string& apiKey)
{
    m_apiKey = apiKey;
    m_headers["X-API-Key"] = apiKey;
}

void HttpClient::addHeader(const std::string& key, const std::string& value)
{
    m_headers[key] = value;
}

void HttpClient::setTimeout(int seconds)
{
    m_timeout = seconds;
}

size_t HttpClient::writeCallback(void* contents, size_t size, size_t nmemb, std::string* userp)
{
    size_t totalSize = size * nmemb;
    userp->append(static_cast<char*>(contents), totalSize);
    return totalSize;
}

HttpClient::Response HttpClient::performRequest(const std::string& url, const std::string& method, const std::string& body)
{
    Response response;
    response.success = false;
    response.statusCode = 0;

    if (!m_initialized) {
        response.errorMessage = "HttpClient not initialized";
        return response;
    }

    CURL* curl = curl_easy_init();
    if (!curl) {
        response.errorMessage = "Failed to create CURL handle";
        return response;
    }

    std::string responseBody;

    // URL 설정
    curl_easy_setopt(curl, CURLOPT_URL, url.c_str());

    // 타임아웃 설정
    curl_easy_setopt(curl, CURLOPT_TIMEOUT, m_timeout);

    // 응답 콜백 설정
    curl_easy_setopt(curl, CURLOPT_WRITEFUNCTION, writeCallback);
    curl_easy_setopt(curl, CURLOPT_WRITEDATA, &responseBody);

    // 헤더 설정
    struct curl_slist* headers = nullptr;
    for (const auto& header : m_headers) {
        std::string headerStr = header.first + ": " + header.second;
        headers = curl_slist_append(headers, headerStr.c_str());
    }
    curl_easy_setopt(curl, CURLOPT_HTTPHEADER, headers);

    // 메서드별 설정
    if (method == "POST") {
        curl_easy_setopt(curl, CURLOPT_POST, 1L);
        curl_easy_setopt(curl, CURLOPT_POSTFIELDS, body.c_str());
        curl_easy_setopt(curl, CURLOPT_POSTFIELDSIZE, body.length());
    } else if (method == "GET") {
        curl_easy_setopt(curl, CURLOPT_HTTPGET, 1L);
    }

    // SSL 검증 (개발 환경에서는 비활성화 가능)
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYPEER, 0L);
    curl_easy_setopt(curl, CURLOPT_SSL_VERIFYHOST, 0L);

    // 요청 수행
    CURLcode res = curl_easy_perform(curl);

    if (res != CURLE_OK) {
        response.errorMessage = curl_easy_strerror(res);
    } else {
        response.success = true;
        response.body = responseBody;

        long httpCode = 0;
        curl_easy_getinfo(curl, CURLINFO_RESPONSE_CODE, &httpCode);
        response.statusCode = static_cast<int>(httpCode);
    }

    // 정리
    curl_slist_free_all(headers);
    curl_easy_cleanup(curl);

    return response;
}

HttpClient::Response HttpClient::get(const std::string& endpoint)
{
    std::string url = m_baseUrl + endpoint;
    return performRequest(url, "GET");
}

void HttpClient::getAsync(const std::string& endpoint, ResponseCallback callback)
{
    std::thread([this, endpoint, callback]() {
        Response response = get(endpoint);
        if (callback) {
            callback(response);
        }
    }).detach();
}

HttpClient::Response HttpClient::post(const std::string& endpoint, const std::string& jsonBody)
{
    std::string url = m_baseUrl + endpoint;
    return performRequest(url, "POST", jsonBody);
}

void HttpClient::postAsync(const std::string& endpoint, const std::string& jsonBody, ResponseCallback callback)
{
    std::thread([this, endpoint, jsonBody, callback]() {
        Response response = post(endpoint, jsonBody);
        if (callback) {
            callback(response);
        }
    }).detach();
}

bool HttpClient::checkConnection()
{
    Response response = get("/api/iot/health");
    return response.success && response.statusCode == 200;
}

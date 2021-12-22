cmake_minimum_required(VERSION 3.10)

project(THE3_SkinAnalyzer
    VERSION 1.0.0
    DESCRIPTION "THE 3.0 Skin Analysis IoT Device"
    LANGUAGES CXX
)

# C++ 표준 설정
set(CMAKE_CXX_STANDARD 14)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

# 컴파일러 옵션
if(MSVC)
    add_compile_options(/W4)
else()
    add_compile_options(-Wall -Wextra -pedantic)
endif()

# libcurl 찾기
find_package(CURL REQUIRED)

# 헤더 파일 디렉토리
include_directories(${PROJECT_SOURCE_DIR}/include)
include_directories(${CURL_INCLUDE_DIRS})

# 소스 파일
set(SOURCES
    src/main.cpp
    src/HttpClient.cpp
    src/SkinSensor.cpp
)

# 헤더 파일
set(HEADERS
    include/Config.h
    include/HttpClient.h
    include/SkinSensor.h
)

# 실행 파일 생성
add_executable(${PROJECT_NAME} ${SOURCES} ${HEADERS})

# 라이브러리 링크
target_link_libraries(${PROJECT_NAME} PRIVATE ${CURL_LIBRARIES})

# pthread (Linux/macOS)
if(NOT MSVC)
    find_package(Threads REQUIRED)
    target_link_libraries(${PROJECT_NAME} PRIVATE Threads::Threads)
endif()

# 설치 설정
install(TARGETS ${PROJECT_NAME}
    RUNTIME DESTINATION bin
)

# 디버그/릴리즈 빌드 타입
if(NOT CMAKE_BUILD_TYPE)
    set(CMAKE_BUILD_TYPE Release)
endif()

message(STATUS "Build type: ${CMAKE_BUILD_TYPE}")
message(STATUS "C++ Standard: ${CMAKE_CXX_STANDARD}")

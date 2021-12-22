# THE 3.0 Skin Analysis IoT Device

피부과 진단 기기의 임베디드 소프트웨어입니다. C++로 작성되었으며, 피부 측정 센서 데이터를 수집하여 백엔드 서버로 전송합니다.

## 기능

- **피부 분석 측정**: 광센서, 수분 센서, 탄력 센서 데이터 수집
- **치료 모드 제어**: 진동(V), 이온토포레시스(I), 고주파(T), LED(L) 치료
- **REST API 통신**: HTTP POST로 JSON 데이터 전송
- **API Key 인증**: X-API-Key 헤더 기반 인증

## 시스템 요구사항

- CMake 3.10+
- C++14 호환 컴파일러
- libcurl

## 빌드 방법

### Linux/macOS

```bash
# 의존성 설치 (Ubuntu/Debian)
sudo apt-get install cmake libcurl4-openssl-dev

# 빌드
mkdir build && cd build
cmake ..
make

# 실행
./THE3_SkinAnalyzer
```

### Windows (Visual Studio)

```powershell
# vcpkg로 libcurl 설치
vcpkg install curl:x64-windows

# 빌드
mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg root]/scripts/buildsystems/vcpkg.cmake
cmake --build . --config Release
```

## 서버 통신

### API 엔드포인트

| 엔드포인트 | 메서드 | 설명 |
|-----------|--------|------|
| `/api/iot/health` | GET | 서버 상태 확인 |
| `/api/iot/skin-analysis` | POST | 피부 분석 데이터 전송 |
| `/api/iot/treatment` | POST | 치료 데이터 전송 |

### 요청 예시 (피부 분석)

```json
{
  "deviceId": "THE3-SKIN-DEVICE-001",
  "patientName": "홍길동",
  "birthDate": "1990-01-01",
  "pd1": "125.50",
  "pd2": "130.25",
  "hz": "50.00",
  "s1": "45.30",
  "s2": "52.80",
  "s3": "48.00",
  "moistureLevel": "65.00",
  "thicknessResult": "normal",
  "elasticityResult": "good",
  "moistureLevelResult": "normal"
}
```

### 인증

모든 API 요청에 다음 헤더가 필요합니다:

```
X-API-Key: THE3-IOT-API-KEY-2024
```

## 파일 구조

```
iot-device/
├── CMakeLists.txt          # CMake 빌드 설정
├── README.md               # 이 문서
├── include/
│   ├── Config.h            # 설정 값
│   ├── HttpClient.h        # HTTP 클라이언트
│   └── SkinSensor.h        # 센서 모듈
└── src/
    ├── main.cpp            # 메인 프로그램
    ├── HttpClient.cpp      # HTTP 통신 구현
    └── SkinSensor.cpp      # 센서 데이터 처리
```

## 설정

`include/Config.h` 파일에서 서버 URL, API Key 등을 설정할 수 있습니다:

```cpp
namespace Config {
    const std::string SERVER_URL = "http://localhost:8080";
    const std::string API_KEY = "THE3-IOT-API-KEY-2024";
    const std::string DEVICE_ID = "THE3-SKIN-DEVICE-001";
}
```

## 하드웨어 연동

실제 하드웨어 연동 시 `SkinSensor.cpp`의 센서 읽기 함수를 수정하여 GPIO, I2C, SPI 등의 실제 센서 인터페이스와 연동합니다.

```cpp
SkinSensor::SensorData SkinSensor::readSensorData()
{
    // TODO: 실제 하드웨어 ADC 값 읽기
    // 예: wiringPi, pigpio 등 사용
}
```

## 라이선스

Copyright (c) 2021 THE 3.0 Co., Ltd.

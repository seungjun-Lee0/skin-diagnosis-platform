# THE 3.0 Skin Analysis IoT Device

피부과 진단 기기의 임베디드 소프트웨어입니다. C++로 작성되었으며, 피부 측정 센서 데이터를 수집하여 백엔드 서버로 전송합니다.

## 기능

- **피부 분석 측정**: 광센서, 수분 센서, 탄력 센서 데이터 수집
- **치료 모드 제어**: 진동(V), 이온토포레시스(I), 고주파(T), LED(L) 치료
- **REST API 통신**: HTTP POST로 JSON 데이터 전송
- **환경변수 기반 설정**: API 키 등 보안 설정을 환경변수로 관리
- **HAL 추상화**: 플랫폼 독립적 하드웨어 추상화 레이어

## 하드웨어 구성

| 센서/부품 | 모델 | I2C 주소 | 용도 |
|-----------|------|----------|------|
| ADC | ADS1115 (16-bit) | 0x48 | 광센서 PD1, PD2, 두께 측정 |
| 수분 센서 | SHT31 | 0x44 | 피부 수분/온도 측정 |
| ToF 센서 | VL6180X | 0x29 | 피부 탄력 측정 |
| EEPROM | AT24C256 | 0x50 | 캘리브레이션 데이터 저장 |

### 데이터시트 참조

- ADS1115: [TI SBAS444B](https://www.ti.com/lit/ds/symlink/ads1115.pdf)
- SHT31: [Sensirion SHT31 Datasheet](https://www.sensirion.com/products/catalog/SHT31-DIS-B/)
- VL6180X: [ST DocID025086](https://www.st.com/resource/en/datasheet/vl6180x.pdf)

## 시스템 요구사항

- CMake 3.10+
- C++14 호환 컴파일러
- libcurl

## 환경변수 설정

**필수:**
```bash
export THE3_API_KEY=your_api_key_here
```

**선택:**
```bash
export THE3_SERVER_URL=http://your-server:8080   # 기본값: http://localhost:8080
export THE3_DEVICE_ID=THE3-SKIN-DEVICE-001       # 기본값: THE3-SKIN-DEVICE-001
export THE3_LOG_LEVEL=DEBUG                       # 기본값: INFO
export THE3_LOG_FILE=/var/log/the3-device.log    # 기본값: /var/log/the3-device.log
```

## 빌드 방법

### Linux/macOS

```bash
# 의존성 설치 (Ubuntu/Debian)
sudo apt-get install cmake libcurl4-openssl-dev

# 시뮬레이션 모드 빌드 (하드웨어 없이 테스트)
mkdir build && cd build
cmake .. -DPLATFORM_SIMULATION=ON
make

# 실제 하드웨어 빌드 (Raspberry Pi)
cmake .. -DPLATFORM_RPI=ON
make

# 실행
export THE3_API_KEY=your_api_key
./THE3_SkinAnalyzer
```

### Raspberry Pi

```bash
# 의존성 설치
sudo apt-get install cmake libcurl4-openssl-dev i2c-tools

# I2C 활성화
sudo raspi-config
# Interface Options > I2C > Enable

# 빌드
mkdir build && cd build
cmake .. -DPLATFORM_RPI=ON
make

# I2C 장치 확인
i2cdetect -y 1
# Expected: 0x29, 0x44, 0x48, 0x50
```

### Windows (Visual Studio)

```powershell
# vcpkg로 libcurl 설치
vcpkg install curl:x64-windows

# 빌드
mkdir build && cd build
cmake .. -DCMAKE_TOOLCHAIN_FILE=[vcpkg root]/scripts/buildsystems/vcpkg.cmake -DPLATFORM_SIMULATION=ON
cmake --build . --config Release
```

## 서버 통신

### API 엔드포인트

| 엔드포인트 | 메서드 | 설명 |
|-----------|--------|------|
| `/api/iot/health` | GET | 서버 상태 확인 |
| `/api/iot/skin-analysis` | POST | 피부 분석 데이터 전송 |
| `/api/iot/treatment` | POST | 치료 데이터 전송 |
| `/api/iot/telemetry/batch` | POST | 배치 텔레메트리 전송 |

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
X-API-Key: [THE3_API_KEY 환경변수 값]
```

## 파일 구조

```
iot-device/
├── CMakeLists.txt              # CMake 빌드 설정
├── README.md                   # 이 문서
├── include/
│   ├── Config.h                # 환경변수 기반 설정
│   ├── HardwareAbstraction.h   # HAL 인터페이스 및 I2C/GPIO 정의
│   ├── HttpClient.h            # HTTP 클라이언트
│   └── SkinSensor.h            # 센서 모듈 (I2C 주소, 레지스터 정의)
└── src/
    ├── main.cpp                # 메인 프로그램
    ├── HttpClient.cpp          # HTTP 통신 구현 (libcurl)
    └── SkinSensor.cpp          # 센서 HAL 구현 및 시뮬레이션
```

## 아키텍처

```
┌─────────────────────────────────────────────────────────────────┐
│                      Application Layer                          │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────────────────┐ │
│  │   main.cpp  │  │ HttpClient  │  │       SkinSensor        │ │
│  └─────────────┘  └─────────────┘  └─────────────────────────┘ │
├─────────────────────────────────────────────────────────────────┤
│                 Hardware Abstraction Layer (HAL)                │
│  ┌─────────────────────────────────────────────────────────────┐│
│  │  I2CInterface  │  GPIOInterface  │  Platform Detection     ││
│  └─────────────────────────────────────────────────────────────┘│
├─────────────────────────────────────────────────────────────────┤
│                    Platform Implementation                       │
│  ┌───────────────┐  ┌───────────────┐  ┌──────────────────────┐│
│  │ Simulation    │  │ Raspberry Pi  │  │ STM32 (future)       ││
│  │ (Testing)     │  │ (bcm2835)     │  │                      ││
│  └───────────────┘  └───────────────┘  └──────────────────────┘│
└─────────────────────────────────────────────────────────────────┘
```

## 캘리브레이션

기기별 캘리브레이션 데이터는 EEPROM에 저장됩니다:

```
EEPROM Layout (AT24C256):
Offset  Size    Description
0x00    4       Magic number (0x54483330 = "TH30")
0x04    2       Version
0x06    2       CRC16 checksum
0x08    4       PD1 offset (float)
0x0C    4       PD2 offset (float)
0x10    4       Moisture scale (float)
0x14    4       Moisture offset (float)
...
0x30    16      Serial number
0x40    4       Manufacturing date (Unix timestamp)
0x44    4       Last calibration date
```

## 진단 명령

프로그램 실행 후 메뉴에서:

```
8. Self test - Run sensor diagnostics
```

Self-test 결과:
- Bit 0: ADC (ADS1115) 상태
- Bit 1: 수분 센서 (SHT31) 상태
- Bit 2: ToF 센서 (VL6180X) 상태
- Bit 3: EEPROM (AT24C256) 상태

## 라이선스

Copyright (c) 2021 THE 3.0 Co., Ltd.

이 소프트웨어는 중소기업기술정보진흥원(TIPA) 지원 정부 R&D 과제로 개발되었습니다.

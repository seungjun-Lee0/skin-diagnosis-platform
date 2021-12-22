-- 데이터베이스 스키마 생성
CREATE DATABASE IF NOT EXISTS the3 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE the3;

-- 1. 회원 테이블
CREATE TABLE IF NOT EXISTS the3_member (
    mno INT AUTO_INCREMENT PRIMARY KEY,
    uname VARCHAR(50) NOT NULL,
    uid VARCHAR(50) NOT NULL UNIQUE,
    upwd VARCHAR(255) NOT NULL,
    salt VARCHAR(255),
    uemail VARCHAR(100),
    utel VARCHAR(20),
    sms VARCHAR(10) DEFAULT 'false',
    mail VARCHAR(10) DEFAULT 'false',
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. 피부 진단 테이블
CREATE TABLE IF NOT EXISTS the3_diagnosis (
    dno INT AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(50),
    uemail VARCHAR(100),
    uname VARCHAR(50),
    c1 VARCHAR(255),
    c2 VARCHAR(255),
    c3 VARCHAR(255),
    c4 VARCHAR(255),
    c5 VARCHAR(255),
    c6 VARCHAR(255),
    s1 VARCHAR(255),
    s2 VARCHAR(255),
    s3 VARCHAR(255),
    s4 VARCHAR(255),
    s5 VARCHAR(255),
    s6 VARCHAR(255),
    s7 VARCHAR(255),
    s8 VARCHAR(255),
    s9 VARCHAR(255),
    s10 VARCHAR(255),
    s11 VARCHAR(255),
    s12 VARCHAR(255),
    fnames TEXT,
    uuid VARCHAR(255),
    status VARCHAR(20) DEFAULT 'pending',
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 3. 여드름 점수 테이블
CREATE TABLE IF NOT EXISTS the3_acne (
    ano INT AUTO_INCREMENT PRIMARY KEY,
    fname VARCHAR(255),
    avg FLOAT,
    fh FLOAT,
    lc FLOAT,
    rc FLOAT,
    nose FLOAT,
    chin FLOAT
);

-- 4. 이벤트 테이블
CREATE TABLE IF NOT EXISTS the3_event (
    bno INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    sdate DATE,
    edate DATE,
    fnames TEXT,
    uuid VARCHAR(255),
    views INT DEFAULT 0,
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 5. 공지사항 테이블
CREATE TABLE IF NOT EXISTS the3_notice (
    bno INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    content TEXT,
    fixed VARCHAR(10) DEFAULT 'false',
    fnames TEXT,
    uuid VARCHAR(255),
    views INT DEFAULT 0,
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 6. 상담 문의 테이블
CREATE TABLE IF NOT EXISTS the3_inquiry (
    bno INT AUTO_INCREMENT PRIMARY KEY,
    uid VARCHAR(50),
    pwd VARCHAR(255),
    title VARCHAR(255) NOT NULL,
    content TEXT,
    fixed VARCHAR(10) DEFAULT 'false',
    secret VARCHAR(10) DEFAULT 'false',
    fnames TEXT,
    uuid VARCHAR(255),
    views INT DEFAULT 0,
    comment INT DEFAULT 0,
    status VARCHAR(10) DEFAULT 'false',
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 7. 상담 답변 테이블
CREATE TABLE IF NOT EXISTS the3_inquiryReply (
    rno INT AUTO_INCREMENT PRIMARY KEY,
    content TEXT,
    uid VARCHAR(50),
    bno INT,
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (bno) REFERENCES the3_inquiry(bno) ON DELETE CASCADE
);

-- 8. 관리자 데이터 테이블
CREATE TABLE IF NOT EXISTS the3_adminData (
    adno INT AUTO_INCREMENT PRIMARY KEY,
    uname VARCHAR(50),
    ubdate VARCHAR(20),
    pd1 VARCHAR(50),
    pd2 VARCHAR(50),
    hz VARCHAR(50),
    s1 VARCHAR(50),
    s2 VARCHAR(50),
    s3 VARCHAR(50),
    moistureLev VARCHAR(50),
    thicknessRes VARCHAR(50),
    elasticityRes VARCHAR(50),
    moistureLevRes VARCHAR(50),
    type VARCHAR(10),
    vMode VARCHAR(50),
    vSensitivity VARCHAR(50),
    vTime VARCHAR(50),
    vHz VARCHAR(50),
    iTime VARCHAR(50),
    iCurrent VARCHAR(50),
    tTime VARCHAR(50),
    tVoltage VARCHAR(50),
    tHz VARCHAR(50),
    lMode VARCHAR(50),
    lBrightness VARCHAR(50),
    lTime VARCHAR(50),
    lHz VARCHAR(50),
    regdate TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 기본 관리자 계정 추가
-- ID: admin / PW: admin1234
INSERT INTO the3_member (uname, uid, upwd, salt, uemail, utel, sms, mail)
VALUES ('관리자', 'admin', '73b8d2f648dc278248b9e45ff54fefb73076e400446397e243b001ee85776563', 'a1b2c3d4e5f6a7b8a1b2c3d4e5f6a7b8', 'admin@the3.com', '010-0000-0000', 'false', 'false');

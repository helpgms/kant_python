-- 데이터베이스 생성(Data Definition Lauguage => DDL) 
CREATE DATABASE sportscenter;

-- 회원 테이블 (DDL)

CREATE TABLE members
(
    member_id   SERIAL      PRIMARY KEY,
    name        VARCHAR(30) NOT NULL,
    gender      CHAR(1)     NOT NULL,
    brith_year  SMALLINT    NOT NULL,
    phone       VARCHAR(20),
    email       VARCHAR(50),
    region      VARCHAR(10),
    join_date   DATE        NOT NULL
);

-- 회원 등록
-- INSERT INTO members (컬럼1, 컬럼2, 컬럼3) VALUES (컬럼1, 컬럼2, 컬럼 3);

-- INSERT INTO member VALUES (모든 컬럼, , , ,)
-- INSERT INTO member SELECT * FROM WHERE ~~~

--  INSERT INTO members (컬럼1, 컬럼2, 컬럼3)
--  VALUES
--  (컬럼1, 컬럼2, 컬럼3),
--  (컬럼1, 컬럼2, 컬럼3),
--  (컬럼1, 컬럼2, 컬럼3),
--  (컬럼1, 컬럼2, 컬럼3)

-- Data Manipulate Lauguage (DML)
 INSERT INTO members 
 (
    name, 
    gender,
    brith_year,
    phone,
    email,
    region,
    join_date
 )
 VALUES
 (
    '김하늘', 
    'F', 
    1995, 
    '010-1234-5678', 
    'haneul@example.com', 
    '마포구', 
    '2026-09-01'
 );

 INSERT INTO members 
 (
    name, 
    gender, 
    brith_year, 
    phone, 
    email, 
    region, 
    join_date
 )
VALUES 
(
    '이준호', 
    'M', 
    1988, 
    '010-2345-6789', 
    NULL, 
    '서대문구', 
    '2026-09-03'
);

-- 종목 개설 강좌 목록
CREATE TABLE sports
(
    sports_id   SERIAL     PRIMARY KEY,
    sport_name VARCHAR(20) NOT NULL
);

INSERT INTO sports (sport_name) VALUES ('수영');
INSERT INTO sports (sport_name) VALUES ('헬스');

-- 개설 강좌
CREATE TABLE courses
(
    courses_id      SERIAL       PRIMARY KEY,
    sports_id       INT          NOT NULL  REFERENCES sports (sports_id), -- 외래키 (Foregn key)
    course_name     VARCHAR(30)  NOT NULL,
    level           VARCHAR(10)  NOT NULL,
    class_days      VARCHAR(10)  NOT NULL,
    start_time      TIME         NOT NULL,
    capacity        SMALLINT     NOT NULL,
    fee             INT          NOT NULL
);

INSERT INTO courses (sports_id, course_name, level, class_days, start_time, capacity, fee)
VALUES (1, '수영 초급 새벽반', '초급', '월수금', '06:00', 20, 70000);
INSERT INTO courses (sports_id, course_name, level, class_days, start_time, capacity, fee)
VALUES (2, '헬스 자유이용', '자유', '매일', '06:00', 50, 50000);
INSERT INTO courses (sports_id, course_name, level, class_days, start_time, capacity, fee)
VALUES (30, '헬스 자유이용', '자유', '매일', '06:00', 50, 50000);

-- 1:1 사물함 테이블
CREATE TABLE lockers
(
    locker_no   INT     PRIMARY KEY,
    member_id   INT     NOT NULL UNIQUE REFERENCES members(member_id) ON DELETE CASCADE,
    asign_date  DATE    NOT NULL
);

INSERT INTO lockers VALUES (101, 1, '2026-11-01');
INSERT INTO lockers VALUES (103, 3, '2026-11-01');

INSERT INTO members (name, gender, brith_year, join_date)
VALUES ('임시회원', 'M', 2000, '2026-11-01');
SELECT member_id, name FROM members;

-- 데이터베이스 생성 (DDL: Data Definition Lauguage)
CREATE DATABASE sportscenter;

-- 회원 테이블 tbs_테이블명, viw_뷰명 (DDL)

CREATE TABLE members
(
    member_id   SERIAL      PRIMARY KEY,
    name        VARCHAR(30) NOT NULL,
    gender      CHAR(1)     NOT NULL,
    birth_year  SMALLINT    NOT NULL,
    phone       VARCHAR(20),
    email       VARCHAR(50),
    region      VARCHAR(10),
    join_date   DATE        NOT NULL
);

-- 회원 등록 
-- INSERT INTO members (컬럼1, 컬럼2, 컬럼3) VALUES (컬럼1값, 컬럼2값, 컬럼3값);
-- INSERT INTO members VALUES (모든 컬럼, , , , );
-- INSERT INTO members SELECT * FROM WHERE ~~~

-- INSERT INTO members (컬럼1, 컬럼2, 컬럼3) 
-- VALUES 
-- (컬럼1값, 컬럼2값, 컬럼3값),
-- (컬럼1값, 컬럼2값, 컬럼3값),
-- (컬럼1값, 컬럼2값, 컬럼3값),
-- (컬럼1값, 컬럼2값, 컬럼3값)

-- DML : Data Manipulate Lauguage
INSERT INTO members 
(
    name, 
    gender, 
    birth_year,
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

-- 종목 개설강좌 목록
CREATE TABLE sports
(
    sports_id   SERIAL      PRIMARY KEY,
    sport_name  VARCHAR(20) NOT NULL 
);

INSERT INTO sports (sport_name) VALUES ('수영');
INSERT INTO sports (sport_name) VALUES ('헬스');

-- 개설 강좌
CREATE TABLE courses
(
    course_id       SERIAL      PRIMARY KEY,
    sports_id       INT         NOT NULL REFERENCES sports (sports_id), -- 외래키 (Foregn Key)
    course_name     VARCHAR(30) NOT NULL,
    level           VARCHAR(10) NOT NULL,
    class_days      VARCHAR(10) NOT NULL,
    start_time      TIME        NOT NULL,
    capacity        SMALLINT    NOT NULL,
    fee             INT         NOT NULL
);

INSERT INTO courses (sports_id, course_name, level, class_days, start_time, capacity, fee)
VALUES (1, '수영 초급 새벽반', '초급', '월수금', '06:00', 20, 70000);
INSERT INTO courses (sports_id, course_name, level, class_days, start_time, capacity, fee)
VALUES (2, '헬스 자유이용', '자유', '매일', '06:00', 50, 50000);

INSERT INTO courses (sports_id, course_name, level, class_days, start_time, capacity, fee)
VALUES (30, '헬스 자유이용', '자유', '매일', '06:00', 50, 50000);

DROP TABLE IF EXISTS lockers;

-- 1:1 사물함 테이블
CREATE TABLE lockers
(
    locker_no   INT     PRIMARY KEY,
    member_id   INT     NOT NULL UNIQUE REFERENCES members (member_id) ON DELETE CASCADE,
    asign_date  DATE    NOT NULL
);

INSERT INTO lockers VALUES (101, 1, '2026-11-01');

-- 삭제 테스트를 위한 임시 회원 추가
INSERT INTO members (name, gender, birth_year, join_date)
VALUES ('임시회원', 'M', 2000, '2026-11-01');

-- 임시 회원의 락커 배정
INSERT INTO lockers VALUES (102, 3, '2026-11-01');

-- 회원 삭제 시 사물함도 함께 삭제되는지 확인
DELETE FROM members WHERE member_id = 3;

-- 사물함이 삭제되었는지 확인
SELECT * FROM lockers; 

-- 수강 신청 테이블
CREATE TABLE enrollments
(
    member_id       INT             NOT NULL REFERENCES members (member_id),
    course_id       INT             NOT NULL REFERENCES courses (course_id),
    enroll_month    CHAR(7)         NOT NULL,
    status          VARCHAR(10)     NOT NULL,
    pay_amount      NUMERIC(10,2)   NOT NULL CHECK (pay_amount >=0),
    PRIMARY KEY (member_id, course_id, enroll_month)
);

INSERT INTO enrollments 
VALUES (1, 1, '2026-11', '수료', 50000);

INSERT INTO enrollments 
VALUES (2, 2, '2026-10', '수료', 70000);

INSERT INTO enrollments 
VALUES (2, 2, '2026-10', '수료', 60000);
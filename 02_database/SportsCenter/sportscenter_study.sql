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

SELECT course_name, level, start_time 
FROM courses 
WHERE sport_id = 1 
AND (level = '초급' OR start_time < '09:00'); 

SELECT name, birth_year,
       CASE WHEN birth_year <= 1960 THEN '할인'
            WHEN birth_year >= 2000 THEN '청소년 요금제'
            ELSE '일반 요금제'
       END AS 요금구분
FROM members
ORDER BY birth_year, name
LIMIT 10;

-- 수강료가 비싼 순서대로 정렬

SELECT course_name, fee 
FROM courses
WHERE fee >= 80000
ORDER BY fee DESC, course_name;
LIMIT 5;

-- NULL 값 정렬
SELECT name, email
FROM members
ORDER BY email DESC, name;
LIMIT 10;

SELECT 
    COUNT(*)                  AS 강좌수, 
    MIN(fee)                  AS 최저수강료,
    MAX(fee)                  AS 최고수강료,
    SUM(capacity)             AS 전체정원,
    ROUND(AVG(fee), 2)        AS 평균수강료
FROM courses;
    

-- COUNT(*) VS COUNT(컬럼)
SELECT 
    COUNT(*)               AS 회원수,
    COUNT(email)           AS 이메일있음,
    COUNT(phone)           AS 전번있음,
    COUNT(DISTINCT region) AS 거주지
FROM members;

-- 최고 매출 SUM
SELECT 
    COUNT(*)        AS 신청건수 ,
    SUM(pay_amount) AS 매출     ,
    MAX(pay_amount) AS 최고매출
FROM enrollments 
WHERE enroll_month >= '2026-11';

SELECT 
    enroll_month    AS 신청월   , 
    COUNT(*)        AS 신청건수 ,
    SUM(pay_amount) AS 매출
FROM enrollments
GROUP BY enroll_month
ORDER BY enroll_month; 

SELECT 
    enroll_month, status, COUNT(*)  AS 건수
FROM enrollments
GROUP BY enroll_month, status
ORDER BY enroll_month, status;

-- HAVING
SELECT
    course_id, COUNT(*)     AS 누적신청
FROM enrollments
WHERE status <> '취소' 
GROUP BY course_id
HAVING COUNT(*) >= 18
ORDER BY 누적신청 DESC, course_id;

-- 거주지, 해당거주지회원수
-- 조건 : 해당 거주지 회원수 10명 이상인 경우
SELECT
    region  AS 거주지,     COUNT(*)    AS 회원수
FROM members
GROUP BY region
HAVING COUNT(*) >= 10
ORDER BY 회원수 DESC, region;

-- UNION(중복 제거) / UNION ALL
SELECT member_id FROM enrollments WHERE course_id = 4 AND enroll_month = '2026-09'
UNION 
SELECT member_id FROM enrollments WHERE course_id = 4 AND enroll_month = '2026-10'
UNION 
SELECT member_id FROM enrollments WHERE course_id = 4 AND enroll_month = '2026-11'

ORDER BY member_id;

SELECT '강사' AS 구분, name, phone FROM instructors WHERE sport_id = 4
UNION ALL
SELECT '회원' AS 구분, name, phone FROM members WHERE region = '영등포구'; 

SELECT 
    e.member_id, 
    m.name,
    c.course_name,
    e.enroll_month,
    e.status
FROM enrollments e
LEFT JOIN members m ON e.member_id = m.member_id
LEFT JOIN courses c ON e.course_id = c.course_id
WHERE e.course_id = 1 AND e.enroll_month = '2026-11'
ORDER BY m.name;

-- 
SELECT 
    c.course_id,
    c.course_name,
    i.name          AS 강사
FROM courses c
FULL OUTER JOIN instructors i ON c.instructor_id = i.instructor_id
ORDER BY c.course_id;



-- sub 쿼리
SELECT AVG(fee)
FROM courses;

SELECT course_name, fee
FROM courses
WHERE fee > (
    SELECT AVG(fee) FROM courses
)
ORDER BY fee DESC, course_name;


-- FROM Sub Query
SELECT paid.member_id   AS 회원번호,
       m.name           AS 회원명, 
       paid.total_paid  AS 매출액
FROM
(
    SELECT member_id, SUM(pay_amount) AS total_paid
    FROM enrollments
    GROUP BY member_id
) AS paid
LEFT JOIN  members m ON paid.member_id = m.member_id
WHERE paid.total_paid >= 400000
ORDER BY paid.total_paid DESC, paid.member_id;

-- Scala Sub 쿼리
SELECT 
    course_name,
    fee,
    ROUND((SELECT AVG(fee) FROM courses),2)         AS 전체평균
    fee - ROUND((SELECT AVG(fee) FROM courses),2)   
FROM courses
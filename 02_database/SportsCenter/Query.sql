INSERT INTO  sports (sport_name)
VALUES ('필라테스')
-- postgres 문법 (표준은 아님)
RETURNING *;

SELECT * FROM sports;

CREATE TABLE contact_lists
(
    request_id      SERIAL          PRIMARY KEY,
    member_id       INT             NOT NULL,
    name            VARCHAR(20)     NOT NULL,
    reason          VARCHAR(50)     NOT NULL,
    request_date    DATE            NOT NULL
);

SELECT * FROM contact_lists;

TRUNCATE contact_lists;
-- 서브쿼리 경우 VALUES 필요없음
-- CAST() -> 표준 방법
-- :: 타입 -> postgres 방법

INSERT INTO contact_lists(member_id, name, reason, request_date)
SELECT member_id, name, '이메일 미등록' AS reason, CAST('2026-11-19' AS DATE) AS req_date
FROM members
WHERE email IS NULL
UNION
SELECT member_id, name, '휴대폰 미등록', '2026-11-19' :: DATE
FROM members
WHERE phone IS NULL
RETURNING *;

SELECT * FROM members WHERE member_id = 2;

-- UPADTE
UPDATE members 
SET email = 'lssa@adc.com'
WHERE member_id = 2
RETURNING *;

SELECT * FROM courses;

UPDATE courses
SET class_days = '월수금', start_time = '20:00'
WHERE course_id = 9
RETURNING course_id, course_name, class_days, start_time;

SELECT * FROM courses WHERE sport_id = 1;

UPDATE courses
SET fee = fee * 1.05
WHERE sport_id = 1
RETURNING course_name, fee;

-- 서브 쿼리 활용한 UPDATE

-- 2026-11 수강신청인원이 5명 이상인 경우 수강신청인원 수 +5
SELECT * FROM enrollments
ORDER BY member_id;

UPDATE courses
SET capacity = capacity + 5
WHERE course_id IN (SELECT course_id
                    FROM enrollments
                    WHERE enroll_month = '2026-11'
                    GROUP BY course_id
                    HAVING COUNT(*) >= 5)
RETURNING course_id, course_name, capacity;
 
 -- DELETE FROM

 SELECT * FROM lockers;

 DELETE FROM lockers
 WHERE member_id = 38
 RETURNING *;

SELECT m.member_id, m.name, m.join_date
FROM members m
WHERE NOT EXISTS(SELECT 1 FROM enrollments e WHERE e.member_id = m.member_id);

DELETE FROM members m 
WHERE NOT EXISTS(SELECT 1 FROM enrollments e WHERE e.member_id = m.member_id)
RETURNING m.member_id, m.name;

-- DELETE는 행을 삭제
-- TRUNCATE 해당 데이터 전체 삭제
-- DROP 테이블 삭제

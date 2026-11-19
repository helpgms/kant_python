SELECT c.course_id, s.sport_name, c.course_name, c.class_days, c.fee
FROM courses c
JOIN sports s ON c.sport_id = s.sport_id
LEFT JOIN enrollments e ON c.course_id = e.course_id
                        AND e.enroll_month = '2026-11';

SELECT m.member_id
 FROM enrollments e
LEFT JOIN members m ON e.member_id = m.member_id
ORDER BY m.member_id
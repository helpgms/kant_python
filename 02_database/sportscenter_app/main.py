import psycopg
from psycopg.rows import dict_row

# DSN : Data Source Name
DSN = "host=localhost port=5432 dbname=sportscenter user=postgres password=1234"

MONTH = "2026-11"

# 여러문장 쓰기 위해서는 """ 큰 따옴표 3개
LIST_SQL = """ 
SELECT c.course_id, s.sport_name, c.course_name, c.class_days, c.fee
FROM courses c
JOIN sports s ON c.sport_id = s.sport_id
ORDER BY c.course_id
"""

# 수강 신청가능 목록 조회
# MONTH, 인 이유는 우리는 데이터를 튜플 단위로 끌어오는데 매개변수는 1개여서 , 제외 시에 튜플로 인식안해서 붙인거임
def list_courses(conn):
    for c in conn.execute(LIST_SQL): 
        print(f"{c['course_id']:>3} | {c['sport_name']} | {c['course_name']} | {c['class_days']} | {c['fee']:,}원")


# TODO : 입력 로직 구현
def check_username(conn,username):
    row = conn.execute(
        "SELECT member_id FROM members WHERE name = %s ORDER BY member_id ASC",
        (username,)
    ).fetchone()

    if row is None:
        print("회원이 아니다.")
        return None

    print(f"{username}님의 회원ID {row['member_id']} 입니다.")
    return row['member_id']

# 강좌 조회
def check_coursename(conn):
    coursename = input("강좌명 입력하세요: ")

    row = conn.execute(
        "SELECT course_id, course_name FROM courses WHERE course_name LIKE %s ORDER BY course_id ASC",
        (f"%{coursename}%",)
    ).fetchall()

    print(f"{coursename} 연관된 강좌들은")

    for r in row:
         print(f"{r['course_id']} | {r['course_name']}")

    # 수강 목록 추출 후 신청할 강좌 입력하기
    enroll_course_id = int(input("수강할 강좌를 입력해주세요 : "))
    return enroll_course_id

    # 없는 거 체크해야하는데 

# 수강 신청
def enroll(conn, member_id, course_id):
    # TODO: 신청한 강좌의 수강료 추출
    fee_row = conn.execute(
        "SELECT course_name, fee FROM courses WHERE course_id = %s ORDER BY course_id",
        (course_id,)
        ).fetchone() 

    if fee_row is None:
        print("없는 강좌입니다.")
        return 
    
    fee =  fee_row['fee']

    conn.execute(
        "INSERT INTO enrollments (member_id, course_id, enroll_month, status, pay_amount) "
        "VALUES (%s, %s, %s, '수강중', %s)" ,
        (member_id, course_id, MONTH, fee)
    )
# 여기서 중복이 계속 발생 1번 학생이 12번 수강하고 완료, 그 후 다시 하면 오류발생 
# 원인은 쿼리문에서 INSERT INTO로 데이터를 넣어서 발생하는 것 같음. 해결방안은 모르겠음
# 중복입니다 출력 후 다시 실행하는 방법?

    print(f"{fee_row['course_name']}의 수강비는 {fee_row['fee']:,}원 입니다.")
    print("수강신청 완료되었습니다.")

def main():
    with psycopg.connect(DSN, row_factory=dict_row) as conn:
        username = input("회원의 이름을 입력하세요:")
        MEMBER_ID = check_username(conn,username)
        if MEMBER_ID is None:
            return
        
        # 수강목록
        list_courses(conn)

        # 조회
        COURSE_ID = check_coursename(conn)
        if COURSE_ID is None:
            return

        # 수강 신청
        enroll(conn, MEMBER_ID, COURSE_ID)


        # row = conn.execute("SELECT current_database(), current_user").fetchone()
        # print("연결 성공:", row)
        # rows = conn.execute("SELECT course_id, course_name, fee FROM courses LIMIT 5").fetchall()
        # # print(rows)
        # for row in rows:
        #     print(row["course_name"], row[])

# 아직 도전 과제를 할 단계가 아닌 것 같아 pass

if __name__ == "__main__":
    main()

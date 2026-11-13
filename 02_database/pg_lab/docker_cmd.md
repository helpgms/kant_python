## Docker CLI 명령어

### 컨테이너 목록 조회
```sh
docker ps   
```
### 컨테이너 실행(구동), 올린다, 로드한다.
```sh
docker run -d --name my-pg -e POSTGRES_PASSWORD=1234 -p 5432:5432 postgres:18

docker run -d --name my-pg \
-e POSTGRES_PASSWORD=1234 \
-p 5432:5432 postgres:18
```
### 정지된 컨테이너 목록까지 조회
```sh
docker ps -a
```
### 외부 SQL 파일을 도커 컨테이너 내부로 복사
```sh
docker cp kant_shop.sql(대상 파일) my-pg(컨테이너 명):/tmp/kant_shop.sql(복사파일) 
```

```sh
접속 전에 경로 오류가 뜬다면:
sed -i '/PATHCONV\|CONV_EXCL/d' ~/.bashrc
echo 'export MSYS_NO_PATHCONV=1' >> ~/.bashrc
echo 'export MSYS2_ARG_CONV_EXCL="*"' >> ~/.bashrc
source ~/.bashrc

- 1번째 방법
docker exec -it my-pg psql -U postgres -f //tmp/kant_shop.sql
```
```sh
- 2번째 방법
docker exec -i my-pg psql -U postgres < kant_shop.sql
```

### 데이터베이스를 선택(지정) 접속 및 확인
```sh
docker exec -it my-pg psql -U postgres -d kant_shop
SELECT * FROM product; (확인)
```

---

### 컨테이너를 삭제해도 안에 있는 데이터들은 남기고 싶을 때 볼륨 활용(필수)
```sh
- docker volume ls -> 확인
- docker volume create pgdata(볼륨이름) -> 생성
- docker volume inspect pgdata(볼륨명) -> 상세 정보 확인
```
- 기본 컨테이너 생성 시에 볼륨을 연결
```sh
docker run -d --name my-pg -e POSTGRES_PASSWORD=1234 -p 5432:5432 -v pgdata:/var/lib/postgresql postgres:18
```

- 컨테이너 삭제 후 볼륨 연결 확인
```sh
docker exec -it my-pg psql -U postgres -d kant_shop -c "SELECT * FROM product"
```

---

### compose 하는 방법
```sh
services:                 # 실행할 컨테이너(서비스) 목록 — 필수
  서비스이름:              # 예: db, web (직접 정하는 이름)
    image: 이미지:태그      # 사용할 이미지
    container_name: 이름   # 컨테이너 이름 (생략 시 자동 생성)
    environment:           # 환경 변수 (-e)
      KEY: value
    ports:                 # 포트 연결 (-p) — 문자열로 감싸는 것을 권장
      - "호스트:컨테이너"
    volumes:               # 볼륨 연결 (-v)
      - 볼륨이름:컨테이너경로

volumes:                  # 사용할 볼륨 선언 (최상위)
  볼륨이름:

- 후 확인 방법 : docker compose config
```
```sh
- 컨테이너에 올리는 방법 : docker compose up -d
- 컨테이너에서 없애는 법 : docker compose down
- 올라왔는지 안올라왔는지 확인하는 방법: docker compose ps
```

### 이제 연동하는 것을 해보자
```sh
- DBcode - SQL 이거를 설치
- 연동하고자 하는 sql 선택 (postgreSQL)
- 컨테이너 명 지정, localhost : 포트 번호(5432), 이미 설정한 유저명, 비번, 이미 만든 DB refresh 해서 검색.
```
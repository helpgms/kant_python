CREATE TABLE items
(
    item_id         SERIAL       PRIMARY KEY,
    item_name       VARCHAR(30)  NOT NULL,
    item_price      INT          NOT NULL,  
    item_stock      INT          NOT NULL,
    item_category   VARCHAR(30)  NOT NULL  REFERENCES categories(category_name),
    item_ex         TEXT
);
# 가격이 0이하면?
# 수량이 0이하면?

CREATE TABLE categories
(
    category_id     SERIAL          PRIMARY KEY,
    category_name   VARCHAR(30)     NOT NULL    UNIQUE,
    category_ex     TEXT
);

CREATE TABLE itemcart
(
    itemcart_id     SERIAL      PRIMARY KEY,
    user_id         INT         NOT NULL,
    item_id         INT         NOT NULL    REFERENCES items (item_id),
    cart_in_amount  INT         NOT NULL, 
    UNIQUE (user_id,item_id)
);

# 카트 안에 수량이 0일수도 있지 않나?
# 유저가 같은 상품을 계속 반복적으로 담으면? 기본키로 해서 1:1로 만들어?

INSERT INTO items
(
    item_name,
    item_price,
    item_stock,
    item_category,
    item_ex
)
VALUES ('사탕', 1000, 100, '음식', '디저트 일종');

INSERT INTO categories
(
    category_name,
    category_ex
)
VALUES('음식', '간식');
# items 테이블에 있는 item_category 와 categories 테이블에 있는 category_name 이 약간 겹치는 느낌? 
# 그래서 참조키로 설정

INSERT INTO itemcart
(
    user_id,
    item_id,
    cart_in_amount
)
VALUES(101,1, 50);
# 상품 아이디가 숫자여서 판별하기가 어렵네..

INSERT INTO categories (category_name, category_ex)
VALUES
('음식', '간식 및 식품'),
('전자기기', '전자제품 및 주변기기'),
('의류', '의류 및 패션 상품'),
('생활용품', '일상생활 필수품'),
('도서', '책 및 학습 자료'),
('운동용품', '운동 및 헬스 관련 상품'),
('문구', '필기 및 사무용품'),
('가구', '실내 가구 및 인테리어'),
('뷰티', '화장품 및 미용용품'),
('반려동물', '반려동물 관련 상품');

INSERT INTO items
(item_name, item_price, item_stock, item_category, item_ex)
VALUES
('초콜릿', 2000, 150, '음식', '달콤한 밀크 초콜릿'),
('무선 마우스', 25000, 30, '전자기기', '블루투스 무선 마우스'),
('반팔 티셔츠', 19000, 80, '의류', '면 소재 기본 티셔츠'),
('텀블러', 15000, 50, '생활용품', '스테인리스 보온 텀블러'),
('SQL 입문서', 28000, 25, '도서', 'SQL 기초 학습 도서'),
('요가매트', 22000, 40, '운동용품', '미끄럼 방지 요가매트'),
('볼펜 세트', 5000, 200, '문구', '검정 볼펜 5개 세트'),
('접이식 의자', 35000, 15, '가구', '휴대용 접이식 의자'),
('핸드크림', 9000, 60, '뷰티', '보습 핸드크림'),
('강아지 장난감', 12000, 45, '반려동물', '고무 재질 장난감');

INSERT INTO itemcart
(user_id, item_id, cart_in_amount)
VALUES
(101, 2, 3),
(101, 3, 1),
(102, 4, 2),
(102, 5, 1),
(103, 6, 2),
(103, 7, 1),
(104, 8, 5),
(104, 9, 1),
(105, 10, 2),
(105, 11, 1);


-- DROP TABLE ---------------------------------

DROP TABLE member;

DROP TABLE cart;

DROP TABLE item;

DROP TABLE item_img;

DROP TABLE category;




---- jung sql #1 category ----------------------
CREATE TABLE category (
    cate_code NUMBER(20) NOT NULL,
    cate_name VARCHAR2(30) NOT NULL,
    cate_top  VARCHAR2(30) NULL
);

DROP TABLE category;
-- 테이블 category 임시데이터
INSERT INTO category VALUES (
    1001,
    '방석',
    'living'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    1002,
    '이불',
    'living'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    1003,
    '넥카라',
    'living'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    1004,
    '계단',
    'living'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    1005,
    '쿠션',
    'living'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    1006,
    '매트',
    'living'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    1007,
    '식기',
    'living'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2001,
    '하네스',
    'walking'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2002,
    '포옹백',
    'walking'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2003,
    '목줄',
    'walking'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2004,
    '아웃도어 매트',
    'walking'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2005,
    '바람막이',
    'walking'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2006,
    '이동가방',
    'walking'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2007,
    '벌레퇴치제',
    'walking'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    2008,
    '의류',
    'walking'
);

COMMIT;

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    3001,
    '트릿',
    'food'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    3002,
    '쮸르',
    'food'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    3003,
    '영양스튜',
    'food'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    3004,
    '미니캔',
    'food'
);

INSERT INTO category (
    cate_code,
    cate_name,
    cate_top
) VALUES (
    3005,
    '덴탈',
    'food'
);

SELECT
    cate_code,
    cate_name,
    cate_top
FROM
    category;
--=====================================================================================================


UPDATE category
SET
    cate_code = 1001
WHERE
    cate_code = 1000;



-- #1. 카테고리 검색하기
SELECT
    cate_code,
    cate_name,
    cate_top
FROM
    category
WHERE
    cate_top = 'living';
    

---- jung sql #2 item ----------------------

CREATE TABLE item (
    item_id          NUMBER(20) NOT NULL,
    cate_code        NUMBER(20) NOT NULL,
    item_name        VARCHAR2(50) NOT NULL,
    item_price       NUMBER(20) NOT NULL,
    item_amount      NUMBER(20) NOT NULL,
    item_detail      VARCHAR2(255) NOT NULL,
    item_sell_status VARCHAR2(200) DEFAULT 'sell'
);

SELECT
    *
FROM
    item;


-- 상품 판매상태 제약조건 추가 
ALTER TABLE item
    ADD CONSTRAINT item_sell_status_check CHECK ( item_sell_status LIKE 'sell'
                                                  OR item_sell_status LIKE 'sold_out'
                                                  OR item_sell_status = NULL );


-- 임시데이터
INSERT INTO item VALUES (
    01,
    1001,
    '상품1',
    10000,
    46,
    '상품설명1',
    'sell'
);

INSERT INTO item VALUES (
    02,
    1002,
    '상품2',
    10000,
    47,
    '상품설명2',
    'sell'
);

INSERT INTO item VALUES (
    03,
    1003,
    '상품3',
    10000,
    48,
    '상품설명3',
    'sell'
);

INSERT INTO item VALUES (
    04,
    1004,
    '상품4',
    10000,
    49,
    '상품설명4',
    'sell'
);

INSERT INTO item VALUES (
    05,
    2001,
    '상품5',
    10000,
    50,
    '상품설명5',
    'sell'
);

INSERT INTO item VALUES (
    06,
    2002,
    '상품6',
    10000,
    51,
    '상품설명6',
    'sell'
);

INSERT INTO item VALUES (
    07,
    2003,
    '상품7',
    10000,
    52,
    '상품설명7',
    'sell'
);

INSERT INTO item VALUES (
    08,
    2004,
    '상품8',
    10000,
    53,
    '상품설명8',
    'sell'
);

INSERT INTO item VALUES (
    09,
    2005,
    '상품9',
    10000,
    54,
    '상품설명9',
    'sell'
);

INSERT INTO item VALUES (
    10,
    3001,
    '상품10',
    10000,
    55,
    '상품설명10',
    'sell'
);

INSERT INTO item VALUES (
    11,
    3002,
    '상품11',
    10000,
    56,
    '상품설명11',
    'sell'
);

INSERT INTO item VALUES (
    12,
    3003,
    '상품12',
    10000,
    56,
    '상품설명12',
    'sell'
);

TRUNCATE TABLE item;

DELETE FROM item
WHERE
    item_id = 1;

COMMIT;

--===================================================================================================================================
-- #1. item 전체목록 조회하기 - 판매중인상품만 표시
SELECT
    item_id,
    cate_code,
    item_name,
    item_price,
    item_amount,
    item_detail,
    item_sell_status
FROM
    item
WHERE
    item_sell_status = 'sell';


-- #2. item 1개 (item_id)로 조회하기 
SELECT
    item_id,
    cate_code,
    item_name,
    item_price,
    item_amount,
    item_detail,
    item_sell_status
FROM
    item
WHERE
    item_id = 1;

-- #3. item 상위카테고리 이름(living, walking, food)으로 검색하기
SELECT
    c.cate_code,
    c.cate_top,
    i.item_id,
    i.item_name,
    i.item_price,
    i.item_detail,
    i.item_sell_status
FROM
         category c
    INNER JOIN item i ON c.cate_code = i.cate_code
WHERE
        cate_top = 'living'
    AND item_sell_status = 'sell'
ORDER BY
    item_id DESC;


-- #4. item 등록하기
INSERT INTO item (
    item_id,
    cate_code,
    item_name,
    item_price,
    item_amount,
    item_detail
) VALUES (
    02,
    02,
    '상품2',
    10000,
    48,
    '상품설명2'
);


-- #5. 상품 판매상태 수정하기
UPDATE item
SET
    item_sell_status = 'sold out'
WHERE
    item_id = 12;


-- #6. item과 item_img 조인
SELECT
    i.item_name,
    m.img_name,
    m.img_url,
    m.rep_img_yn
FROM
         item_img m
    INNER JOIN item i ON i.item_id = m.item_id
WHERE
    i.item_id = 1;


-- #7. item 검색값 페이징처리하기
SELECT
    item_id,
    item_name
FROM
    (
        SELECT
            ceil(ROWNUM / 10) page,
            item_id,
            item_name
        FROM
            (
                SELECT
                    item_id,
                    item_name
                FROM
                    item
                WHERE
                    item_id = 1
            )
    )
WHERE
    page = 1;





-- # 8. 등록한 상품 정보 수정하기 페이지에 보여줄 내용
SELECT
    c.cate_top,
    c.cate_name,
    i.item_name,
    i.item_id,
    i.item_price,
    i.item_amount,
    i.item_detail,
    i.item_sell_status
FROM
         category c
    INNER JOIN item i ON c.cate_code = i.cate_code;

-- #. 9.
--    UPDATE item
--		SET
--		SELECT
--			c.cate_top,
--			c.cate_name,
--			i.item_name,
--			i.item_id,
--			i.item_price,
--			i.item_amount,
--			i.item_detail,
--			i.item_sell_status
--		FROM
--			category c
--				INNER JOIN item i ON c.cate_code = i.cate_code;





---- jung sql #3 item_img ----------------------

CREATE TABLE item_img (
    item_img_id  NUMBER(20) NOT NULL,
    item_id      NUMBER(20) NOT NULL,
    img_name     VARCHAR2(255) NOT NULL,
    ori_img_name VARCHAR2(255) NOT NULL,
    img_url      VARCHAR2(255) DEFAULT 'C:/grrreung/shoppingmall-project/upload/',
    rep_img_yn   VARCHAR2(255) DEFAULT 'N'
);

UPDATE item_img
SET
    rep_img_yn = 'Y'
WHERE
    item_img_id = 78;

COMMIT;

SELECT
    *
FROM
    item;

SELECT
    *
FROM
    item_img;

DROP TABLE item_img;
-- 대표이미지 여부 제약조건 추가
ALTER TABLE item_img
    ADD CONSTRAINT rep_img_yn_check CHECK ( rep_img_yn LIKE 'Y'
                                            OR rep_img_yn LIKE 'N'
                                            OR rep_img_yn = NULL );

CREATE SEQUENCE item_img_id_sq;

DROP SEQUENCE item_img_id_sq;
-- 테이블 item_img 임시데이터 C:\Users\USER\Desktop\00_project\shoppingmall_project\src\main\resources\web\upload\item\


INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    01,
    'item01_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    01,
    'item01_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    01,
    'item01_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    01,
    'item01_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    01,
    'item01_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    02,
    'item02_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    02,
    'item02_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    02,
    'item02_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    02,
    'item02_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    02,
    'item02_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    03,
    'item03_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    03,
    'item03_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    03,
    'item03_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    03,
    'item03_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    03,
    'item03_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    04,
    'item04_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    04,
    'item04_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    04,
    'item04_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    04,
    'item04_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    04,
    'item04_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    05,
    'item05_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    05,
    'item05_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    05,
    'item05_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    05,
    'item05_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    05,
    'item05_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    06,
    'item06_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    06,
    'item06_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    06,
    'item06_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    06,
    'item06_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    06,
    'item06_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    07,
    'item07_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    07,
    'item07_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    07,
    'item07_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    07,
    'item07_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    07,
    'item07_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    07,
    'item07_description.png',
    'image07'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    08,
    'item08_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    08,
    'item08_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    08,
    'item08_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    08,
    'item08_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    08,
    'item08_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    09,
    'item09_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    09,
    'item09_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    09,
    'item09_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    09,
    'item09_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    09,
    'item09_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    10,
    'item10_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    10,
    'item10_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    10,
    'item10_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    10,
    'item10_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    10,
    'item10_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_image05.png',
    'image05'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_description01.png',
    'image06'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_description02.png',
    'image07'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    11,
    'item11_description03.png',
    'image08'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    rep_img_yn
) VALUES (
    item_img_id_sq.NEXTVAL,
    12,
    'item12_image01.png',
    'image01',
    'Y'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    12,
    'item12_image02.png',
    'image02'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    12,
    'item12_image03.png',
    'image03'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    12,
    'item12_image04.png',
    'image04'
);

INSERT INTO item_img (
    item_img_id,
    item_id,
    img_name,
    ori_img_name
) VALUES (
    item_img_id_sq.NEXTVAL,
    12,
    'item12_image05.png',
    'image05'
);

TRUNCATE TABLE item_img;

COMMIT;

SELECT
    item_img_id,
    item_id,
    img_name,
    ori_img_name,
    img_url,
    rep_img_yn
FROM
    item_img;

SELECT
    m.img_name,
    m.img_url,
    m.rep_img_yn
FROM
         item_img m
    INNER JOIN item i ON i.item_id = m.item_id
WHERE
        i.item_id = 1
    AND m.rep_img_yn = 'Y';

SELECT
    i.item_id,
    m.img_name,
    m.img_url
FROM
         item_img m
    INNER JOIN item i ON i.item_id = m.item_id
WHERE
        i.item_id = 11
    AND m.img_name LIKE '%description%'
ORDER BY
    img_name ASC;

SELECT
    i.item_id,
    m.img_name,
    m.item_img_id,
    m.img_url,
    m.rep_img_yn
FROM
         item_img m
    INNER JOIN item i ON i.item_id = m.item_id
WHERE
        i.item_id = 11
    AND NOT m.img_name LIKE '%description%';
             

------------------------------------------------


CREATE TABLE member (
    member_id VARCHAR2(30) NOT NULL,
    password  VARCHAR2(255) NOT NULL,
    name      VARCHAR2(30) NOT NULL,
    hp        VARCHAR2(255) NOT NULL,
    email     VARCHAR2(255) NULL,
    admin     VARCHAR2(255) DEFAULT 'N',
    address   VARCHAR2(255) NOT NULL
);

CREATE TABLE cart (
    cart_id     NUMBER(20) NOT NULL,
    member_id   VARCHAR2(30) NOT NULL,
    item_id     NUMBER(20) NOT NULL,
    cart_amount NUMBER(20) NOT NULL
);

CREATE TABLE notice (
    noti_code  NUMBER(20) NOT NULL,
    noti_title VARCHAR2(500) NOT NULL,
    noti_cont  VARCHAR2(500) NOT NULL,
    noti_date  DATE DEFAULT sysdate,
    noti_auth  VARCHAR2(30) DEFAULT 'grrreng'
);

CREATE TABLE item_qna (
    qna_code  NUMBER(20) NOT NULL,
    item_id   NUMBER(20) NOT NULL,
    qna_title VARCHAR2(100) NOT NULL,
    qna_cont  VARCHAR2(500) NOT NULL,
    qna_date  DATE DEFAULT sysdate,
    member_id VARCHAR2(30) NOT NULL
);

CREATE TABLE item_rev (
    rev_code  NUMBER(20) NOT NULL,
    item_id   NUMBER(20) NOT NULL,
    rev_title VARCHAR2(100) NOT NULL,
    rev_cont  VARCHAR2(500) NOT NULL,
    rev_date  DATE DEFAULT sysdate,
    member_id VARCHAR2(30) NOT NULL
);

CREATE TABLE item_qna_re (
    re_code  NUMBER(20) NOT NULL,
    qna_code NUMBER(20) NOT NULL,
    re_cont  VARCHAR2(500) NOT NULL,
    re_date  DATE DEFAULT sysdate
);


-- ALTER ---------------------------------

ALTER TABLE order_gr ADD CONSTRAINT pk_order_gr PRIMARY KEY ( order_id );

ALTER TABLE order_item ADD CONSTRAINT pk_order_item PRIMARY KEY ( order_item_id,
                                                                  order_id );



-- SEQUENCE DROP ---------------------------------

-- Drop sequence for notice
DROP SEQUENCE notice_seq;

-- Drop sequence for item_rev�� ������ ����
DROP SEQUENCE item_rev_seq;


-- Drop sequence for item_qna
DROP SEQUENCE item_qna_seq;

-- Drop sequence for item_qna_re
DROP SEQUENCE item_qna_re_seq;


-- SEQUENCE CREATE ---------------------------------

-- Sequence for notice
CREATE SEQUENCE notice_seq START WITH 1 INCREMENT BY 1; 

-- Sequence for item_rev
CREATE SEQUENCE item_rev_seq START WITH 1 INCREMENT BY 1; 

-- Sequence for order_gr
CREATE SEQUENCE order_gr_seq START WITH 10000 INCREMENT BY 1;

-- Sequence for item_qna
CREATE SEQUENCE item_qna_seq START WITH 1 INCREMENT BY 1;

-- Sequence for item_qna_re
CREATE SEQUENCE item_qna_re_seq START WITH 1 INCREMENT BY 1;


-- TEST INSERT ---------------------------------

-- Insert data into member table 임시데이터
INSERT INTO member (
    member_id,
    password,
    name,
    hp,
    email,
    address
) VALUES (
    'customer1',
    '123456',
    '김고객',
    '01011111111',
    'aaa@naver.com',
    '경기도 하남시 미사강변한강로 60'
);

INSERT INTO member (
    member_id,
    password,
    name,
    hp,
    email,
    address
) VALUES (
    'customer2',
    '123456',
    '박고객',
    '01022222222',
    'bbb@naver.com',
    '서울시 강남구'
);

-- order_gr table 임시데이터
INSERT INTO order_gr (
    order_id,
    member_id,
    order_memo,
    order_name,
    order_add,
    order_hp,
    order_price_all
) VALUES (
    order_gr_seq.NEXTVAL,
    'customer1',
    '문앞에 놔주세요',
    '주문자이름',
    '주문자주소',
    '010-1111-2222',
    '200000'
);

INSERT INTO order_gr (
    order_id,
    member_id,
    order_memo,
    order_name,
    order_add,
    order_hp,
    order_price_all
) VALUES (
    order_gr_seq.NEXTVAL,
    'customer2',
    '경비실에 맡겨주세요',
    '주문자이름22',
    '주문자주소22',
    '010-1111-3333',
    '88000'
);

-- order_item table 임시데이터 

-- order_id = 10000 2개
INSERT INTO order_item (
    order_item_id,
    order_id,
    item_id,
    order_price,
    order_amount
) VALUES (
    1,
    10000,
    1,
    80000,
    8
);

INSERT INTO order_item (
    order_item_id,
    order_id,
    item_id,
    order_price,
    order_amount
) VALUES (
    1,
    10020,
    1001,
    30000,
    10
);

SELECT
    *
FROM
    order_item;
    

-- Insert data into cart table
INSERT INTO cart (
    cart_id,
    member_id,
    item_id,
    cart_amount
) VALUES (
    1,
    'member001',
    101,
    2
);


-- Insert data into notice table
INSERT INTO notice (
    noti_code,
    noti_title,
    noti_cont
) VALUES (
    notice_seq.NEXTVAL,
    '4공지사항테스트입니다',
    '공지사항테스트.'
);

COMMIT;
-- Insert data into item_qna table
INSERT INTO item_qna (
    qna_code,
    item_id,
    qna_title,
    qna_cont,
    member_id
) VALUES (
    item_qna_seq.NEXTVAL,
    101,
    'Question about the item',
    'What are the specifications of this item?',
    'member001'
);

-- Insert data into item_rev table
INSERT INTO item_rev (
    rev_code,
    item_id,
    rev_title,
    rev_cont,
    member_id
) VALUES (
    item_rev_seq.NEXTVAL,
    101,
    'Great product',
    '내용이 들어간당',
    'member001'
);

-- Insert data into item_qna_re table
INSERT INTO item_qna_re (
    re_code,
    qna_code,
    re_cont
) VALUES (
    item_qna_re_seq.NEXTVAL,
    1,
    'The specifications are...'
);


-- SELECT ALL ---------------------------------

-- Select all from order_gr
SELECT
    *
FROM
    order_gr;

-- Select all from member
SELECT
    *
FROM
    member;

-- Select all from order_item
SELECT
    *
FROM
    order_item;

-- Select all from item
SELECT
    *
FROM
    item;

-- Select all from item_img
SELECT
    *
FROM
    item_img;

-- Select all from cart
SELECT
    *
FROM
    cart;

-- Select all from notice
SELECT
    *
FROM
    notice;

-- Select all from item_qna
SELECT
    *
FROM
    item_qna;

-- Select all from item_rev
SELECT
    *
FROM
    item_rev;

-- Select all from item_qna_re
SELECT
    *
FROM
    item_qna_re;

-- Select all from category
SELECT
    *
FROM
    category;

SELECT
    *
FROM
    item_rev;

SELECT
    *
FROM
    item_rev
ORDER BY
    rev_code DESC;

-------------------------------------------------------------------------------


-- member_id 별 주문내역 조회 셀렉문 

SELECT
    g.order_id,
    g.order_date,
    g.order_status,
    g.order_price_all,
    i.item_name,
    oi.order_amount
FROM
         order_item oi
    JOIN order_gr g ON g.order_id = oi.order_id
    LEFT OUTER JOIN item     i ON oi.item_id = i.item_id
WHERE
    member_id = 'customer1'
ORDER BY
    order_id DESC;

UPDATE order_gr
SET
    order_price_all = 230
WHERE
    order_id = 10000;

----


SELECT
    *
FROM
         order_item oi
    JOIN order_gr g ON g.order_id = oi.order_id
    LEFT OUTER JOIN item     i ON oi.item_id = i.item_id
WHERE
    g.order_id = 10020;
    

----


SELECT
    *
FROM
         order_gr g
    JOIN order_item oi ON g.order_id = oi.order_id
    LEFT OUTER JOIN item       i ON oi.item_id = i.item_id
WHERE
    member_id = 'customer1';
    
    
    
-- xml 에 있는 sql문 
SELECT
    g.order_id,
    g.order_date,
    g.order_status,
    g.order_price_all,
    i.item_name,
    oi.order_amount
FROM
         order_gr g
    JOIN order_item oi ON g.order_id = oi.order_id
    JOIN item       i ON oi.item_id = i.item_id
WHERE
    member_id = 'customer1'
ORDER BY
    order_id DESC;


--=====================================================================



SELECT
    og.order_id,
    COUNT(oi.order_item_id)               AS order_item_id,
    SUM(oi.order_price * oi.order_amount) AS order_price_all,
    i.item_name,
    oi.order_amount,
    oi.order_price,
    og.order_status,
    og.order_date
FROM
         order_gr og
    JOIN order_item oi ON og.order_id = oi.order_id
    JOIN item       i ON oi.item_id = i.item_id
WHERE
    og.member_id = 'customer1'
GROUP BY
    og.order_id,
    og.order_status,
    og.order_date,
    i.item_name,
    oi.order_amount,
    oi.order_price
ORDER BY
    og.order_date DESC;

COMMIT;
    
--=================================================================
-- 상품명으로 상품코드가져오기

SELECT
    item_id
FROM
    item
WHERE
    item_name = '상품1';

COMMIT;

------------상품후기 게시물처리------------------------------
-- 동일한 order_id,item_id,member_id로 구매한 수량 
SELECT
    oi.order_amount
FROM
         order_gr og
    JOIN member     m ON og.member_id = m.member_id
    JOIN order_item oi ON og.order_id = oi.order_id
WHERE
        og.member_id = 'customer1'
    AND oi.order_item_id = 1
    AND og.order_id = 10000;
    
    
-- 작성된 게시글 수 조회
SELECT
    COUNT(*) cnt
FROM
    item_rev
WHERE
    item_id = 1
    And
    member_id ='멤버아이디';
    
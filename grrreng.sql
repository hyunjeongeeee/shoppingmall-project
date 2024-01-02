-- DROP TABLE ---------------------------------

DROP TABLE member;

DROP TABLE order_item;

DROP TABLE order_gr;

DROP TABLE item;

DROP TABLE item_img;

DROP TABLE cart;

DROP TABLE notice;

DROP TABLE item_qna;

DROP TABLE item_rev;

DROP TABLE item_qna_re;

DROP TABLE category;


-- CREATE ---------------------------------

CREATE TABLE member (
    member_id VARCHAR2(30) NOT NULL,
    password  VARCHAR2(255) NOT NULL,
    name      VARCHAR2(30) NOT NULL,
    hp        VARCHAR2(255) NOT NULL,
    email     VARCHAR2(255) NULL,
    admin     VARCHAR2(255) DEFAULT 'N',
    address   VARCHAR2(255) NOT NULL,
    address2   VARCHAR2(255) ,
    address3   VARCHAR2(255) ,
    address4   VARCHAR2(255) 
);

CREATE TABLE cart (
    cart_id     NUMBER(20) NOT NULL,
    member_id   VARCHAR2(30) NOT NULL,
    item_id     NUMBER(20) NOT NULL,
    cart_amount NUMBER(20) NOT NULL
);


-- ALTER ---------------------------------


ALTER TABLE member ADD CONSTRAINT pk_member PRIMARY KEY ( member_id );

ALTER TABLE cart ADD CONSTRAINT pk_cart PRIMARY KEY ( cart_id );

COMMIT;

-- Insert data into member table
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
    '홍길동',
    '010-1111-2222',
    'test@naver.com',
    '경기도 하남시 미사강변서로 60'
);

select * from member;


-- cart seq
drop sequence cart_id_seq;

CREATE SEQUENCE cart_id_seq
    START WITH 1
    INCREMENT BY 1; 


-- Insert data into cart table
INSERT INTO cart (
    cart_id,
    member_id,
    item_id,
    cart_amount
) VALUES (
    1,
    'customer1',
    101,
    2
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

SELECT
    *
FROM
    item_qna
WHERE
    qna_title LIKE '%1%'
    OR member_id LIKE '%1%';

SELECT
    noti_code,
    noti_title,
    noti_cont,
    noti_auth,
    to_char(noti_date, 'yyyy-MM-DD HH24:MI:SS') noti_date
FROM
    notice
WHERE
    noti_code = 1;

SELECT
    noti_code,
    noti_title,
    noti_cont,
    noti_auth,
    noti_date
FROM
    (
        SELECT
            ceil(ROWNUM / 5) page,
            noti_code,
            noti_title,
            noti_cont,
            noti_auth,
            noti_date
        FROM
            (
                SELECT
                    noti_code,
                    noti_title,
                    noti_cont,
                    noti_auth,
                    to_char(noti_date, 'yyyy-MM-DD HH24:MI:SS') noti_date
                FROM
                    notice
                WHERE
                    noti_title LIKE '%l%'
                    OR noti_auth LIKE '%g%'
                ORDER BY
                    noti_date DESC
            )
    )
WHERE
    page = 1;

SELECT
    COUNT(*) cnt
FROM
    notice
WHERE
    noti_title LIKE '%a%'
    OR noti_date LIKE '%a%'
ORDER BY
    noti_code DESC;


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
    member_id = 'member001'
ORDER BY
    order_id desc;
    
update  order_gr set order_price_all = 230 where order_id = 10000;

----


SELECT
   *
FROM
         order_item oi
    JOIN order_gr g ON g.order_id = oi.order_id
    LEFT OUTER JOIN item     i ON oi.item_id = i.item_id
WHERE

    g.order_id = 10000;
    
    
    ----


SELECT
    *
FROM
         order_gr g
    JOIN order_item oi ON g.order_id = oi.order_id
   LEFT OUTER JOIN item       i ON oi.item_id = i.item_id
WHERE
    member_id = 'member001';
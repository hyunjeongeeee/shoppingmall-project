DROP TABLE order_item;

DROP TABLE order_gr;

-- CREATE ---------------------------------

CREATE TABLE order_gr (
    order_id        NUMBER(20) NOT NULL,
    member_id       VARCHAR2(30) NOT NULL,
    order_date      DATE DEFAULT sysdate,
    order_status    VARCHAR2(255) DEFAULT '주문완료',
    order_memo      VARCHAR2(100) NULL,
    order_name      VARCHAR2(30) NOT NULL,
    order_add       VARCHAR2(255) NOT NULL,
    order_hp        VARCHAR2(30) NOT NULL,
    order_price_all VARCHAR2(50) NOT NULL
);

CREATE TABLE order_item (
    order_item_id NUMBER(20) NOT NULL,
    order_id      NUMBER(20) NOT NULL,
    item_id       NUMBER(20) NOT NULL,
    order_price   NUMBER(20) NOT NULL,
    order_amount  NUMBER(20) NOT NULL
);

-- ALTER ---------------------------------
ALTER TABLE order_gr ADD CONSTRAINT pk_order_gr PRIMARY KEY ( order_id );

ALTER TABLE order_item ADD CONSTRAINT pk_order_item PRIMARY KEY ( order_item_id,
                                                                  order_id );

ALTER TABLE order_item
    ADD CONSTRAINT fk_order_gr_to_order_item_1 FOREIGN KEY ( order_id )
        REFERENCES order_gr ( order_id );
        

-- Drop sequence for order_gr
DROP SEQUENCE order_gr_seq;

DROP SEQUENCE order_item_seq;

-- Sequence for order_gr
CREATE SEQUENCE order_gr_seq START WITH 10000 INCREMENT BY 1;

CREATE SEQUENCE order_item_seq START WITH 20000 INCREMENT BY 1;

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

select * from order_gr;

-- order_item table 임시데이터 

-- order_id = 10000 2개
INSERT INTO order_item (
    order_item_id,
    order_id,
    item_id,
    order_price,
    order_amount
) VALUES (
    order_item_seq.NEXTVAL,
    10000,
    1,
    80000,
    3
);

INSERT INTO order_item (
    order_item_id,
    order_id,
    item_id,
    order_price,
    order_amount
) VALUES (
    order_item_seq.NEXTVAL,
    10001,
    2,
    20000,
    2
);


SELECT
    *
FROM
    order_item;
    
    

-- #1. member_id 별 주문내역 조회 셀렉문 

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



-- #2. order_id 별 조회

SELECT
    *
FROM
         order_item oi
    JOIN order_gr g ON g.order_id = oi.order_id
    LEFT OUTER JOIN item     i ON oi.item_id = i.item_id
WHERE
    g.order_id = 10001;
    

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

commit;
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

DROP TABLE notice;

DROP TABLE item_qna;

DROP TABLE item_rev;

DROP TABLE item_qna_re;

-- create 

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


-- alter

ALTER TABLE notice ADD CONSTRAINT pk_notice PRIMARY KEY ( noti_code );

ALTER TABLE item_qna ADD CONSTRAINT pk_item_qna PRIMARY KEY ( qna_code );

ALTER TABLE item_rev ADD CONSTRAINT pk_item_rev PRIMARY KEY ( rev_code );

ALTER TABLE item_qna_re ADD CONSTRAINT pk_item_qna_re PRIMARY KEY ( re_code );


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

-- Sequence for item_qna
CREATE SEQUENCE item_qna_seq START WITH 1 INCREMENT BY 1;

-- Sequence for item_qna_re
CREATE SEQUENCE item_qna_re_seq START WITH 1 INCREMENT BY 1;


-- Insert data into notice table
INSERT INTO notice (
    noti_code,
    noti_title,
    noti_cont
) VALUES (
    notice_seq.NEXTVAL,
    '공지사항 테스트 제목',
    '공지사항 테스트 내용 입니다'
);

-- Insert data into item_qna table
INSERT INTO item_qna (
    qna_code,
    item_id,
    qna_title,
    qna_cont,
    member_id
) VALUES (
    item_qna_seq.NEXTVAL,
    01,
    '상품문의 테스트 제목',
    '상품문의 테스트 내용 입니다',
    'customer1'
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
    01,
    '상품후기 테스트 제목',
    '상품후기 테스트 내용 입니다',
    'customer1'
);

-- Insert data into item_qna_re table
INSERT INTO item_qna_re (
    re_code,
    qna_code,
    re_cont
) VALUES (
    item_qna_re_seq.NEXTVAL,
    1,
    '상품문의 테스트 답변입니다.'
);

COMMIT;


--

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


-- 페이징처리 select 문
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
    
    
    
-- 아이템 리뷰 서치
SELECT
		rev_code,
		rev_title,
		rev_cont,
		member_id,
		rev_date
		FROM
		(
		SELECT
		ceil(ROWNUM / 5)  page,
		rev_code,
		rev_title,
		rev_cont,
		member_id,
		rev_date
		FROM
		(
		SELECT
		rev_code,
		rev_title,
		rev_cont,
		member_id,
		to_char(rev_date, 'yyyy-MM-DD HH24:MI:SS') rev_date
		FROM
		item_rev
		where
				rev_title LIKE '%cust%'
				OR rev_code LIKE '%cust%'
				OR member_id = 'cust'
			
		ORDER BY
		rev_code DESC
		)
		)
		WHERE
		page = 1;

select *
from item_rev
where member_id = 'customer1';
    
    
-- 페이징 처리 카운트

SELECT
    COUNT(*) cnt
FROM
    notice
WHERE
    noti_title LIKE '%a%'
    OR noti_date LIKE '%a%'
ORDER BY
    noti_code DESC;


--
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
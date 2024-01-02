CREATE TABLE item (
   item_id           NUMBER(20)       NOT NULL,
   cate_code       NUMBER(20)       NOT NULL,
   item_name       VARCHAR2(50)       NOT NULL,
   item_price       NUMBER(20)       NOT NULL,
   item_amount   NUMBER(20)       NOT NULL,
   item_detail       VARCHAR2(255)   NOT NULL,
   item_sell_status   VARCHAR2(200)   DEFAULT 'sell'
);





-- 상품 판매상태 제약조건 추가 
ALTER TABLE ITEM ADD CONSTRAINT ITEM_SELL_STATUS_CHECK CHECK(
    ITEM_SELL_STATUS LIKE 'sell' OR 
    ITEM_SELL_STATUS LIKE 'sold_out' OR
    ITEM_SELL_STATUS = null
);


-- 임시데이터
insert into item values(01, 1001 , '상품1', 10000, 46, '상품설명1', 'sell');
insert into item values(02, 1002 , '상품2', 10000, 47, '상품설명2', 'sell');
insert into item values(03, 1003 , '상품3', 10000, 48, '상품설명3', 'sell');
insert into item values(04, 1004 , '상품4', 10000, 49, '상품설명4', 'sell');
insert into item values(05, 2001 , '상품5', 10000, 50, '상품설명5', 'sell');
insert into item values(06, 2002 , '상품6', 10000, 51, '상품설명6', 'sell');
insert into item values(07, 2003 , '상품7', 10000, 52, '상품설명7', 'sell');
insert into item values(08, 2004 , '상품8', 10000, 53, '상품설명8', 'sell');
insert into item values(09, 2005 , '상품9', 10000, 54, '상품설명9', 'sell');
insert into item values(10, 3001, '상품10', 10000, 55, '상품설명10', 'sell');
insert into item values(11, 3002 , '상품11', 10000, 56, '상품설명11', 'sell');
insert into item values(12, 3003 , '상품12', 10000, 56, '상품설명12', 'sell');


truncate table item;

delete from item
where item_id=1;


commit;
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
WHERE item_sell_status = 'sell';


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
    cate_top = 'living' and item_sell_status = 'sell'
ORDER BY item_id DESC;


-- #4. item 등록하기
INSERT INTO item (item_id, cate_code, item_name, item_price, item_amount, item_detail) 
VALUES (02, 02, '상품2', 10000, 48, '상품설명2');


-- #5. 상품 판매상태 수정하기
update item
set item_sell_status = 'sold out'
where item_id=12;


-- #6. item과 item_img 조인
select I.item_name, M.img_name,  M.img_url, M.rep_img_yn
from item_img M
    inner join item I
    on I.item_id = M.item_id
where I.item_id = 1;


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
                      where
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

-- #. 9. 상품정보 수정 해주기 => 미완성임
    UPDATE item
		SET
		
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


-- #10. 
SELECT
    COUNT(*) count
FROM
    item
WHERE
    item_name LIKE '%상품%'
	and item_sell_status LIKE 'sell'
order by item_id DESC;


-- #11. 카테고리로 상품 리스트 검색
        SELECT
			cate_code,
			cate_top,
			item_id,
			item_name,
			item_price,
			item_detail,
			item_sell_status
		FROM
			(
            SELECT
            CEIL(ROWNUM / 3) page,
            cate_code,
			cate_top,
			item_id,
			item_name,
			item_price,
			item_detail,
			item_sell_status
            FROM
                (
                SELECT
                c.cate_code,
                c.cate_top,
                i.item_id,
                i.item_name,
                i.item_price,
                i.item_detail,
                i.item_sell_status
                    FROM category c            
                    INNER JOIN item i 
                    ON c.cate_code = i.cate_code
		WHERE
			cate_top = 'living' and item_sell_status = 'sell'
              )
            )
        where page = 1
		ORDER BY item_id DESC;




SELECT
			cate_code,
			cate_top,
			item_id,
			item_name,
			item_price,
			item_detail,
			item_sell_status
		FROM
			(
				SELECT
					CEIL(ROWNUM /15) page,
					cate_code,
					cate_top,
					item_id,
					item_name,
					item_price,
					item_detail,
					item_sell_status
				FROM
					(
						SELECT
							c.cate_code,
							c.cate_top,
							i.item_id,
							i.item_name,
							i.item_price,
							i.item_detail,
							i.item_sell_status
						FROM category c
							 	INNER JOIN item i
						 		ON c.cate_code = i.cate_code
						WHERE
							item_sell_status = 'sell'
						    
					)
			)
		WHERE
			page = 1
		ORDER BY item_id DESC;


-- 아이템 상세보기 페이지에서 보여줄 리뷰목록 조회
SELECT
    rev_code, item_id, rev_title, rev_title, rev_cont, rev_date, member_id
FROM
    item_rev
WHERE
    item_id=12;










-- 장바구니에서 선택된 상품만 주문서로 넘기기


SELECT
    c.cart_id,
    i.item_name,
    i.item_detail,
    i.item_price,
    c.member_id,
    c.item_id,
    c.cart_amount,
    m.img_name AS item_img
FROM
         cart c
    INNER JOIN item     i ON c.item_id = i.item_id
    INNER JOIN item_img m ON i.item_id = m.item_id
WHERE
        c.member_id = 'customer1'
    AND m.rep_img_yn = 'Y'
ORDER BY
    item_id DESC;


DELETE FROM item_qna_re;

SELECT
    *
FROM
    item_qna_re
    WHERE  qna_code = 23
    ORDER BY re_code asc;

    
commit;

UPDATE item_qna_re 
SET
    re_cont = '1114561' , 
    re_date = SYSDATE 
WHERE RE_CODE = 74;


SELECT
    *
FROM
    member;

UPDATE member
SET
    admin = 'Y'
WHERE
    member_id = 'customer1';

COMMIT;

-- item id로 카테고리 찾아오기
SELECT
    *
FROM
    category
WHERE
    cate_code = (
        SELECT
            cate_code
        FROM
            item
        WHERE
            item_id = 1
    );
    
    
    SELECT
		rev_code,
		rev_title,
		rev_cont,
		member_id,
		rev_date,
        item_id
		FROM
		(
		SELECT
		ceil(ROWNUM / 5)  page,
		rev_code,
		rev_title,
		rev_cont,
		member_id,
		rev_date,
        item_id
		FROM
		(
		SELECT
		rev_code,
		rev_title,
		rev_cont,
		member_id,
		to_char(rev_date, 'yyyy-MM-DD HH24:MI:SS') rev_date,
        item_id
		FROM
		item_rev
where
				rev_title LIKE '%cust%'
				OR rev_code LIKE '%1%'
		
		ORDER BY
		rev_code DESC
		)
		)
		WHERE
		page = 1;
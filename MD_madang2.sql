--4-1.
SELECT ABS(-78), ABS(+78)
FROM Dual;

--4-2.
SELECT ROUND(4.875, 1)
FROM Dual;

--4-3.
SELECT custid "고객번호", ROUND(SUM(saleprice)/COUNT(*), -2) "평균금액"
FROM Orders
GROUP BY custid;

--4-4.
SELECT bookid, REPLACE(bookname, '야구', '농구')bookname, publisher, price
FROM Book;

--4-5.
SELECT bookname "제목", LENGTH(bookname)"글자수", LENGTHB(bookname) "바이트수"
FROM Book
WHERE publisher = '굿스포츠';

--4-6.
SELECT SUBSTR(name, 1, 1) "성", COUNT(*) "인원"
FROM Customer
GROUP BY SUBSTR(name, 1, 1);

SELECT TO_DATE('2025-07-01', 'yyyy-mm-dd')+5 BEFORE, TO_DATE('2025-07-01', 'yyyy-mm-dd')-5 AFTER
FROM Dual;

--4-7.
SELECT orderid "주문번호", orderdate "주문일", orderdate +10 "확정일"
FROM Orders;

SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyymmdd day')
FROM Dual;

--4-8.
SELECT orderid "주문번호", TO_CHAR(orderdate, 'yyyy-mm-dd dy') "주문일", custid "고객번호", bookid "도서번호"
FROM Orders
WHERE orderdate = TO_DATE('20250707', 'yyyymmdd');

--4-9.
SELECT SYSDATE, TO_CHAR(SYSDATE, 'yyyy/mm/dd dy hh24:mi:ss') "SYSDATE_1"
FROM Dual;

--NULL 값 처리
SELECT price+100
FROM Mybook
WHERE bookid = 3;

SELECT SUM(price), AVG(price), COUNT(*), COUNT(price)
FROM Mybook;

SELECT SUM(price), AVG(price), COUNT(*)
FROM Mybook
WHERE bookid >= 4;

SELECT *
FROM Mybook
WHERE price IS NULL;

--4-10.
SELECT name "이름", NVL(phone, '연락처없음') "전화번호"
FROM Customer;

--4-11.
SELECT ROWNUM "순번", custid, name, phone
FROM Customer
WHERE ROWNUM <= 2;

SELECT ROWNUM "순번", custid, name, phone
FROM (SELECT custid, name, phone FROM Customer ORDER BY name)
WHERE ROWNUM <= 2;

--4-12.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice <= (SELECT AVG(saleprice) FROM orders);

--4-13.
SELECT orderid, custid, saleprice
FROM Orders md
WHERE saleprice > (SELECT AVG(saleprice) FROM Orders so WHERE md.custid = so.custid);

--4-14.
SELECT SUM(saleprice) "total"
FROM Orders
WHERE custid IN (SELECT custid FROM Customer WHERE address LIKE '%대한민국%');

--4-15.
SELECT orderid, saleprice
FROM Orders
WHERE saleprice > ALL (SELECT saleprice FROM Orders WHERE custid =3);

--4-16.
SELECT SUM(saleprice) "total"
FROM Orders od
WHERE EXISTS (SELECT * FROM Customer cs WHERE address LIKE '% 대한민국%' AND cs.custid = od.custid);

--4-17.
SELECT (SELECT name FROM Customer cs WHERE cs.custid = od.custid) "name", SUM(saleprice) "total"
FROM Orders od
GROUP BY od.custid;

--4-18.
ALTER TABLE Orders ADD bookname VARCHAR2(40);

UPDATE Orders
SET bookname = (SELECT bookname FROM Book WHERE Book.bookid = Orders.bookid);

ALTER TABLE Orders DROP COLUMN bookname;

--4-19.
SELECT cs.name, SUM(od.saleprice) "total"
FROM (SELECT custid, name FROM Customer WHERE custid <= 2) cs, Orders od
WHERE cs.custid = od.custid
GROUP BY cs.name;

--4-20.
CREATE VIEW vw_Customer
AS SELECT * FROM Customer WHERE address LIKE '%대한민국%';

SELECT *
FROM vw_Customer;

--4-21.
CREATE VIEW vw_Orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
AS SELECT od.orderid, od.custid, cs.name, od.bookid, bk.bookname, od.saleprice, od.orderdate
FROM Orders od, Customer cs, Book bk
WHERE od.custid = cs.custid AND od.bookid = bk.bookid;

SELECT orderid, bookname, saleprice
FROM vw_Orders
WHERE name = '김연아';

--4-22.
CREATE OR REPLACE VIEW vw_Customer (custid, name, address)
AS SELECT custid, name, address FROM Customer WHERE address LIKE '%영국%';

SELECT *
FROM vw_Customer

--4-23.
DROP VIEW vw_Customer;

SELECT *
FROM vw_Customer;



--3-1.
SELECT bookname, price
FROM book;

SElECT price, bookname
FROM book;

--3-2.
SELECT bookid, bookname, publisher, price
FROM book;

--3-3.
SELECT publisher
FROM book;

SELECT DISTINCT publisher
FROM book;

--3-4.
SELECT *
FROM book
WHERE price < 20000;

SELECT bookname, publisher
FROM book
WHERE price >= 20000;

--3-5.
SELECT *
FROM book
WHERE price BETWEEN 10000 AND 20000;

SELECT *
FROM book
WHERE price >= 10000 AND price <= 20000;

--3-6.
SELECT bookid, bookname, publisher, price
FROM book
WHERE publisher IN ('굿스포츠', '대한미디어');

SELECT *
FROM book
WHERE publisher NOT IN ('굿스포츠', '대한미디어');

--3-7.
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '축구의 역사';

--3-8.
SELECT bookname, publisher
FROM book
WHERE bookname LIKE '%축구%';

--3-9.
SELECT *
FROM book
WHERE bookname LIKE '_구%';

--3-10.
SELECT *
FROM book
WHERE bookname LIKE '%축구%' AND price >= 20000;

--3-11.
SELECT *
FROM book
WHERE publisher = '굿스포츠' OR publisher = '대한미디어' ;

SELECT *
FROM book
WHERE publisher IN ('굿스포츠','대한미디어');

--3-12.
SELECT *
FROM book
ORDER BY bookname;

--3-13.
SELECT *
FROM book
ORDER BY price, bookname;

--3-14.
SELECT *
FROM book
ORDER BY price DESC, publisher ASC;

--3-15.
SELECT SUM(saleprice)
FROM orders;

SELECT SUM(saleprice) AS 총매출
FROM orders;

--3-16.
SELECT SUM(saleprice) AS 총매출
FROM orders
WHERE custid = 2;

SELECT SUM(saleprice) AS total,
       AVG(saleprice) AS average,
       MIN(saleprice) AS minmum,
       MAX(saleprice) AS maximum
FROM orders;

--3-18.
SELECT COUNT(*)
FROM orders;

--3-19.
SELECT custid, COUNT(*) AS 도서수량, SUM(saleprice) AS 총액
FROM orders
GROUP BY custid;

--3-20.
SELECT custid, COUNT(*) AS 도서수량
FROM orders
WHERE saleprice >= 8000
GROUP BY custid
HAVING count(*) >=2
ORDER BY custid;

--3-21.
SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid;

--3-22.
SELECT *
FROM customer, orders
WHERE customer.custid = orders.custid
order by customer.custid;

--3-23.
SELECT name, saleprice
FROM customer, orders
WHERE customer.custid = orders.custid;

--3-24.
SELECT name, SUM(saleprice) AS 총판매액
FROM customer, orders
WHERE customer.custid = orders.custid
GROUP BY name
ORDER BY name;

--3-25.
SELECT customer.name, book.bookname
FROM customer, orders, book
WHERE customer.custid = orders.custid AND orders.bookid = book.bookid

-- [질의 3-26] 가격이 20,000원인 도서를 주문한 고객의 이름과 도서의 이름을 구하시오.
SELECT	 Customer.name, book.bookname
FROM	 Customer, Orders, Book
WHERE	 Customer.custid =Orders.custid 
	     AND Orders.bookid =Book.bookid AND Book. price =20000;
         
--3-27.
SELECT customer.name, saleprice
FROM customer LEFT OUTER JOIN orders ON
     customer.custid = orders.custid;
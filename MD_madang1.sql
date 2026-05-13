-- ============================================
-- 테이블 삭제 (순서 중요)
-- ============================================
DROP TABLE 예약;
DROP TABLE 상영관;
DROP TABLE 고객;
DROP TABLE 극장;
-- ============================================
-- 테이블 생성
-- ============================================
-- 극장 테이블
CREATE TABLE 극장 (
극장번호 NUMBER PRIMARY KEY,
극장이름 VARCHAR2(100) NOT NULL,
위치 VARCHAR2(100)
);
-- 상영관 테이블 (복합 PK)
CREATE TABLE 상영관 (
극장번호 NUMBER,
상영관번호 NUMBER,
영화제목 VARCHAR2(200) NOT NULL,
가격 NUMBER,
좌석수 NUMBER,
CONSTRAINT pk_상영관 PRIMARY KEY (극장번호, 상영관번호),
CONSTRAINT fk_상영관_극장 FOREIGN KEY (극장번호) REFERENCES 극장(극장번호)
);
-- 고객 테이블
CREATE TABLE 고객 (
고객번호 NUMBER PRIMARY KEY,
이름 VARCHAR2(100) NOT NULL,
주소 VARCHAR2(200)
);
-- 예약 테이블 (복합 PK)
CREATE TABLE 예약 (
극장번호 NUMBER,
상영관번호 NUMBER,
고객번호 NUMBER,
좌석번호 NUMBER,
날짜 DATE,
CONSTRAINT pk_예약 PRIMARY KEY (극장번호, 상영관번호, 고객번호),
CONSTRAINT fk_예약_상영관 FOREIGN KEY (극장번호, 상영관번호)
REFERENCES 상영관(극장번호, 상영관번호),
CONSTRAINT fk_예약_고객 FOREIGN KEY (고객번호) REFERENCES 고객(고객번호)
);
-- ============================================
-- 예시 데이터 삽입
-- ============================================
-- 극장 데이터 (5개 극장)
INSERT INTO 극장 VALUES (1, '강남극장', '강남');
INSERT INTO 극장 VALUES (2, '강동극장', '강동');
INSERT INTO 극장 VALUES (3, '홍대극장', '마포');
INSERT INTO 극장 VALUES (4, '신촌극장', '서대문');
INSERT INTO 극장 VALUES (5, '잠실극장', '송파');
-- 상영관 데이터 (극장별 2~3개 상영관)
INSERT INTO 상영관 VALUES (1, 1, '아바타', 12000, 150);
INSERT INTO 상영관 VALUES (1, 2, '범죄도시4', 11000, 120);
INSERT INTO 상영관 VALUES (1, 3, '파묘', 9000, 80);
INSERT INTO 상영관 VALUES (2, 1, '듄2', 13000, 200);
INSERT INTO 상영관 VALUES (2, 2, '건국전쟁', 8000, 60);
INSERT INTO 상영관 VALUES (3, 1, '오펜하이머', 12000, 180);
INSERT INTO 상영관 VALUES (3, 2, '서울의봄', 10000, 100);
INSERT INTO 상영관 VALUES (3, 3, '밀수', 9000, 90);
INSERT INTO 상영관 VALUES (4, 1, '콘크리트유토피아', 11000, 130);
INSERT INTO 상영관 VALUES (4, 2, '외계+인', 7000, 70);
INSERT INTO 상영관 VALUES (5, 1, '탑건매버릭', 13000, 250);
INSERT INTO 상영관 VALUES (5, 2, '앤트맨', 10000, 110);
-- 고객 데이터 (8명)
INSERT INTO 고객 VALUES (1, '김철수', '서울시 강남구 역삼동');
INSERT INTO 고객 VALUES (2, '이영희', '서울시 강동구 천호동');
INSERT INTO 고객 VALUES (3, '박민준', '서울시 마포구 홍대동');
INSERT INTO 고객 VALUES (4, '최수연', '서울시 서대문구 신촌동');
INSERT INTO 고객 VALUES (5, '정하늘', '서울시 송파구 잠실동');
INSERT INTO 고객 VALUES (6, '한지민', '서울시 강북구 수유동');
INSERT INTO 고객 VALUES (7, '강감찬', '서울시 용산구 이태원동');
INSERT INTO 고객 VALUES (8, '장내윤', '서울시 성동구 왕십리동');
-- 예약 데이터 (다양한 날짜와 좌석)
INSERT INTO 예약 VALUES (1, 1, 1, 15, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 1, 2, 23, TO_DATE('2024-10-01', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 2, 3, 7, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (1, 3, 4, 11, TO_DATE('2024-10-05', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 1, 1, 50, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 1, 5, 88, TO_DATE('2024-10-10', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (2, 2, 6, 3, TO_DATE('2024-10-12', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 1, 2, 77, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 2, 7, 45, TO_DATE('2024-10-15', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (3, 3, 8, 62, TO_DATE('2024-10-18', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (4, 1, 3, 19, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (4, 2, 4, 33, TO_DATE('2024-10-20', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 1, 5, 100, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 1, 6, 120, TO_DATE('2024-10-22', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 2, 7, 55, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
INSERT INTO 예약 VALUES (5, 2, 8, 67, TO_DATE('2024-10-25', 'YYYY-MM-DD'));
COMMIT;

-- 전체 데이터 확인
SELECT *
FROM 극장;

SELECT * 
FROM 상영관;

SELECT * 
FROM 고객;

SELECT * 
FROM 예약;

-- 4개 테이블 전체 조인 확인
SELECT t.극장이름,
s.상영관번호,
s.영화제목,
s.가격,
c.이름 AS 고객이름,
r.좌석번호,
r.날짜
FROM 극장 t
JOIN 상영관 s ON t.극장번호 = s.극장번호
JOIN 예약 r ON s.극장번호 = r.극장번호
AND s.상영관번호 = r.상영관번호
JOIN 고객 c ON r.고객번호 = c.고객번호
ORDER BY r.날짜, t.극장번호;

--1) 영화 가격이 9,000원 이상인 상영관의 극장번호를 추출하시오.
SELECT 극장번호
FROM 상영관
WHERE 가격 >= 9000;

--2)극장별 상영관(두 테이블 조인)
SELECT *
FROM 극장, 상영관
WHERE 극장.극장번호 = 상영관.극장번호;

--3)영화 가격이 10,000원 이상인 영화를 상영하는 극장이름
SELECT DISTINCT t.극장이름
FROM 극장 t
JOIN 상영관 s 
ON t.극장번호 = s.극장번호
WHERE s.가격 >=10000;
 
--1) 극장테이블에서 극장이름, 위치를 추출하시오
SELECT 극장이름, 위치 FROM 극장;

--2) 영화 가격이 10000이하인 영화제목을 추출하시오
SELECT 영화제목 
FROM 상영관 
WHERE 가격 <= 10000;

--3) 고객테이블에서 이름,주소를 추출하시오
SELECT 이름, 주소 
FROM 고객;

--4) 극장 위치가 강남인 곳에서 상영 중인 영화제목을 추출하시오
SELECT s.영화제목 
FROM 극장 t JOIN 상영관 s ON t.극장번호 = s.극장번호
WHERE t.위치 = '강남';

--5)강남에 위치한 극장을 모두 예약한 고객 이름
SELECT c.이름 
FROM 고객 c 
WHERE NOT EXISTS(
 SELECT t.극장번호 FROM 극장 t WHERE t.위치 ='강남'
 MINUS
 SELECT r.극장번호 FROM 예약 r WHERE r.고객번호 = c.고객번호);
 
--[단순질의]
--1. 극장테이블에서 극장이름, 위치를 추출하시오
SELECT 극장이름, 위치
FROM 극장;

--2. 극장 테이블에서 위치가 '서울'인 극장의 극장이름을 조회하시오.
SELECT 극장이름
FROM 극장
WHERE 위치 = '서울';

--3. 상영관 테이블에서 가격이 10000원 이상인 상영관의 극장번호, 상영관번호, 영화제목을 조회하시오.
SELECT 극장번호, 상영관번호, 영화제목
FROM 상영관
WHERE 가격 >= 10000;

--4. 상영관 테이블에서 영화제목별 상영관 수를 조회하시오.
SELECT 영화제목, COUNT(*) AS 상영관수
FROM 상영관
GROUP BY 영화제목;

--5. 예약 테이블에서 날짜가 '2024-01-01'인 모든 예약 정보를 조회하시오.
SELECT *
FROM 예약
WHERE 날짜 = TO_DATE('2024-01-01', 'YYYY-MM-DD');

--6. 고객 테이블에서 주소별 고객 수를 조회하시오.
SELECT 주소, COUNT(*) AS 고객수
FROM 고객
GROUP BY 주소;

--7. 상영관 테이블에서 좌석수가 가장 많은 상영관의 극장번호와 상영관번호를 조회하시오.
SELECT 극장번호, 상영관번호, MAX(좌석수)
FROM 상영관
GROUP BY 극장번호, 상영관번호;

--8. 예약 테이블에서 고객번호별 예약 횟수를 조회하시오.
SELECT 고객번호, COUNT(*) AS 예약횟수
FROM 예약
GROUP BY 고객번호;

--9. 상영관 테이블에서 극장번호별 평균 가격을 조회하시오.
SELECT 극장번호, AVG(가격)AS 평균가격
FROM 상영관
GROUP BY 극장번호;

--10. 고객 테이블에서 이름이 '김'으로 시작하는 고객의 이름과 주소를 조회하시오.
SELECT 이름, 주소
FROM 고객
WHERE 이름 LIKE '김%';

--[조인질의]
--11. 극장과 상영관 테이블을 조인하여 극장이름과 해당 극장의 영화제목을 조회하시오.
SELECT 극장이름, 영화제목
FROM 극장, 상영관
WHERE 극장.극장번호 = 상영관.극장번호;

--12. 극장, 상영관, 예약 테이블을 조인하여 극장이름, 영화제목, 예약 날짜를 조회하시오.
SELECT 극장이름, 영화제목, 날짜
FROM 극장, 상영관, 예약
WHERE 극장.극장번호 = 상영관.극장번호 AND 예약.극장번호 = 상영관.극장번호;

--13. 고객과 예약 테이블을 조인하여 고객 이름과 해당 고객의 예약 날짜를 조회하시오.
SELECT 이름, 날짜
FROM 고객, 예약
WHERE 고객.고객번호 = 예약.고객번호;

--14. 극장, 상영관, 예약, 고객 테이블을 모두 조인하여 극장이름, 영화제목, 고객이름, 좌석번호를 조회하시오.
SELECT 극장이름, 영화제목, 이름, 좌석번호
FROM 극장, 상영관, 예약, 고객
WHERE 극장.극장번호 = 상영관.극장번호 AND 예약.극장번호 = 상영관.극장번호 AND 고객.고객번호 = 예약.고객번호;

--15. 상영관과 예약 테이블을 조인하여 영화제목별 총 예약 수를 조회하시오.
SELECT 영화제목, COUNT(고객번호) AS 예약수
FROM 상영관, 예약
WHERE 상영관.극장번호 = 예약.극장번호
GROUP BY 영화제목;

--16. 극장과 상영관 테이블을 조인하여 위치가 '서울'인 극장에서 상영 중인 영화제목과 가격을 조회하시오.
SELECT 영화제목, 가격
FROM 극장, 상영관
WHERE 극장.극장번호 = 상영관.극장번호 AND 위치 = '서울'
GROUP BY 영화제목, 가격;

--17. 고객과 예약 테이블을 LEFT JOIN하여 예약이 한 건도 없는 고객의 이름을 조회하시오.
SELECT 이름
FROM 고객 LEFT JOIN 예약 ON 고객.고객번호 = 예약.고객번호
WHERE 예약.고객번호 IS NULL;

--18. 극장, 상영관, 예약 테이블을 조인하여 극장별 총 예약 수를 조회하시오.
SELECT 극장이름, COUNT(고객번호) AS 예약수
FROM 극장, 상영관, 예약
WHERE 극장.극장번호 = 상영관.극장번호 AND 예약.극장번호 = 상영관.극장번호
GROUP BY 극장이름;

--19. 상영관과 예약 테이블을 조인하여 가격이 15000원 이상인 상영관을 예약한 고객번호와 영화제목을 조회하시오.
SELECT 고객번호, 영화제목
FROM 상영관, 예약
WHERE 상영관.극장번호 = 예약.극장번호 AND 가격 >= 15000
GROUP BY 고객번호, 영화제목;

--20. 극장, 상영관, 예약, 고객 테이블을 조인하여 고객별 총 예약 횟수와 이름을 조회하시오.
SELECT 이름, COUNT(고객번호) AS 예약수
FROM 극장, 상영관, 예약, 고객
WHERE 상영관.극장번호 = 극장.극장번호 AND 예약.극장번호 = 극장.극장번호 AND 고객.고객번호 = 예약.고객번호
GROUP BY 이름;

--[부속질의]
--21. 예약 테이블에서 가장 많은 예약이 발생한 극장번호를 조회하시오.
SELECT 극장번호
FROM 예약
GROUP BY 극장번호
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM 예약 GROUP BY 극장번호);

--22. 고객 테이블에서 예약 테이블에 예약 기록이 있는 고객의 이름과 주소를 조회하시오. (IN사용)
SELECT 이름, 주소
FROM 고객
WHERE 고객번호 IN (SELECT 고객번호 FROM 예약);

--23. 극장 테이블에서 상영관이 3개 이상 등록된 극장의 극장이름을 조회하시오.
SELECT 극장이름
FROM 극장
WHERE 극장번호 IN (SELECT 극장번호 FROM 상영관 GROUP BY 극장번호 HAVING COUNT(*) >=3);

--24. 상영관 테이블에서 전체 상영관 평균 가격보다 비싼 상영관의 영화제목과 가격을 조회하시오.
SELECT 영화제목, 가격
FROM 상영관
WHERE 가격 > (SELECT AVG(가격) FROM 상영관); 

--25.  고객 테이블에서 예약 테이블에 예약 기록이 전혀 없는 고객의 이름을 조회하시오.(NOT IN 사용)
SELECT 이름
FROM 고객
WHERE 고객번호 NOT IN (SELECT 고객번호 FROM 예약);

--26. 극장 테이블에서 예약 테이블에 예약된 적이 없는 극장의 극장이름을 조회하시오.
SELECT 극장이름
FROM 극장
WHERE 극장번호 NOT IN (SELECT 극장번호 FROM 예약);

--27. 예약 테이블에서 예약 횟수가 전체 고객 평균 예약 횟수보다 많은 고객번호를 조회하시오.
SELECT 고객번호
FROM 예약
GROUP BY 고객번호
HAVING COUNT(*) > (SELECT AVG(COUNT(*)) FROM 예약 GROUP BY 고객번호);

--28. 상영관 테이블에서 좌석수가 가장 적은 상영관이 속한 극장의 극장이름을 조회하시오.
SELECT 극장이름
FROM 극장
WHERE 극장번호 IN (SELECT 극장번호 FROM 상영관 WHERE 좌석수 = (SELECT MIN(좌석수) FROM 상영관));

--29. 예약 테이블에서 '2024-01-01'에 예약이 발생한 상영관의 영화제목을 조회하시오.
SELECT 영화제목
FROM 상영관
WHERE (극장번호,상영관번호) IN (SELECT 극장번호,상영관번호 FROM 예약 WHERE 날짜 = TO_DATE('2024-01-01','YYYY-MM-DD'));

--30. 고객 테이블에서 두 번 이상 예약한 고객의 이름을 조회하시오.
SELECT 이름
FROM 고객
WHERE 고객번호 IN (SELECT 고객번호 FROM 예약 GROUP BY 고객번호 HAVING COUNT(*) >= 2);

-- ============================================
-- 테이블 생성
-- ============================================
-- 승객 테이블
CREATE TABLE Passenger (
pid NUMBER PRIMARY KEY,
pname VARCHAR2(100) NOT NULL,
pgender VARCHAR2(5),
pcity VARCHAR2(100)
);
-- ============================================
-- 테이블 생성
-- ============================================
-- 승객 테이블
CREATE TABLE Passenger (
pid NUMBER PRIMARY KEY,
pname VARCHAR2(100) NOT NULL,
pgender VARCHAR2(5),
pcity VARCHAR2(100)
);
-- 여행사 테이블
CREATE TABLE Agency (
aid NUMBER PRIMARY KEY,
aname VARCHAR2(100) NOT NULL,
acity VARCHAR2(100)
);
-- 항공편 테이블
CREATE TABLE Flight (
fid NUMBER PRIMARY KEY,
fdate DATE NOT NULL,
time VARCHAR2(10),
src VARCHAR2(100),
dest VARCHAR2(100)
);
-- 예약 테이블
CREATE TABLE Booking (
pid NUMBER,
aid NUMBER,
fid NUMBER,
fdate DATE,
CONSTRAINT pk_booking PRIMARY KEY (pid, aid, fid),
CONSTRAINT fk_book_pass FOREIGN KEY (pid) REFERENCES Passenger(pid),
CONSTRAINT fk_book_agen FOREIGN KEY (aid) REFERENCES Agency(aid),
CONSTRAINT fk_book_flig FOREIGN KEY (fid) REFERENCES Flight(fid)
);
-- ============================================
-- 예시 데이터 삽입
-- ============================================
-- 승객 데이터 (승객번호 100번 포함)
INSERT INTO Passenger VALUES (100, '김철수', '남', '서울시 강남구');
INSERT INTO Passenger VALUES (101, '이영희', '여', '서울시 강동구');
INSERT INTO Passenger VALUES (102, '박민준', '남', '서울시 도봉구');
INSERT INTO Passenger VALUES (103, '최수연', '여', '서울시 마포구');
INSERT INTO Passenger VALUES (104, '홍길동', '남', '서울시 송파구');
-- 여행사 데이터
INSERT INTO Agency VALUES (1, '마당여행사', '서울시 강남구');
INSERT INTO Agency VALUES (2, '하늘여행사', '서울시 강동구');
INSERT INTO Agency VALUES (3, '바람여행사', '서울시 도봉구');
-- 항공편 데이터 (항공편 100번: 김포→제주 포함)
INSERT INTO Flight VALUES (100, TO_DATE('2025-01-15', 'YYYY-MM-DD'), '09:00',
'김포', '제주');
INSERT INTO Flight VALUES (101, TO_DATE('2025-01-20', 'YYYY-MM-DD'), '11:00',
'김포', '제주');
INSERT INTO Flight VALUES (102, TO_DATE('2025-01-25', 'YYYY-MM-DD'), '14:00',
'김포', '부산');
INSERT INTO Flight VALUES (103, TO_DATE('2024-12-31', 'YYYY-MM-DD'), '16:00',
'김포', '제주'); -- 2025년 이전
INSERT INTO Flight VALUES (104, TO_DATE('2025-02-01', 'YYYY-MM-DD'), '18:00',
'부산', '제주');
-- 예약 데이터 (승객 100번이 2025년 1월 1일 이후 탑승 포함)
-- 100번 승객 예약 (2025년 이후)
INSERT INTO Booking VALUES (100, 1, 100, TO_DATE('2025-01-15',
'YYYY-MM-DD')); -- ✅ 김포→제주 100번 항공편
INSERT INTO Booking VALUES (100, 2, 101, TO_DATE('2025-01-20',
'YYYY-MM-DD')); -- ✅ 김포→제주 101번 항공편
INSERT INTO Booking VALUES (100, 1, 104, TO_DATE('2025-02-01',
'YYYY-MM-DD')); -- ✅ 부산→제주
-- 100번 승객 예약 (2025년 이전 - 비교용)
INSERT INTO Booking VALUES (100, 3, 103, TO_DATE('2024-12-31',
'YYYY-MM-DD')); -- ❌ 2025년 이전
-- 다른 승객 예약
INSERT INTO Booking VALUES (101, 1, 100, TO_DATE('2025-01-15',
'YYYY-MM-DD'));
INSERT INTO Booking VALUES (102, 2, 101, TO_DATE('2025-01-20',
'YYYY-MM-DD'));
INSERT INTO Booking VALUES (103, 3, 102, TO_DATE('2025-01-25',
'YYYY-MM-DD'));
INSERT INTO Booking VALUES (104, 1, 103, TO_DATE('2024-12-31',
'YYYY-MM-DD'));
COMMIT;

--검증 쿼리
-- 1) 항공편 100번인 승객이 2025년 1월 1일 이후 탑승한 데이터
SELECT p.pid, p.pname, f.fid, f.src, f.dest, b.fdate
FROM Passenger p
JOIN Booking b ON p.pid = b.pid
JOIN Flight f ON b.fid = f.fid
WHERE f.fid = 100
AND b.fdate > TO_DATE('2025-01-01', 'YYYY-MM-DD');

-- 2) 승객 100번이 2025년 1월 1일 이후 탑승한 데이터
SELECT p.pid, p.pname, f.fid, f.src, f.dest, b.fdate
FROM Passenger p
JOIN Booking b ON p.pid = b.pid
JOIN Flight f ON b.fid = f.fid
WHERE p.pid = 100
AND b.fdate > TO_DATE('2025-01-01', 'YYYY-MM-DD');

--예제 시작
--1)도착지가 제주인 항공편에 대한 정보를 보이시오
SELECT *
FROM Flight
WHERE dest = '제주';

--2)출발지가 김포(src)이고 도착지가 제주(dest)인 항공편에 대한 정보를 보이시오
SELECT *
FROM Flight
WHERE src = '김포'
AND dest = '제주';

--3)고객번호가 100번인 승객이 2025년1월 1일 이후에 탑승한 비행기 번호(fid)를 보이시오
SELECT DISTINCT b.fid
FROM Booking b
WHERE b.pid = 100
AND b.fdate > TO_DATE('2025-01-01', 'YYYY-MM-DD');

--4)예약을 한 적이 있는 고객의 이름(pname)을 보이시오
SELECT DISTINCT p.pname
FROM Passenger p
WHERE EXISTS (
SELECT 1
FROM Booking b
WHERE b.pid = p.pid );

--5)예약을 한 적이 없는 고객의 이름(pname)을 보이시오
SELECT DISTINCT p.pname
FROM Passenger p
WHERE NOT EXISTS (
SELECT 1
FROM Booking b
WHERE b.pid = p.pid );

--6)고객번호가 100번인 승객이 거주하는 도시(pcity)와 같은 도시에 위치한 여행사(aname)의 이름을 보이시오
SELECT a.aname
FROM Agency a
WHERE a.acity = (
SELECT p.pcity
FROM Passenger p
WHERE p.pid = 100 );

--7)2025년 1월 1일부터 1월 30일 사이에 출발시각이 16:00이후인 항공편 정보를 보이시오
SELECT *
FROM Flight
WHERE fdate BETWEEN TO_DATE('2025-01-01', 'YYYY-MM-DD')
AND TO_DATE('2025-01-30', 'YYYY-MM-DD')
AND time >= '16:00';

--8)고객번호가 100번인 승객이 한 번도 예약하지 않은 여행사의 이름(aname)을 보이시오
SELECT a.aname
FROM Agency a
WHERE NOT EXISTS (
SELECT 1
FROM Booking b
WHERE b.aid = a.aid
AND b.pid = 100 );

--9)마당여행사(aname)를 통해 예약한 남자 승객(pgender)의 정보를 보이시오
SELECT DISTINCT p.*
FROM Passenger p
JOIN Booking b ON p.pid = b.pid
JOIN Agency a ON b.aid = a.aid
WHERE a.aname = '마당여행사'
AND p.pgender = '남';

--[단순질의]
--1. Passenger 테이블에서 모든 승객의 pid, pname, pcity를 조회하시오.
SELECT pid, pname, pcity
FROM Passenger;

--2. Passenger 테이블에서 pgender가 '남'인 승객의 pname과 pcity를 조회하시오.
SELECT pname, pcity
FROM Passenger
WHERE pgender = '남';

--3. Flight 테이블에서 출발지(src)가 '김포'인 항공편의 fid, fdate, dest를 조회하시오.
SELECT fid, fdate, dest
FROM 
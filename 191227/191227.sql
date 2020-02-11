--**제약 조건
--테이블에서 데이터를 저장할 때 반드시 지켜야 하는 조건

--제약 조건을 위반해서 데이터 삽입이 안 되는 경우
--dept테이블의 기본키는 deptno
--deptno는 중복될 수 없고 null일 수 없다
INSERT INTO dept(deptno, dname, loc)
 VALUES(10, '영업', '서울');
--10번이 존재하기 때문에 삽입 에러 발생(제약 조건 위반 에러 메시지 출력)

--1. 제약 조건 확인
--자신이 소유하고 있는 개체에 대한 정보는 user_개체s 테이블에 저장되어 있음
SELECT constraint_name, constraint_type, table_name
FROM user_constraints;

--type은 4가지
--2. 제약 조건 type
---1) P: primary key
---2) R: foreign key
---3) C: check, not null
---4) U: unique

--3. 제약 조건 설정
CREATE TABLE 테이블이름(
    열이름 자료형 [constraint 제약 조건 이름] 제약 조건 종류,
    열이름 자료형 [constraint 제약 조건 이름] 제약 조건 종류,
     ...
    [constraint 제약 조건 이름] 제약 조건 종류(컬럼 이름));
-->열을 만들 때 설정하는 제약조건을 컬럼레벨 제약조건
-->열에 대한 정의를 끝내고 나중에 만드는 제약조건은 테이블 레벨 제약조건 
-->NOT NULL은 반드시 컬럼 레벨 제약조건에서 설정해야 함

--4. 데이터베이스에서 null 저장
temp1 varchar2(10) NOT NULL,
--temp1: 10byte 할당받아 사용. NOT NULL은 무조건 여기서 크기 설정됨
temp2 varchar2(10)
--temp2: NULL 여부를 저장하기 위한 1바이트를 추가로 설정
---(11byte 할당받아서 사용)

--5. 작성
--회원 테이블
--email 문자 50자 이내 변경 불가능 - 기본키
--pw 문자 15자 이내 변경을 자주 - 필수
--nickname 한글 10자 이내이고 변경 불가능 - 유일(중복불가능)

-->컬럼레벨 제약조건을 이용해서 테이블 생성
drop table member; 기존의 member 테이블이 존재하면 삭제
create table member(
    email varchar2(50) primary key,
    pw char(15) not null,
    nickname varchar2(30) unique;
--varchar2는 저장되는 데이터의 크기에 따라 저장공간이 변함
--char는 한 번 설정되면 저장되는 데이터의 크기와 상관없이 크기 고정
--자주 변경되는 데이터는 char로 만듦

--자주 변경되는 데이터를 varchar2로 만들게 되면 데이터의 크기가 변경될 때
--저장 공간이 부족하면 row migration(행 이주)를 수행해서
--작업 속도가 현저히 떨어질 수 있음
   
   
--6. 제약 조건 이름
--제약 조건 이름을 생략하면 오라클이 제약조건 이름을 임의로 생성함
--제약 조건을 삭제하거나 변경할 때 자신이 만든 이름이 아니기 때문에 찾기 어려움
--위처럼 제약조건 이름 없이 생성하는 것보다는 제약 조건 이름을 추가하여 작성하는 것을 권장

create table member(
    email varchar2(50) CONSTRAINT member_pk PRIMARY KEY,
    pw char(15) CONSTRAINT member_nn NOT NULL,
    nickname varchar2(30) CONSTRAINT member_uk UNIQUE;
 --제약 조건 이름을 만들 때는 관습적으로 테이블 이름과 제약 조건 종류를 합쳐서 만듦
SELECT constraint_name, constraint_type, table_name
FROM user_constraints;


--7.체크 제약 조건 설정
CHECK(컬럼이름 조건);
--성별은 남 또는 여만 가져야 한다.
gender varchar2(3) CHECK(gender IN ('남','여'))

--점수는 0-100 사이의 값만 가져야 한다.
score number(3) CHECK(score BETWEEN 0 AND 100)

--8. 외래키 제약 조건
--컬럼 레벨에서 설정할 때
REFERENCES 참조할 테이블(부모테이블)이름(참조할 열 이름) 옵션;

--옵션을 생략하면 참조하는 테이블에 있는 값은 참조되는 테이블에서 삭제될 수 없음
--옵션을 생략하면 부모 테이블에서 외래키로 설정된 값을 삭제할 수 없음
--옵션은 2가지
---하나는 부모 테이블에서 삭제될 때 자식 테이블에서 같이 삭제되도록 할 수 있고
ON DELETE CASCADE
---다른 하나는 값을 NULL로 변경해주는 것
ON DELETE SET NULL

--외래키로 설정되는 키는 그 테이블에서 PRIMARY KEY이거나 UNIQUE이어야 함
--데이터베이스 이론 책에는 PRIMARY KEY이어야 한다고 나옴
--실제 데이터베이스에서는 UNIQUE로 설정됨

--dept 테이블에서 deptno가 10인 데이터를 삭제
SELECT *
FROM dept;

DELETE FROM DEPT
WHERE deptno = 10;
--error:
--SQL Error [2292] [23000]: ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record FOUND
--emp테이블에서 옵션 없이 deptno를 참조하기 때문에 emp테이블에서 10을 저장하고 있으면 삭제가 안됨
--dept테이블 자체도 삭제 안됨


--DROP TABLE member;

SELECT *
FROM member;

CREATE TABLE member(
email varchar2(100) PRIMARY KEY,
pw char(50) NOT NULL,
nickname varchar2(30) UNIQUE);

--데이터 삽입
INSERT INTO member(email, pw, nickname) 
VALUES('ggangpae1@gmail.com', '1234', '군계');
 
CREATE TABLE board(
num NUMBER(5) PRIMARY KEY,
title varchar2(100), 
content varchar2(1000), 
email varchar2(100) REFERENCES MEMBER(email) ON DELETE cascade);

INSERT INTO board(num, title, content, email) 
VALUES(1, '제목', '내용', 'jessica72@gmail.com');
--삽입 실패: email이 member테이블의 이메일을 참조하는 외래키로 설정
--MEMBER 테이블에 없는 값은 삽입 불가

INSERT INTO board(num, title, content, email) 
VALUES(1, '제목', '내용', 'ggangpae1@gmail.com');

--data 삽입 여부 확인
SELECT *
FROM board;

--member테이블에서 email이 ggangpae1@gmail.com인 데이터를 삭제
--board테이블의 외래키 옵션이 ON DELETE CASCADE ->  board 테이블에서도 데이터 삭제

DELETE FROM member
WHERE email = 'ggangpae1@gmail.com';

SELECT *
FROM board;

--부모 테이블 삭제 명령
DROP TABLE MEMBER;
--에러 발생하는데 테이블의 구조를 변경하거나 삭제하는 명령은 
--데이터를 확인하지 않고 테이블 사이의 관계만 확인해서 수행여부 결정

--DROP TABLE board;


--9.default
--데이터를 입력하지 않았을 때 자동으로 삽입하는 값을 설정할 때 사용하는 옵션
--default값의 형태로 설정

--regdate는 오늘 날짜를 기본값으로 설정
regdate DEFAULT SYSDATE

--readcnt 값은 기본값을 0으로 설정
readcnt DEFAULT 0

--10.테이블 레벨 제약 조건 설정
--열을 생성할 때 제약 조건을 설정하지 않고 열을 전부 생성한 후 마지막에 제약 조건 설정
--제약조건이름(열 이름)의 형태로 설정
--외래키는 foreign key(열 이름) references 부모테이블이름(열 이름)의 형태로 설정
--반드시 테이블 레벨에서 제약 조건 설정하는 경우
----: 기본키를 두 개 이상의 열로 만들 때
CREATE TABLE board(
num NUMBER(5) PRIMARY KEY,
title varchar2(100), 
content varchar2(1000), 
email varchar2(100)
FOREIGN KEY(email) REFERENCES MEMBER(email) ON DELETE cascade);

--기본키를 두 개 이상의 컬럼으로 만들게 되면 컬럼 레벨에서 2개 열에 primary key를 설정해야 함 -->error
--primary key는 테이블 만들 때 딱 1번만 설정 가능
id varchar2(10) PRIMARY KEY,
num number(5) PRIMARY KEY;
--->에러

--만약 id와 num을 합쳐거 primary key를 만들고자 하면 이때 모든 열을 정의하고
--마지막에 primary key(id, num)의 형태로 설정해야 함

--11. 제약 조건 변경
---1) 제약 조건 추가
ALTER TABLE 테이블 이름
ADD [CONSTRAINT 제약 조건 이름]
제약 조건 종류(열 이름);

---2) 제약 조건 수정
ALTER TABLE 테이블 이름
MODIFY 열이름 [CONSTRAINT 제약 조건 이름] 제약 조건 종류;
--NOT NULL을 추가하는 경우는 add가 아니라 modify임
--NULL이 가능한 상태에서 NULL이 불가능한 것으로 수정한다고 간주

---3) 제약 조건 삭제
ALTER TABLE 테이블 이름
DROP CONSTRAINT 제약 조건 이름;


--12. 제약 조건의 비활성화
---1) 비활성화
ALTER TABLE 테이블 이름
disable CONSTRAINT 제약 조건 이름;

---2) 활성화
ALTER TABLE 테이블 이름
enable CONSTRAINT 제약 조건 이름;
-->테스트 할 때 많이 이용
--예) 회원테이블
------ID, password, nickname 필수
-->샘플 데이터 삽입해서 아이디 중복 검사 테스트


--**테이블을 제외한 개체
--1. View
--자주 사용하는 select문을 하나의 이름으로 만들어주고 마치 테이블인 것처럼 사용
--가상의 테이블
---1) 사용 이유
------속도: select구문은 요청이 오면 그 때 구문 확인해서 return
---------view와 procedure는 처음 한 번 수행하고 나면 메모리에 저장된 상태로 존재해서
---------다음 호출부터는 구문확인을 하지 않음
------보안: 각 사용자에게 모든 데이터를 넘겨주지 않고 필요한 데이터만 별도의 이름으로 사용하게 함
---------실제 구조 알 수 없도록 함
---------procedure도 같은 이유로 사용

---2) View는 삽입, 삭제, 갱신에 제약이 있는 것이지 불가능은 아니다
---View에 데이터를 삽입하면 View를 만들 때 사용한 원본 테이블에 데이터가 삽입됨

---3) 생성구문
CREATE [OR replace] VIEW 뷰이름
AS
SELECT 구문
[WITH CHECK OPTION]
[WITH READ ONLY]
-->OR REPLACE: VIEW가 존재하면 수정
-->VIEW는 ALTER VIEW 명령이 없어서 구조변경이 안됨
-->WITH CHECK OPTION 은 SELECT 문에서 조회가 가능한 경우에만 삽입, 삭제, 갱신 설정
-->WITH READ ONLY는 읽기 전용
--> 두 설정어는 같이 있으면 안 됨

---4) 삭제
DROP VIEW 뷰이름;

---5) 실습
--dept 테이블의 모든 내용을 복사해서 tempdept라는 테이블 생성
CREATE VIEW tempdept
AS
SELECT *
FROM dept;

SELECT *
FROM tempdept;

--어떤 유저가 tempdept테이블에서 deptno와 dname만 필요하다면
--테이블을 주는 것이 아니고 뷰를 만들어서 제공
CREATE OR REPLACE VIEW deptview
AS
SELECT deptno, dname
FROM tempdept;
-->deptview를 테이블인 것처럼 사용 가능
SELECT *
FROM deptview;
--실제로 deptview라는 테이블은 없음
--별도의 옵션 없이 뷰를 생성했기 때문에 뷰에 데이터 삽입, 삭제, 갱신 가능
--뷰에 작없이 발생하는 것이 아니고 원본 테이블에 작업을 수행함
INSERT INTO deptview(deptno, dname) 
values(11, '마케팅');
--데이터 삽입 결과 확인
SELECT *
FROM deptview;

--원본 테이블에 삽입결과 들어가있는 것 확인
SELECT *
FROM tempdept;

--뷰를 만들 때 WITH READ ONLY 라는 옵션을 추가했다면 데이터 삽입시 에러 발생

---6) 복합 뷰
---2개 이상의 테이블을 JOIN 해서 만든 뷰
---복합 뷰는 WITH READ ONLY 옵션이 없어도 삽입, 삭제, 갱신 작업에 제약이 있음
---구조 변경이 ALTER이지만 VIEW는 사용 불가능
---DROP VIEW는 가능
---구조 변경 시 CREATE OR REPLACE VIEW (덮어씌워서)를 통해서 변경 가능

--2. inline VIEW  (TOP-N)
---1) 오라클의 rownum
---오라클이 부여하는 일련번호
---SELECT 구문을 수행해서 결과를 리턴할 때 보여지는 일련번호
---FROM절에서 where절로 조건을 비교를 할 때 임시로 부여되고 where절 조건을 만족하면 확정되는 형태
---어떤 행을 가져왔을 때 where절의 조건을 만족하면 rownum은 1이 증가해서 설정
---where절 조건 불충족시 다음행 가져올 때 rownum은 이전과 같은 상태의 값으로 설정

--student 테이블 만들어서 inline view 사용 이전 결과들 알아보기
--DROP TABLE STUDENT;
CREATE TABLE student(
name char(6), score NUMBER(5));

INSERT ALL
INTO student 
VALUES('김', 80)
INTO student 
VALUES('이', 90)
INTO student 
VALUES('박', 87)
INTO student 
VALUES('최', 91)
SELECT *
FROM DUAL;

SELECT *
FROM student;

--where절 없을 때
SELECT rownum, name, score
FROM student;

--where절 있을 때(조건 수행 필요)
SELECT rownum, name, score
FROM STUDENT
WHERE score >= 90;
--where절은 행 기준으로 수행
--충족된 '이'의 90점이 rownum 1번이 되고 
--충족된 '최'의 91점이 rownum 2번이 됨

SELECT rownum, name, score
FROM STUDENT
WHERE rownum <= 2;
--rownum 1, 2 행 return

SELECT rownum, name, score
FROM STUDENT
WHERE rownum > 2;
--안 나옴
--작다로는 할 수 있지만 크다로는 절대 못함
--어떤 행 기준으로 앞의 값은 가져올 수 있어도 뒤의 값은 못 가져옴

SELECT rownum, name, score --3
FROM STUDENT --1
WHERE rownum <= 2  --2
ORDER BY score DESC; --4
--score 기준으로 네개 나오는 게 아닐 rownum 2개 꺼내고 점수 높은 순으로 2, 1 거꾸로 나옴
--where이 ORDER BY보다 먼저 수행되기 때문에
--rownum은 안 바뀜
------------------> inline VIEW
--where보다 먼저 조건 걸 수 있는 곳은 from밖에 없음
--inline view는 from절에 사용하는 select절(오라클에서는)
--일종의 subquery

--student 테이블에서 점수 높은 두 값 내림차순 해서 rownum는 순차적으로 가져오기
SELECT rownum, name, score  --3
FROM (SELECT * FROM STUDENT ORDER BY score DESC)  --1(모든 행 점수 기준 내림차순 먼저)
WHERE rownum <= 2;  --2(번호 매긴 후 1, 2번 추리기)

--rownum> 2 값 try
SELECT rownum, name, score  --3
FROM (SELECT * FROM STUDENT ORDER BY score DESC)  --1(모든 행 점수 기준 내림차순 먼저)
WHERE rownum > 2;  --2
--error(rownum은 return된 뒤 번호 매겨지는 것으로서 계속해서 1에 머물러 있는 한 값이 나올 수 없음)

--순번 > 2 값 뽑아낼 수 있는 수식(rownum을 다른 것으로 치환)
SELECT rownum, name, score  --3(나온 값에서 rowname 다시 매기기)
FROM (SELECT rownum rnum, name, score --(rnum을 하나의 컬럼으로)
    FROM (SELECT * FROM STUDENT 
        ORDER BY score DESC))  --1
WHERE rnum > 2;  --2(rnum에서  2보다 큰 값 꺼내기)
--더보기 역할할 수 있음(더보기 누르면 밑에 3, 4 나옴)

--다른 아이디어(페이지 뽑아오기) 페이징 처리
WHERE rnum >= 1 AND rnum <= 10 --1에서 10쪽까지 페이지 뽑아오기
WHERE rnum >= 11 AND rnum <= 20 

---2) inline VIEW
---from절에 작성한 select구문
---3) 오라클에서 데이터를 page단위 또는 topN 구현할 때 사용
---4) 구조
SELECT 필요한 컬럼이름 나열
FROM (SELECT rownum 별명, 컬럼이름 나열 
    FROM(SELECT 필요한 컬럼이름 
        FROM 테이블이름 
        ORDER BY 원하는 컬럼으로 정렬)
WHERE 별명을 가지고 페이지 단위 또는 더보기 작성;

---5) emp테이블에서 입사일이 가장 늦은 사원 5명의 이름과 입사일
------adams, scott, miller, ford, james
SELECT ename, hiredate --, rnum--(페이지처럼 보고싶으면) 
FROM (SELECT rownum rnum, ename, hiredate 
    FROM(SELECT rownum, ename, hiredate 
        FROM EMP 
        ORDER BY hiredate desc))
WHERE rnum > = 1 AND rnum <= 5;

-----그 다음 페이지에 있을 5명
SELECT ename, hiredate--, rnum--(페이지처럼 보고싶으면)
FROM (SELECT rownum rnum, ename, hiredate 
    FROM(SELECT rownum, ename, hiredate 
        FROM EMP 
        ORDER BY hiredate desc))
WHERE rnum > = 6 AND rnum <= 10;
----------------------------------------->신문에서 많이 쓰임



--TO_DATE 문자타입 SQL문장
SELECT TO_DATE('20191201151212','YYYYMMDDHH24MISS') AS ONE
           ,TO_DATE('20191201091212','YYYYMMDDHHMISS') AS TWO
           ,TO_DATE('2019120115','YYYYMMDDHH24') AS THREE
           ,TO_DATE('2019','YYYY') AS FOUR
FROM DUAL;


--**SEQUENCE
--오라클에 존재하는 일련번호 생성을 위한 개체
--기본키를 생성하는 것이 애매한 경우 시퀀스를 이용해서 생성하는 경우가 있음
--1. 생성
CREATE SEQUENCE 시퀀스 이름
    [START WITH 시작번호]
    [INCREMENT BY 간격]
    [MAXVALUE 최댓값 | nomaxvalue]
    [MINVALUE 최솟값 | nominvalue]
    [CYCLE | nocycle]
    [cache | nocache]

--START WITH 를 생랼하면 관리자 계정에서는 1인데 나머지 계정은 1이 아닐 수도 있음
--increment by는 생략하면 1
--maxvalue 생략하면 10^27
--minvalue 생략하면 1
--마지막 숫자에 도달할 때 맨 처음 숫자로 이동할지 여부를 cycle로 지정할 수 있으며
-- nocycle로 지정하면 마지막 숫자 다음에서 오류 발생
-- cycle을 설정하면 primary key로 사용할 수 없음
--기본은 nocycle
--cache는 시퀀스 값 메모리에서 관리할 것인지의 여부로 기본은 nocache

--2. 값 사용

--다음 시퀀스 값
시퀀스.nextval   

--현재 시퀀스 값
시퀀스.currval 
--nextval 한 번이라도 호출한 후에 사용해야 함(otherwise error)

--3. 시퀀스 수정
ALTER SEQUENCE 시퀀스이름
옵션다시 설정
--> start with로 수정할 수 없음

--4. 시퀀스 삭제
DROP SEQUENCE 시퀀스이름;

--5. 실습
--1부터 1씩 증가 시퀀스
CREATE SEQUENCE boardseq
START WITH 1;

--시퀀스 다음값 확인
SELECT boardseq.nextval
FROM dual;

-- 현재 시퀀스 확인   --(nextval 안 할 시 에러)
SELECT boardseq.currval
FROM dual;

--시퀀스 삭제
DROP SEQUENCE boardseq;

--6. 데이터베이스 연동 프로그래밍에서는 SEQUENCE 대신에 가장 큰 값을 찾아서 +1 하는 경우도 있음
--일련번호를 만들 때 꼭 sequence를 쓰는 것은 아님


--**index
--데이터를 빠르게 조회하기 위한 포인터
--책에서 특정 챕터를 빠르게 보기 위한 책갈피
--데이터베이스 종류에 따라 구현 방식 가지각색
--오라클 =>  B*트리 --b는 balance, 균형트리
--인덱스를 사용하면 빠르게 조회할 수 있다는 장점이 있지만 인덱스만틈 메모리 할당 필요
----삽입이나 삭제 및 갱신 작업이 발생하면 인덱스 조정으로 인한 속도 저하 발생 우려

--배열: 크기 고정
--연속적으로 저장

--리스트: 크기 가변
---list를 이해해야 tree를 이해할 수 있음
---*linked list: 데이터와 다음 데이터를 가리키는 포인터를 갖는 자료
------------------>컴퓨터에서 거의 매일 쓰는 아주 많이 씀
---리스트중 배열과 비슷한 리스트: array list
-----한쪽이 뚫려 있어서 나열하듯 계속 추가 가능. 중간에 뻥 뚫리면 스스로 당겨서 메꿈
--ARRAY list
-----*stack
-----Queue
-----Deque
-----못 만들더라도 각각 이름과 특징은 알고 있도록 =>면접

--array list 단점 때문에 생겨난  linked list

--data, 다음 data 위치
--10, 40, 30
--head, --
--head, (3000번쪠)(다음 데이터 주소 저장)
--10(3000번째), (700번쪠)
---------10, (2700번째) <<--이런식이면 40 지워지는 걸로 간주(고리끊기, 사슬 끊기)
---------예) 휴지통에 버리기, 휴지통 비우기, 휴지통 복구하기<<<복구 가능
--40(700번쩨), (2700번쩨)
--포인터들만 없앰 
--용량 큰 파일1 개 지우는 것보다 용량 작은 파일 50개 지우는 게 속도가 더 느린 이유
--30(2700번째), nil

--double linked는 양쪽으로
--python 함수 reverse(한쪽 방향으로 갈 수 있고 반대로 갈 수도 있다면)
--파이썬의 리스트가 더블링크드 리스트임
--자바는 다 있음,,,
--파이썬은 리스트만 배우면 되니 쉽다고 느껴지는 것
--파이썬은 제한 많음
--응용프로그램은 파이썬으로 만든 게 적다(오예!)
--용도별로 다 있는 자바가 더 효율적이지
--트리는 더블링크드 리스트가 가로 세로 레벨로 이어져 있다고 생각하면 됨(더블링크드는 가로만 있음)
-----상하관계 존재(부모-자식) 예) 파일탐색기 ▶ ▼

--B tree
--: (데이터를 가리킬 수 있는)포인터의 1/2이상 채워진 트리
--B* tree
--: 2/3 이상 채워진 트리

--**index
--데이터를 빠르게 조회하기 위한 포인터
--책에서 특정 챕터를 빠르게 보기 위한 책갈피
--데이터베이스 종류에 따라 구현 방식 가지각색
--오라클 =>  B*트리 --b는 balance, 균형트리
--인덱스를 사용하면 빠르게 조회할 수 있다는 장점이 있지만 인덱스만틈 메모리 할당 필요
----삽입이나 삭제 및 갱신 작업이 발생하면 인덱스 조정으로 인한 속도 저하 발생 우려

--정렬 구조는 트리를 이용한다
--이곳은 출발점보다 큰 자료가 있고 다른 곳은 출발점보다 작은 자료가 있다.
--출발점인 자료를 지우면? ==>트리를 다시 만들어야 함(인덱스 조정작업)
--출발점보다 더 적절한 값이 들어와서 출발점이 바뀌어도 인덱스 조정작업
--인덱스 작업으로 빨리 찾을 수는 있지만 삽입,삭제, 갱신 작업으로 인해 느려짐 
--읽기보다 삽입, 삭제, 갱신 작업을 많이 한다고 그러면 인덱스가 적절하지 않을 수도

--stack 동전케이스? 가장 마지막에 넣은 게 가장 먼저 나옴
--queue 자판기 FIRST IN FIRST OUT
--deque 위로도 가고 아래도 감(터치로 올리면 위 자료 사라지고 아래 자료 생겨남)

--1. 인덱스 생성
CREATE INDEX 인덱스 이름
ON 테이블이름(컬럼이름);

--2. 인덱스 제거
DROP INDEX 인덱스이름;

--> BLOB나 CLOB의 LOB 계열은 인덱스 설정 불가
---데이터 크기가 크기 때문에 인덱스 설정시 부담이 너무 커서 인덱스 설정 권장 안 함

--3. 인덱스 생성해야 하는 경우
--행의 개수가 너무 많을 때
--특정 열이 where절에서 자주 사용될 때
--null이 많은 열
--join에 자주 사용되는 열
--검색할 때 전체 데이터의 2-4% 정도 검색할 때

--4.인덱스 생성하면 안되는 경우
--행의 개수가 너무 적을 때
--삽입, 삭제, 갱신 작업이 빈번히 발생할 때
--검색 결과가 전체 데이터의 10%이상일 때

--5. PRIMARY KEY나 UNIQUE 속성을 설정하면 자동으로 인덱스 생성



--**동의어(synonym)
--데이터베이스 개체에 별명을 붙이는 것
--1. 생성
CREATE synonym 별명
FOR 원래이름;
--2. 삭제
DROP synonym 별명;
--데이터베이스를 프로그램과 연동할 때  별명을 사용하면 유지보수 편리함

--**stored PROCEDURE
--자주 사용하는 SQL구문을 프로그래밍 언어의 함수처럼 하나의 이름으로 만들어두고 그 이름을 이용해서 sql구문 실행
--1. 장점
--SQL 구문을 실행하는 것보다는 실행 속도가 빠르고 보안이 유지
--2. 생성
CREATE [OR replace] PROCEDURE 프로시저이름(매개변수 이름 [MODE]자료형, ...)
IS
지역변수 선언
BEGIN
	수행할 sql구문
END;
/  -->DBeaver에서는 마지막 슬래시 제외해야 함
----OR REPLACE는 수정할 때 사용
----MODE는 IN, OUT, 생략도 가능
---------IN: 입력을 위한 매개변수
---------OUT: 출력을 위한 매개변수
----자료형을 작성 시 직접 자료형을 작성해도 되나 테이블이름.열이름%TYPE 으로 다른 열의 자료형 이용 가능
--SQL 작성할 때도 마지막에 반드시 ';' 빼먹지 않는 것 주의

--3. 프로시저 호출
---1) sqlplus: EXECUTE 프로시저이름(매개변수);
---2) DBeaver, sqldeveloper
BEGIN
	프로시저이름(매개변수);
END;

--4. 프로시저를 만드는 문법은 관계형 데이터베이스 종류마다 다름
--오라클의 프로시저 만드는 문법을 PL/SQL이라고 함

--5. 프로시저 삭제
DROP PROCEDURE 프로시저 이름;

--6. 실습
--deptno, dname, loc을 입력받아서 dept 테이블에 데이터를 삽입하는 프로시저 만들고 호출
CREATE PROCEDURE insert_dept(
    vdeptno dept.deptno%TYPE,   ---매개변수 그대로 쓰지 말기(파이썬 self 생각남)
    vdname dept.dname%TYPE,
    vloc dept.loc%TYPE)
IS --지역변수 필요없으면 생략
BEGIN
	INSERT INTO dept(deptno, dname, LOC)
	 values(vdeptno, vdname, vloc);
END;
--/(DBeaver가 아닐 땐 슬래시까지 포함시켜줘야 함)

---2)프로시저 실행
--생성됐는지 꼭 확인해봐야 함(에러 발생 여부 확인)
BEGIN
	insert_dept(23, '총무', '수원');
END;
--NO error!
--error 발생시 왼쪽 파일schemas-SCOTT-Procedures 의 declaration에서 틀린 부분 확인
----본문 다시 돌아와서 수정하고 프로시저이름 오른쪽클릭-새로고침 후 다시 실행

--한 줄쓰기도 가능
BEGIN insert_dept(22, '총무', '수원'); END;

---3)확인
SELECT *
FROM dept;
--22번 총무 삽입됨을 알 수 있음

---4) 프로시저 삭제
DROP PROCEDURE insert_dept;

--**TRIGGER 트리거
--테이블에 데이터를 삽입, 삭제, 갱신할 때 작업 전후에 다른 작업을 수행하도록 하는 개체
--작업 전에 수행하는 동작은 유효성을 검사 시 유효성 검사에 실패할 경우 작업을 수행하지 않기 위해서임
--작업 후에 수행하는 동작은 작업을 하고 다른 작업을 연쇄적으로 실행하기 위해서임
--프로그래밍에서 이와 유사한 개념으로 필터와 AOP가 있음
--데이터 작업을 수행하고 로그를 기록해야 하는 경우

--실제 수행해야 할 작업 => 비즈니스 로직
--로그를 기록하는 것처럼 실제 작업은 아니나 별도로 해야 하는 작업 => 공통 관심 사항
--비즈니스 로직 수행 종료 후 공통 관심 사항 실행을 위해 일반 코드로 작성하게 되면
--==> 비즈니스 로직 수행
--==> 공통 관심 사항 수행
--데이터베이스에서는 트리거를 이용해서 비즈니스 로직을 수행하면 공통 관심 사항이 자동으로 수행하도록 하고
--비즈니스 로직 담당 개발자가 비즈니스 로직 개발에만 집중할 수 있도록 해줌

--sqlite에서는 외래키를 설정하고 ON DELETE CASCADE 옵션을 설정해도
--부모테이블에서 데이터가 삭제될 때 자식 테이블에서 데이터가 연쇄적으로 삭제되지 않음
--이런 경우에도 트리거를 이용하면 부모 테이블에서 데이터가 삭제될 때 자식 테이블에서 자동으로 삭제되도록 구현 가능

--1.trigger 생성
CREATE OR REPLACE TRIGGER 트리거이름
[BEFORE | AFTER] [ INSERT | UPDATE | DELETE] ON 테이블이름
[FOR EACH ROW]
[WHEN 조건]
BEGIN
	수행할 내용
END;
--FOR EACH ROW는 여러 개의 행에 UPDATE, DELETE, INSERT가 발생할 때 트리거를 여러 번 수행시키는 옵션
--생략 시 여러 개의 행에 작업이 발생해도 트리거는 한 번만 동작
--작업 하나마다 하고 싶으면 FOR EACH ROW 하는 거고 그게 아니면 생략 가능
--when에 조건 설정하고 조건이 맞는 경우에만 수행하게 할 수도 있고 수행하지 않게 할 수도 있음

:OLD.컬럼이름, :NEW.컬럼이름
--OLD는 이전 데이터
------DELETE에서 삭제되는 데이터의 값
------UPDATE에서 변경되기 이전 데이터의 값
------INSERT에서는 사용 불가
--NEW는 새로 대입되는 값
------UPDATE와 INSERT에서 사용

--수행할 내용 자리에 raise error 코드 입력
raise_application_error(에러코드번호, 메시지);
--작업 수행하지 않고 에러 메시지 출력 (python raise 같은 거네)

--raise_application_error 예시
WHEN 정기점검 시간인지 확인
raise_application_error(에러코드번호, 메시지);
--정기점검 시간에 INSERT 일어나지 않도록

--관리자가 되면 트리거 자주 사용
--다음주 트리거 시간 설정, 파이썬 연동, BLOB
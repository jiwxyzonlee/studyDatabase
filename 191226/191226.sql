---->회원정보 테이블 만들기(테이블이름 - member)
CREATE TABLE member(
email varchar2(100), 
name varchar2(30), 
password char(15), 
age number(3),
joindate date,
logindate date);

--table 확인
SELECT * FROM MEMBER;

--*1. emp테이블 복사해서 emp01 테이블 생성
CREATE TABLE emp01
AS
SELECT *
FROM EMP;

--emp01 TABLE 확인
SELECT *
FROM emp01;

--*2. emp테이블의 구조만 복사해서 테이블 생성
--==>emp02
CREATE TABLE emp02
AS
SELECT *
FROM EMP
WHERE 0 = 1;  --절대 true 될 수 없는 조건 / 무조건 참은 1 = 1

--emp02 TABLE 확인
SELECT *
FROM emp02;

--id / pw 있는 홈피의 경우
SELECT *
FROM MEMBER
WHERE id = ? AND pw = ? OR 1 = 1;
--데이터가 없으면 
--로그인 구현시 id를 가지고 비밀번호를 가져와서 다시 비교하도록 만들거나
--아이디와 비밀번호를 입력할 때 sql 예약어를 사용하지 못하도록 해야 함
--ex. or 입력 못하도록

--프로그램에서 비밀번호를 비교하도록 만들면 됨
SELECT *
FROM MEMBER
WHERE id = ?;

--파이썬 정규표현식 - 패턴 읽기


--**테이블 수정
--열을 추가하거나 열을 변경하거나 열을 삭제하는 작업
--1. 열을 추가
alter table 테이블 이름
add(열 이름 자료형);

--emp02 TABLE에 전화번호 열 추가
--전화번호는 문자 11자리 
-- 자주 변경될 것 같은데 자릿수는 변화 없음 => varchar2 사용 가능
ALTER TABLE emp02
ADD(phone varchar2(11));

--TABLE 확인
SELECT *
FROM emp02;

--2. 열 수정
alter table 테이블이름
modify(열이름, 자료형);

--자료형 자체를 변경하는 것, 길이 줄이는 것은 신중히 고려해야
--기존 데이터가 소멸 우려
--보통 늘리는 쪽으로 선택함

--emp02 table에서 phone column 자료형을 varchar2(12)로 변경
alter table emp02
modify(phone varchar2(12));

--table 확인
select *
from emp02;


--3. 열 삭제
ALTER TABLE 테이블 이름
DROP COLUMN 열이름;
--열 이름을 정확하게 입력했는데도 삭제되지 않은 경우는
--다른 테이블에서 이 열을 참조하는 경우가 있기 때문임
--이럴 때는 자식 테이블의 데이터를 먼저 지우고 삭제해야 함
--외래 키

--emp01 table의 phone 열 삭제
ALTER TABLE emp02
DROP COLUMN phone;

--TABLE 확인
SELECT *
FROM emp02;
--삭제는 웬만하면 잘 안 씀


--4.SET unused
--데이터베이스 테이블은 구조를 변경하거나 삭제할 때 
--그리고 데이터를 추가하거나 갱신 또는 제거할 때
--LOCK 발생

--lock이 걸려 있으면 select를 제외한 다른 작업 수행 불가

--대량의 데이터가 저장된 상태에서 열 삭제 시
--열이 전부 삭제 될 때까지 LOCK 걸려서 다른 작업 수행 불가

--열 삭제는 바로 삭제하는 것보다 사용을 못하게 한 후 시간 여유를 가지고 삭제하는 것이 효율적
ALTER TABLE 테이블 이름
SET unused(열 이름);
-- 위 명령 수행시 열 사용 못함

ALTER TABLE 테이블이름
DROP unused columns; 
--이 명령으로 사용금지된 열 삭제
--ex. 서버점검시간



--*3. 테이블 제거
DROP TABLE 테이블 이름;
--테이블이 존재하는데 위 명령이 실패하는 경우는 하나 이상의 열이 다른 테이블에서 참조되는 경우

--emp02 table 제거
DROP TABLE emp02;

--확인
SELECT *
FROM emp02;
--SQL Error [942] [42000]: ORA-00942: table or view does not exist
--정상적으로 테이블이 삭제됐을 경우 위와 같은 에러 발생

--테이블의 데이터만 삭제
truncate TABLE 테이블 이름;
--개발을 종료하고 서비스 하기 전에 배포할 때 줄 이용

--테이블 이름 변경(거의 안 씀)
RENAME 예전 이름 TO 새이름;

--여기까지
--------------------------------------DDL(DATA DEFINITION LANGUAGE)
--데이터 구조에 관련된 명령어
--CREATE ALTER DROP truncate rename  



--------------------------------------DML (DATA MANIPULATION LANGUAGE) 
--(데이터 조작 언어. 작업의 단위가 테이블이 아니고 테이블 안의 데이터)
--데이터 삽입, 갱신, 삭제하는 명령어

--*1. 데이터 삽입
INSERT INTO 테이블이름(열 이름 나열)
 VALUES(열이름에 해당하는 데이터 나열);

--열 개수에 맞게 데이터 나열하고 자료형도 일치해야
--!!!!! VALUES 앞에 공백 있어야 함 !!!!!

--INSERT 하다보면 데이터베이스에서는 실수가 없는데
--INSERT INTO 테이블이름, (여기서 이어쓰면 상관 없으나 줄 나누고)
--(^없이)VALUES   => (+)결합으로 인식됨
-- => '테이블이름values' 붙어서 return됨

--문자열에서의 에러는 찾기가 어려움
--그럴 때는 줄바꿈 안 하고 나열하는 게 더 나음

--dept 테이블에 deptno가 있고 dname은 비서 loc은 서울인 데이터 삽입
--loc 컬럼의 길이는 13이어서 한글 5글자(=15바이트)는 삽입 불가
INSERT INTO dept(deptno, dname, loc)
VALUES(99, '비서', '서울특별시');
--sql을 다른 editor에 작성한 후 복사를 할 때는 작은 따옴표 꼭 확인
--powerpoint 같은 프로그램서의 작은 따옴표가 다른 형태로 바뀌어서 에러 발생 할 수도 있음

--table 확인
SELECT *
FROM dept;


--SQL Error [12899] [72000]: ORA-12899: value too large for column "SCOTT"."DEPT"."LOC" (actual: 15, maximum: 13)
--ORA-12899  -->db에러. 오라클 문제임

--데이터를 삽입할 때 컬럼 이름 생략 가능
--테이블의 구조에 맞게 모든 데이터를 순서대로 전부 입력하는 경우에만 가능
INSERT INTO dept
 VALUES(88, '총무', '마산');
 
--table 확인
SELECT *
FROM dept;

--NULL 삽입
--명시적으로 값을 NULL 이라고 설정해도 되고
--기본값이 설정되지 않은 컬럼은 생략하고 대입

INSERT INTO dept 
VALUES(87, '영업', null);

INSERT INTO dept(deptno, DNAME) 
VALUES(86, '회계');
--이 경우에는 loc에 기본값이 설정되지 않은 경우에 null이 대입되고
--기본값이 설정되어 있으면 기본값 대입됨

--table 확인
SELECT *
FROM dept 
ORDER BY deptno;

--조회한 결과(select 문 결과)를 삽입 가능
INSERT INTO 테이블 이름(컬럼 이름 나열)
SELECT 구문;
--SELECT 구문 결과와 컬럼 이름, 자료형이 일치하고 개수도 같으면 조회한 결과 삽입 가능

--(table 두 개 필요, dept테이블의 구조를 그대로 갖는 dept01 테이블 생성)
CREATE TABLE dept01
AS
SELECT *
FROM DEPT
WHERE 0 = 1;

--table 확인
SELECT *
FROM dept01;

--예 : 바깥에 데이터를 가져 나가야 하는데 db를 다 옮길 수는 없고 자료는 필요할 때
--dept테이블에서 deptno가 50이상인 데이터만 select한 결과를  dept01에 복사
INSERT INTO dept01
SELECT *
FROM DEPT
WHERE deptno >= 50;

--table 확인
SELECT *
FROM dept01;

--하나의 테이블에서 조회한 내용을 2개 이상의 테이블에 삽입 가능
--전제조건: 조회한 내용의 열이름과 삽입하고자 하는 테이블의 열이름이 일치해야 함
INSERT ALL
INSERT INTO 테이블이름(컬럼 이름 나열)
INSERT INTO 테이블이름(컬럼 이름 나열)
...
SELECT 구문;

--*2. 데이터 수정
UPDATE 테이블이름
SET 수정할 열 이름 = 수정할 내용
[WHERE 조건];
--where 절 생략 가능
--where 절 생략 시 테이블의 모든 데이터가 수정됨

--삽입과 다르게 수정과 삭제는 문법적으로 이상이 없는데도 1개도 수정되거나 삭제되지 않을 수 있음
--삽입은 데이터에 변화가 생기지 않는다면 실패
--수정이나 삭제는 where절이 있어서 조건에 맞는 데이터가 한 개도 없으면 수정이나 삭제는 불이행

--SELECT / SELECT 이외
--: 데이터 return 유무
--select이외 문은 영향받은 행의 개수 RETURN
--INSERT 는 0 안됨. 1이어야 함
--수정이나 삭제는 where존재, where에 맞지 않으면 수정이나 삭제 안 함
--------0은 조건에 맞는 데이터가 없다는 뜻
--INSERT 는 1이상이 와야 성공
--update나 delete는 0이 아니면 성공

--dept01테이블에서 deptno가 88이상인 데이터만 deptno값 1 감소
UPDATE dept01
SET deptno = deptno - 1
WHERE deptno >= 88;

--table 확인
SELECT *
FROM dept01;

--SET 절에 여러 개의 컬럼 값 수정 가능
--콤마(,)로 구분해서 여러 개 기재
--dept01 테이블에서 deptno가 86인 데이터의 dname은 SI로 LOC는 홍대로 변경
UPDATE dept01
SET dname = 'SI', LOC = '홍대'
WHERE deptno = 86;
--회원번호 수정 구조

--table 확인
SELECT *
FROM dept01;


--*3. 데이터 삭제
DELETE FROM 테이블이름
[WHERE 조건];
--데이터베이스 종류에 따라 FROM 생략 가능
--조건이 없으면 테이블의 모든 데이터를 삭제함
--조건에 맞는 데이터가 있는데도 삭제가 안되는 경우 다른 테이블에서 이 데이터를 참조해서임

--dept01 테이블에서 deptno가 40이상인 데이터만 삭제
DELETE FROM dept01
WHERE deptno >= 40;

--table 확인
SELECT *
FROM dept01;

--**TABLE MERGE 
--2개의 테이블의 데이터를 비교해서 없는 데이터는 추가하고 존재하는 데이터는 갱신하는 작업
--코드 관리 사이트 등을 만들 때 기존 데이터를 업데이트 하는 용도로 사용
--구조 매우 복잡(다행히 사용 빈도는 낮음)
MERGE INTO 기본테이블이름
USING 업데이트 될 데이터를 가진 테이블이름
ON(어떤 값이 같으면 동일한 데이터를 취급할 것인지 조건 기술)

WHEN MATCHED THEN
UPDATE SET
기본테이블의 컬럼 이름 = 업데이트 될 데이터의 테이블이름.컬럼이름,
콤마를 이용하여 업데이트 될 컬럼을 동일한 방식으로 나열

WHEN NOT MATCHED THEN
INSERT VALUES(엽데이트 될 데이터를 가진 테이블 이름. 컬럼, ...);

--예시
--dept01 테이블에 dept테이블에 작성된 데이트 업데이트,
-----존재하지 않는 데이터 추가
MERGE INTO dept01
USING DEPT
ON(dept01.deptno = dept.DEPTNO)

WHEN MATCHED THEN
UPDATE SET
dept01.dname = dept.dname,
dept01.loc = dept.loc

WHEN NOT MATCHED THEN   --python의 try except 같은 것
INSERT VALUES(dept.deptno, dept.dname, dept.LOC);
--없는 값은 새로 추가

--table 확인
SELECT *
FROM dept01

----->덮어쓰기, 깃허브가 이런 구조를 가짐


--------------------------------------TCL(TRANSACTION CONTROL LANGUAGE)
--실무에서는 별도로 구분하지만 데이터베이스 이론에서는 DCL로 분류
--TCL은 제어어기는 하지만 개발자가 주로 사용하는 LANGUAGE이기 때문에 별도로 분류
--이와 비슷한 형태로 이론에서는 INSERT DELETE UPDATE SELECT 를 DML로 분류하지만
--실무에서는 INSERT, DELETE, UPDATE 는 DML로, SELECT는 DQL로 분류
--DML은 테이블에 변화를 가져오지만 SELECT는 변화를 가져오지 않는다.

--동시에 접근할 수 있는 방법과 동시에 접근 못하는 방법

--TRANSACTION: 한 번에 이뤄져야 하는 작업의 논리적인 단위
--1. 트랜잭션이 가져야 하는 성질(ACID)  <--NoSQL에는 없는 개념(느슨한 트랜잭션)
--1) Atomicity: ALL OR NOTHING (전부 아니면 전무) 원자성
--2) Consistency: 일관성. 트랜잭션과 일관성이 있어야
--3) ISOLATION: 독립성, 트랜잭션은 독립적으로 수행됨
--4) Durability: 영속성, 지속성. 한 번 완료된 트랜잭션은 계속되어야 한다

--2. 2명의 유저 중 한 명의 유저의 아이템을 다른 유저가 구매하려 한다.
-----데이터 베이스에는 4가지 동작이 발생
-----판매하려고 하는 유저의 금액이 늘어나야 한다
-----판매하려고 하는 유저의 아이템이 소멸되어야 한다
-----구매하려고 하는 유저의 금액이 감소해야 한다
-----구매하려고 하는 유저의 아이템이 추가되어야 한다.

-----4개의 작업 도중 중간에 장애가 발생하면 어떻게 할 것인가

--3. 트랜잭션 처리 방법
--1) manual COMMIT
--- 직접 commit과 ROLLBACK 수행
--2) auto COMMIT
--- 하나의 SQL 문장이 성공하면 자동으로 COMMIT
--- 자바나 dbeaver는 auto COMMIT

--4. 트랜잭션 작업 종류
---1) COMMIT : 작업이 완료돼서 변경된 데이터가 원본 데이터에 반영
---2) ROLLBACK : 변경된 데이터를 삭제, 원본 데이터에 변경된 내용이 반영되지 않음

---3) SAVEPOINT : 많은 양의 작업을 한번에 COMMIT 하거나 ROLLBACK 하면 
------------------시스템에 문제가 발생할 수 있기 때문에
------------------중간 중간 rollback할 수 있는 위치 

--5. 트랜잭션 생성
--- 새로운 트랜잭션이 없는 상태에서 INSERT, DELETE, UPDATE를 수행하면 자동 생성

--6. 트랜잭션이 완료돼서 소멸
---- 명시적으로 commit을 호출한 경우나 시스템이나 접속도구가 정상 종료된 경우
---- DDL(Create, Alter, Drop, Truncatem Rename)이나 
---- DCL(Grant, Revoke)을 정상적으로 수행한 경우는
---- 트랜잭션이 COMMIT 되고 소멸됩니다.
---- rollback을 호출하거나 시스템이나 접속도구 비정상 종료되면 rollback되고 트랜잭션 소멸

---- ROLLBACK TO SAVEPOINT 이름을 입력하면 savepoint이름을 생성한 자리로  rollback됨

--7. dbeaver을 이용해서 실습을 할 때는 auto commit을 해제(none)하고 수행해야 함
--toad 무료 버전을 사용하면 savepoit를 1개만 생성 가능

--8. NoSQL은 일반적으로 트랜잭션의 개념이 없는 auto commit의 형태
-----NoSQL 쪽은 협업 안해보면 취직 못함

--실습
--switch to auto-commit : None 뜨는 거 확인
--dept 테이블의 모든 내용을 복사해서 deptcopy 테이블 생성
CREATE TABLE DEPTCOPY
AS
SELECT *
FROM dept;
--table 확인
SELECT *
FROM deptcopy;

--deptcopy 테이블의 데이터 삭제
DELETE FROM deptcopy;
--table 확인
SELECT *
FROM deptcopy;

--트랜잭션 취소
ROLLBACK;
--table data 확인
SELECT *
FROM deptcopy;
--data 복원됨을 알 수 있음

--select는 데이터 변경이 없기 때문에  transaction과 아무런 영향이 없음
--deptno가 10번인 데이터를 deptcopy table에서 삭제
DELETE FROM DEPTCOPY
WHERE deptno = 10;
--deptcopy테이블에서 바로 삭제하는 게 아닌 카피본 생성 뒤 그 위에서 삭제
--원본 테이블은 lock걸어 놓음(카피본 작업 끝날 때까진 insert, delete, update 불가)
--파일이 멍때리고 있다는 건 어딘가 사용중이기 때문에 lock걸려있다는 것을 인지해야 함
--이때 select문 하면 보여주는 건 카피본
--롤백은 카피본 없던 일로 만들어버림
--원본은 지워진 적이 없다.

--transaction을 commit하고 완료
COMMIT;
--commit은 카피본을 원본으로 덮어 씌워버리고 카피본 버림

--작업취소 rollback 시도
ROLLBACK;
--commit 후 아무리 rollback을 해도 카피본은 버려졌기 때문에 복구 불가

--table 확인
SELECT *
FROM deptcopy; --commit으로 원본에 반영이 됐기 때문에 복원 불가

--SQL developer : manual commit
----lock때문에 select는 되는데(db접속은 된다는 말) insert delete update 불가
----commit 만 하면 해결 가능

--dBeaver : auto commit

--create/alter/drop/grant/revoke ==>성공시 commit 안써도 commit임
-->관리자의 수행이기 때문
--프로그래머는 특별한 경우가 아니면 create/alter/drop/grant/revoke과 select 같이 안 씀
--create/alter/drop/grant/revoke >> rollback 불가능. 문제 생기면 리부트 해야 함
--아 그래서 컴퓨터 앱 설치 후 재부팅이 이것 때문인가

--savepoint 거래를 할 때마다 commit 하는 건 너무 힘들다
--지난 번 f = open, f.close() 엄청나게 돌린 나를 보는 것 같군
--중간에 하나 잘못 돼서 rollback하면 이전 내용 다 날아가버리니까
--일정한 시간이나 일정한 거래 건수가 올 때마다 savepoint 만듦
--rollback to s1 : s1으로 돌아감
--savepoint는 중간에 서버 꺼져도 다 날아가지 않음


---savepoint 와 autocommit
--실습을 위해서 emp table의 모든 데이터를 가지고 있는 empcopy 테이블 생성
CREATE TABLE EMPCOPY
AS
SELECT *
FROM emp;

--테이블이 제대로 생성되고 데이터가 어떤 것들이 있는지 확인
SELECT *
FROM EMPCOPY;

--empno가 7369인 데이터를 empcopy 테이블에서 삭제
DELETE FROM EMPCOPY
WHERE empno = 7369;
--table 확인
SELECT *
FROM EMPCOPY;

--emp테이블의 데이터를 복사해서 empcopy1이라는 테이블 생성
CREATE TABLE empcopy1
AS
SELECT *
FROM emp;

--테이블이 제대로 생성되고 데이터가 어떤 것들이 있는지 확인
SELECT *
FROM empcopy1;

--이전에 데이터 삭제 구문(empcopy)을 잘못한 것 같아서 rollback 수행
ROLLBACK;

SELECT *
FROM empcopy;
--->삭제된 데이터 복원 불가
---empcopy1 CREATE 과정에서 이미 COMMIT 되어버렸기 때문

--CREATE/ALTER/DROP/GRANT/REVOKE/를 성공적으로 수행하면 자동 COMMIT

--INSERT/DELETE/UPDATE/를 수행하는 애플리케이션과 
--DDL 또는 DCL을 수행하는 애플리케이션을 하나로 만들지 않는 것을 권장

--데이터를 조작하는 애플리케이션에서 COMMIT이나 ROLLBACK만을 사용하게 되면
--거래 별로 COMMIT을 너무 자주 수행해서 데이터베이스 성능을 떨어뜨리게 되고
--마지막에 COMMIT 한 번만을 하는 형태로 만들면 거래가 잘못된 경우 ROLLBACK 해야 하는 거래가 너무 많아짐
--MMORPG 서버나 금융 거래 서버는 1초에도 수십번 거래가 이루어짐
--이 경우 잘못돼서 rolback하게 되면 너무 많은 거래 취소됨
--그래서 일정한 시간 또는 거래의 개수마다 rollback할 수 있는 SAVEPOINT 지점 생성

--중간에 SAVEPOINT 이름; 을 삽입하면 SAVEPOINT 생성됨
--savepoint로 ROLLBACK 할 때는 ROLLBACK TO 이름; 으로 함

--empcopy 테이블에서 empno가 7499 데이터 삭제
DELETE FROM EMPCOPY
WHERE empno = 7499;

SELECT *
FROM empcopy;

--SAVEPOINT 생성
SAVEPOINT s1;

--empcopy 테이블에서 empno가 7521인 데이터의 ename을 태연으로 수정
UPDATE EMPCOPY
SET ename = '태연'
WHERE empno = 7521;

--새로운 SAVEPOINT 생성
SAVEPOINT s2;

--empcopy테이블에서 empno가 7788인 데이터 삭제
DELETE FROM EMPCOPY
WHERE empno = 7788;
--empcopy테이블 현재 상태 확인
SELECT *
FROM empcopy;
--현재 상태 데이터 11행 7521데이터 ename = 태연 설정

ROLLBACK TO s2;
--data 복원(7788)
SELECT *
FROM empcopy;

ROLLBACK TO s1;
--data복원(s2도 소멸, s2로도 못 돌아감)
SELECT *
FROM empcopy; --7521 ename 태연 없음, s2 못돌아감

ROLLBACK TO s2; --불가능
--SQL Error [1086] [72000]: ORA-01086: savepoint 'S2' never established in this session or is invalid
--이 세션에는 만들어 지지 않았다, 롤백 불가능

--개발자는 SELECT -> INSERT, DELETE, UPDATE -> COMMIT, ROLLBACK ->CREATE, ALTER, DROP
--운영자/관리자 : CREATE, ALTER, DROP -> GRANT, REVOKE -> COMMIT, ROLLBACK -> INSERT, DELETE, UPDATE, SELECT
--분석가 : SELECT

--sqlite는 서버구축에는 거의 안 씀
--devise(browser, smartphone --device 안 sqlite에 임시 데이터 저장)
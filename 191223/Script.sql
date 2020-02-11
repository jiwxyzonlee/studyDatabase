
-- 특정 컬럼들만 조회
SELECT 컬럼이름나열
FROM 테이블 이름;


--emp 테이블에서 empno와 ename을 조회


--컬럼에 별명 부여
SELECT 컬럼이름 AS 별명의 형식 - 별명에 공백이나 영문 대문자가 있으면 " "안에 기재
FROM 테이블 이름;
-- 위와 동일한 문장을 empno에는 사원번호 ename에서 사원이름이라는 별명 부여


-- ||이용해서 행 값 수정하기
SELECT empno, ename
FROM emp;

SELECT empno AS 사원번호, ename AS 사원이름   --as없어도 값 나옴
FROM emp;

SELECT empno ||' is '||ename AS 사원
FROM emp;


-- between a and b
SELECT ename, hiredate
FROM emp
WHERE hiredate BETWEEN '1982/01/01' AND '1982/12/31';

SELECT ename, hiredate
FROM emp
WHERE hiredate NOT BETWEEN '1982/01/01' AND '1982/12/31';

SELECT ename,job,sal,deptno
FROM emp
WHERE sal BETWEEN 1000 AND 3000;


--IN (목록 나열) 목록에 포함된 데이터만 조회
-- 보통은 or로 대체 가능하지만 subquery에서는 or로 대체가 안 됨

--emp 테이블에서 jpb이 CLERK 또는 SALESMAN인 데이터의 모든 컬럼을 조회
SELECT *
FROM emp 
WHERE job IN ('CLERK','SALESMAN');  --vlaue값에서 대소문자 다르면 구별 안됨

SELECT *
FROM EMP 
WHERE job = 'CLERK' OR job = 'SALESMAN';

SELECT *
FROM emp 
WHERE job NOT IN ('CLERK','SALESMAN');

SELECT *
FROM EMP 
WHERE job != 'CLERK' and job != 'SALESMAN'

--like
--패턴과 일치하는 데이터를 조회할 때 사용
--2개의 wild card 문자를 이용
-- %: 글자 수와 상관없이 매칭
-- _:한 글자와만 매칭

--%A%: A가 포함된
--%A: A로 끝나는
--A% : A로 시작하는
--_A: A로 끝나는 두 글자

--wild card 문자 검색할 때
--_(언더바)를 포함한 글자 검색
--like '%\_%' escape '\': \(역슬래시) 다음에 나오는 글자(_)는 있는 그대로 해석해라

SELECT ename, hiredate
FROM EMP 
WHERE hiredate LIKE '82%';  --82년으로 시작되는 데이터 뽑기

SELECT ename, hiredate
FROM EMP 
WHERE hiredate LIKE '___01___' --1월만 포함된 데이터 뽑기

--hiredate가 12월인 데이터의 ename과 hiredate를 조회
SELECT ename, hiredate
FROM EMP
WHERE hiredate LIKE '___12___'  --12월만 포함한 데이터 뽑기


--NULL 조회(IS NULL/IS NOT NULL)
--IS NULL 입력된 데이터가 'null'인 데이터를 조회

--emp테이블에서 comm값이 null인 데이터의 ename과 comm 조회
SELECT ename, COMM
FROM EMP
WHERE comm IS NULL;

--null 아닌 데이터 조회
SELECT ename, COMM
FROM EMP 
WHERE comm IS NOT NULL;

--and 와 or 사용시 주의점
--and는 앞 조건이 false이면 뒤의 조건을 확인하지 않는다
--or 앞쪽의 조건이 true이면 뒤의 조건을 확인하지 않습니다.
--and 와or 를 사용할 때는 조건을 확인해서 and의 앞쪽에 false일 가능성이 높은 가능성을 배치하고,
--or의 경우에는 true일 가능성이 높은조건을 배치
--and와 ord와 같이 사용될 때는 and의  순위가 높다
--a OR b AND c(b이고 c인 데이터)
--or의 우선순위를 높이려면 괄호를 해야 한다.

--__order BY[asc|dsc}
--SELECT 구분의 결과를 정렬

--두 개이상의 데이터를 조회하는 경우 해주는 것이 좋다
--구문의 가장 마지막 절이고 마지막으로 수행

--asc오름 차순
--DESC 내림차순
--컬럼이름 대신 SELECT 별명 가능
--데이터 분석은 인덱스가 1부터 시작

--컬럼 이름을 2개 이상 사용하면 앞의 데이터 값을 동일하게 적용
--컬럼 이름대신 연산식가능

--EMP 테이블 모든 테이블 조회
--HIREDATE 의 오름 차순 정렬
---DEPTINO의 내림차순 정렬 동일한 값이면 empno의 오름차순으로 결정


SELECT *
FROM EMP 
ORDER BY hiredate ASC;

SELECT 컬럼이름  여기도 AS 로 별명쓰는 것 가능
FROM EMP 
ORDER BY hiredate (별명쓰는 거 가능) ASC;


SELECT empno, ename, job, mgr,hiredate AS 입사일, sal, 

--deptno먼저 내림차순 (deptno의 내림차순 정렬하고 동일한 값이면 empno의 오름차순으로 정렬)
SELECT*
FROM EMP 
ORDER BY deptno DESC, empno; 


SELECT  --5
FROM    --1
WHERE --2
GROUP BY  --3
HAVING  --4
ORDER BY  --6

--==>select와 from은 필수

--5.연습문제
--emp 작성 테이블에서 sal이 3000이상인 사원의 empno, ename, job, sal을 조회하는 select문장 작성
SELECT empno, ename, job, sal
FROM EMP
WHERE sal >= 3000;

--emp 테이블에서 empno가 7788인 사원의 ename과 deptno를 조회하는 SELECT 문장 작성
SELECT empno, ename, deptno
FROM EMP 
WHERE empno = 7788;

--emp 테이블에서 hiredate가 1981년 2월 20일과 1981년 5월 1일 사이에 입사한 사원의 ename, job, hiredate를 조회하는 select문장 작성
--단 hiredate 순으로
SELECT ename, job, hiredate
FROM EMP 
WHERE hiredate BETWEEN '1981/02/20' and '1981/05/01'
ORDER BY hiredate;

SELECT ename, job, hiredate
FROM EMP 
WHERE hiredate >= '1981/02/20' AND hiredate <= '1981/05/01'
ORDER BY hiredate;

--위 식보다 아래 식이 더 낫다
--앞의 조건은 참이 5개이고 뒤의 조건은 참이 13개
--거짓일 가능성이 높은 조건을 앞에 작성하는 것이 데이터가 많을 때는 시간을 절약
SELECT ename, job, hiredate
FROM EMP 
WHERE hiredate <= '1981/05/01' AND hiredate >= '1981/02/20'
ORDER BY hiredate;

--emp테이블에서 deptno가 10, 20인 사원의 모든 정보를 조회하는 select문(ename순으로 조회)
--모든 between은 and로 바꿀 수 있지만 IN은 그러하지 않음
SELECT *
FROM EMP 
WHERE deptno != 30
ORDER BY ename;

SELECT *
FROM EMP 
WHERE deptno BETWEEN 10 AND 20
ORDER BY ename;

SELECT *
FROM EMP
WHERE deptno = 10 OR deptno = 20
ORDER BY ename;

SELECT *
FROM EMP 
WHERE deptno IN (10,20)
ORDER BY ename;

--emp테이블에서 sal이 1500이상이고 deptno가 10, 30인 사원의 ename과 sal을 조회하는 select문
--heading을 employee와 monthly salary로 조회
SELECT ename AS employee, sal AS "Monthly Salary"
FROM EMP
WHERE sal>=1500 AND deptno IN (10,30);

SELECT ename AS employee, sal AS "Monthly Salary"   --이거 조심
FROM EMP
WHERE sal>=1500 AND deptno = 10 OR sal >= 1500 AND deptno = 30;   

SELECT ename AS employee, sal AS "Monthly Salary"
FROM EMP
WHERE sal>=1500 AND (deptno = 10 OR deptno = 30);

SELECT ename AS employee, sal AS "Monthly Salary"
FROM EMP
WHERE sal>=1500 AND deptno != 20;

--emp 테이블에서 hiredate가 1982년 사원의 모든 정보 조회하는 select문
SELECT *
FROM emp
WHERE hiredate like '82______';

SELECT *
FROM emp
WHERE hiredate like '%82%';

SELECT *
FROM emp
WHERE hiredate like '82%';

SELECT *
FROM EMP
WHERE hiredate BETWEEN '1982/01/01' AND '1982/12/31';

SELECT *
FROM EMP
WHERE hiredate >= '1982/01/01' AND hiredate <= '1982/12/31';

--emp테이블에서 mgr인 null인 사원의 ename과 job칼럼 조회
SELECT ename, job
FROM EMP 
WHERE mgr IS NULL ;

--EMP 테이블에서 COMM이 NULL이 아닌 사원의 모든 정보를 조회하는 SELECT 문을 작성
SELECT *
FROM EMP 
WHERE comm IS not NULL ;

--EMP 테이블에서 comm이 sal보다 10% 이상 많은 사원에 대하여 ename, sal, comm를 조회하는 SELECT 문을 작성
SELECT ename, sal, comm
FROM EMP 
WHERE comm >= sal*1.1 ;

--EMP 테이블에서 job이 CLERK이거나 ANALYST이고 sal이 1000, 3000, 5000이 아닌 사원의 모든 정보를 조회하는 SELECT 문을 작성
SELECT *
FROM EMP 
WHERE job IN ('CLERK', 'ANALYST') AND sal NOT IN (1000, 3000, 5000) ;

--EMP 테이블에서 ename에 A 와 E를 모두 포함하고 있는 사원의 ename 과 sal을 조회
SELECT ename, sal
FROM EMP 
WHERE ename LIKE '%A%' AND ename LIKE '%E%' ;

--EMP 테이블에서 (ename에 L이 두 자 이상이 포함되어 있고 deptno가 30)이거나 mgr이 7566인 사원의 모든 정보를 조회하는 SELECT 문을 작성
SELECT *
FROM EMP 
WHERE ename LIKE '%L%L%' AND deptno = 30 OR mgr = 7566 ;


SELECT SYSDATE
FROM dual;


SELECT *
FROM dual;

SELECT ename, trunc(sysdate-hiredate, -2) as 근무일수
FROM emp;

SELECT ename, sal
FROM EMP 
WHERE lower(job) = 'manager';

SELECT ename, sal
FROM EMP 
WHERE upper(job) = 'MANAGER';
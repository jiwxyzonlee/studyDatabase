--substr data를 어디서부터 어디까지 잘라낼 거냐
--프로그래밍 언어에 따라 인덱스인지 개수인지 다르므로 돌려보고 판단

--2번째부터 4글자 가져오기
SELECT substr('안녕하세요', 2, 4)
FROM dual;


--4번째 바이트에서 3바이트 가져오기
SELECT substrb('안녕하세요',4, 3 )
FROM dual;  --3바이트씩 이므로 2에서 출발 불가(1,4,7 가능. 한 글자당 3바이트 이므로 '녕'이 나옴)


--4번째 바이트에서 5바이트 가져오기
SELECT substrb('Hello World', 4, 5)
FROM dual;   --lo Wo :4번째부터 다섯글자

--substr: 문자열에서 원하는 위치부터 원하는 글자 수만큼 추출해주는 함수

--instr: 문자열에서 특정 문자열을 찾아주는 함수
--시작위치는 생략하면 1
--몇번째를 생략해도 1
--instr(문자열, 검색할 문자열, 시작위치, 몇번째)
SELECT instr('Hello Oracle', 'Hello')
FROM dual;   --1 나옴

SELECT instr('Hello Oracle', 'Hi')
FROM dual;   --0
--다른 프로그래밍 언어에서 -1이 최대가 되는 이유
  --끝까지 다 찾아 봤는데 없더라
--오라클은 1부터 시작해서 없으면 0이 나옴(프로그래밍 언어가 아님)

--퀵소트


--TRIM 굉장히 중요 (LTRIM, RTRIM) 좌우 공백 제거
--문자열 검색 알고리즘에서는 좌우 공백을 제거하고 조회
--파이썬 strip같은 거네
--ID 쓰는 것도 마찬가지, 구글 검색결과
--엔터 로그인은 종종 공백 들어가 때가 있음
--ID 쓸 때 공백 못쓰게 하는 이유

--도메인 지식
---정보를 몇개로 분류할 것인가
--데이터 가공

--좌우 공백 제거
SELECT trim('       Hi')
FROM dual;  --Hi

--프로그램이나 데이터베이스에 문자열을 비교할 때는 좌우공백을 제거하고 비교하는 경우가 많습니다.
--영문인 경우는 대소문자 구분 여부를 설정해야
--비밀번호를 제외하고는 대소문자 구분 안 함
--영문 텍스트 마이닝할 때(텍스트 분석) 가장 많이 하는 일 중 하나가 소문자 변환
--예외 시티은행 아이디는 전부 대문자


--concat
--2개의 문자열을 합쳐서 하나의 문자열로 만들어주는 함수
--함수보다는 연산자 더 많이 활용

SELECT concat(ename, job)
FROM emp;

SELECT ename ||' '|| job
FROM emp;

--convert
--문자열의 chr set 변환(인코딩)
--convert(data, 변경할 인코딩, 원래 인코딩)
--많이 사용되는 인코딩 방식은 US7ASCII, UTF8, WE8ISO8859 (UTF8 빼곤 한글 안됨)
--ASCII(아스키) : 영문 및 특수문자를 1바이트로 표현하는 방식
--UTF 8 : 전세계 모드 문자를 표현하기 위한 코드(한 글자가 3바이트)
--ISO8859-1: 서유럽 문자로 한글로 표현되지 않음 (ISO Latin-1 이라고도 함)

--convert(): 한글은 UTF8밖에 표현이 안되기 때문에 거의 사용되지 않음, 유럽쪽에서는 많이 사용

--보건복지부는 spss 씀
--인코딩 개념 알아두기

--날짜 관련 함수
--(시계열 분석에서 써먹음)
SYSDATE
--현재 날짜 및 시간 리턴
--대부분 관계형 데이터베이스는 하루를 숫자 1로 간주해서 더하기 빼기 가능
NEXT_DAY
--특정 날짜에서 입력한 요일이 언제인지 리턴해줌
ADD_MONTHS
--특정 날짜에서 월을 더해서 리턴
--round, trunc를 이용해서 반올림이나 버림 가능

--google analytics
--R

--오늘 날짜와 산술 연산
SELECT SYSDATE
FROM dual;

--날짜 사이 연산
--며칠 근무했는지 확인
SELECT ename, round(SYSDATE-hiredate)
FROM emp;

SELECT ename, trunc(SYSDATE-hiredate, -1)
FROM emp;

SELECT round(sysdate - to_date('2019/11/26', 'yyyy/mm/dd'))
FROM dual;

--R의 시계열 분석, 파이썬의 시계열 분석

--형 변환 함수
--숫자 <-> 문자
--문자 <-> 날짜

--문자로 변환
TO_CHAR

--날짜로 변환
TO_DATE

--숫자로 변환
TO_NUMBER

--날짜 사이의 연산은 숫자로 변환해서 연산해야
-- 날짜 - 날짜는 숫자로 결과 RETURN

--문자로 변환하는 경우는 대부분 출력을 위함
--숫자나 날짜로 변환하는 경우는 연산을 하기 위함

--숫자 서식
--1. 숫자 서식 
--0 무조건 표시하고 없으면 0
--9 있으면 표시하고 없으면 생략
--L 통화 기호
--. 소수점
--, 천 단위 구분기호 ****중요***함수 적용 옵션 적용하면 숫자 없으면 문자되어버림
--날짜나 숫자 저장할 때 자릿수 맞춰주는 게 중요(그래서 0이나 9가 서술되어있는 것)
('7', 00)  -->무조건 7을 두자리로 주겠다
('17', 00)
--군대 07(공칠)시

--날짜 서식
yyyy--연도
yy --연도
mm --월
DAY -- 요일
dd --일
hh -- 12시간제
hh24 --24시간제
mi -- 분
ss -- 초
am OR pm --오전 오후

--null 대체 함수
NVL(DATA, 데이터가 null일 때 사용할 값)
NVL2(DATA, 데이터가 null이 아닐 때 사용할 값, null일 때 사용할 값)

--emp 테이블에서 ename과 comm의 값에 100을 더한 값 조회
SELECT ename, comm+100
FROM EMP;
--null과 연산해도 NULL
--프로그래밍 언어에서는 예외가 발생
SELECT ename, nvl(comm+100, 0)
FROM emp;
SELECT ename, nvl(comm, 0)+100
FROM emp;
SELECT ename, nvl2(comm,comm+100, 0)
FROM emp;
SELECT ename, nvl2(comm,comm, 0)+100
FROM emp;

--결측치 날리기/대체하기/ 등
--설문조사가 제일 어려움 샤이트럼프

--그룹화
--1. 그룹함수
--다중 행 함수라고도 하는데 1개 이상의 행을 가지고 연산을 한 후 하나의 결과를 리턴
--sum, avg, max, min, count, stddev(표준편차), variance(분산)
--함수의 매개변수로 컬럼 이름이나 연산식을 대입하는데 null인 데이터는 제외하고 연산함
--데이터의 개수를 셀 때 count를 사용, 컬럼이름을 대입하면 null인 데이터는 제외
--전체 데이터의 개수를 알고 싶을 때는 컬럼 이름 대신 *을 대입함
--모든 컬럼 중 null이 없다면 개수를 세는 데 포함 됨

--avg를 이용하여 평균을 구할 땐 대부분 null인 데이터를 치환하여 계산함
--comm 컬럼의 경우 14개 데이터 중 4개만 입력되어 있음. 이 상태에서 평균 구하면 4개 데이터의 평균만 나옴


--그룹함수는 GROUP BY 절의 내용과만이 같이 출력 가능
--그룹화 하지 않은 컬럼과는 같이 출력할 수 없음

--평균과 최대, 최소 그리고 사분위 수는 같이 출력하는 게 좋다
--이 값들을 보고 데이터의 대략적인 분포를 알고 이상치 여부를 판단하거나 대표값을 선정
--noise 나 outlier  (boxplot)
--기술통계량 보여주기

--emp테이블에서 sal의 평균
SELECT avg(sal) AS 급여평균
FROM emp;

--emp테이블에서 comm의 평균:comm에는 null이 포함됨
SELECT COMM
FROM emp;

--emp테이블에서 null값(상여금을 못받는 직원의 값)을 0으로 치환해서 평균
SELECT avg(nvl(comm,0)) AS 상여금평균
FROM emp;
--emp테이블에서 null값을 100으로 치환해서 평균
SELECT avg(nvl(comm, 100)) AS 상여금평균
FROM emp;

--emp테이블에서 상여금을 받는 사원의 수
SELECT count(comm)
FROM emp;

--emp테이블에서 전체 사원의 수
SELECT count(*)
FROM emp;

--급여가 가장 많은 사원의 ename과 sal값
--ename은 여러개의 값이고 max(sal)은 하나의 값이라 같이 출력할 수 없음
--이경우 서브쿼리나 조인을 이용해서 해결해야

SELECT ename, sal, job
FROM emp
ORDER BY sal DESC;


--2. GROUP BY
--그룹화에 사용하는 절
--컬럼 이름이나 연산식을 이용해서 그룹화를 하는 것
--GROUP BY 절에 기재한 내용은 그룹함수와 함께 출력 가능

--emp테이블에서 job별로 평균 sal의 값을 조회
SELECT job, avg(sal)
FROM EMP
GROUP BY JOB;
--R과 비슷

SELECT deptno, avg(sal)
FROM EMP
GROUP BY deptno;

SELECT deptno, count(job)
FROM EMP
GROUP BY deptno;

--emp테이블에서 입사년도 별 인원수를 조회
--입사연도는 hiredate 컬럼 ---여기서 연도만 추출하려면?
SELECT hiredate, count(*)
FROM EMP
GROUP BY hiredate;

--like는 안됨(where과 having만 가능)
--함수는 from빼고 아무 곳에서나 사용 가능
SELECT substr(hiredate, 1, 2), count(*)
FROM EMP
GROUP BY substr(hiredate, 1, 2)
ORDER BY substr(hiredate, 1, 2);
--ORDER BY count(*) desc;

SELECT substr(hiredate, 1, 2) AS 입사연도, count(*) AS 인원수
FROM EMP
GROUP BY substr(hiredate, 1, 2)
--ORDER BY substr(hiredate, 1, 2);
ORDER BY 인원수 desc;

SELECT substr(hiredate, 1, 2) AS 입사연도, count(*) AS 인원수
FROM EMP
GROUP BY substr(hiredate, 1, 2)  --그룹바이에는 별명 못 오나봐
ORDER BY 입사연도;
--ORDER BY 인원수 desc;

--요일 별로 하는 게 제일 어려울 듯
--현재 hiredate는 요일이 없음
SELECT TO_CHAR(hiredate, 'day') AS 요일, count(*) AS 인원수
FROM emp
GROUP BY TO_CHAR(hiredate, 'day');


--GROUP BY 절에 여러개의 컬럼이나 연산식 작성 가능
--첫번째로 그룹화하고 그 안에서 다시 그룹화
--예) 월별, 요일별 작성 가능
SELECT TO_CHAR(hiredate, 'mm') AS 월, TO_CHAR(hiredate, 'day') AS 요일, count(*) AS 인원수
FROM EMP
GROUP BY TO_CHAR(hiredate, 'mm'), TO_CHAR(hiredate, 'day');

--having은 그룹화 한 이후에 조건을 적용할 때 사용
--where절은 GROUP by보다 먼저 실행되기 때문에 그룹함수를 사용할 수 없다
--그룹함수를 이용한 조건은 having에서 작성해야 한다

SELECT --5
FROM --1
WHERE --2      그룹바이보다 먼저 실행되기 때문에 그룹바이 있을 경우 조건은 해빙으로
GROUP BY --3
HAVING --4
ORDER BY; --6

--5명 이상 입사한 해를 조회
SELECT substr(hiredate, 1, 2), count(*)
FROM EMP
GROUP BY substr(hiredate, 1, 2)
HAVING count(*) >= 5;

--오류버전
SELECT substr(hiredate, 1, 2), count(*)
FROM EMP
--WHERE count(*) >= 5;   <<< 이 경우 where가 두 번째로 실행되므로 오류 남
GROUP BY substr(hiredate, 1, 2)
HAVING count(*) >= 5;

--그룹함수를 사용하지 않는 조건을 having에 사용하는 것은 비효율적(특히 select에서)
--sql은 절 단위로 수행해서 하나의 결과를 만들어 냄

--비효율적인 예
SELECT avg(sal)
FROM EMP
GROUP BY DEPTNO
HAVING deptno = 10;

--효율적인 예
SELECT avg(sal)
FROM EMP
WHERE deptno = 10
GROUP BY deptno;

--**filtering은 where에서 미리 걸러내는 게 좋다**

--분석과정에서의 filtering 확인
--자료형(분류하려면 범주형이어야), 이상치 확인(기술통계량), 표준화(숫자데이터는 맞춰줘야) = 불필요 제거

--데이터에서 차이가 나면 결국 시간 차이로 이어짐(거래량)
--코레일 잘 만듦



--JOIN
--2개의 테이블을 조합하는 것
--구조가 다른 테이블들끼리 합쳐서 하나의 테이블을 만드는 것
--동일한 구조를 가진 테이블끼리 세로로 합치는 것을 MERGE라고 함

--1. cartesian product
--   = CROSS JOIN 
-- 2개의 테이블의 모든 데이터들을 조합하는 것
--FROM 절에 테이블 이름 2개 기재하면 디폴트로 됨

--행의 개수:  양쪽 테이블의 행의 개수의 곱,
--열의 개수: 양쪽 테이블의 열의 개수의 합

--관계형 데이터베이스에서 테이블을 너무 많이 분할했을 때 발생하는 문제점

--emp테이블에는 8개 열과 14개의 행이 존재
--dept 테이블에는 3개의 열과 4개의 행이 존재
--emp테이블과 dept테이블  cartesian product => 11개의 열과 56개의 행 생성
SELECT *
FROM emp, dept;

--2. equi join
-- 2개의 테이블의 공통된 의미를 갖는 열의 값이 같을 때만 결합
-- (deptno 같은 것 확인)
-- 실제 동작은 공통된 의미가 아니라 자료형만 같으면 수행 가능
--where 절에 양쪽 테이블의 공통된 의미를 갖는 데이터가 같을 때 결합하도록 기재
-- 양쪽 테이블에 있는 열의 이름이 같으면 앞에 테이블 이름. 을 추가해서 구분해줘야 함
SELECT *
FROM EMP, DEPT
WHERE emp.deptno = dept.deptno;
--WHERE deptno = deptno; <<이렇게 하면 ambiguous 하다고 에러 뜸
--테이블 이름 생략하면 열의 이름이 애매하다고 에러 발생
--새로운 조건을 추가해서 필터링을 할 때는 위치는 상관 없지만 일반적으로 join 조건 뒤에 and를 추가하고 작성
SELECT ENAME, DNAME
FROM EMP, DEPT
WHERE emp.deptno = dept.deptno
AND ENAME = 'MILLER';
--emp테이블에서 sal이 3000이상인 사원의 ename과 deptno 그리고 dept 테이블의 loc 조회
SELECT ENAME, emp.deptno, LOC  --loc은 dept 테이블에 존재. 둘다 갖고 있는 열은 이름 써줘야. 안쓰면 모호
FROM EMP, DEPT
WHERE emp.deptno = dept.DEPTNO  --emp와 dept가 공통으로 갖는 열
AND sal >= 3000;

SELECT ENAME, emp.deptno, LOC  
FROM EMP, DEPT
WHERE emp.deptno = dept.DEPTNO AND sal >= 3000; --이렇게 해도 됨

SELECT ENAME, emp.deptno, LOC  
FROM EMP, DEPT
WHERE sal >= 3000 AND emp.deptno = dept.DEPTNO; --이렇게 해도 됨, 이게 더 나은듯?

--3. 테이블에 별명 부여
--테이블 이름이 너무 길거나 알아보기 어려운 경우 또는 SELF JOIN 의 경우 테이블 이름에 별명 부여
--테이블 이름 뒤에 공백을 추가하고 별명 입력
--SELECT 에서 컬럼의 이름에 별명을 붙인 경우 ORDER BY 절에서 별명 사용해도 되고 원래 이름 사용해도 됨
--FROM절에서 테이블 이름에 별명을 붙인 경우에는 반드시 테이블 이름 대신 별명을 사용해야 함

--파이썬에서도 import 패키지명 AS 별명 으로 했던 방법
--이 방법에서 패키지명 그대로는 못씀, 꼭 별명만 써야 함

SELECT ename, e.deptno, LOC   --<select는 5번이기 때문에 같이 바꿔주어야 함
FROM EMP e, DEPT d             --<이거임
WHERE e.DEPTNO = d.DEPTNO AND sal >= 3000;

--4. non equi join
-- join 할 때 ' = '(등호) 대신에 다른 연산자로 join 하는 것
-- salgrade table은 grade와 losal, hisal 열로 구성
--grade는 급여 등급이고 losal은 등급 중 최저 급여, hisal은 최고 급여
--emp테이블에서 가져온 sal과 losal이나 hisal과 비교하게 되면 '=(등호)'로 안 될 수도 있음

--emp테이블의 ename과 sal 그리고 salgrade 테이블의 sal에 해당하는 grade를 조회하고자 함
--교보문고 플래티넘, 골드, 실버 등 이런 거 정해줄 때
--신용등급도 이렇게 하나?
SELECT *
FROM SALGRADE;

SELECT ename, sal, grade
FROM emp, SALGRADE
WHERE emp.sal = salgrade.LOSAL;
-->이러면 안 나옴

SELECT ename, sal, grade
FROM emp, SALGRADE
WHERE emp.sal = salgrade.HISAL;
-->이러면 제대로 안 나옴

SELECT ename, sal, grade
FROM emp, SALGRADE
WHERE emp.sal >= salgrade.loSAL AND emp.sal <= salgrade.HISAL;
-->이러면 제대로 나옴
-->between 써도 괜춘
-->학점 줄 때도 이렇게 주겠죠

--**어렵**
--5. SELF JOIN 
--자신의 테이블과 JOIN
--하나의 테이블에 동일한 의미를 갖는 열이 두 개 이상 있는 경우에만
--FROM 절에 동일한 테이블의 이름을 2번 기재하므로 반드시 별명 부여해야

--emp테이블에서 empno는 사원 번호, mgr은 관리자 사원번호
--즉 둘 다 사원 번호
--사원 이름과 관리자 이름을 조회하려 하면 SELF JOIN 을 사용해야 함
--예) sns 친구 추천(ex 알 수도 있는 사람-추천 시스템, 좋아할 만한 책)
--감성 추천, 페이스북-좋아요, 구매한 상품 목록-추천(같은 테이블에 두 번 방문)
--(같은 의미를 갖는 데이터가 모여야 추천 시스템을 만들 수 있다.)
SELECT e1.ENAME 사원, e2.ENAME 관리자
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.empno;
--여기서 사원의 sal말하면 e1, 관리자의 sal 말하면 e2
SELECT e1.ENAME 사원, e2.ENAME 관리자--, e1.sal, e2.sal
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.empno;

--emp테이블에서 ename이 scott인 사원의 관리자 
SELECT e2.ENAME 관리자
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

--emp테이블에서 ename이 scott인 사원의 관리자의 관리자의 사원번호
SELECT e2.MGR supervisor
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

SELECT e2.ENAME "SCOTT 관리자", e2.MGR "SCOTT 관리자의 관리자"
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

SELECT e1. ENAME 직원, e2.ENAME 관리자, e2.EMPNO 관리자번호, e2.MGR 상급자번호
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

--6. OUTER JOIN 
--INNER JOIN은 보통 equi JOIN 을 의미함
--OUTER JOIN 은 어느 한 쪽에만 존재하는 데이터도 join에 참여시키는 것
--emp테이블에는 deptno가 10, 20, 30이 있고 dept테이블에는  deptno가 10, 20, 30, 40이 존재
--이 경우 equi join을 하게 되면 양쪽 모두 존재하는 10, 20, 30만 조회
--dept 테이블에만 존재하는 40까지도 참여시키고자 할 때 수행하는 join이 OUTER JOIN 
--OUTER JOIN 할 때는 포함시킬 테이블의 JOIN 조건 기술시 반대편에 '(+)' 추가
emp.deptno(+) = dept.DEPTNO
-->dept테이블에 있는 모든 데이터가 JOIN 참여 수행
--'(+)'를 양쪽에 붙이는 것은 안됨

--equi JOIN (공통된 10, 20, 30만 조회. 40제외)
SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE emp.deptno = dept.deptno;

--outer join(emp에는 40번이 없어서 e.name에 null)
SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE emp.deptno(+) = dept.deptno;

SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE emp.deptno = dept.deptno(+);  -->변화 없음(40 안 나옴

SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE dept.deptno(+) = emp.deptno;  -->변화 없음(40 안 나옴)

--7. ANSI JOIN
--미국 표준 협회에서 만든 JOIN 문법으로 대다수의 관계형 데이터베이스에서 적용이 되지만
--일부 관계형 데이터베이스에서는 안될 수도 있음
--1) Cartesian Product(Cross Join)
--: 두 개의 테이블의 모든 조합을 만드는 것
FROM 테이블 이름 CROSS JOIN 테이블 이름

--2) Equi Join(Inner Join, 조건을 on 절에 기재)
--join 조건과 where 구분하기 위해
FROM 테이블 이름1 INNER JOIN 테이블 이름2
ON 테이블 이름1.컬럼 이름 = 테이블 이름2.컬럼 이름

SELECT *
FROM emp INNER JOIN DEPT
on emp.deptno = dept.deptno;

--이 경우 양쪽 컬럼 이름이 같으면 on 대신 using 사용
FROM 테이블 이름1 INNER JOIN 테이블 이름2
USING(컬럼이름)

SELECT *
FROM emp INNER JOIN DEPT
using(deptno);

--컬럼이름 같으면 inner join 대신에 natural join이라고 입력하고 join 조건 생략 가능
FROM 테이블 이름 NATURAL JOIN 테이블 이름2

SELECT *
FROM emp NATURAL JOIN DEPT;

--셋 모두 같은 값


--3) OUTER JOIN
FROM 테이블이름1 [LEFT|RIGHT|FULL] OUTER JOIN 테이블이름2
ON 테이블이름1.컬럼이름 = 테이블이름2.컬럼이름
--full은 양쪽 다 참여
--full은 어느 한쪽 테이블에만 존재하는 데이터도 join에 참여

SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp RIGHT OUTER JOIN dept  --오른쪽이 다 참여
ON  emp.deptno = dept.deptno;

--8. SET 연산
--> 동일한 구조를 가진 2개의 테이블만 가능
--구조가 같다는 의미는 열의 개수가 같아야 하고 각 열의 자료형이 같아야
--첫번째 SELECT 구문에서 기술된 열과 두번째 SELECT 구문에서 기술된 열들은 
--좌측부터 1대1 대응하며 그 개수와 타입이 일치해야 함
--ORDER BY는 한번만 기술 가능하고 SELECT 구문의 마지막에 기술

--하나 이상의 테이블로부터 자료를 검색하는 또 다른 방법은 SET연산자를 이용
--SET연산자를 이용하여 여러 개의 SELECT문장을 연결하여 작성


--1 합집합(union, 중복제거) UNION all( 중복 제거 없음)
--2)교집합 INTERSECT
--3)차집합(minus)

SELECT 구문
set operator
SELECT 구문

--각 결과의 합(합집합) 
SELECT deptno
FROM EMP 
UNION all
SELECT DEPTNO
from DEPT;

SELECT deptno
FROM DEPT
UNION ALL
SELECT DEPTNO
FROM emp;
--:각 결과의 합(합집합:중복되는 값은 한번 출력) 
SELECT deptno
FROM DEPT
UNION
SELECT DEPTNO
FROM emp;


--양쪽에서 검색된 자료만 출력
SELECT deptno
FROM DEPT
INTERSECT
SELECT DEPTNO
FROM emp;

--첫번째 SELECT문장에서 두번째 SELECT문장에의 값을 뺀 것을 출력(40)
SELECT deptno
FROM DEPT
MINUS
SELECT DEPTNO
FROM emp;

--sub query
--SQL 문장 안에 포함된 SQL
--다른 SQL 구문 안에 SELECT 구문을 포함

--1. 작성 방법
--포함된 구문은 반드시 ()로 감싸서 우선순위를 높여 먼저 실행되도록 해야

--2. sub query의 실행
--메인 쿼리가 실행되기 전에 1번만 실행

--3. 종류
--1)단일 행 서브쿼리: 서브쿼리의 결과가 하나의 행인 경우
--  단일 행 연산자 사용 (=, !=, >, >=, <, <=)
--2)다중 행 서브커리: 서브쿼리의 결과가 두 개 이상의 행인 경우
--  단일 행 연산자를 단독으로 사용 불가능
--   (in, not in, all, any 와 같은 다중 행 연산자를 같이 사용)

--4. 단일행 서브쿼리
--1) emp테이블에서 ename이 SCOTT인 사원의 관리자 이름을 조회
SELECT e2.ENAME
FROM EMP e1, EMP e2
WHERE e1.ename = 'SCOTT' AND e1. mgr = e2.empno;
--이왕이면 join말고 sub query를 쓰세요
--join을 줄이는 쪽으로
--select 자리에 출력하는 열의 이름들이 하나의 테이블에서 추출이 가능하다면 sub query로 해결 가능
SELECT ename 
FROM EMP
WHERE EMPNO = (SELECT mgr
				FROM EMP
				WHERE ename = 'SCOTT');
--R로 비유하자면
--emp %>% filter(ename = 'SCOTT')%>%select(mgr)//%>% filter(empno)%>%select(ename)

--2)emp테이블과 dept테이블은 deptno를 같이 소유하고 있음
----dept테이블의 loc가 dallas사원의 emp테이블의 ename과 sal을 조회
SELECT ename, sal
FROM EMP
WHERE deptno = (SELECT deptno
				FROM dept
				WHERE loc = 'DALLAS');

--3)dept테이블의 DNAME이 SALES인 데이터의 ENAME과 JOB을 조회
--부서명이 SALES인 사원의 이름과 직무 조회
--ENAME과 job은 emp에 존재
--dept테이블과 emp테이블은 deptno를 공유
SELECT ENAME, JOB
FROM EMP
WHERE deptno =(SELECT DEPTNO
				FROM DEPT
				WHERE DNAME = 'SALES');

--5. 다중 행 서브쿼리
--emp테이블과 dept테이블은 deptno 같이 소유
--dept테이블의 loc 가 dallas나 chicago인 사원의 emp테이블의 ename과 sal 조회

--에러 나는 식
SELECT ename, SAL
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
				FROM DEPT
				WHERE LOC = 'DALLAS' OR LOC = 'CHICAGO');
-- 문법적으로 에러가 아닐 수도 있지만
--Dallas와 chicago에 근무하는 사원의 deptno는 20과 30
--두개의 데이터는 '='로 비교할 수 없다
--이 경우 '=' 대신 'in'을 사용해야 함
-- !=의 경우 NOT IN 사용

--옳은 식
SELECT ename, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO
				FROM DEPT
				WHERE LOC = 'DALLAS' OR LOC = 'CHICAGO');

--all 이나 any는 없어도 된다?
--2개 이상의 숫자가 결과로 리턴값이 2개 숫자보다 모두 큰 경우에 해당하는 데이터를 조회할 때
-- > (100, 200)의 형식은 안 됨
--크다, 작다는 하나의 값과만 비교 가능
--여러 개의 데이터를 크다 작다로 비교하려면 all이나 any라는 연산자 이용

-- > ALL(100, 200): 100과 200보다 모두 큰 경우 true 리턴
--이 때는 MAX 를 붙여도 된다(200과만 비교하면 되기 때문에)
-- > MAX(100, 200)  (가장 큰 200보다 클 때)

-- > ANY(100, 200): 100이나 200중 하나라도 크면 true
-- > MIN(100, 200)과 값은 같다(가장 작은 100보다 클 때)

--emp테이블에서 deptno가 10 또는 20인 부서의 평균 sal보다 sal이 더 큰 사원의 ename과 sal 조회
--먼저 deptno가 10 또는 20인 부서의 평균 sal 조회
SELECT avg(SAL)
FROM EMP
WHERE deptno = 10 OR deptno = 20
GROUP BY deptno;
--deptno = 10 일 때와 deptno = 20일 때 두 개 평균으로 나옴

--에러 나는 식
SELECT ename, sal
FROM EMP
WHERE sal > (SELECT avg(SAL)
				FROM EMP
				WHERE deptno = 10 OR deptno = 20
				GROUP BY deptno);
--이 문장은 서브쿼리의 결과가 두 개이기 때문에 에러가 남

--올바른 식(jones, scott, ford, king)
SELECT ename, sal
FROM EMP
WHERE sal > ALL(SELECT avg(SAL)
				FROM EMP
				WHERE deptno = 10 OR deptno = 20
				GROUP BY deptno);

--max는 함수 위치가 달리 붙는다(jones, scott, king, ford)
SELECT ename, sal
FROM EMP
WHERE sal > (SELECT max(avg(SAL))
				FROM EMP
				WHERE deptno = 10 OR deptno = 20
				GROUP BY deptno);

--관리자의 인원수 조회
SELECT count(MGR)
FROM EMP;

SELECT MGR
FROM EMP;

SELECT mgr, count(MGR)
FROM EMP
GROUP BY MGR;

SELECT mgr, count(*)
FROM EMP
GROUP BY MGR;

--중복된 관리자 빼기
SELECT count(DISTINCT MGR)
FROM EMP;








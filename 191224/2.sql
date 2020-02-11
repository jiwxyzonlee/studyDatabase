SELECT * 
FROM emp;

SELECT empno, ename, sal, job
FROM emp;

SELECT ename, sal, sal+300
FROM emp;

SELECT empno, ename, sal, comm, sal+comm/100
FROM emp;

SELECT ename, sal, comm, sal*12+NVL(comm,0)
FROM emp;

SELECT ename AS 이름, sal 급여
FROM emp;

SELECT ename || ' ' || job AS "employees"
FROM emp;

SELECT ename || ' ' || 'is a' || ' ' || job AS "employees Details"
FROM emp;

SELECT ename || ': 1 Year salary = ' || sal * 12 Monthly
FROM emp;

SELECT job 
FROM emp;

SELECT DISTINCT job 
FROM emp;

SELECT DISTINCT deptno,job
FROM emp;

SELECT empno, ename, job, sal
FROM emp
WHERE sal >= 3000;

SELECT empno, ename, job, sal, deptno
FROM emp
WHERE job = 'MANAGER';

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE hiredate >= '1982/01/01';

SELECT ename,job,sal,deptno
FROM emp
WHERE sal BETWEEN 1300 AND 1500;

SELECT empno, ename, job, sal, hiredate
FROM emp
WHERE empno IN (7902,7788,7566);

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE hiredate >= to_date('1982/01/01', 'yyyy/mm/dd') and
hiredate <= to_date('1982/12/31', 'yyyy/mm/dd');

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE hiredate LIKE '82%';

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE hiredate LIKE '___12%';

SELECT empno, ename, job, sal, comm, deptno
FROM emp
WHERE comm IS NULL;

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE sal >= 2800 AND job = 'MANAGER';

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE job = 'MANAGER' AND sal >= 2800;

SELECT empno, ename, job, sal, hiredate, deptno
FROM emp
WHERE sal >= 1100 OR job = 'MANAGER';

SELECT empno, ename, job, sal, deptno
FROM emp
WHERE job NOT IN ('MANAGER','CLERK','ANALYST');

SELECT empno, ename, job, sal
FROM emp
WHERE job = 'SALESMAN' OR job = 'PRESIDENT' AND sal > 1500;

SELECT empno, ename, job, sal
FROM emp
WHERE (job = 'SALESMAN' OR job = 'PRESIDENT') AND sal > 1500;

SELECT hiredate, empno, ename, job, sal, deptno
FROM emp
ORDER BY hiredate;

SELECT hiredate, empno, ename, job, sal, deptno
FROM emp
ORDER BY hiredate desc;

SELECT empno, ename, job, sal, sal*12 annsal
FROM emp
ORDER BY annsal;

SELECT empno, ename, job, sal, sal*12 annsal
FROM emp
ORDER BY sal*12;

SELECT empno, ename, job, sal, sal*12 annsal
FROM emp
ORDER BY 5;

SELECT deptno, sal, empno, ename, job
FROM emp
ORDER BY deptno, sal DESC;

SELECT deptno, job, sal, empno, ename, hiredate
FROM emp
ORDER BY deptno, job, sal DESC;

SELECT empno, ename, job, sal
FROM emp
WHERE sal >= 3000;

SELECT ename, deptno 
FROM emp
WHERE empno = 7788;

SELECT ename, job, hiredate
FROM emp
WHERE hiredate >= '1981/02/20' AND hiredate <= '1981/05/05'
ORDER BY hiredate;

SELECT *
FROM emp
WHERE deptno in(10,20)
ORDER BY ename;

SELECT *
FROM emp
WHERE hiredate >= '1982/01/01' AND hiredate <= '1982/12/31'
ORDER BY hiredate;

SELECT ename, job
FROM emp 
WHERE mgr IS NULL;

SELECT *
FROM emp
WHERE comm IS NOT NULL;

SELECT ename, sal, comm
FROM emp 
WHERE comm >= sal * 1.1;

SELECT * 
FROM emp 
WHERE job in('CLERK', 'ANALYST') AND sal NOT in(1000,3000,5000);

SELECT ename, sal
FROM emp 
WHERE ename LIKE '%A%' AND ename LIKE '%E%';

SELECT ename, mgr FROM emp;
SELECT *
FROM emp
WHERE ename LIKE '%L%L%' AND deptno = 30 OR mgr = 7566;









CREATE TABLE EMP01( 
EMPNO NUMBER(4), 
ENAME VARCHAR2(20), 
SAL NUMBER(7, 2));

CREATE TABLE DEPT01(
DEPTNO NUMBER(2),
DNAME VARCHAR2(14),
LOC VARCHAR2(13));

CREATE TABLE EMP02 
AS 
SELECT * FROM EMP;

CREATE TABLE EMP03 
AS 
SELECT EMPNO, ENAME FROM EMP;

CREATE TABLE EMP04 
AS 
SELECT EMPNO, ENAME, SAL FROM EMP;

CREATE TABLE EMP05
AS
SELECT * FROM EMP
WHERE DEPTNO=10;

CREATE TABLE EMP06
AS 
SELECT * FROM EMP WHERE 1=0;

CREATE TABLE DEPT02
AS 
SELECT * FROM DEPT WHERE 1=0;

ALTER TABLE EMP01
ADD(JOB VARCHAR2(9)); 

ALTER TABLE DEPT02
ADD(DMGR VARCHAR(4)); 

ALTER TABLE EMP01
MODIFY(JOB VARCHAR2(30)); 

ALTER TABLE DEPT02
MODIFY(DMGR NUMBER(30)); 

ALTER TABLE EMP01
DROP COLUMN JOB; 

ALTER TABLE DEPT02
DROP COLUMN DMGR; 

ALTER TABLE EMP02 
SET UNUSED(JOB);

ALTER TABLE EMP02 
DROP UNUSED COLUMNS;

DROP TABLE EMP01;

TRUNCATE TABLE EMP02;

RENAME EMP02 TO TEST;

Create table emp_demo
as select empno,ename,job,mgr,hiredate,deptno
   from emp;
  
create table emp_dept
as select empno, ename, job, dname, loc
   from emp, dept
   where emp.deptno=dept.deptno

create table emp_grade
as select empno, ename, job, sal, comm, grade
   from emp e, salgrade s
   where e.sal between s.losal and s.hisal
   order by grade DESC;
 
alter table emp_grade
modify (sal number(12,4));

drop table emp_dept;
drop table emp_grade;








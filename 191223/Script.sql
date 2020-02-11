
-- Ư�� �÷��鸸 ��ȸ
SELECT �÷��̸�����
FROM ���̺� �̸�;


--emp ���̺��� empno�� ename�� ��ȸ


--�÷��� ���� �ο�
SELECT �÷��̸� AS ������ ���� - ���� �����̳� ���� �빮�ڰ� ������ " "�ȿ� ����
FROM ���̺� �̸�;
-- ���� ������ ������ empno���� �����ȣ ename���� ����̸��̶�� ���� �ο�


-- ||�̿��ؼ� �� �� �����ϱ�
SELECT empno, ename
FROM emp;

SELECT empno AS �����ȣ, ename AS ����̸�   --as��� �� ����
FROM emp;

SELECT empno ||' is '||ename AS ���
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


--IN (��� ����) ��Ͽ� ���Ե� �����͸� ��ȸ
-- ������ or�� ��ü ���������� subquery������ or�� ��ü�� �� ��

--emp ���̺��� jpb�� CLERK �Ǵ� SALESMAN�� �������� ��� �÷��� ��ȸ
SELECT *
FROM emp 
WHERE job IN ('CLERK','SALESMAN');  --vlaue������ ��ҹ��� �ٸ��� ���� �ȵ�

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
--���ϰ� ��ġ�ϴ� �����͸� ��ȸ�� �� ���
--2���� wild card ���ڸ� �̿�
-- %: ���� ���� ������� ��Ī
-- _:�� ���ڿ͸� ��Ī

--%A%: A�� ���Ե�
--%A: A�� ������
--A% : A�� �����ϴ�
--_A: A�� ������ �� ����

--wild card ���� �˻��� ��
--_(�����)�� ������ ���� �˻�
--like '%\_%' escape '\': \(��������) ������ ������ ����(_)�� �ִ� �״�� �ؼ��ض�

SELECT ename, hiredate
FROM EMP 
WHERE hiredate LIKE '82%';  --82������ ���۵Ǵ� ������ �̱�

SELECT ename, hiredate
FROM EMP 
WHERE hiredate LIKE '___01___' --1���� ���Ե� ������ �̱�

--hiredate�� 12���� �������� ename�� hiredate�� ��ȸ
SELECT ename, hiredate
FROM EMP
WHERE hiredate LIKE '___12___'  --12���� ������ ������ �̱�


--NULL ��ȸ(IS NULL/IS NOT NULL)
--IS NULL �Էµ� �����Ͱ� 'null'�� �����͸� ��ȸ

--emp���̺��� comm���� null�� �������� ename�� comm ��ȸ
SELECT ename, COMM
FROM EMP
WHERE comm IS NULL;

--null �ƴ� ������ ��ȸ
SELECT ename, COMM
FROM EMP 
WHERE comm IS NOT NULL;

--and �� or ���� ������
--and�� �� ������ false�̸� ���� ������ Ȯ������ �ʴ´�
--or ������ ������ true�̸� ���� ������ Ȯ������ �ʽ��ϴ�.
--and ��or �� ����� ���� ������ Ȯ���ؼ� and�� ���ʿ� false�� ���ɼ��� ���� ���ɼ��� ��ġ�ϰ�,
--or�� ��쿡�� true�� ���ɼ��� ���������� ��ġ
--and�� ord�� ���� ���� ���� and��  ������ ����
--a OR b AND c(b�̰� c�� ������)
--or�� �켱������ ���̷��� ��ȣ�� �ؾ� �Ѵ�.

--__order BY[asc|dsc}
--SELECT ������ ����� ����

--�� ���̻��� �����͸� ��ȸ�ϴ� ��� ���ִ� ���� ����
--������ ���� ������ ���̰� ���������� ����

--asc���� ����
--DESC ��������
--�÷��̸� ��� SELECT ���� ����
--������ �м��� �ε����� 1���� ����

--�÷� �̸��� 2�� �̻� ����ϸ� ���� ������ ���� �����ϰ� ����
--�÷� �̸���� ����İ���

--EMP ���̺� ��� ���̺� ��ȸ
--HIREDATE �� ���� ���� ����
---DEPTINO�� �������� ���� ������ ���̸� empno�� ������������ ����


SELECT *
FROM EMP 
ORDER BY hiredate ASC;

SELECT �÷��̸�  ���⵵ AS �� ������ �� ����
FROM EMP 
ORDER BY hiredate (������ �� ����) ASC;


SELECT empno, ename, job, mgr,hiredate AS �Ի���, sal, 

--deptno���� �������� (deptno�� �������� �����ϰ� ������ ���̸� empno�� ������������ ����)
SELECT*
FROM EMP 
ORDER BY deptno DESC, empno; 


SELECT  --5
FROM    --1
WHERE --2
GROUP BY  --3
HAVING  --4
ORDER BY  --6

--==>select�� from�� �ʼ�

--5.��������
--emp �ۼ� ���̺��� sal�� 3000�̻��� ����� empno, ename, job, sal�� ��ȸ�ϴ� select���� �ۼ�
SELECT empno, ename, job, sal
FROM EMP
WHERE sal >= 3000;

--emp ���̺��� empno�� 7788�� ����� ename�� deptno�� ��ȸ�ϴ� SELECT ���� �ۼ�
SELECT empno, ename, deptno
FROM EMP 
WHERE empno = 7788;

--emp ���̺��� hiredate�� 1981�� 2�� 20�ϰ� 1981�� 5�� 1�� ���̿� �Ի��� ����� ename, job, hiredate�� ��ȸ�ϴ� select���� �ۼ�
--�� hiredate ������
SELECT ename, job, hiredate
FROM EMP 
WHERE hiredate BETWEEN '1981/02/20' and '1981/05/01'
ORDER BY hiredate;

SELECT ename, job, hiredate
FROM EMP 
WHERE hiredate >= '1981/02/20' AND hiredate <= '1981/05/01'
ORDER BY hiredate;

--�� �ĺ��� �Ʒ� ���� �� ����
--���� ������ ���� 5���̰� ���� ������ ���� 13��
--������ ���ɼ��� ���� ������ �տ� �ۼ��ϴ� ���� �����Ͱ� ���� ���� �ð��� ����
SELECT ename, job, hiredate
FROM EMP 
WHERE hiredate <= '1981/05/01' AND hiredate >= '1981/02/20'
ORDER BY hiredate;

--emp���̺��� deptno�� 10, 20�� ����� ��� ������ ��ȸ�ϴ� select��(ename������ ��ȸ)
--��� between�� and�� �ٲ� �� ������ IN�� �׷����� ����
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

--emp���̺��� sal�� 1500�̻��̰� deptno�� 10, 30�� ����� ename�� sal�� ��ȸ�ϴ� select��
--heading�� employee�� monthly salary�� ��ȸ
SELECT ename AS employee, sal AS "Monthly Salary"
FROM EMP
WHERE sal>=1500 AND deptno IN (10,30);

SELECT ename AS employee, sal AS "Monthly Salary"   --�̰� ����
FROM EMP
WHERE sal>=1500 AND deptno = 10 OR sal >= 1500 AND deptno = 30;   

SELECT ename AS employee, sal AS "Monthly Salary"
FROM EMP
WHERE sal>=1500 AND (deptno = 10 OR deptno = 30);

SELECT ename AS employee, sal AS "Monthly Salary"
FROM EMP
WHERE sal>=1500 AND deptno != 20;

--emp ���̺��� hiredate�� 1982�� ����� ��� ���� ��ȸ�ϴ� select��
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

--emp���̺��� mgr�� null�� ����� ename�� jobĮ�� ��ȸ
SELECT ename, job
FROM EMP 
WHERE mgr IS NULL ;

--EMP ���̺��� COMM�� NULL�� �ƴ� ����� ��� ������ ��ȸ�ϴ� SELECT ���� �ۼ�
SELECT *
FROM EMP 
WHERE comm IS not NULL ;

--EMP ���̺��� comm�� sal���� 10% �̻� ���� ����� ���Ͽ� ename, sal, comm�� ��ȸ�ϴ� SELECT ���� �ۼ�
SELECT ename, sal, comm
FROM EMP 
WHERE comm >= sal*1.1 ;

--EMP ���̺��� job�� CLERK�̰ų� ANALYST�̰� sal�� 1000, 3000, 5000�� �ƴ� ����� ��� ������ ��ȸ�ϴ� SELECT ���� �ۼ�
SELECT *
FROM EMP 
WHERE job IN ('CLERK', 'ANALYST') AND sal NOT IN (1000, 3000, 5000) ;

--EMP ���̺��� ename�� A �� E�� ��� �����ϰ� �ִ� ����� ename �� sal�� ��ȸ
SELECT ename, sal
FROM EMP 
WHERE ename LIKE '%A%' AND ename LIKE '%E%' ;

--EMP ���̺��� (ename�� L�� �� �� �̻��� ���ԵǾ� �ְ� deptno�� 30)�̰ų� mgr�� 7566�� ����� ��� ������ ��ȸ�ϴ� SELECT ���� �ۼ�
SELECT *
FROM EMP 
WHERE ename LIKE '%L%L%' AND deptno = 30 OR mgr = 7566 ;


SELECT SYSDATE
FROM dual;


SELECT *
FROM dual;

SELECT ename, trunc(sysdate-hiredate, -2) as �ٹ��ϼ�
FROM emp;

SELECT ename, sal
FROM EMP 
WHERE lower(job) = 'manager';

SELECT ename, sal
FROM EMP 
WHERE upper(job) = 'MANAGER';
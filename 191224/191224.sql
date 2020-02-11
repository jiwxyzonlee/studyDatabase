--substr data�� ��𼭺��� ������ �߶� �ų�
--���α׷��� �� ���� �ε������� �������� �ٸ��Ƿ� �������� �Ǵ�

--2��°���� 4���� ��������
SELECT substr('�ȳ��ϼ���', 2, 4)
FROM dual;


--4��° ����Ʈ���� 3����Ʈ ��������
SELECT substrb('�ȳ��ϼ���',4, 3 )
FROM dual;  --3����Ʈ�� �̹Ƿ� 2���� ��� �Ұ�(1,4,7 ����. �� ���ڴ� 3����Ʈ �̹Ƿ� '��'�� ����)


--4��° ����Ʈ���� 5����Ʈ ��������
SELECT substrb('Hello World', 4, 5)
FROM dual;   --lo Wo :4��°���� �ټ�����

--substr: ���ڿ����� ���ϴ� ��ġ���� ���ϴ� ���� ����ŭ �������ִ� �Լ�

--instr: ���ڿ����� Ư�� ���ڿ��� ã���ִ� �Լ�
--������ġ�� �����ϸ� 1
--���°�� �����ص� 1
--instr(���ڿ�, �˻��� ���ڿ�, ������ġ, ���°)
SELECT instr('Hello Oracle', 'Hello')
FROM dual;   --1 ����

SELECT instr('Hello Oracle', 'Hi')
FROM dual;   --0
--�ٸ� ���α׷��� ���� -1�� �ִ밡 �Ǵ� ����
  --������ �� ã�� �ôµ� ������
--����Ŭ�� 1���� �����ؼ� ������ 0�� ����(���α׷��� �� �ƴ�)

--����Ʈ


--TRIM ������ �߿� (LTRIM, RTRIM) �¿� ���� ����
--���ڿ� �˻� �˰��򿡼��� �¿� ������ �����ϰ� ��ȸ
--���̽� strip���� �ų�
--ID ���� �͵� ��������, ���� �˻����
--���� �α����� ���� ���� �� ���� ����
--ID �� �� ���� ������ �ϴ� ����

--������ ����
---������ ��� �з��� ���ΰ�
--������ ����

--�¿� ���� ����
SELECT trim('       Hi')
FROM dual;  --Hi

--���α׷��̳� �����ͺ��̽��� ���ڿ��� ���� ���� �¿������ �����ϰ� ���ϴ� ��찡 �����ϴ�.
--������ ���� ��ҹ��� ���� ���θ� �����ؾ�
--��й�ȣ�� �����ϰ�� ��ҹ��� ���� �� ��
--���� �ؽ�Ʈ ���̴��� ��(�ؽ�Ʈ �м�) ���� ���� �ϴ� �� �� �ϳ��� �ҹ��� ��ȯ
--���� ��Ƽ���� ���̵�� ���� �빮��


--concat
--2���� ���ڿ��� ���ļ� �ϳ��� ���ڿ��� ������ִ� �Լ�
--�Լ����ٴ� ������ �� ���� Ȱ��

SELECT concat(ename, job)
FROM emp;

SELECT ename ||' '|| job
FROM emp;

--convert
--���ڿ��� chr set ��ȯ(���ڵ�)
--convert(data, ������ ���ڵ�, ���� ���ڵ�)
--���� ���Ǵ� ���ڵ� ����� US7ASCII, UTF8, WE8ISO8859 (UTF8 ���� �ѱ� �ȵ�)
--ASCII(�ƽ�Ű) : ���� �� Ư�����ڸ� 1����Ʈ�� ǥ���ϴ� ���
--UTF 8 : ������ ��� ���ڸ� ǥ���ϱ� ���� �ڵ�(�� ���ڰ� 3����Ʈ)
--ISO8859-1: ������ ���ڷ� �ѱ۷� ǥ������ ���� (ISO Latin-1 �̶�� ��)

--convert(): �ѱ��� UTF8�ۿ� ǥ���� �ȵǱ� ������ ���� ������ ����, �����ʿ����� ���� ���

--���Ǻ����δ� spss ��
--���ڵ� ���� �˾Ƶα�

--��¥ ���� �Լ�
--(�ð迭 �м����� �����)
SYSDATE
--���� ��¥ �� �ð� ����
--��κ� ������ �����ͺ��̽��� �Ϸ縦 ���� 1�� �����ؼ� ���ϱ� ���� ����
NEXT_DAY
--Ư�� ��¥���� �Է��� ������ �������� ��������
ADD_MONTHS
--Ư�� ��¥���� ���� ���ؼ� ����
--round, trunc�� �̿��ؼ� �ݿø��̳� ���� ����

--google analytics
--R

--���� ��¥�� ��� ����
SELECT SYSDATE
FROM dual;

--��¥ ���� ����
--��ĥ �ٹ��ߴ��� Ȯ��
SELECT ename, round(SYSDATE-hiredate)
FROM emp;

SELECT ename, trunc(SYSDATE-hiredate, -1)
FROM emp;

SELECT round(sysdate - to_date('2019/11/26', 'yyyy/mm/dd'))
FROM dual;

--R�� �ð迭 �м�, ���̽��� �ð迭 �м�

--�� ��ȯ �Լ�
--���� <-> ����
--���� <-> ��¥

--���ڷ� ��ȯ
TO_CHAR

--��¥�� ��ȯ
TO_DATE

--���ڷ� ��ȯ
TO_NUMBER

--��¥ ������ ������ ���ڷ� ��ȯ�ؼ� �����ؾ�
-- ��¥ - ��¥�� ���ڷ� ��� RETURN

--���ڷ� ��ȯ�ϴ� ���� ��κ� ����� ����
--���ڳ� ��¥�� ��ȯ�ϴ� ���� ������ �ϱ� ����

--���� ����
--1. ���� ���� 
--0 ������ ǥ���ϰ� ������ 0
--9 ������ ǥ���ϰ� ������ ����
--L ��ȭ ��ȣ
--. �Ҽ���
--, õ ���� ���б�ȣ ****�߿�***�Լ� ���� �ɼ� �����ϸ� ���� ������ ���ڵǾ����
--��¥�� ���� ������ �� �ڸ��� �����ִ� �� �߿�(�׷��� 0�̳� 9�� �����Ǿ��ִ� ��)
('7', 00)  -->������ 7�� ���ڸ��� �ְڴ�
('17', 00)
--���� 07(��ĥ)��

--��¥ ����
yyyy--����
yy --����
mm --��
DAY -- ����
dd --��
hh -- 12�ð���
hh24 --24�ð���
mi -- ��
ss -- ��
am OR pm --���� ����

--null ��ü �Լ�
NVL(DATA, �����Ͱ� null�� �� ����� ��)
NVL2(DATA, �����Ͱ� null�� �ƴ� �� ����� ��, null�� �� ����� ��)

--emp ���̺��� ename�� comm�� ���� 100�� ���� �� ��ȸ
SELECT ename, comm+100
FROM EMP;
--null�� �����ص� NULL
--���α׷��� ������ ���ܰ� �߻�
SELECT ename, nvl(comm+100, 0)
FROM emp;
SELECT ename, nvl(comm, 0)+100
FROM emp;
SELECT ename, nvl2(comm,comm+100, 0)
FROM emp;
SELECT ename, nvl2(comm,comm, 0)+100
FROM emp;

--����ġ ������/��ü�ϱ�/ ��
--�������簡 ���� ����� ����Ʈ����

--�׷�ȭ
--1. �׷��Լ�
--���� �� �Լ���� �ϴµ� 1�� �̻��� ���� ������ ������ �� �� �ϳ��� ����� ����
--sum, avg, max, min, count, stddev(ǥ������), variance(�л�)
--�Լ��� �Ű������� �÷� �̸��̳� ������� �����ϴµ� null�� �����ʹ� �����ϰ� ������
--�������� ������ �� �� count�� ���, �÷��̸��� �����ϸ� null�� �����ʹ� ����
--��ü �������� ������ �˰� ���� ���� �÷� �̸� ��� *�� ������
--��� �÷� �� null�� ���ٸ� ������ ���� �� ���� ��

--avg�� �̿��Ͽ� ����� ���� �� ��κ� null�� �����͸� ġȯ�Ͽ� �����
--comm �÷��� ��� 14�� ������ �� 4���� �ԷµǾ� ����. �� ���¿��� ��� ���ϸ� 4�� �������� ��ո� ����


--�׷��Լ��� GROUP BY ���� ��������� ���� ��� ����
--�׷�ȭ ���� ���� �÷����� ���� ����� �� ����

--��հ� �ִ�, �ּ� �׸��� ����� ���� ���� ����ϴ� �� ����
--�� ������ ���� �������� �뷫���� ������ �˰� �̻�ġ ���θ� �Ǵ��ϰų� ��ǥ���� ����
--noise �� outlier  (boxplot)
--�����跮 �����ֱ�

--emp���̺��� sal�� ���
SELECT avg(sal) AS �޿����
FROM emp;

--emp���̺��� comm�� ���:comm���� null�� ���Ե�
SELECT COMM
FROM emp;

--emp���̺��� null��(�󿩱��� ���޴� ������ ��)�� 0���� ġȯ�ؼ� ���
SELECT avg(nvl(comm,0)) AS �󿩱����
FROM emp;
--emp���̺��� null���� 100���� ġȯ�ؼ� ���
SELECT avg(nvl(comm, 100)) AS �󿩱����
FROM emp;

--emp���̺��� �󿩱��� �޴� ����� ��
SELECT count(comm)
FROM emp;

--emp���̺��� ��ü ����� ��
SELECT count(*)
FROM emp;

--�޿��� ���� ���� ����� ename�� sal��
--ename�� �������� ���̰� max(sal)�� �ϳ��� ���̶� ���� ����� �� ����
--�̰�� ���������� ������ �̿��ؼ� �ذ��ؾ�

SELECT ename, sal, job
FROM emp
ORDER BY sal DESC;


--2. GROUP BY
--�׷�ȭ�� ����ϴ� ��
--�÷� �̸��̳� ������� �̿��ؼ� �׷�ȭ�� �ϴ� ��
--GROUP BY ���� ������ ������ �׷��Լ��� �Բ� ��� ����

--emp���̺��� job���� ��� sal�� ���� ��ȸ
SELECT job, avg(sal)
FROM EMP
GROUP BY JOB;
--R�� ���

SELECT deptno, avg(sal)
FROM EMP
GROUP BY deptno;

SELECT deptno, count(job)
FROM EMP
GROUP BY deptno;

--emp���̺��� �Ի�⵵ �� �ο����� ��ȸ
--�Ի翬���� hiredate �÷� ---���⼭ ������ �����Ϸ���?
SELECT hiredate, count(*)
FROM EMP
GROUP BY hiredate;

--like�� �ȵ�(where�� having�� ����)
--�Լ��� from���� �ƹ� �������� ��� ����
SELECT substr(hiredate, 1, 2), count(*)
FROM EMP
GROUP BY substr(hiredate, 1, 2)
ORDER BY substr(hiredate, 1, 2);
--ORDER BY count(*) desc;

SELECT substr(hiredate, 1, 2) AS �Ի翬��, count(*) AS �ο���
FROM EMP
GROUP BY substr(hiredate, 1, 2)
--ORDER BY substr(hiredate, 1, 2);
ORDER BY �ο��� desc;

SELECT substr(hiredate, 1, 2) AS �Ի翬��, count(*) AS �ο���
FROM EMP
GROUP BY substr(hiredate, 1, 2)  --�׷���̿��� ���� �� ������
ORDER BY �Ի翬��;
--ORDER BY �ο��� desc;

--���� ���� �ϴ� �� ���� ����� ��
--���� hiredate�� ������ ����
SELECT TO_CHAR(hiredate, 'day') AS ����, count(*) AS �ο���
FROM emp
GROUP BY TO_CHAR(hiredate, 'day');


--GROUP BY ���� �������� �÷��̳� ����� �ۼ� ����
--ù��°�� �׷�ȭ�ϰ� �� �ȿ��� �ٽ� �׷�ȭ
--��) ����, ���Ϻ� �ۼ� ����
SELECT TO_CHAR(hiredate, 'mm') AS ��, TO_CHAR(hiredate, 'day') AS ����, count(*) AS �ο���
FROM EMP
GROUP BY TO_CHAR(hiredate, 'mm'), TO_CHAR(hiredate, 'day');

--having�� �׷�ȭ �� ���Ŀ� ������ ������ �� ���
--where���� GROUP by���� ���� ����Ǳ� ������ �׷��Լ��� ����� �� ����
--�׷��Լ��� �̿��� ������ having���� �ۼ��ؾ� �Ѵ�

SELECT --5
FROM --1
WHERE --2      �׷���̺��� ���� ����Ǳ� ������ �׷���� ���� ��� ������ �غ�����
GROUP BY --3
HAVING --4
ORDER BY; --6

--5�� �̻� �Ի��� �ظ� ��ȸ
SELECT substr(hiredate, 1, 2), count(*)
FROM EMP
GROUP BY substr(hiredate, 1, 2)
HAVING count(*) >= 5;

--��������
SELECT substr(hiredate, 1, 2), count(*)
FROM EMP
--WHERE count(*) >= 5;   <<< �� ��� where�� �� ��°�� ����ǹǷ� ���� ��
GROUP BY substr(hiredate, 1, 2)
HAVING count(*) >= 5;

--�׷��Լ��� ������� �ʴ� ������ having�� ����ϴ� ���� ��ȿ����(Ư�� select����)
--sql�� �� ������ �����ؼ� �ϳ��� ����� ����� ��

--��ȿ������ ��
SELECT avg(sal)
FROM EMP
GROUP BY DEPTNO
HAVING deptno = 10;

--ȿ������ ��
SELECT avg(sal)
FROM EMP
WHERE deptno = 10
GROUP BY deptno;

--**filtering�� where���� �̸� �ɷ����� �� ����**

--�м����������� filtering Ȯ��
--�ڷ���(�з��Ϸ��� �������̾��), �̻�ġ Ȯ��(�����跮), ǥ��ȭ(���ڵ����ʹ� �������) = ���ʿ� ����

--�����Ϳ��� ���̰� ���� �ᱹ �ð� ���̷� �̾���(�ŷ���)
--�ڷ��� �� ����



--JOIN
--2���� ���̺��� �����ϴ� ��
--������ �ٸ� ���̺�鳢�� ���ļ� �ϳ��� ���̺��� ����� ��
--������ ������ ���� ���̺��� ���η� ��ġ�� ���� MERGE��� ��

--1. cartesian product
--   = CROSS JOIN 
-- 2���� ���̺��� ��� �����͵��� �����ϴ� ��
--FROM ���� ���̺� �̸� 2�� �����ϸ� ����Ʈ�� ��

--���� ����:  ���� ���̺��� ���� ������ ��,
--���� ����: ���� ���̺��� ���� ������ ��

--������ �����ͺ��̽����� ���̺��� �ʹ� ���� �������� �� �߻��ϴ� ������

--emp���̺��� 8�� ���� 14���� ���� ����
--dept ���̺��� 3���� ���� 4���� ���� ����
--emp���̺�� dept���̺�  cartesian product => 11���� ���� 56���� �� ����
SELECT *
FROM emp, dept;

--2. equi join
-- 2���� ���̺��� ����� �ǹ̸� ���� ���� ���� ���� ���� ����
-- (deptno ���� �� Ȯ��)
-- ���� ������ ����� �ǹ̰� �ƴ϶� �ڷ����� ������ ���� ����
--where ���� ���� ���̺��� ����� �ǹ̸� ���� �����Ͱ� ���� �� �����ϵ��� ����
-- ���� ���̺� �ִ� ���� �̸��� ������ �տ� ���̺� �̸�. �� �߰��ؼ� ��������� ��
SELECT *
FROM EMP, DEPT
WHERE emp.deptno = dept.deptno;
--WHERE deptno = deptno; <<�̷��� �ϸ� ambiguous �ϴٰ� ���� ��
--���̺� �̸� �����ϸ� ���� �̸��� �ָ��ϴٰ� ���� �߻�
--���ο� ������ �߰��ؼ� ���͸��� �� ���� ��ġ�� ��� ������ �Ϲ������� join ���� �ڿ� and�� �߰��ϰ� �ۼ�
SELECT ENAME, DNAME
FROM EMP, DEPT
WHERE emp.deptno = dept.deptno
AND ENAME = 'MILLER';
--emp���̺��� sal�� 3000�̻��� ����� ename�� deptno �׸��� dept ���̺��� loc ��ȸ
SELECT ENAME, emp.deptno, LOC  --loc�� dept ���̺� ����. �Ѵ� ���� �ִ� ���� �̸� �����. �Ⱦ��� ��ȣ
FROM EMP, DEPT
WHERE emp.deptno = dept.DEPTNO  --emp�� dept�� �������� ���� ��
AND sal >= 3000;

SELECT ENAME, emp.deptno, LOC  
FROM EMP, DEPT
WHERE emp.deptno = dept.DEPTNO AND sal >= 3000; --�̷��� �ص� ��

SELECT ENAME, emp.deptno, LOC  
FROM EMP, DEPT
WHERE sal >= 3000 AND emp.deptno = dept.DEPTNO; --�̷��� �ص� ��, �̰� �� ������?

--3. ���̺� ���� �ο�
--���̺� �̸��� �ʹ� ��ų� �˾ƺ��� ����� ��� �Ǵ� SELF JOIN �� ��� ���̺� �̸��� ���� �ο�
--���̺� �̸� �ڿ� ������ �߰��ϰ� ���� �Է�
--SELECT ���� �÷��� �̸��� ������ ���� ��� ORDER BY ������ ���� ����ص� �ǰ� ���� �̸� ����ص� ��
--FROM������ ���̺� �̸��� ������ ���� ��쿡�� �ݵ�� ���̺� �̸� ��� ������ ����ؾ� ��

--���̽㿡���� import ��Ű���� AS ���� ���� �ߴ� ���
--�� ������� ��Ű���� �״�δ� ����, �� ���� ��� ��

SELECT ename, e.deptno, LOC   --<select�� 5���̱� ������ ���� �ٲ��־�� ��
FROM EMP e, DEPT d             --<�̰���
WHERE e.DEPTNO = d.DEPTNO AND sal >= 3000;

--4. non equi join
-- join �� �� ' = '(��ȣ) ��ſ� �ٸ� �����ڷ� join �ϴ� ��
-- salgrade table�� grade�� losal, hisal ���� ����
--grade�� �޿� ����̰� losal�� ��� �� ���� �޿�, hisal�� �ְ� �޿�
--emp���̺��� ������ sal�� losal�̳� hisal�� ���ϰ� �Ǹ� '=(��ȣ)'�� �� �� ���� ����

--emp���̺��� ename�� sal �׸��� salgrade ���̺��� sal�� �ش��ϴ� grade�� ��ȸ�ϰ��� ��
--�������� �÷�Ƽ��, ���, �ǹ� �� �̷� �� ������ ��
--�ſ��޵� �̷��� �ϳ�?
SELECT *
FROM SALGRADE;

SELECT ename, sal, grade
FROM emp, SALGRADE
WHERE emp.sal = salgrade.LOSAL;
-->�̷��� �� ����

SELECT ename, sal, grade
FROM emp, SALGRADE
WHERE emp.sal = salgrade.HISAL;
-->�̷��� ����� �� ����

SELECT ename, sal, grade
FROM emp, SALGRADE
WHERE emp.sal >= salgrade.loSAL AND emp.sal <= salgrade.HISAL;
-->�̷��� ����� ����
-->between �ᵵ ����
-->���� �� ���� �̷��� �ְ���

--**���**
--5. SELF JOIN 
--�ڽ��� ���̺�� JOIN
--�ϳ��� ���̺� ������ �ǹ̸� ���� ���� �� �� �̻� �ִ� ��쿡��
--FROM ���� ������ ���̺��� �̸��� 2�� �����ϹǷ� �ݵ�� ���� �ο��ؾ�

--emp���̺��� empno�� ��� ��ȣ, mgr�� ������ �����ȣ
--�� �� �� ��� ��ȣ
--��� �̸��� ������ �̸��� ��ȸ�Ϸ� �ϸ� SELF JOIN �� ����ؾ� ��
--��) sns ģ�� ��õ(ex �� ���� �ִ� ���-��õ �ý���, ������ ���� å)
--���� ��õ, ���̽���-���ƿ�, ������ ��ǰ ���-��õ(���� ���̺� �� �� �湮)
--(���� �ǹ̸� ���� �����Ͱ� �𿩾� ��õ �ý����� ���� �� �ִ�.)
SELECT e1.ENAME ���, e2.ENAME ������
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.empno;
--���⼭ ����� sal���ϸ� e1, �������� sal ���ϸ� e2
SELECT e1.ENAME ���, e2.ENAME ������--, e1.sal, e2.sal
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.empno;

--emp���̺��� ename�� scott�� ����� ������ 
SELECT e2.ENAME ������
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

--emp���̺��� ename�� scott�� ����� �������� �������� �����ȣ
SELECT e2.MGR supervisor
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

SELECT e2.ENAME "SCOTT ������", e2.MGR "SCOTT �������� ������"
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

SELECT e1. ENAME ����, e2.ENAME ������, e2.EMPNO �����ڹ�ȣ, e2.MGR ����ڹ�ȣ
FROM EMP e1, EMP e2
WHERE e1.MGR = e2.EMPNO AND upper(e1.ENAME) = 'SCOTT';

--6. OUTER JOIN 
--INNER JOIN�� ���� equi JOIN �� �ǹ���
--OUTER JOIN �� ��� �� �ʿ��� �����ϴ� �����͵� join�� ������Ű�� ��
--emp���̺��� deptno�� 10, 20, 30�� �ְ� dept���̺���  deptno�� 10, 20, 30, 40�� ����
--�� ��� equi join�� �ϰ� �Ǹ� ���� ��� �����ϴ� 10, 20, 30�� ��ȸ
--dept ���̺��� �����ϴ� 40������ ������Ű���� �� �� �����ϴ� join�� OUTER JOIN 
--OUTER JOIN �� ���� ���Խ�ų ���̺��� JOIN ���� ����� �ݴ��� '(+)' �߰�
emp.deptno(+) = dept.DEPTNO
-->dept���̺� �ִ� ��� �����Ͱ� JOIN ���� ����
--'(+)'�� ���ʿ� ���̴� ���� �ȵ�

--equi JOIN (����� 10, 20, 30�� ��ȸ. 40����)
SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE emp.deptno = dept.deptno;

--outer join(emp���� 40���� ��� e.name�� null)
SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE emp.deptno(+) = dept.deptno;

SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE emp.deptno = dept.deptno(+);  -->��ȭ ����(40 �� ����

SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp, DEPT
WHERE dept.deptno(+) = emp.deptno;  -->��ȭ ����(40 �� ����)

--7. ANSI JOIN
--�̱� ǥ�� ��ȸ���� ���� JOIN �������� ��ټ��� ������ �����ͺ��̽����� ������ ������
--�Ϻ� ������ �����ͺ��̽������� �ȵ� ���� ����
--1) Cartesian Product(Cross Join)
--: �� ���� ���̺��� ��� ������ ����� ��
FROM ���̺� �̸� CROSS JOIN ���̺� �̸�

--2) Equi Join(Inner Join, ������ on ���� ����)
--join ���ǰ� where �����ϱ� ����
FROM ���̺� �̸�1 INNER JOIN ���̺� �̸�2
ON ���̺� �̸�1.�÷� �̸� = ���̺� �̸�2.�÷� �̸�

SELECT *
FROM emp INNER JOIN DEPT
on emp.deptno = dept.deptno;

--�� ��� ���� �÷� �̸��� ������ on ��� using ���
FROM ���̺� �̸�1 INNER JOIN ���̺� �̸�2
USING(�÷��̸�)

SELECT *
FROM emp INNER JOIN DEPT
using(deptno);

--�÷��̸� ������ inner join ��ſ� natural join�̶�� �Է��ϰ� join ���� ���� ����
FROM ���̺� �̸� NATURAL JOIN ���̺� �̸�2

SELECT *
FROM emp NATURAL JOIN DEPT;

--�� ��� ���� ��


--3) OUTER JOIN
FROM ���̺��̸�1 [LEFT|RIGHT|FULL] OUTER JOIN ���̺��̸�2
ON ���̺��̸�1.�÷��̸� = ���̺��̸�2.�÷��̸�
--full�� ���� �� ����
--full�� ��� ���� ���̺��� �����ϴ� �����͵� join�� ����

SELECT dept.deptno, dept.DNAME, emp.ENAME
FROM emp RIGHT OUTER JOIN dept  --�������� �� ����
ON  emp.deptno = dept.deptno;

--8. SET ����
--> ������ ������ ���� 2���� ���̺� ����
--������ ���ٴ� �ǹ̴� ���� ������ ���ƾ� �ϰ� �� ���� �ڷ����� ���ƾ�
--ù��° SELECT �������� ����� ���� �ι�° SELECT �������� ����� ������ 
--�������� 1��1 �����ϸ� �� ������ Ÿ���� ��ġ�ؾ� ��
--ORDER BY�� �ѹ��� ��� �����ϰ� SELECT ������ �������� ���

--�ϳ� �̻��� ���̺�κ��� �ڷḦ �˻��ϴ� �� �ٸ� ����� SET�����ڸ� �̿�
--SET�����ڸ� �̿��Ͽ� ���� ���� SELECT������ �����Ͽ� �ۼ�


--1 ������(union, �ߺ�����) UNION all( �ߺ� ���� ����)
--2)������ INTERSECT
--3)������(minus)

SELECT ����
set operator
SELECT ����

--�� ����� ��(������) 
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
--:�� ����� ��(������:�ߺ��Ǵ� ���� �ѹ� ���) 
SELECT deptno
FROM DEPT
UNION
SELECT DEPTNO
FROM emp;


--���ʿ��� �˻��� �ڷḸ ���
SELECT deptno
FROM DEPT
INTERSECT
SELECT DEPTNO
FROM emp;

--ù��° SELECT���忡�� �ι�° SELECT���忡�� ���� �� ���� ���(40)
SELECT deptno
FROM DEPT
MINUS
SELECT DEPTNO
FROM emp;

--sub query
--SQL ���� �ȿ� ���Ե� SQL
--�ٸ� SQL ���� �ȿ� SELECT ������ ����

--1. �ۼ� ���
--���Ե� ������ �ݵ�� ()�� ���μ� �켱������ ���� ���� ����ǵ��� �ؾ�

--2. sub query�� ����
--���� ������ ����Ǳ� ���� 1���� ����

--3. ����
--1)���� �� ��������: ���������� ����� �ϳ��� ���� ���
--  ���� �� ������ ��� (=, !=, >, >=, <, <=)
--2)���� �� ����Ŀ��: ���������� ����� �� �� �̻��� ���� ���
--  ���� �� �����ڸ� �ܵ����� ��� �Ұ���
--   (in, not in, all, any �� ���� ���� �� �����ڸ� ���� ���)

--4. ������ ��������
--1) emp���̺��� ename�� SCOTT�� ����� ������ �̸��� ��ȸ
SELECT e2.ENAME
FROM EMP e1, EMP e2
WHERE e1.ename = 'SCOTT' AND e1. mgr = e2.empno;
--�̿��̸� join���� sub query�� ������
--join�� ���̴� ������
--select �ڸ��� ����ϴ� ���� �̸����� �ϳ��� ���̺��� ������ �����ϴٸ� sub query�� �ذ� ����
SELECT ename 
FROM EMP
WHERE EMPNO = (SELECT mgr
				FROM EMP
				WHERE ename = 'SCOTT');
--R�� �������ڸ�
--emp %>% filter(ename = 'SCOTT')%>%select(mgr)//%>% filter(empno)%>%select(ename)

--2)emp���̺�� dept���̺��� deptno�� ���� �����ϰ� ����
----dept���̺��� loc�� dallas����� emp���̺��� ename�� sal�� ��ȸ
SELECT ename, sal
FROM EMP
WHERE deptno = (SELECT deptno
				FROM dept
				WHERE loc = 'DALLAS');

--3)dept���̺��� DNAME�� SALES�� �������� ENAME�� JOB�� ��ȸ
--�μ����� SALES�� ����� �̸��� ���� ��ȸ
--ENAME�� job�� emp�� ����
--dept���̺�� emp���̺��� deptno�� ����
SELECT ENAME, JOB
FROM EMP
WHERE deptno =(SELECT DEPTNO
				FROM DEPT
				WHERE DNAME = 'SALES');

--5. ���� �� ��������
--emp���̺�� dept���̺��� deptno ���� ����
--dept���̺��� loc �� dallas�� chicago�� ����� emp���̺��� ename�� sal ��ȸ

--���� ���� ��
SELECT ename, SAL
FROM EMP
WHERE DEPTNO = (SELECT DEPTNO
				FROM DEPT
				WHERE LOC = 'DALLAS' OR LOC = 'CHICAGO');
-- ���������� ������ �ƴ� ���� ������
--Dallas�� chicago�� �ٹ��ϴ� ����� deptno�� 20�� 30
--�ΰ��� �����ʹ� '='�� ���� �� ����
--�� ��� '=' ��� 'in'�� ����ؾ� ��
-- !=�� ��� NOT IN ���

--���� ��
SELECT ename, SAL
FROM EMP
WHERE DEPTNO IN (SELECT DEPTNO
				FROM DEPT
				WHERE LOC = 'DALLAS' OR LOC = 'CHICAGO');

--all �̳� any�� ��� �ȴ�?
--2�� �̻��� ���ڰ� ����� ���ϰ��� 2�� ���ں��� ��� ū ��쿡 �ش��ϴ� �����͸� ��ȸ�� ��
-- > (100, 200)�� ������ �� ��
--ũ��, �۴ٴ� �ϳ��� ������ �� ����
--���� ���� �����͸� ũ�� �۴ٷ� ���Ϸ��� all�̳� any��� ������ �̿�

-- > ALL(100, 200): 100�� 200���� ��� ū ��� true ����
--�� ���� MAX �� �ٿ��� �ȴ�(200���� ���ϸ� �Ǳ� ������)
-- > MAX(100, 200)  (���� ū 200���� Ŭ ��)

-- > ANY(100, 200): 100�̳� 200�� �ϳ��� ũ�� true
-- > MIN(100, 200)�� ���� ����(���� ���� 100���� Ŭ ��)

--emp���̺��� deptno�� 10 �Ǵ� 20�� �μ��� ��� sal���� sal�� �� ū ����� ename�� sal ��ȸ
--���� deptno�� 10 �Ǵ� 20�� �μ��� ��� sal ��ȸ
SELECT avg(SAL)
FROM EMP
WHERE deptno = 10 OR deptno = 20
GROUP BY deptno;
--deptno = 10 �� ���� deptno = 20�� �� �� �� ������� ����

--���� ���� ��
SELECT ename, sal
FROM EMP
WHERE sal > (SELECT avg(SAL)
				FROM EMP
				WHERE deptno = 10 OR deptno = 20
				GROUP BY deptno);
--�� ������ ���������� ����� �� ���̱� ������ ������ ��

--�ùٸ� ��(jones, scott, ford, king)
SELECT ename, sal
FROM EMP
WHERE sal > ALL(SELECT avg(SAL)
				FROM EMP
				WHERE deptno = 10 OR deptno = 20
				GROUP BY deptno);

--max�� �Լ� ��ġ�� �޸� �ٴ´�(jones, scott, king, ford)
SELECT ename, sal
FROM EMP
WHERE sal > (SELECT max(avg(SAL))
				FROM EMP
				WHERE deptno = 10 OR deptno = 20
				GROUP BY deptno);

--�������� �ο��� ��ȸ
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

--�ߺ��� ������ ����
SELECT count(DISTINCT MGR)
FROM EMP;








---->ȸ������ ���̺� �����(���̺��̸� - member)
CREATE TABLE member(
email varchar2(100), 
name varchar2(30), 
password char(15), 
age number(3),
joindate date,
logindate date);

--table Ȯ��
SELECT * FROM MEMBER;

--*1. emp���̺� �����ؼ� emp01 ���̺� ����
CREATE TABLE emp01
AS
SELECT *
FROM EMP;

--emp01 TABLE Ȯ��
SELECT *
FROM emp01;

--*2. emp���̺��� ������ �����ؼ� ���̺� ����
--==>emp02
CREATE TABLE emp02
AS
SELECT *
FROM EMP
WHERE 0 = 1;  --���� true �� �� ���� ���� / ������ ���� 1 = 1

--emp02 TABLE Ȯ��
SELECT *
FROM emp02;

--id / pw �ִ� Ȩ���� ���
SELECT *
FROM MEMBER
WHERE id = ? AND pw = ? OR 1 = 1;
--�����Ͱ� ������ 
--�α��� ������ id�� ������ ��й�ȣ�� �����ͼ� �ٽ� ���ϵ��� ����ų�
--���̵�� ��й�ȣ�� �Է��� �� sql ���� ������� ���ϵ��� �ؾ� ��
--ex. or �Է� ���ϵ���

--���α׷����� ��й�ȣ�� ���ϵ��� ����� ��
SELECT *
FROM MEMBER
WHERE id = ?;

--���̽� ����ǥ���� - ���� �б�


--**���̺� ����
--���� �߰��ϰų� ���� �����ϰų� ���� �����ϴ� �۾�
--1. ���� �߰�
alter table ���̺� �̸�
add(�� �̸� �ڷ���);

--emp02 TABLE�� ��ȭ��ȣ �� �߰�
--��ȭ��ȣ�� ���� 11�ڸ� 
-- ���� ����� �� ������ �ڸ����� ��ȭ ���� => varchar2 ��� ����
ALTER TABLE emp02
ADD(phone varchar2(11));

--TABLE Ȯ��
SELECT *
FROM emp02;

--2. �� ����
alter table ���̺��̸�
modify(���̸�, �ڷ���);

--�ڷ��� ��ü�� �����ϴ� ��, ���� ���̴� ���� ������ ����ؾ�
--���� �����Ͱ� �Ҹ� ���
--���� �ø��� ������ ������

--emp02 table���� phone column �ڷ����� varchar2(12)�� ����
alter table emp02
modify(phone varchar2(12));

--table Ȯ��
select *
from emp02;


--3. �� ����
ALTER TABLE ���̺� �̸�
DROP COLUMN ���̸�;
--�� �̸��� ��Ȯ�ϰ� �Է��ߴµ��� �������� ���� ����
--�ٸ� ���̺��� �� ���� �����ϴ� ��찡 �ֱ� ������
--�̷� ���� �ڽ� ���̺��� �����͸� ���� ����� �����ؾ� ��
--�ܷ� Ű

--emp01 table�� phone �� ����
ALTER TABLE emp02
DROP COLUMN phone;

--TABLE Ȯ��
SELECT *
FROM emp02;
--������ �����ϸ� �� �� ��


--4.SET unused
--�����ͺ��̽� ���̺��� ������ �����ϰų� ������ �� 
--�׸��� �����͸� �߰��ϰų� ���� �Ǵ� ������ ��
--LOCK �߻�

--lock�� �ɷ� ������ select�� ������ �ٸ� �۾� ���� �Ұ�

--�뷮�� �����Ͱ� ����� ���¿��� �� ���� ��
--���� ���� ���� �� ������ LOCK �ɷ��� �ٸ� �۾� ���� �Ұ�

--�� ������ �ٷ� �����ϴ� �ͺ��� ����� ���ϰ� �� �� �ð� ������ ������ �����ϴ� ���� ȿ����
ALTER TABLE ���̺� �̸�
SET unused(�� �̸�);
-- �� ��� ����� �� ��� ����

ALTER TABLE ���̺��̸�
DROP unused columns; 
--�� ������� �������� �� ����
--ex. �������˽ð�



--*3. ���̺� ����
DROP TABLE ���̺� �̸�;
--���̺��� �����ϴµ� �� ����� �����ϴ� ���� �ϳ� �̻��� ���� �ٸ� ���̺��� �����Ǵ� ���

--emp02 table ����
DROP TABLE emp02;

--Ȯ��
SELECT *
FROM emp02;
--SQL Error [942] [42000]: ORA-00942: table or view does not exist
--���������� ���̺��� �������� ��� ���� ���� ���� �߻�

--���̺��� �����͸� ����
truncate TABLE ���̺� �̸�;
--������ �����ϰ� ���� �ϱ� ���� ������ �� �� �̿�

--���̺� �̸� ����(���� �� ��)
RENAME ���� �̸� TO ���̸�;

--�������
--------------------------------------DDL(DATA DEFINITION LANGUAGE)
--������ ������ ���õ� ��ɾ�
--CREATE ALTER DROP truncate rename  



--------------------------------------DML (DATA MANIPULATION LANGUAGE) 
--(������ ���� ���. �۾��� ������ ���̺��� �ƴϰ� ���̺� ���� ������)
--������ ����, ����, �����ϴ� ��ɾ�

--*1. ������ ����
INSERT INTO ���̺��̸�(�� �̸� ����)
 VALUES(���̸��� �ش��ϴ� ������ ����);

--�� ������ �°� ������ �����ϰ� �ڷ����� ��ġ�ؾ�
--!!!!! VALUES �տ� ���� �־�� �� !!!!!

--INSERT �ϴٺ��� �����ͺ��̽������� �Ǽ��� ���µ�
--INSERT INTO ���̺��̸�, (���⼭ �̾�� ��� ������ �� ������)
--(^����)VALUES   => (+)�������� �νĵ�
-- => '���̺��̸�values' �پ return��

--���ڿ������� ������ ã�Ⱑ �����
--�׷� ���� �ٹٲ� �� �ϰ� �����ϴ� �� �� ����

--dept ���̺� deptno�� �ְ� dname�� �� loc�� ������ ������ ����
--loc �÷��� ���̴� 13�̾ �ѱ� 5����(=15����Ʈ)�� ���� �Ұ�
INSERT INTO dept(deptno, dname, loc)
VALUES(99, '��', '����Ư����');
--sql�� �ٸ� editor�� �ۼ��� �� ���縦 �� ���� ���� ����ǥ �� Ȯ��
--powerpoint ���� ���α׷����� ���� ����ǥ�� �ٸ� ���·� �ٲ� ���� �߻� �� ���� ����

--table Ȯ��
SELECT *
FROM dept;


--SQL Error [12899] [72000]: ORA-12899: value too large for column "SCOTT"."DEPT"."LOC" (actual: 15, maximum: 13)
--ORA-12899  -->db����. ����Ŭ ������

--�����͸� ������ �� �÷� �̸� ���� ����
--���̺��� ������ �°� ��� �����͸� ������� ���� �Է��ϴ� ��쿡�� ����
INSERT INTO dept
 VALUES(88, '�ѹ�', '����');
 
--table Ȯ��
SELECT *
FROM dept;

--NULL ����
--��������� ���� NULL �̶�� �����ص� �ǰ�
--�⺻���� �������� ���� �÷��� �����ϰ� ����

INSERT INTO dept 
VALUES(87, '����', null);

INSERT INTO dept(deptno, DNAME) 
VALUES(86, 'ȸ��');
--�� ��쿡�� loc�� �⺻���� �������� ���� ��쿡 null�� ���Եǰ�
--�⺻���� �����Ǿ� ������ �⺻�� ���Ե�

--table Ȯ��
SELECT *
FROM dept 
ORDER BY deptno;

--��ȸ�� ���(select �� ���)�� ���� ����
INSERT INTO ���̺� �̸�(�÷� �̸� ����)
SELECT ����;
--SELECT ���� ����� �÷� �̸�, �ڷ����� ��ġ�ϰ� ������ ������ ��ȸ�� ��� ���� ����

--(table �� �� �ʿ�, dept���̺��� ������ �״�� ���� dept01 ���̺� ����)
CREATE TABLE dept01
AS
SELECT *
FROM DEPT
WHERE 0 = 1;

--table Ȯ��
SELECT *
FROM dept01;

--�� : �ٱ��� �����͸� ���� ������ �ϴµ� db�� �� �ű� ���� ���� �ڷ�� �ʿ��� ��
--dept���̺��� deptno�� 50�̻��� �����͸� select�� �����  dept01�� ����
INSERT INTO dept01
SELECT *
FROM DEPT
WHERE deptno >= 50;

--table Ȯ��
SELECT *
FROM dept01;

--�ϳ��� ���̺��� ��ȸ�� ������ 2�� �̻��� ���̺� ���� ����
--��������: ��ȸ�� ������ ���̸��� �����ϰ��� �ϴ� ���̺��� ���̸��� ��ġ�ؾ� ��
INSERT ALL
INSERT INTO ���̺��̸�(�÷� �̸� ����)
INSERT INTO ���̺��̸�(�÷� �̸� ����)
...
SELECT ����;

--*2. ������ ����
UPDATE ���̺��̸�
SET ������ �� �̸� = ������ ����
[WHERE ����];
--where �� ���� ����
--where �� ���� �� ���̺��� ��� �����Ͱ� ������

--���԰� �ٸ��� ������ ������ ���������� �̻��� ���µ��� 1���� �����ǰų� �������� ���� �� ����
--������ �����Ϳ� ��ȭ�� ������ �ʴ´ٸ� ����
--�����̳� ������ where���� �־ ���ǿ� �´� �����Ͱ� �� ���� ������ �����̳� ������ ������

--SELECT / SELECT �̿�
--: ������ return ����
--select�̿� ���� ������� ���� ���� RETURN
--INSERT �� 0 �ȵ�. 1�̾�� ��
--�����̳� ������ where����, where�� ���� ������ �����̳� ���� �� ��
--------0�� ���ǿ� �´� �����Ͱ� ���ٴ� ��
--INSERT �� 1�̻��� �;� ����
--update�� delete�� 0�� �ƴϸ� ����

--dept01���̺��� deptno�� 88�̻��� �����͸� deptno�� 1 ����
UPDATE dept01
SET deptno = deptno - 1
WHERE deptno >= 88;

--table Ȯ��
SELECT *
FROM dept01;

--SET ���� ���� ���� �÷� �� ���� ����
--�޸�(,)�� �����ؼ� ���� �� ����
--dept01 ���̺��� deptno�� 86�� �������� dname�� SI�� LOC�� ȫ��� ����
UPDATE dept01
SET dname = 'SI', LOC = 'ȫ��'
WHERE deptno = 86;
--ȸ����ȣ ���� ����

--table Ȯ��
SELECT *
FROM dept01;


--*3. ������ ����
DELETE FROM ���̺��̸�
[WHERE ����];
--�����ͺ��̽� ������ ���� FROM ���� ����
--������ ������ ���̺��� ��� �����͸� ������
--���ǿ� �´� �����Ͱ� �ִµ��� ������ �ȵǴ� ��� �ٸ� ���̺��� �� �����͸� �����ؼ���

--dept01 ���̺��� deptno�� 40�̻��� �����͸� ����
DELETE FROM dept01
WHERE deptno >= 40;

--table Ȯ��
SELECT *
FROM dept01;

--**TABLE MERGE 
--2���� ���̺��� �����͸� ���ؼ� ���� �����ʹ� �߰��ϰ� �����ϴ� �����ʹ� �����ϴ� �۾�
--�ڵ� ���� ����Ʈ ���� ���� �� ���� �����͸� ������Ʈ �ϴ� �뵵�� ���
--���� �ſ� ����(������ ��� �󵵴� ����)
MERGE INTO �⺻���̺��̸�
USING ������Ʈ �� �����͸� ���� ���̺��̸�
ON(� ���� ������ ������ �����͸� ����� ������ ���� ���)

WHEN MATCHED THEN
UPDATE SET
�⺻���̺��� �÷� �̸� = ������Ʈ �� �������� ���̺��̸�.�÷��̸�,
�޸��� �̿��Ͽ� ������Ʈ �� �÷��� ������ ������� ����

WHEN NOT MATCHED THEN
INSERT VALUES(������Ʈ �� �����͸� ���� ���̺� �̸�. �÷�, ...);

--����
--dept01 ���̺� dept���̺� �ۼ��� ����Ʈ ������Ʈ,
-----�������� �ʴ� ������ �߰�
MERGE INTO dept01
USING DEPT
ON(dept01.deptno = dept.DEPTNO)

WHEN MATCHED THEN
UPDATE SET
dept01.dname = dept.dname,
dept01.loc = dept.loc

WHEN NOT MATCHED THEN   --python�� try except ���� ��
INSERT VALUES(dept.deptno, dept.dname, dept.LOC);
--���� ���� ���� �߰�

--table Ȯ��
SELECT *
FROM dept01

----->�����, ����갡 �̷� ������ ����


--------------------------------------TCL(TRANSACTION CONTROL LANGUAGE)
--�ǹ������� ������ ���������� �����ͺ��̽� �̷п����� DCL�� �з�
--TCL�� ������� ������ �����ڰ� �ַ� ����ϴ� LANGUAGE�̱� ������ ������ �з�
--�̿� ����� ���·� �̷п����� INSERT DELETE UPDATE SELECT �� DML�� �з�������
--�ǹ������� INSERT, DELETE, UPDATE �� DML��, SELECT�� DQL�� �з�
--DML�� ���̺� ��ȭ�� ���������� SELECT�� ��ȭ�� �������� �ʴ´�.

--���ÿ� ������ �� �ִ� ����� ���ÿ� ���� ���ϴ� ���

--TRANSACTION: �� ���� �̷����� �ϴ� �۾��� ������ ����
--1. Ʈ������� ������ �ϴ� ����(ACID)  <--NoSQL���� ���� ����(������ Ʈ�����)
--1) Atomicity: ALL OR NOTHING (���� �ƴϸ� ����) ���ڼ�
--2) Consistency: �ϰ���. Ʈ����ǰ� �ϰ����� �־��
--3) ISOLATION: ������, Ʈ������� ���������� �����
--4) Durability: ���Ӽ�, ���Ӽ�. �� �� �Ϸ�� Ʈ������� ��ӵǾ�� �Ѵ�

--2. 2���� ���� �� �� ���� ������ �������� �ٸ� ������ �����Ϸ� �Ѵ�.
-----������ ���̽����� 4���� ������ �߻�
-----�Ǹ��Ϸ��� �ϴ� ������ �ݾ��� �þ�� �Ѵ�
-----�Ǹ��Ϸ��� �ϴ� ������ �������� �Ҹ�Ǿ�� �Ѵ�
-----�����Ϸ��� �ϴ� ������ �ݾ��� �����ؾ� �Ѵ�
-----�����Ϸ��� �ϴ� ������ �������� �߰��Ǿ�� �Ѵ�.

-----4���� �۾� ���� �߰��� ��ְ� �߻��ϸ� ��� �� ���ΰ�

--3. Ʈ����� ó�� ���
--1) manual COMMIT
--- ���� commit�� ROLLBACK ����
--2) auto COMMIT
--- �ϳ��� SQL ������ �����ϸ� �ڵ����� COMMIT
--- �ڹٳ� dbeaver�� auto COMMIT

--4. Ʈ����� �۾� ����
---1) COMMIT : �۾��� �Ϸ�ż� ����� �����Ͱ� ���� �����Ϳ� �ݿ�
---2) ROLLBACK : ����� �����͸� ����, ���� �����Ϳ� ����� ������ �ݿ����� ����

---3) SAVEPOINT : ���� ���� �۾��� �ѹ��� COMMIT �ϰų� ROLLBACK �ϸ� 
------------------�ý��ۿ� ������ �߻��� �� �ֱ� ������
------------------�߰� �߰� rollback�� �� �ִ� ��ġ 

--5. Ʈ����� ����
--- ���ο� Ʈ������� ���� ���¿��� INSERT, DELETE, UPDATE�� �����ϸ� �ڵ� ����

--6. Ʈ������� �Ϸ�ż� �Ҹ�
---- ��������� commit�� ȣ���� ��쳪 �ý����̳� ���ӵ����� ���� ����� ���
---- DDL(Create, Alter, Drop, Truncatem Rename)�̳� 
---- DCL(Grant, Revoke)�� ���������� ������ ����
---- Ʈ������� COMMIT �ǰ� �Ҹ�˴ϴ�.
---- rollback�� ȣ���ϰų� �ý����̳� ���ӵ��� ������ ����Ǹ� rollback�ǰ� Ʈ����� �Ҹ�

---- ROLLBACK TO SAVEPOINT �̸��� �Է��ϸ� savepoint�̸��� ������ �ڸ���  rollback��

--7. dbeaver�� �̿��ؼ� �ǽ��� �� ���� auto commit�� ����(none)�ϰ� �����ؾ� ��
--toad ���� ������ ����ϸ� savepoit�� 1���� ���� ����

--8. NoSQL�� �Ϲ������� Ʈ������� ������ ���� auto commit�� ����
-----NoSQL ���� ���� ���غ��� ���� ����

--�ǽ�
--switch to auto-commit : None �ߴ� �� Ȯ��
--dept ���̺��� ��� ������ �����ؼ� deptcopy ���̺� ����
CREATE TABLE DEPTCOPY
AS
SELECT *
FROM dept;
--table Ȯ��
SELECT *
FROM deptcopy;

--deptcopy ���̺��� ������ ����
DELETE FROM deptcopy;
--table Ȯ��
SELECT *
FROM deptcopy;

--Ʈ����� ���
ROLLBACK;
--table data Ȯ��
SELECT *
FROM deptcopy;
--data �������� �� �� ����

--select�� ������ ������ ���� ������  transaction�� �ƹ��� ������ ����
--deptno�� 10���� �����͸� deptcopy table���� ����
DELETE FROM DEPTCOPY
WHERE deptno = 10;
--deptcopy���̺��� �ٷ� �����ϴ� �� �ƴ� ī�Ǻ� ���� �� �� ������ ����
--���� ���̺��� lock�ɾ� ����(ī�Ǻ� �۾� ���� ������ insert, delete, update �Ұ�)
--������ �۶����� �ִٴ� �� ��� ������̱� ������ lock�ɷ��ִٴ� ���� �����ؾ� ��
--�̶� select�� �ϸ� �����ִ� �� ī�Ǻ�
--�ѹ��� ī�Ǻ� ���� �Ϸ� ��������
--������ ������ ���� ����.

--transaction�� commit�ϰ� �Ϸ�
COMMIT;
--commit�� ī�Ǻ��� �������� ���� ���������� ī�Ǻ� ����

--�۾���� rollback �õ�
ROLLBACK;
--commit �� �ƹ��� rollback�� �ص� ī�Ǻ��� �������� ������ ���� �Ұ�

--table Ȯ��
SELECT *
FROM deptcopy; --commit���� ������ �ݿ��� �Ʊ� ������ ���� �Ұ�

--SQL developer : manual commit
----lock������ select�� �Ǵµ�(db������ �ȴٴ� ��) insert delete update �Ұ�
----commit �� �ϸ� �ذ� ����

--dBeaver : auto commit

--create/alter/drop/grant/revoke ==>������ commit �Ƚᵵ commit��
-->�������� �����̱� ����
--���α׷��Ӵ� Ư���� ��찡 �ƴϸ� create/alter/drop/grant/revoke�� select ���� �� ��
--create/alter/drop/grant/revoke >> rollback �Ұ���. ���� ����� ����Ʈ �ؾ� ��
--�� �׷��� ��ǻ�� �� ��ġ �� ������� �̰� �����ΰ�

--savepoint �ŷ��� �� ������ commit �ϴ� �� �ʹ� �����
--���� �� f = open, f.close() ��û���� ���� ���� ���� �� ����
--�߰��� �ϳ� �߸� �ż� rollback�ϸ� ���� ���� �� ���ư������ϱ�
--������ �ð��̳� ������ �ŷ� �Ǽ��� �� ������ savepoint ����
--rollback to s1 : s1���� ���ư�
--savepoint�� �߰��� ���� ������ �� ���ư��� ����


---savepoint �� autocommit
--�ǽ��� ���ؼ� emp table�� ��� �����͸� ������ �ִ� empcopy ���̺� ����
CREATE TABLE EMPCOPY
AS
SELECT *
FROM emp;

--���̺��� ����� �����ǰ� �����Ͱ� � �͵��� �ִ��� Ȯ��
SELECT *
FROM EMPCOPY;

--empno�� 7369�� �����͸� empcopy ���̺��� ����
DELETE FROM EMPCOPY
WHERE empno = 7369;
--table Ȯ��
SELECT *
FROM EMPCOPY;

--emp���̺��� �����͸� �����ؼ� empcopy1�̶�� ���̺� ����
CREATE TABLE empcopy1
AS
SELECT *
FROM emp;

--���̺��� ����� �����ǰ� �����Ͱ� � �͵��� �ִ��� Ȯ��
SELECT *
FROM empcopy1;

--������ ������ ���� ����(empcopy)�� �߸��� �� ���Ƽ� rollback ����
ROLLBACK;

SELECT *
FROM empcopy;
--->������ ������ ���� �Ұ�
---empcopy1 CREATE �������� �̹� COMMIT �Ǿ���ȱ� ����

--CREATE/ALTER/DROP/GRANT/REVOKE/�� ���������� �����ϸ� �ڵ� COMMIT

--INSERT/DELETE/UPDATE/�� �����ϴ� ���ø����̼ǰ� 
--DDL �Ǵ� DCL�� �����ϴ� ���ø����̼��� �ϳ��� ������ �ʴ� ���� ����

--�����͸� �����ϴ� ���ø����̼ǿ��� COMMIT�̳� ROLLBACK���� ����ϰ� �Ǹ�
--�ŷ� ���� COMMIT�� �ʹ� ���� �����ؼ� �����ͺ��̽� ������ ����߸��� �ǰ�
--�������� COMMIT �� ������ �ϴ� ���·� ����� �ŷ��� �߸��� ��� ROLLBACK �ؾ� �ϴ� �ŷ��� �ʹ� ������
--MMORPG ������ ���� �ŷ� ������ 1�ʿ��� ���ʹ� �ŷ��� �̷����
--�� ��� �߸��ż� rolback�ϰ� �Ǹ� �ʹ� ���� �ŷ� ��ҵ�
--�׷��� ������ �ð� �Ǵ� �ŷ��� �������� rollback�� �� �ִ� SAVEPOINT ���� ����

--�߰��� SAVEPOINT �̸�; �� �����ϸ� SAVEPOINT ������
--savepoint�� ROLLBACK �� ���� ROLLBACK TO �̸�; ���� ��

--empcopy ���̺��� empno�� 7499 ������ ����
DELETE FROM EMPCOPY
WHERE empno = 7499;

SELECT *
FROM empcopy;

--SAVEPOINT ����
SAVEPOINT s1;

--empcopy ���̺��� empno�� 7521�� �������� ename�� �¿����� ����
UPDATE EMPCOPY
SET ename = '�¿�'
WHERE empno = 7521;

--���ο� SAVEPOINT ����
SAVEPOINT s2;

--empcopy���̺��� empno�� 7788�� ������ ����
DELETE FROM EMPCOPY
WHERE empno = 7788;
--empcopy���̺� ���� ���� Ȯ��
SELECT *
FROM empcopy;
--���� ���� ������ 11�� 7521������ ename = �¿� ����

ROLLBACK TO s2;
--data ����(7788)
SELECT *
FROM empcopy;

ROLLBACK TO s1;
--data����(s2�� �Ҹ�, s2�ε� �� ���ư�)
SELECT *
FROM empcopy; --7521 ename �¿� ����, s2 �����ư�

ROLLBACK TO s2; --�Ұ���
--SQL Error [1086] [72000]: ORA-01086: savepoint 'S2' never established in this session or is invalid
--�� ���ǿ��� ����� ���� �ʾҴ�, �ѹ� �Ұ���

--�����ڴ� SELECT -> INSERT, DELETE, UPDATE -> COMMIT, ROLLBACK ->CREATE, ALTER, DROP
--���/������ : CREATE, ALTER, DROP -> GRANT, REVOKE -> COMMIT, ROLLBACK -> INSERT, DELETE, UPDATE, SELECT
--�м��� : SELECT

--sqlite�� �������࿡�� ���� �� ��
--devise(browser, smartphone --device �� sqlite�� �ӽ� ������ ����)
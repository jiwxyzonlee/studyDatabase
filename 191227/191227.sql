--**���� ����
--���̺��� �����͸� ������ �� �ݵ�� ���Ѿ� �ϴ� ����

--���� ������ �����ؼ� ������ ������ �� �Ǵ� ���
--dept���̺��� �⺻Ű�� deptno
--deptno�� �ߺ��� �� ���� null�� �� ����
INSERT INTO dept(deptno, dname, loc)
 VALUES(10, '����', '����');
--10���� �����ϱ� ������ ���� ���� �߻�(���� ���� ���� ���� �޽��� ���)

--1. ���� ���� Ȯ��
--�ڽ��� �����ϰ� �ִ� ��ü�� ���� ������ user_��üs ���̺� ����Ǿ� ����
SELECT constraint_name, constraint_type, table_name
FROM user_constraints;

--type�� 4����
--2. ���� ���� type
---1) P: primary key
---2) R: foreign key
---3) C: check, not null
---4) U: unique

--3. ���� ���� ����
CREATE TABLE ���̺��̸�(
    ���̸� �ڷ��� [constraint ���� ���� �̸�] ���� ���� ����,
    ���̸� �ڷ��� [constraint ���� ���� �̸�] ���� ���� ����,
     ...
    [constraint ���� ���� �̸�] ���� ���� ����(�÷� �̸�));
-->���� ���� �� �����ϴ� ���������� �÷����� ��������
-->���� ���� ���Ǹ� ������ ���߿� ����� ���������� ���̺� ���� �������� 
-->NOT NULL�� �ݵ�� �÷� ���� �������ǿ��� �����ؾ� ��

--4. �����ͺ��̽����� null ����
temp1 varchar2(10) NOT NULL,
--temp1: 10byte �Ҵ�޾� ���. NOT NULL�� ������ ���⼭ ũ�� ������
temp2 varchar2(10)
--temp2: NULL ���θ� �����ϱ� ���� 1����Ʈ�� �߰��� ����
---(11byte �Ҵ�޾Ƽ� ���)

--5. �ۼ�
--ȸ�� ���̺�
--email ���� 50�� �̳� ���� �Ұ��� - �⺻Ű
--pw ���� 15�� �̳� ������ ���� - �ʼ�
--nickname �ѱ� 10�� �̳��̰� ���� �Ұ��� - ����(�ߺ��Ұ���)

-->�÷����� ���������� �̿��ؼ� ���̺� ����
drop table member; ������ member ���̺��� �����ϸ� ����
create table member(
    email varchar2(50) primary key,
    pw char(15) not null,
    nickname varchar2(30) unique;
--varchar2�� ����Ǵ� �������� ũ�⿡ ���� ��������� ����
--char�� �� �� �����Ǹ� ����Ǵ� �������� ũ��� ������� ũ�� ����
--���� ����Ǵ� �����ʹ� char�� ����

--���� ����Ǵ� �����͸� varchar2�� ����� �Ǹ� �������� ũ�Ⱑ ����� ��
--���� ������ �����ϸ� row migration(�� ����)�� �����ؼ�
--�۾� �ӵ��� ������ ������ �� ����
   
   
--6. ���� ���� �̸�
--���� ���� �̸��� �����ϸ� ����Ŭ�� �������� �̸��� ���Ƿ� ������
--���� ������ �����ϰų� ������ �� �ڽ��� ���� �̸��� �ƴϱ� ������ ã�� �����
--��ó�� �������� �̸� ���� �����ϴ� �ͺ��ٴ� ���� ���� �̸��� �߰��Ͽ� �ۼ��ϴ� ���� ����

create table member(
    email varchar2(50) CONSTRAINT member_pk PRIMARY KEY,
    pw char(15) CONSTRAINT member_nn NOT NULL,
    nickname varchar2(30) CONSTRAINT member_uk UNIQUE;
 --���� ���� �̸��� ���� ���� ���������� ���̺� �̸��� ���� ���� ������ ���ļ� ����
SELECT constraint_name, constraint_type, table_name
FROM user_constraints;


--7.üũ ���� ���� ����
CHECK(�÷��̸� ����);
--������ �� �Ǵ� ���� ������ �Ѵ�.
gender varchar2(3) CHECK(gender IN ('��','��'))

--������ 0-100 ������ ���� ������ �Ѵ�.
score number(3) CHECK(score BETWEEN 0 AND 100)

--8. �ܷ�Ű ���� ����
--�÷� �������� ������ ��
REFERENCES ������ ���̺�(�θ����̺�)�̸�(������ �� �̸�) �ɼ�;

--�ɼ��� �����ϸ� �����ϴ� ���̺� �ִ� ���� �����Ǵ� ���̺��� ������ �� ����
--�ɼ��� �����ϸ� �θ� ���̺��� �ܷ�Ű�� ������ ���� ������ �� ����
--�ɼ��� 2����
---�ϳ��� �θ� ���̺��� ������ �� �ڽ� ���̺��� ���� �����ǵ��� �� �� �ְ�
ON DELETE CASCADE
---�ٸ� �ϳ��� ���� NULL�� �������ִ� ��
ON DELETE SET NULL

--�ܷ�Ű�� �����Ǵ� Ű�� �� ���̺��� PRIMARY KEY�̰ų� UNIQUE�̾�� ��
--�����ͺ��̽� �̷� å���� PRIMARY KEY�̾�� �Ѵٰ� ����
--���� �����ͺ��̽������� UNIQUE�� ������

--dept ���̺��� deptno�� 10�� �����͸� ����
SELECT *
FROM dept;

DELETE FROM DEPT
WHERE deptno = 10;
--error:
--SQL Error [2292] [23000]: ORA-02292: integrity constraint (SCOTT.FK_DEPTNO) violated - child record FOUND
--emp���̺��� �ɼ� ���� deptno�� �����ϱ� ������ emp���̺��� 10�� �����ϰ� ������ ������ �ȵ�
--dept���̺� ��ü�� ���� �ȵ�


--DROP TABLE member;

SELECT *
FROM member;

CREATE TABLE member(
email varchar2(100) PRIMARY KEY,
pw char(50) NOT NULL,
nickname varchar2(30) UNIQUE);

--������ ����
INSERT INTO member(email, pw, nickname) 
VALUES('ggangpae1@gmail.com', '1234', '����');
 
CREATE TABLE board(
num NUMBER(5) PRIMARY KEY,
title varchar2(100), 
content varchar2(1000), 
email varchar2(100) REFERENCES MEMBER(email) ON DELETE cascade);

INSERT INTO board(num, title, content, email) 
VALUES(1, '����', '����', 'jessica72@gmail.com');
--���� ����: email�� member���̺��� �̸����� �����ϴ� �ܷ�Ű�� ����
--MEMBER ���̺� ���� ���� ���� �Ұ�

INSERT INTO board(num, title, content, email) 
VALUES(1, '����', '����', 'ggangpae1@gmail.com');

--data ���� ���� Ȯ��
SELECT *
FROM board;

--member���̺��� email�� ggangpae1@gmail.com�� �����͸� ����
--board���̺��� �ܷ�Ű �ɼ��� ON DELETE CASCADE ->  board ���̺����� ������ ����

DELETE FROM member
WHERE email = 'ggangpae1@gmail.com';

SELECT *
FROM board;

--�θ� ���̺� ���� ���
DROP TABLE MEMBER;
--���� �߻��ϴµ� ���̺��� ������ �����ϰų� �����ϴ� ����� 
--�����͸� Ȯ������ �ʰ� ���̺� ������ ���踸 Ȯ���ؼ� ���࿩�� ����

--DROP TABLE board;


--9.default
--�����͸� �Է����� �ʾ��� �� �ڵ����� �����ϴ� ���� ������ �� ����ϴ� �ɼ�
--default���� ���·� ����

--regdate�� ���� ��¥�� �⺻������ ����
regdate DEFAULT SYSDATE

--readcnt ���� �⺻���� 0���� ����
readcnt DEFAULT 0

--10.���̺� ���� ���� ���� ����
--���� ������ �� ���� ������ �������� �ʰ� ���� ���� ������ �� �������� ���� ���� ����
--���������̸�(�� �̸�)�� ���·� ����
--�ܷ�Ű�� foreign key(�� �̸�) references �θ����̺��̸�(�� �̸�)�� ���·� ����
--�ݵ�� ���̺� �������� ���� ���� �����ϴ� ���
----: �⺻Ű�� �� �� �̻��� ���� ���� ��
CREATE TABLE board(
num NUMBER(5) PRIMARY KEY,
title varchar2(100), 
content varchar2(1000), 
email varchar2(100)
FOREIGN KEY(email) REFERENCES MEMBER(email) ON DELETE cascade);

--�⺻Ű�� �� �� �̻��� �÷����� ����� �Ǹ� �÷� �������� 2�� ���� primary key�� �����ؾ� �� -->error
--primary key�� ���̺� ���� �� �� 1���� ���� ����
id varchar2(10) PRIMARY KEY,
num number(5) PRIMARY KEY;
--->����

--���� id�� num�� ���İ� primary key�� ������� �ϸ� �̶� ��� ���� �����ϰ�
--�������� primary key(id, num)�� ���·� �����ؾ� ��

--11. ���� ���� ����
---1) ���� ���� �߰�
ALTER TABLE ���̺� �̸�
ADD [CONSTRAINT ���� ���� �̸�]
���� ���� ����(�� �̸�);

---2) ���� ���� ����
ALTER TABLE ���̺� �̸�
MODIFY ���̸� [CONSTRAINT ���� ���� �̸�] ���� ���� ����;
--NOT NULL�� �߰��ϴ� ���� add�� �ƴ϶� modify��
--NULL�� ������ ���¿��� NULL�� �Ұ����� ������ �����Ѵٰ� ����

---3) ���� ���� ����
ALTER TABLE ���̺� �̸�
DROP CONSTRAINT ���� ���� �̸�;


--12. ���� ������ ��Ȱ��ȭ
---1) ��Ȱ��ȭ
ALTER TABLE ���̺� �̸�
disable CONSTRAINT ���� ���� �̸�;

---2) Ȱ��ȭ
ALTER TABLE ���̺� �̸�
enable CONSTRAINT ���� ���� �̸�;
-->�׽�Ʈ �� �� ���� �̿�
--��) ȸ�����̺�
------ID, password, nickname �ʼ�
-->���� ������ �����ؼ� ���̵� �ߺ� �˻� �׽�Ʈ


--**���̺��� ������ ��ü
--1. View
--���� ����ϴ� select���� �ϳ��� �̸����� ������ְ� ��ġ ���̺��� ��ó�� ���
--������ ���̺�
---1) ��� ����
------�ӵ�: select������ ��û�� ���� �� �� ���� Ȯ���ؼ� return
---------view�� procedure�� ó�� �� �� �����ϰ� ���� �޸𸮿� ����� ���·� �����ؼ�
---------���� ȣ����ʹ� ����Ȯ���� ���� ����
------����: �� ����ڿ��� ��� �����͸� �Ѱ����� �ʰ� �ʿ��� �����͸� ������ �̸����� ����ϰ� ��
---------���� ���� �� �� ������ ��
---------procedure�� ���� ������ ���

---2) View�� ����, ����, ���ſ� ������ �ִ� ������ �Ұ����� �ƴϴ�
---View�� �����͸� �����ϸ� View�� ���� �� ����� ���� ���̺� �����Ͱ� ���Ե�

---3) ��������
CREATE [OR replace] VIEW ���̸�
AS
SELECT ����
[WITH CHECK OPTION]
[WITH READ ONLY]
-->OR REPLACE: VIEW�� �����ϸ� ����
-->VIEW�� ALTER VIEW ����� ��� ���������� �ȵ�
-->WITH CHECK OPTION �� SELECT ������ ��ȸ�� ������ ��쿡�� ����, ����, ���� ����
-->WITH READ ONLY�� �б� ����
--> �� ������� ���� ������ �� ��

---4) ����
DROP VIEW ���̸�;

---5) �ǽ�
--dept ���̺��� ��� ������ �����ؼ� tempdept��� ���̺� ����
CREATE VIEW tempdept
AS
SELECT *
FROM dept;

SELECT *
FROM tempdept;

--� ������ tempdept���̺��� deptno�� dname�� �ʿ��ϴٸ�
--���̺��� �ִ� ���� �ƴϰ� �並 ���� ����
CREATE OR REPLACE VIEW deptview
AS
SELECT deptno, dname
FROM tempdept;
-->deptview�� ���̺��� ��ó�� ��� ����
SELECT *
FROM deptview;
--������ deptview��� ���̺��� ����
--������ �ɼ� ���� �並 �����߱� ������ �信 ������ ����, ����, ���� ����
--�信 �۾��� �߻��ϴ� ���� �ƴϰ� ���� ���̺� �۾��� ������
INSERT INTO deptview(deptno, dname) 
values(11, '������');
--������ ���� ��� Ȯ��
SELECT *
FROM deptview;

--���� ���̺� ���԰�� ���ִ� �� Ȯ��
SELECT *
FROM tempdept;

--�並 ���� �� WITH READ ONLY ��� �ɼ��� �߰��ߴٸ� ������ ���Խ� ���� �߻�

---6) ���� ��
---2�� �̻��� ���̺��� JOIN �ؼ� ���� ��
---���� ��� WITH READ ONLY �ɼ��� ��� ����, ����, ���� �۾��� ������ ����
---���� ������ ALTER������ VIEW�� ��� �Ұ���
---DROP VIEW�� ����
---���� ���� �� CREATE OR REPLACE VIEW (�������)�� ���ؼ� ���� ����

--2. inline VIEW  (TOP-N)
---1) ����Ŭ�� rownum
---����Ŭ�� �ο��ϴ� �Ϸù�ȣ
---SELECT ������ �����ؼ� ����� ������ �� �������� �Ϸù�ȣ
---FROM������ where���� ������ �񱳸� �� �� �ӽ÷� �ο��ǰ� where�� ������ �����ϸ� Ȯ���Ǵ� ����
---� ���� �������� �� where���� ������ �����ϸ� rownum�� 1�� �����ؼ� ����
---where�� ���� �������� ������ ������ �� rownum�� ������ ���� ������ ������ ����

--student ���̺� ���� inline view ��� ���� ����� �˾ƺ���
--DROP TABLE STUDENT;
CREATE TABLE student(
name char(6), score NUMBER(5));

INSERT ALL
INTO student 
VALUES('��', 80)
INTO student 
VALUES('��', 90)
INTO student 
VALUES('��', 87)
INTO student 
VALUES('��', 91)
SELECT *
FROM DUAL;

SELECT *
FROM student;

--where�� ���� ��
SELECT rownum, name, score
FROM student;

--where�� ���� ��(���� ���� �ʿ�)
SELECT rownum, name, score
FROM STUDENT
WHERE score >= 90;
--where���� �� �������� ����
--������ '��'�� 90���� rownum 1���� �ǰ� 
--������ '��'�� 91���� rownum 2���� ��

SELECT rownum, name, score
FROM STUDENT
WHERE rownum <= 2;
--rownum 1, 2 �� return

SELECT rownum, name, score
FROM STUDENT
WHERE rownum > 2;
--�� ����
--�۴ٷδ� �� �� ������ ũ�ٷδ� ���� ����
--� �� �������� ���� ���� ������ �� �־ ���� ���� �� ������

SELECT rownum, name, score --3
FROM STUDENT --1
WHERE rownum <= 2  --2
ORDER BY score DESC; --4
--score �������� �װ� ������ �� �ƴ� rownum 2�� ������ ���� ���� ������ 2, 1 �Ųٷ� ����
--where�� ORDER BY���� ���� ����Ǳ� ������
--rownum�� �� �ٲ�
------------------> inline VIEW
--where���� ���� ���� �� �� �ִ� ���� from�ۿ� ����
--inline view�� from���� ����ϴ� select��(����Ŭ������)
--������ subquery

--student ���̺��� ���� ���� �� �� �������� �ؼ� rownum�� ���������� ��������
SELECT rownum, name, score  --3
FROM (SELECT * FROM STUDENT ORDER BY score DESC)  --1(��� �� ���� ���� �������� ����)
WHERE rownum <= 2;  --2(��ȣ �ű� �� 1, 2�� �߸���)

--rownum> 2 �� try
SELECT rownum, name, score  --3
FROM (SELECT * FROM STUDENT ORDER BY score DESC)  --1(��� �� ���� ���� �������� ����)
WHERE rownum > 2;  --2
--error(rownum�� return�� �� ��ȣ �Ű����� �����μ� ����ؼ� 1�� �ӹ��� �ִ� �� ���� ���� �� ����)

--���� > 2 �� �̾Ƴ� �� �ִ� ����(rownum�� �ٸ� ������ ġȯ)
SELECT rownum, name, score  --3(���� ������ rowname �ٽ� �ű��)
FROM (SELECT rownum rnum, name, score --(rnum�� �ϳ��� �÷�����)
    FROM (SELECT * FROM STUDENT 
        ORDER BY score DESC))  --1
WHERE rnum > 2;  --2(rnum����  2���� ū �� ������)
--������ ������ �� ����(������ ������ �ؿ� 3, 4 ����)

--�ٸ� ���̵��(������ �̾ƿ���) ����¡ ó��
WHERE rnum >= 1 AND rnum <= 10 --1���� 10�ʱ��� ������ �̾ƿ���
WHERE rnum >= 11 AND rnum <= 20 

---2) inline VIEW
---from���� �ۼ��� select����
---3) ����Ŭ���� �����͸� page���� �Ǵ� topN ������ �� ���
---4) ����
SELECT �ʿ��� �÷��̸� ����
FROM (SELECT rownum ����, �÷��̸� ���� 
    FROM(SELECT �ʿ��� �÷��̸� 
        FROM ���̺��̸� 
        ORDER BY ���ϴ� �÷����� ����)
WHERE ������ ������ ������ ���� �Ǵ� ������ �ۼ�;

---5) emp���̺��� �Ի����� ���� ���� ��� 5���� �̸��� �Ի���
------adams, scott, miller, ford, james
SELECT ename, hiredate --, rnum--(������ó�� ���������) 
FROM (SELECT rownum rnum, ename, hiredate 
    FROM(SELECT rownum, ename, hiredate 
        FROM EMP 
        ORDER BY hiredate desc))
WHERE rnum > = 1 AND rnum <= 5;

-----�� ���� �������� ���� 5��
SELECT ename, hiredate--, rnum--(������ó�� ���������)
FROM (SELECT rownum rnum, ename, hiredate 
    FROM(SELECT rownum, ename, hiredate 
        FROM EMP 
        ORDER BY hiredate desc))
WHERE rnum > = 6 AND rnum <= 10;
----------------------------------------->�Ź����� ���� ����



--TO_DATE ����Ÿ�� SQL����
SELECT TO_DATE('20191201151212','YYYYMMDDHH24MISS') AS ONE
           ,TO_DATE('20191201091212','YYYYMMDDHHMISS') AS TWO
           ,TO_DATE('2019120115','YYYYMMDDHH24') AS THREE
           ,TO_DATE('2019','YYYY') AS FOUR
FROM DUAL;


--**SEQUENCE
--����Ŭ�� �����ϴ� �Ϸù�ȣ ������ ���� ��ü
--�⺻Ű�� �����ϴ� ���� �ָ��� ��� �������� �̿��ؼ� �����ϴ� ��찡 ����
--1. ����
CREATE SEQUENCE ������ �̸�
    [START WITH ���۹�ȣ]
    [INCREMENT BY ����]
    [MAXVALUE �ִ� | nomaxvalue]
    [MINVALUE �ּڰ� | nominvalue]
    [CYCLE | nocycle]
    [cache | nocache]

--START WITH �� ���U�ϸ� ������ ���������� 1�ε� ������ ������ 1�� �ƴ� ���� ����
--increment by�� �����ϸ� 1
--maxvalue �����ϸ� 10^27
--minvalue �����ϸ� 1
--������ ���ڿ� ������ �� �� ó�� ���ڷ� �̵����� ���θ� cycle�� ������ �� ������
-- nocycle�� �����ϸ� ������ ���� �������� ���� �߻�
-- cycle�� �����ϸ� primary key�� ����� �� ����
--�⺻�� nocycle
--cache�� ������ �� �޸𸮿��� ������ �������� ���η� �⺻�� nocache

--2. �� ���

--���� ������ ��
������.nextval   

--���� ������ ��
������.currval 
--nextval �� ���̶� ȣ���� �Ŀ� ����ؾ� ��(otherwise error)

--3. ������ ����
ALTER SEQUENCE �������̸�
�ɼǴٽ� ����
--> start with�� ������ �� ����

--4. ������ ����
DROP SEQUENCE �������̸�;

--5. �ǽ�
--1���� 1�� ���� ������
CREATE SEQUENCE boardseq
START WITH 1;

--������ ������ Ȯ��
SELECT boardseq.nextval
FROM dual;

-- ���� ������ Ȯ��   --(nextval �� �� �� ����)
SELECT boardseq.currval
FROM dual;

--������ ����
DROP SEQUENCE boardseq;

--6. �����ͺ��̽� ���� ���α׷��ֿ����� SEQUENCE ��ſ� ���� ū ���� ã�Ƽ� +1 �ϴ� ��쵵 ����
--�Ϸù�ȣ�� ���� �� �� sequence�� ���� ���� �ƴ�


--**index
--�����͸� ������ ��ȸ�ϱ� ���� ������
--å���� Ư�� é�͸� ������ ���� ���� å����
--�����ͺ��̽� ������ ���� ���� ��� ��������
--����Ŭ =>  B*Ʈ�� --b�� balance, ����Ʈ��
--�ε����� ����ϸ� ������ ��ȸ�� �� �ִٴ� ������ ������ �ε�����ƴ �޸� �Ҵ� �ʿ�
----�����̳� ���� �� ���� �۾��� �߻��ϸ� �ε��� �������� ���� �ӵ� ���� �߻� ���

--�迭: ũ�� ����
--���������� ����

--����Ʈ: ũ�� ����
---list�� �����ؾ� tree�� ������ �� ����
---*linked list: �����Ϳ� ���� �����͸� ����Ű�� �����͸� ���� �ڷ�
------------------>��ǻ�Ϳ��� ���� ���� ���� ���� ���� ��
---����Ʈ�� �迭�� ����� ����Ʈ: array list
-----������ �շ� �־ �����ϵ� ��� �߰� ����. �߰��� �� �ո��� ������ ��ܼ� �޲�
--ARRAY list
-----*stack
-----Queue
-----Deque
-----�� ������� ���� �̸��� Ư¡�� �˰� �ֵ��� =>����

--array list ���� ������ ���ܳ�  linked list

--data, ���� data ��ġ
--10, 40, 30
--head, --
--head, (3000����)(���� ������ �ּ� ����)
--10(3000��°), (700����)
---------10, (2700��°) <<--�̷����̸� 40 �������� �ɷ� ����(������, �罽 ����)
---------��) �����뿡 ������, ������ ����, ������ �����ϱ�<<<���� ����
--40(700����), (2700����)
--�����͵鸸 ���� 
--�뷮 ū ����1 �� ����� �ͺ��� �뷮 ���� ���� 50�� ����� �� �ӵ��� �� ���� ����
--30(2700��°), nil

--double linked�� ��������
--python �Լ� reverse(���� �������� �� �� �ְ� �ݴ�� �� ���� �ִٸ�)
--���̽��� ����Ʈ�� ����ũ�� ����Ʈ��
--�ڹٴ� �� ����,,,
--���̽��� ����Ʈ�� ���� �Ǵ� ���ٰ� �������� ��
--���̽��� ���� ����
--�������α׷��� ���̽����� ���� �� ����(����!)
--�뵵���� �� �ִ� �ڹٰ� �� ȿ��������
--Ʈ���� ����ũ�� ����Ʈ�� ���� ���� ������ �̾��� �ִٰ� �����ϸ� ��(����ũ��� ���θ� ����)
-----���ϰ��� ����(�θ�-�ڽ�) ��) ����Ž���� �� ��

--B tree
--: (�����͸� ����ų �� �ִ�)�������� 1/2�̻� ä���� Ʈ��
--B* tree
--: 2/3 �̻� ä���� Ʈ��

--**index
--�����͸� ������ ��ȸ�ϱ� ���� ������
--å���� Ư�� é�͸� ������ ���� ���� å����
--�����ͺ��̽� ������ ���� ���� ��� ��������
--����Ŭ =>  B*Ʈ�� --b�� balance, ����Ʈ��
--�ε����� ����ϸ� ������ ��ȸ�� �� �ִٴ� ������ ������ �ε�����ƴ �޸� �Ҵ� �ʿ�
----�����̳� ���� �� ���� �۾��� �߻��ϸ� �ε��� �������� ���� �ӵ� ���� �߻� ���

--���� ������ Ʈ���� �̿��Ѵ�
--�̰��� ��������� ū �ڷᰡ �ְ� �ٸ� ���� ��������� ���� �ڷᰡ �ִ�.
--������� �ڷḦ �����? ==>Ʈ���� �ٽ� ������ ��(�ε��� �����۾�)
--��������� �� ������ ���� ���ͼ� ������� �ٲ� �ε��� �����۾�
--�ε��� �۾����� ���� ã�� ���� ������ ����,����, ���� �۾����� ���� ������ 
--�б⺸�� ����, ����, ���� �۾��� ���� �Ѵٰ� �׷��� �ε����� �������� ���� ����

--stack �������̽�? ���� �������� ���� �� ���� ���� ����
--queue ���Ǳ� FIRST IN FIRST OUT
--deque ���ε� ���� �Ʒ��� ��(��ġ�� �ø��� �� �ڷ� ������� �Ʒ� �ڷ� ���ܳ�)

--1. �ε��� ����
CREATE INDEX �ε��� �̸�
ON ���̺��̸�(�÷��̸�);

--2. �ε��� ����
DROP INDEX �ε����̸�;

--> BLOB�� CLOB�� LOB �迭�� �ε��� ���� �Ұ�
---������ ũ�Ⱑ ũ�� ������ �ε��� ������ �δ��� �ʹ� Ŀ�� �ε��� ���� ���� �� ��

--3. �ε��� �����ؾ� �ϴ� ���
--���� ������ �ʹ� ���� ��
--Ư�� ���� where������ ���� ���� ��
--null�� ���� ��
--join�� ���� ���Ǵ� ��
--�˻��� �� ��ü �������� 2-4% ���� �˻��� ��

--4.�ε��� �����ϸ� �ȵǴ� ���
--���� ������ �ʹ� ���� ��
--����, ����, ���� �۾��� ����� �߻��� ��
--�˻� ����� ��ü �������� 10%�̻��� ��

--5. PRIMARY KEY�� UNIQUE �Ӽ��� �����ϸ� �ڵ����� �ε��� ����



--**���Ǿ�(synonym)
--�����ͺ��̽� ��ü�� ������ ���̴� ��
--1. ����
CREATE synonym ����
FOR �����̸�;
--2. ����
DROP synonym ����;
--�����ͺ��̽��� ���α׷��� ������ ��  ������ ����ϸ� �������� ����

--**stored PROCEDURE
--���� ����ϴ� SQL������ ���α׷��� ����� �Լ�ó�� �ϳ��� �̸����� �����ΰ� �� �̸��� �̿��ؼ� sql���� ����
--1. ����
--SQL ������ �����ϴ� �ͺ��ٴ� ���� �ӵ��� ������ ������ ����
--2. ����
CREATE [OR replace] PROCEDURE ���ν����̸�(�Ű����� �̸� [MODE]�ڷ���, ...)
IS
�������� ����
BEGIN
	������ sql����
END;
/  -->DBeaver������ ������ ������ �����ؾ� ��
----OR REPLACE�� ������ �� ���
----MODE�� IN, OUT, ������ ����
---------IN: �Է��� ���� �Ű�����
---------OUT: ����� ���� �Ű�����
----�ڷ����� �ۼ� �� ���� �ڷ����� �ۼ��ص� �ǳ� ���̺��̸�.���̸�%TYPE ���� �ٸ� ���� �ڷ��� �̿� ����
--SQL �ۼ��� ���� �������� �ݵ�� ';' ������ �ʴ� �� ����

--3. ���ν��� ȣ��
---1) sqlplus: EXECUTE ���ν����̸�(�Ű�����);
---2) DBeaver, sqldeveloper
BEGIN
	���ν����̸�(�Ű�����);
END;

--4. ���ν����� ����� ������ ������ �����ͺ��̽� �������� �ٸ�
--����Ŭ�� ���ν��� ����� ������ PL/SQL�̶�� ��

--5. ���ν��� ����
DROP PROCEDURE ���ν��� �̸�;

--6. �ǽ�
--deptno, dname, loc�� �Է¹޾Ƽ� dept ���̺� �����͸� �����ϴ� ���ν��� ����� ȣ��
CREATE PROCEDURE insert_dept(
    vdeptno dept.deptno%TYPE,   ---�Ű����� �״�� ���� ����(���̽� self ������)
    vdname dept.dname%TYPE,
    vloc dept.loc%TYPE)
IS --�������� �ʿ������ ����
BEGIN
	INSERT INTO dept(deptno, dname, LOC)
	 values(vdeptno, vdname, vloc);
END;
--/(DBeaver�� �ƴ� �� �����ñ��� ���Խ������ ��)

---2)���ν��� ����
--�����ƴ��� �� Ȯ���غ��� ��(���� �߻� ���� Ȯ��)
BEGIN
	insert_dept(23, '�ѹ�', '����');
END;
--NO error!
--error �߻��� ���� ����schemas-SCOTT-Procedures �� declaration���� Ʋ�� �κ� Ȯ��
----���� �ٽ� ���ƿͼ� �����ϰ� ���ν����̸� ������Ŭ��-���ΰ�ħ �� �ٽ� ����

--�� �پ��⵵ ����
BEGIN insert_dept(22, '�ѹ�', '����'); END;

---3)Ȯ��
SELECT *
FROM dept;
--22�� �ѹ� ���Ե��� �� �� ����

---4) ���ν��� ����
DROP PROCEDURE insert_dept;

--**TRIGGER Ʈ����
--���̺� �����͸� ����, ����, ������ �� �۾� ���Ŀ� �ٸ� �۾��� �����ϵ��� �ϴ� ��ü
--�۾� ���� �����ϴ� ������ ��ȿ���� �˻� �� ��ȿ�� �˻翡 ������ ��� �۾��� �������� �ʱ� ���ؼ���
--�۾� �Ŀ� �����ϴ� ������ �۾��� �ϰ� �ٸ� �۾��� ���������� �����ϱ� ���ؼ���
--���α׷��ֿ��� �̿� ������ �������� ���Ϳ� AOP�� ����
--������ �۾��� �����ϰ� �α׸� ����ؾ� �ϴ� ���

--���� �����ؾ� �� �۾� => ����Ͻ� ����
--�α׸� ����ϴ� ��ó�� ���� �۾��� �ƴϳ� ������ �ؾ� �ϴ� �۾� => ���� ���� ����
--����Ͻ� ���� ���� ���� �� ���� ���� ���� ������ ���� �Ϲ� �ڵ�� �ۼ��ϰ� �Ǹ�
--==> ����Ͻ� ���� ����
--==> ���� ���� ���� ����
--�����ͺ��̽������� Ʈ���Ÿ� �̿��ؼ� ����Ͻ� ������ �����ϸ� ���� ���� ������ �ڵ����� �����ϵ��� �ϰ�
--����Ͻ� ���� ��� �����ڰ� ����Ͻ� ���� ���߿��� ������ �� �ֵ��� ����

--sqlite������ �ܷ�Ű�� �����ϰ� ON DELETE CASCADE �ɼ��� �����ص�
--�θ����̺��� �����Ͱ� ������ �� �ڽ� ���̺��� �����Ͱ� ���������� �������� ����
--�̷� ��쿡�� Ʈ���Ÿ� �̿��ϸ� �θ� ���̺��� �����Ͱ� ������ �� �ڽ� ���̺��� �ڵ����� �����ǵ��� ���� ����

--1.trigger ����
CREATE OR REPLACE TRIGGER Ʈ�����̸�
[BEFORE | AFTER] [ INSERT | UPDATE | DELETE] ON ���̺��̸�
[FOR EACH ROW]
[WHEN ����]
BEGIN
	������ ����
END;
--FOR EACH ROW�� ���� ���� �࿡ UPDATE, DELETE, INSERT�� �߻��� �� Ʈ���Ÿ� ���� �� �����Ű�� �ɼ�
--���� �� ���� ���� �࿡ �۾��� �߻��ص� Ʈ���Ŵ� �� ���� ����
--�۾� �ϳ����� �ϰ� ������ FOR EACH ROW �ϴ� �Ű� �װ� �ƴϸ� ���� ����
--when�� ���� �����ϰ� ������ �´� ��쿡�� �����ϰ� �� ���� �ְ� �������� �ʰ� �� ���� ����

:OLD.�÷��̸�, :NEW.�÷��̸�
--OLD�� ���� ������
------DELETE���� �����Ǵ� �������� ��
------UPDATE���� ����Ǳ� ���� �������� ��
------INSERT������ ��� �Ұ�
--NEW�� ���� ���ԵǴ� ��
------UPDATE�� INSERT���� ���

--������ ���� �ڸ��� raise error �ڵ� �Է�
raise_application_error(�����ڵ��ȣ, �޽���);
--�۾� �������� �ʰ� ���� �޽��� ��� (python raise ���� �ų�)

--raise_application_error ����
WHEN �������� �ð����� Ȯ��
raise_application_error(�����ڵ��ȣ, �޽���);
--�������� �ð��� INSERT �Ͼ�� �ʵ���

--�����ڰ� �Ǹ� Ʈ���� ���� ���
--������ Ʈ���� �ð� ����, ���̽� ����, BLOB
--TRIGGER
--������ �����ͺ��̽������� ���̺� ����, ����, ���� �۾��� �߻����� �� �۾� ���̳� �Ŀ� �ٸ� ������ �����ϵ��� �ϴ� ��
--�۾� ���� �ϴ� ������ ��ȿ�� �˻��ؼ� ��ȿ�� �˻翡 �������� �� �۾��� �������� �ʵ��� �ϱ� ���ؼ��� ��찡 ����
--�۾� �Ŀ� �ϴ� ������ �ϳ��� Ʈ��������� ������ �ϴ� �۾��̳� �α׸� ����ϴ� ��찡 ����.

--1. ���̺� �����Ͱ� ���Ե� �� ������ ���� �ð��� ���Ե� �������� �⺻Ű�� �ٸ� ���̺� ����
--dept ���̺� �����͸� �����ϸ� ���
---1)����� ���̺� ����
CREATE TABLE deptlog(
            deptno NUMBER(2) PRIMARY KEY,
            inserttime date);

--table Ȯ��
SELECT *
FROM deptlog;

---2)Ʈ���� ����
CREATE OR REPLACE TRIGGER tri_01

----dept ���̺� �����͸� ������ ��
----(���� ���� ���۽�Ű�� ������  after ��ſ� before ���)
----insert ��� update, delete ��� ����
AFTER INSERT ON dept

----�Ѳ����� ���� ���� �࿡ �۾��� �߻��� �� �۾��� �������� �ƴϸ� ��ü �ѹ��� �������� ����
----for each row�� �� �� ����, �׷��� ���� ���� ����
FOR EACH ROW
BEGIN
	INSERT INTO deptlog(deptno, inserttime) 
	    --���� �Է�: :new.
	    --���������� ������: :old. (���� ������ ������ ���� ���)
	VALUES(:NEW.deptno, sysdate);	        
END;
--/(DBeaver�� �� �ʿ� ����)

--�� �� ������ ctrl+enter �׳� �� �԰� script �����ؾ� ��
--procedure�� TRIGGER ���� ��
--plsql�� ���������� �߸� ���� �����
--�׷��� ����� ����������� �� Ȯ���ؾ�

--Ȯ���� ���� dept���̺� ������ ����
INSERT INTO dept(deptno, dname, LOC) 
VALUES(73, '����', '�̴�');

--TABLE Ȯ��
SELECT *
FROM deptlog;
--deptlog�� ���� �����͸� ���� ���� ������ ����� ��
--���) ���� ������ ���� �� ��ϵ� �ð� �̿�
--����, ����, ���� �� �α״� �� ����� �ξ��


--2. Ʈ���Ÿ� �̿��ؼ� ��ȿ�� �˻�
--�۾��� ���� �ʵ��� ���ִ� �ڵ�
raise_application_error(�����ڵ� ��ȣ, ���� �޽���)

--emp���̺��� sal�� ���� ���� ������ ���� �����δ� �������� ���ϵ��� Ʈ���� ����
CREATE OR REPLACE TRIGGER tri_02
BEFORE UPDATE ON emp --�����ϴ� ���̹Ƿ� UPDATE
FOR EACH ROW WHEN(NEW.sal < OLD.sal) --����(or�� and �ٿ��� ���� ���� ����)
     -------------when�� �� ���� : �� ����
BEGIN
	raise_application_error(-20500, 'sal�� ���� ������ ���� ����');
    --����Ŭ ���� �ڵ�� ��ĥ ���� �����Ƿ� ������ ���ִ� ����
END;

--TABLE Ȯ��
SELECT *
FROM emp;

--���� ����
UPDATE emp SET sal = 900 WHERE ename = 'SMITH';

--���� ���� �Ұ���(���� Ȯ���غ���)
UPDATE emp SET sal = 800 WHERE ename = 'SMITH';
--SQL Error [20500] [72000]: ORA-20500: sal�� ���� ������ ���� ����
--ORA-06512: at "SCOTT.TRI_02", line 2
--ORA-04088: error during execution of trigger 'SCOTT.TRI_02'
--org.jkiss.dbeaver.model.sql.DBSQLException: SQL Error [20500] [72000]: ORA-20500: sal�� ���� ������ ���� ����
--ORA-06512: at "SCOTT.TRI_02", line 2
--ORA-04088: error during execution of trigger 'SCOTT.TRI_02'


--Ư���� �ð��� �۾� ���ϵ��� �ϱ�
BEGIN
	IF TO_NUMBER(TO_CHAR(SYSDATE, HH24)) NOT BETWEEN 9 AND 18 THEN
	--��ħ 9�ú��� ���� 6�ñ����� �����ϵ���, ���� ������ ����
	   raise_application_error(-25001, '9�ÿ��� 18�ñ����� �۾��� �����մϴ�')
	END IF;
END;


--����� ��������� SYS�� SYSTEM���� �α����ؾ� ��
--SCOTT���δ� ���� �Ұ�
--�ý��� ������ ����ڿ� ���� ��
--������ ������ ��ü�� ���� ����ڰ� �� �� �ִ� �۾� ����
--����� ���� ������ ���α׷����� �����ϴ� ��찡 ����

--����� ����
CREATE USER user_name
IDENTIFIED BY password;

--�ý��� ���ϴ� �ַ� DBA�� �ο�

--���� �ο�
GRANT system_privilege1[, system_privilege2, ]
TO user_name1[, user_name2, ]
[WITH admin OPTION];
--WITH admin OPTION: ���ѵ��� �ٸ� �����鿡�� �ο������ϵ���

--�ý��� ���� ����
SELECT *
FROM SYSTEM_PRIVILEGE_MAP;

--SCOTT���� CREATE ROLE������ �ο�
GRANT create role TO scott;

--���� ���
REVOKE system_privilege1[,system_privilege2, . . . .] | role1[,role2, . . . .]
FROM {user1[,user2, . . . .] | role1[,role2, . . . .] | PUBLIC}; 

--system_privilege �ý��� ����
--user_name ����� ��
--WITH ADMIN OPTION ���� �ý��� ������ �ٸ� ����ڿ��� �ο��� �� �ִ� ����

--A�� B���� ������ �ο��ߴµ� A�� ������ ����Ѵٰ� B�� ���ѵ� ��ҵǴ� ���� �ƴ�

--DBA�� �Ϲ������� �ý��� ������ �Ҵ�
--��ü�� ������ ��� ����ڴ� ��ü ������ �ο� ����
--WITH GRANT OPTION���� �ο� ���� ������ �ο��ڿ� ���� �ٸ� ����ڿ� ROLE���� �ٽ� �ο�����

--OBJECT ������ ����
SELECT *
FROM table_privilege_map;

--��ü ���� �ο�
GRANT select, insert ON emp TO user_name;

--��ü ���� öȸ
 Syntax
REVOKE {object_privilege1[,object_privilege2, . . . . .] | ALL}
ON object_name
FROM {user1[,user2, . . . .] | role1[,role2, . . . . .] | PUBLIC}
[CASCADE CONSTRAINTS];
--CASCADE CONSTRAINTS
--REFERENCES������ ����Ͽ� ������� ��ü�� ���� ���� ���Ἲ ���� ������ �����ϱ� ���� ����Ѵ�.


REVOKE select ON emp FROM unser_name;

--ROLE
-- ����ڿ��� �㰡�� �� �ִ� ���õ� ���ѵ��� �׷����� ROLE�� �̿��ϸ� ���� �ο��� ȸ���� ���� 
CREATE ROLE role_name;
CREATE ROLE level1;


--**����� ����
--express�� xe(���������ͺ��̽���)
--enterprise�� orcl

--oracle�� �ƴ� �ܼ� â�� �ٷ� ħ
exp userid=���̵�/��й�ȣ@���������ͺ��̽��� file=������
exp userid=system/��й�ȣ@���������ͺ��̽��� full=y file=c:\dump.dmp

--system �������� scott ������ �ִ� DB���
exp userid=system/��й�ȣ@���������ͺ��̽��� owner=scott file=c:\dump.dmp
--�ڱ�� ����� �� owner �� ��
--scott�������� �ڽ��� ��� ������ ���
--dos>exp userid=scott/��й�ȣ@���������ͺ��̽��� file=c:\dump.dmp

--**����(Import)
imp ���̵�/��й�ȣ@���������ͺ��̽��� file=������
--system�������� ��ü ����
imp system/��й�ȣ@���������ͺ��̽��� file=c:\dump.dmp
--system �������� scott ������ �ִ� DB����
imp system/��й�ȣ@���������ͺ��̽��� fromuser=scott touser=scott file=c:\dump.dmp

--scott�������� �ڽ��� ��� ������ ���
imp scott/��й�ȣ@���������ͺ��̽��� file=file=c:\dump.dmp
--�����ϰ����ϴ� DB�� ���� �̸��� Object�� ������,������ �����ϰ� �ǳ� ��� ������ ignore �ɼǻ��
imp ���̵�/��й�ȣ@���������ͺ��̽��� file=c:\dump.dmp ignore=y


--**����Ŭ ���̽� ����
--Python���� �����ͺ��̽��� �������ϱ� ���ؼ� Python DB API�� ����� �� �ִ�. 
--ORM (Object Relational Mapping)
--Django ORM, PonyORM, peewee ���� ORM ����� ����� ������ �������� ����
--���̽��� �������� ����(�׼����� �� �ִ� ����� �ſ� �پ�)

--**���̽㿡�� �����ͺ��̽� ����
--1. ǥ�� API�� �̿��ϴ� ���
--2. pandasó�� �ڷᱸ���� �����ϴ� ��Ű�������� �����ͺ��̽��� ���� ������� ����
--3. ORM(Object Relational Mapping)
----: ������ �����ͺ��̽��� ���̺�� ��ü�� �ϴ��Ϸ� ���ν��Ѽ�  SQL���� �����ͺ��̽� ���
----(���̽���) Django �����ӿ�ũ���� ����
----java�� hibernate, android�� content VALUES, iOS������ Core Date ���� ORM ����

--**����Ŭ ���(���̽㿡��)
--1. cx_Oracle�̶�� ��Ű���� �̿�
---1) ��Ű�� ��ġ
pip install ��Ű�� �̸�
pip install ��Ű�� �̸� --upgrade  (���׷��̵�)
pip install ��Ű�� �̸� = ���� (Ư�� ���� ��ġ)

--C, VC++, SPSS�� ���׷��̵�� ����ȸ�翡�� ����
--���¼ҽ� Java: Maven Gradle���� �����ؼ� ����(�۽���� �ɻ�� ���� ����)
--���� ���� ������ �� python�̳� R�� CRAN(������ library ���� �ڵ�+���� ���ε�)
--�ֽ� ���� �� �д� ��쵵 �ֱ� ������ �ٿ�׷��̵��� �� Ư�� ���� ��ġ
--�ѱ��� �ƴ� �̻� �밳 pip�� install
--�ý��� �Ӽ�-���-ȯ�溯��-path
--(install�� path üũ�� ����: pip����� �ܼ� �ƹ� �������� ����� �� �ֱ� ���ؼ�)

---2) pip ���׷��̵�
python -m pip insatll --upgrade pip

---3) pip ��� ������ �߻��ϴ� ���
-----: pip command�� ���ٰ� ������ ���
-----: python�� ��ġ���� �ʾҰų� python ��ɾ� ���丮�� path�� �߰����� ���� ���
-----: windows�� ��� VC++�� ��Ű���� ����� ���, VC++ ����� ��Ű���� ��ġ�ؾ߸� ��ġ�Ǵ� ��Ű�� ����

---4) ��������̳� ������� �� ���������� ��ġ
----- �ٿ�ε尡 ������ ������
pip download ��Ű���̸� (���� ���� ��ǻ�Ϳ� �ٿ�ε�)
----- �ٿ�ε� ���� ���ϵ��� ������ ��
pip install ���ϸ� (���� ��ġ)
----- �̶��� �ڵ����� ���ӵ� ��Ű���� ��ġ������ �ʱ� ������ ���� �ϳ��ϳ� ������� ��ġ�ؾ� ��
----- �ٸ� ��Ű���� �ʿ��ϸ� � ��Ű���� ���ٰ� ���� �߻�, �޽����� �����鼭 �ؾ� ��

--2. �ܺ� ��� ��������
---1)
import ����̸�
--��� �̸��� �ش��ϴ� ����� ����̸����� ��� ������
import numpy
--numpy�� �ִ� �͵��� numpy.�̸����� ����ؾ� ��

---2)
FROM ����̸� import ��� ���� ��ҵ��� ����
--����̸��� �ش��ϴ� ��⿡�� import �ڿ� �ִ� �͵��� ���� ��⿡ ���Խ��Ѽ� ������

--��)
import pandas
pandas.DataFrame()

FROM pandas import DataFrame
DataFrame()

---3)
FROM ����̸� import *
--����̸��� �ش��ϴ� ��� ��� ���ο�Ҹ� ���� ��⿡ ���Խ��� ������

---4)
import ����̸� AS ����
--����̸� ��ſ� ���� ���
--���� ���� ���

--��)
import pandas AS pd
--pandas ��ſ� pd��� �̸�(����) ���
import numpy AS np
--numpy ��ſ�  np��� �̸�(����) ���

--3. ���̽㿡�� ����Ŭ ����
import cx_Oracle

#���� ���� �����
����1 = cx_Oracle.makedsn('ip�ּ�', '��Ʈ��ȣ', '�����ͺ��̽� �̸�')

#����
����2 = cx_Oracle.connect(USER = '����', password = '��й�ȣ', dsn = ����1);

#���� ����
����2.close()
##close()�� ���� ������ �� ��! --file, network, database ������ �ݵ��

--4. ������ �����ͺ��̽� ���� �� tuple ���, NoSQL ���� �� dict ���

--5. insert, delete, update
---���� ��ü�κ��� cursor�� ������
cur = ����2. cursor()

---> cursor�� �̿��ؼ� sql����
cur.exeute('sql ����')
cur.execute('�Ű������� �̿��� sql���� �ۼ�', (�Ű������� �ش��ϴ� ������ ����))
----�ι�° ��� ����

---> �۾� �Ϸ��
cur.commit()

--6. �۾� ���� ���� �߻�
---���� �޽����� ORA�� �����ϸ� �̰� ����Ŭ ���ӿ����� sql������

--dept���̺� ����

--�Ű����� ���� ����
CURSOR = con.cursor()
CURSOR.execute("insert into dept(deptno, dname, loc) values(51, '�ѹ�', '����')")
con.commit()

--python �Է� ������ �Ʒ��� ����(Macafree ��ȭ�� ���� �ؾ� ��)
import cx_Oracle
import sys
try:
    #�����ͺ��̽� ���� ���� ����
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #�����ͺ��̽� ���� ��ü ���� - ����
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #�����ͺ��̽���  ������ ���� �� �ִ� ��ü ����
    cursor = con.cursor()
    #���� ����
    cursor.execute("insert into dept(deptno, dname, loc) values(51, '�ѹ�', '����')")
    #�۾��� ������ ������ �ݿ�
    con.commit()
    #SQL ���� ����
    cursor.execute('select * from DEPT')
    print('���� ����')
    #SQL TABLE Ȯ��
    print(cursor.fetchall())
except Exception as e:
    print('exception', e)
finally:
    con.close()

--db table Ȯ��
SELECT *
FROM dept;
--51 �ѹ� ���� �� ���� �� �� ����

--7. �Ķ���͸� �̿��� ����
---SQL ������ ���� ��:
---��ȣ ���·� �Ű������� ����� �� ��° �Ű�������: ��ȣ �ڸ��� ���ε� Ʃ���� �����ϴ� ������� ������ ����
cursor = con.cursor()
cursor.execute("insert into dept(deptno, dname, loc) values(:1, :2, :3)", (53, '�񼭽�', '�λ�'))
con.commit()
---> �����ϴ� ������ �̿��ϸ� �����͸� �Է¹޾Ƽ� ����ϴ� ���� ��
---> python editor�� insert������ �ٲ��ָ� ��

--�Է°����� �ٷ� �ֱ�
deptno = input("�μ���ȣ")
dname = input("�μ���")
loc = input("����")

--���� ���(����ǥ �Ű� �� �ᵵ ��)
cursor.execute("insert into dept(deptno, dname, loc) values(:1, :2, :3)", (int(deptno), dname, loc))
--�Ϲ� ���
--cursor.execute("insert into dept(deptno, dname, loc) values(" + deptno + ",'" + dname + "','" + loc + "')')


--deptno�� dname, loc�� �Է¹޾Ƽ� deptno�� �ش��ϴ� �������� dname�� loc ����
--python idle editor �Է� ����

import cx_Oracle
import sys
try:
    #�����ͺ��̽� ���� ���� ����
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #�����ͺ��̽� ���� ��ü ���� - ����
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #�����ͺ��̽���  ������ ���� �� �ִ� ��ü ����
    cursor = con.cursor()

    #������ �Է¹ޱ�
    deptno = input('�μ���ȣ: ')
    dname = input('�μ���: ')
    loc = input('����: ')

    #���� ���� ����
    cursor.execute('update dept set dname = :1, loc = :2, where deptno = :3',
                   (dname, loc, int(deptno)))

    #�۾��� ������ ������ �ݿ�
    con.commit()
    #SQL ���� ����
    cursor.execute('select * from DEPT')
    print('���� ����')
    print(cursor.fetchall())
except Exception as e:
    print('exception', e)
finally:
    con.close()

    
--**������ �б�
--execute������ ������ cursor ��ü�� fetchall�̶�� �޼ҵ带 ȣ���ϸ� select�� ����� Ʃ���� Ʃ�÷� �������
--fetchone�̶�� �޼ҵ带 ȣ���ϸ� 1���� Ʃ�÷� return
import cx_Oracle
import sys
try:
    #�����ͺ��̽� ���� ���� ����
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #�����ͺ��̽� ���� ��ü ���� - ����
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #�����ͺ��̽���  ������ ���� �� �ִ� ��ü ����
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #������ �б�
    #1�� ������ ��������
    data = cursor.fetchone()
    #�ҷ��� ������ �ɰ��� ����
    for imsi in data:
        print(imsi)
        
    #�۾��� ������ ������ �ݿ�(�б� ���� ��� ��)
    #con.commit()
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
--��ü ������ (Ʃ�÷�) �����ͼ� ����(fetchall())
import cx_Oracle
import sys
try:
    #�����ͺ��̽� ���� ���� ����
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #�����ͺ��̽� ���� ��ü ���� - ����
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #�����ͺ��̽���  ������ ���� �� �ִ� ��ü ����
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #������ �б�
    
    #���� �� ������ �� ��������
    data = cursor.fetchall()
    #�ҷ��� ������ �ɰ��� ����
    for imsi in data:
        print(imsi)
    #�۾��� ������ ������ �ݿ�(�б� ���� ��� ��)
    #con.commit()
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
    
--variables�� dict�� class�� �ٲ��൵ ��
--��, �̸��� ��������� ��(�����͸� �� ����)
--dict�� list�� ������ִ� �� ����
--(�ӽ� �����̳� �� ������ values�� �̿�������)
--dict�� list �����
import cx_Oracle
import sys
try:
    #�����ͺ��̽� ���� ���� ����
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #�����ͺ��̽� ���� ��ü ���� - ����
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #�����ͺ��̽���  ������ ���� �� �ִ� ��ü ����
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #������ �б�
    #���� �� ������ �� ��������
    data = cursor.fetchall()

    #�����͸� ������ list ����
    li = []

    for imsi in data:
        dic = {'�μ���ȣ' : imsi[0], '�μ���' : imsi[1], '����' : imsi[2]}
        li.append(dic)
    print(li)
    #�۾��� ������ ������ �ݿ�(�б� ���� ������ ���� ������ commit�� ��� ��)
    #con.commit()
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
    
--Ʃ���� ������ ����(data ���� ��: 14<--1�̻��̸� �˻��� data�� �ִٴ� ��)
    print(len.data())
--Ʃ���� ������ ����(data ������ 0)
import cx_Oracle
import sys
try:
    #�����ͺ��̽� ���� ���� ����
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #�����ͺ��̽� ���� ��ü ���� - ����
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #�����ͺ��̽���  ������ ���� �� �ִ� ��ü ����
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #������ �б�
    #���� �� ������ �� ��������
    data = cursor.fetchall()
    #������ ���� ���: 0���� �˻��� ������ ����
    #1�̻��̸� �˻��� ������ ����
    print(len(data))

    #�����͸� ������ list ����
    li = []

    for imsi in data:
        dic = {'�μ���ȣ' : imsi[0], '�μ���' : imsi[1], '����' : imsi[2]}
        li.append(dic)
    print(li)
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
--**�α���
--���̵�� ��й�ȣ�� �Է¹޾Ƽ� ���̵�� ��й�ȣ�� �ش��ϴ� �����Ͱ� ������ �α��� ����
--�ش��ϴ� ������ ������ �α��� ����
--��й�ȣ�� �ݵ�� ��ȣȭ�ؼ� �����ϰ� ��ȣȭ�� �Ұ����ϵ��� �ؾ� ��
    
--**�����ͺ��̽� ���� ���α׷��� ���� �⺻�� CRUD(CREATE, READ, UPDATE, DELETE)
--������ ����, ����, ����
--������ ��ü �Ǵ� ������ ������ ��������, �⺻Ű�� ������ �ϳ��� �����͸� ��ȸ

--
--
--** ���ν��� ����**

--#���������� ��

--=> Ŀ��.callproc('���ν����̸�', (���ν����� �Ű����� ����))

--1. dept ���̺��� �����͸� �����ϴ� ���ν����� ����
CREATE OR REPLACE procedure SCOTT.insert_dept(
--scott���� ���ӵǾ� ������ scott �� �ᵵ ��
--�Ƹ� ������ �� ����� �׷���
    vdeptno dept.deptno%type,
    vdname dept.dname%type,
    vloc dept.loc%type
)
is
begin
    insert into dept(deptno, dname, loc)
    values(vdeptno, vdname, vloc);
END;

--2. ���ν��� �׽�Ʈ
BEGIN
	insert_dept(13, '����', '����');
END;

--table ����
SELECT *
FROM dept;

--**blob ����� �б�
--blob: ���� ������ �����ϱ� ���� ����Ŭ �ڷ���.
------- ���α׷��� ������ byte�������� ����(python�� ��� bytes)

--1. blob�� �����ϱ� ���� ���̺��� ����
--�����ͺ��̽����� �۾�
--�����̸��� ���� ������ ������ �� �ִ� ���̺� ����
CREATE TABLE filesave(
    filename varchar2(50),
    filecontent blob);
--�� ��� ���࿡ �����ϰų� �������� ������ ���̽㿡�� VIEW �Ǵ�  TABLE�� ���ٴ� ���� �޽���
   
SELECT *
FROM filesave;

--**MongoDB

--MEAN(MongoDB, Express.js, Angular.js, Node.js)
--������� �ڹٽ�ũ��Ʈ �������� �����ͺ��̽� �۾�,
--Express.js�� ���� ����
--Angular.js�� ������ �����͸� MVC �������� ���
--Angular.js �ڸ��� �ֱٿ� react�� vue�� �����ϱ⵵ ��
--Node.js�� ���� ���̵� ����� ����

--������ �� ���α׷���
--1. ������ �����ͺ��̽�(Oracle, MySQL..-SQL)
--2. ���� ���̵� ���α׷��� ���(Java-jsp&servlet, C#-asp.net, Php)
--3. Ŭ���̾�Ʈ ���̵� ���α׷��� ���(HTML, CSS, JavaScript)

--������ OPEN SOURCE�� �ƴ�
----MEAN(MongoDB, Express.js, Angular.js, Node.js)
--������� �ڹٽ�ũ��Ʈ �������� �����ͺ��̽� �۾�,
--Express.js�� ���� ����
--Angular.js�� ������ �����͸� MVC �������� ���
--Node.js�� ���� ���̵� ����� ����

--JSON Type�� �����͸� BSON(Binary JSON) ���·� ����
--dict({"key" : "value"}) -> javascript������ ��ü��
--list([]) -->javascript������ �迭��
--���� -> csv, xml, json
--�����͸� �� ���� json���·� �ִ� �� ���� ����

--������ ������ �ֽ� ������ json���·� ��� ������ python���� Ȱ���ϱ� ���Ҵ� ��
--���̽�� ����db ������ ����

--����db�� ���̺��� ������ �ʰ� �ٷ� ���� ����
--ROW�� �ƴ� Document

--�����ʹ� JSON Type���� ����Ǵ� �� ����ȭ�� Scheme�� ����
--DTO       | dict(map)
--RDBMS     | NoSQL
--����                 | �������� ���� �ٷ� ������ ���� ����
-- ��
--������
--������ Ʈ����� | ���� ���� ����, Ȯ�� ����

--DATABASE -> DATABASE
--TABLE -> collection
--ROW -> document
--COLUMN -> field
--INDEX -> INDEX
--JOIN -> embedding & linking
--SELECT ������ ����� ROW ������ ��ȯ -> CURSOR ��ȯ

--JSON ���·� �����Ͱ� ����� - {'key': 'value'} ����
--������ Ű/�� ���� ���ĵǴµ� Ű�� ����  ��Ҵ� ������ ������ �ٸ� ������ ���� �ٸ� ����
--.�� $ ���ڴ� ����� �� ����
-- _�� �����ϴ� ���ڴ� ������� ����(������� ���ɼ��� ����)
--��ҹ��� �� ������ ���� ��Ȯ�� �����ϸ� ��ҹ��ڰ� �ٸ��ų� ������ ���� �ٸ��� ���� �ٸ� ������ �ν�
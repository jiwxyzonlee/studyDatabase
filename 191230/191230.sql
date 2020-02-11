--TRIGGER
--관계형 데이터베이스에서는 테이블에 삽입, 삭제, 갱신 작업이 발생했을 때 작업 전이나 후에 다른 동작을 수행하도록 하는 것
--작업 전에 하는 동작은 유효성 검사해서 유효성 검사에 실패했을 때 작업을 수행하지 않도록 하기 위해서인 경우가 많고
--작업 후에 하는 동작은 하나의 트랜잭션으로 묶여야 하는 작업이나 로그를 기록하는 경우가 많다.

--1. 테이블에 데이터가 삽입될 때 데이터 삽입 시간과 삽입된 데이터의 기본키를 다른 테이블에 저장
--dept 테이블에 데이터를 삽입하면 기록
---1)기록할 테이블 생성
CREATE TABLE deptlog(
            deptno NUMBER(2) PRIMARY KEY,
            inserttime date);

--table 확인
SELECT *
FROM deptlog;

---2)트리거 생성
CREATE OR REPLACE TRIGGER tri_01

----dept 테이블에 데이터를 삽입한 후
----(삽입 전에 동작시키고 싶으면  after 대신에 before 사용)
----insert 대신 update, delete 사용 가능
AFTER INSERT ON dept

----한꺼번에 여러 개의 행에 작업이 발생할 때 작업을 단위별로 아니면 전체 한번만 동작할지 여부
----for each row는 매 번 수행, 그렇지 않은 경우는 생략
FOR EACH ROW
BEGIN
	INSERT INTO deptlog(deptno, inserttime) 
	    --새로 입력: :new.
	    --이전데이터 수정시: :old. (참조 데이터 삭제시 자주 사용)
	VALUES(:NEW.deptno, sysdate);	        
END;
--/(DBeaver는 할 필요 없음)

--위 식 위에서 ctrl+enter 그냥 안 먹고 script 실행해야 함
--procedure와 TRIGGER 만들 때
--plsql은 문법적으로 잘못 만들어도 저장됨
--그래서 제대로 만들어졌는지 꼭 확인해야

--확인을 위해 dept테이블에 데이터 삽입
INSERT INTO dept(deptno, dname, LOC) 
VALUES(73, '경비실', '이대');

--TABLE 확인
SELECT *
FROM deptlog;
--deptlog에 직접 데이터를 넣은 적이 없지만 기록이 됨
--사례) 게임 아이템 복구 시 기록된 시간 이용
--삽입, 삭제, 갱신 시 로그는 잘 만들어 두어야


--2. 트리거를 이용해서 유효성 검사
--작업을 하지 않도록 해주는 코드
raise_application_error(에러코드 번호, 에러 메시지)

--emp테이블에서 sal의 값을 현재 값보다 작은 값으로는 수정하지 못하도록 트리거 생성
CREATE OR REPLACE TRIGGER tri_02
BEFORE UPDATE ON emp --수정하는 것이므로 UPDATE
FOR EACH ROW WHEN(NEW.sal < OLD.sal) --조건(or나 and 붙여서 다중 조건 가능)
     -------------when에 쓸 때는 : 안 붙임
BEGIN
	raise_application_error(-20500, 'sal을 작은 값으로 수정 못함');
    --오라클 에러 코드와 겹칠 수도 있으므로 음수로 해주는 거임
END;

--TABLE 확인
SELECT *
FROM emp;

--정보 수정
UPDATE emp SET sal = 900 WHERE ename = 'SMITH';

--정보 수정 불가능(에러 확인해보기)
UPDATE emp SET sal = 800 WHERE ename = 'SMITH';
--SQL Error [20500] [72000]: ORA-20500: sal을 작은 값으로 수정 못함
--ORA-06512: at "SCOTT.TRI_02", line 2
--ORA-04088: error during execution of trigger 'SCOTT.TRI_02'
--org.jkiss.dbeaver.model.sql.DBSQLException: SQL Error [20500] [72000]: ORA-20500: sal을 작은 값으로 수정 못함
--ORA-06512: at "SCOTT.TRI_02", line 2
--ORA-04088: error during execution of trigger 'SCOTT.TRI_02'


--특정한 시간대 작업 못하도록 하기
BEGIN
	IF TO_NUMBER(TO_CHAR(SYSDATE, HH24)) NOT BETWEEN 9 AND 18 THEN
	--아침 9시부터 저녁 6시까지만 가능하도록, 요일 설정도 가능
	   raise_application_error(-25001, '9시에서 18시까지만 작업을 수행합니다')
	END IF;
END;


--사용자 접근제어는 SYS나 SYSTEM으로 로그인해야 함
--SCOTT으로는 접근 불가
--시스템 보안은 사용자에 대한 것
--데이터 보안은 객체에 대해 사용자가 할 수 있는 작업 규정
--사용자 접근 권한은 프로그램으로 제한하는 경우가 많음

--사용자 생성
CREATE USER user_name
IDENTIFIED BY password;

--시스템 권하는 주로 DBA가 부여

--권한 부여
GRANT system_privilege1[, system_privilege2, ]
TO user_name1[, user_name2, ]
[WITH admin OPTION];
--WITH admin OPTION: 권한들을 다른 유저들에게 부여가능하도록

--시스템 권한 종류
SELECT *
FROM SYSTEM_PRIVILEGE_MAP;

--SCOTT에게 CREATE ROLE권한을 부여
GRANT create role TO scott;

--권한 취소
REVOKE system_privilege1[,system_privilege2, . . . .] | role1[,role2, . . . .]
FROM {user1[,user2, . . . .] | role1[,role2, . . . .] | PUBLIC}; 

--system_privilege 시스템 권한
--user_name 사용자 명
--WITH ADMIN OPTION 받은 시스템 권한을 다른 사용자에게 부여할 수 있는 권한

--A가 B에게 권한을 부여했는데 A의 권한을 취소한다고 B의 권한도 취소되는 것은 아님

--DBA는 일반적으로 시스템 권한을 할당
--객체를 소유한 모든 사용자는 객체 권한을 부여 가능
--WITH GRANT OPTION으로 부여 받은 권한은 부여자에 의해 다른 사용자와 ROLE에게 다시 부여가능

--OBJECT 권한의 종류
SELECT *
FROM table_privilege_map;

--객체 권한 부여
GRANT select, insert ON emp TO user_name;

--객체 권한 철회
 Syntax
REVOKE {object_privilege1[,object_privilege2, . . . . .] | ALL}
ON object_name
FROM {user1[,user2, . . . .] | role1[,role2, . . . . .] | PUBLIC}
[CASCADE CONSTRAINTS];
--CASCADE CONSTRAINTS
--REFERENCES권한을 사용하여 만들어진 객체에 대한 참조 무결성 제약 조건을 제거하기 위해 사용한다.


REVOKE select ON emp FROM unser_name;

--ROLE
-- 사용자에게 허가할 수 있는 관련된 권한들의 그룹으로 ROLE을 이용하면 권한 부여와 회수를 쉽게 
CREATE ROLE role_name;
CREATE ROLE level1;


--**백업과 복원
--express는 xe(전역데이터베이스명)
--enterprise는 orcl

--oracle이 아닌 콘솔 창에 바로 침
exp userid=아이디/비밀번호@전역데이터베이스명 file=저장경로
exp userid=system/비밀번호@전역데이터베이스명 full=y file=c:\dump.dmp

--system 계정으로 scott 계정에 있는 DB백업
exp userid=system/비밀번호@전역데이터베이스명 owner=scott file=c:\dump.dmp
--자기것 백업할 땐 owner 안 씀
--scott계정으로 자신의 모든 데이터 백업
--dos>exp userid=scott/비밀번호@전역데이터베이스명 file=c:\dump.dmp

--**복원(Import)
imp 아이디/비밀번호@전역데이터베이스명 file=백업경로
--system계정으로 전체 복원
imp system/비밀번호@전역데이터베이스명 file=c:\dump.dmp
--system 계정으로 scott 계정에 있는 DB복원
imp system/비밀번호@전역데이터베이스명 fromuser=scott touser=scott file=c:\dump.dmp

--scott계정으로 자신의 모든 데이터 백업
imp scott/비밀번호@전역데이터베이스명 file=file=c:\dump.dmp
--복원하고자하는 DB에 같은 이름의 Object가 있을때,오류를 무시하고 건너 띄고 싶을때 ignore 옵션사용
imp 아이디/비밀번호@전역데이터베이스명 file=c:\dump.dmp ignore=y


--**오라클 파이썬 연동
--Python에서 데이터베이스를 엑서스하기 위해서 Python DB API를 사용할 수 있다. 
--ORM (Object Relational Mapping)
--Django ORM, PonyORM, peewee 등이 ORM 방식을 사용한 데이터 엑세스를 제공
--파이썬의 장점이자 단점(액세스할 수 있는 방법이 매우 다양)

--**파이썬에서 데이터베이스 연동
--1. 표준 API를 이용하는 방법
--2. pandas처럼 자료구조를 제공하는 패키지에서는 데이터베이스에 별도 방식으로 접근
--3. ORM(Object Relational Mapping)
----: 관계형 데이터베이스의 테이블과 객체를 일대일로 매핑시켜서  SQL없이 데이터베이스 사용
----(파이썬은) Django 프레임워크에서 지원
----java의 hibernate, android의 content VALUES, iOS에서의 Core Date 등이 ORM 개념

--**오라클 사용(파이썬에서)
--1. cx_Oracle이라는 패키지를 이용
---1) 패키지 설치
pip install 패키지 이름
pip install 패키지 이름 --upgrade  (업그레이드)
pip install 패키지 이름 = 버전 (특정 버전 설치)

--C, VC++, SPSS의 업그레이드는 제조회사에서 제공
--오픈소스 Java: Maven Gradle에서 검증해서 제공(앱스토어 심사와 같은 원리)
--위의 단점 보완한 게 python이나 R의 CRAN(스스로 library 만들어서 코드+문서 업로드)
--최신 버전 못 읽는 경우도 있기 때문에 다운그레이드할 때 특정 버전 설치
--한글이 아닌 이상 대개 pip로 install
--시스템 속성-고급-환경변수-path
--(install시 path 체크한 이유: pip명령을 콘솔 아무 곳에서나 사용할 수 있기 위해서)

---2) pip 업그레이드
python -m pip insatll --upgrade pip

---3) pip 명령 오류가 발생하는 경우
-----: pip command가 없다고 나오는 경우
-----: python이 설치되지 않았거나 python 명령어 디렉토리가 path에 추가되지 않은 경우
-----: windows의 경우 VC++로 패키지를 만드는 경우, VC++ 재배포 패키지를 설치해야만 설치되는 패키지 존재

---4) 금융기관이나 공공기관 등 폐쇄망에서의 설치
----- 다운로드가 가능한 곳에서
pip download 패키지이름 (으로 현재 컴퓨터에 다운로드)
----- 다운로드 받은 파일들을 복사한 후
pip install 파일명 (으로 설치)
----- 이때는 자동으로 종속된 패키지를 설치해주지 않기 때문에 직접 하나하나 순서대로 설치해야 함
----- 다른 패키지가 필요하면 어떤 패키지가 없다고 에러 발생, 메시지를 읽으면서 해야 함

--2. 외부 모듈 가져오기
---1)
import 모듈이름
--모듈 이름에 해당하는 모듈을 모듈이름으로 묶어서 가져옴
import numpy
--numpy에 있는 것들은 numpy.이름으로 사용해야 함

---2)
FROM 모듈이름 import 모듈 내부 요소들을 나열
--모듈이름에 해당하는 모듈에서 import 뒤에 있는 것들을 현재 모듈에 포함시켜서 가져옴

--예)
import pandas
pandas.DataFrame()

FROM pandas import DataFrame
DataFrame()

---3)
FROM 모듈이름 import *
--모듈이름에 해당하는 모듈 모든 내부요소를 현재 모듈에 포함시켜 가져옴

---4)
import 모듈이름 AS 별명
--모듈이름 대신에 별명 사용
--가장 많이 사용

--예)
import pandas AS pd
--pandas 대신에 pd라는 이름(별명) 사용
import numpy AS np
--numpy 대신에  np라는 이름(별명) 사용

--3. 파이썬에서 오라클 연결
import cx_Oracle

#접속 정보 만들기
변수1 = cx_Oracle.makedsn('ip주소', '포트번호', '데이터베이스 이름')

#접속
변수2 = cx_Oracle.connect(USER = '계정', password = '비밀번호', dsn = 변수1);

#연결 해제
변수2.close()
##close()는 절대 빼먹지 말 것! --file, network, database 에서는 반드시

--4. 관계형 데이터베이스 연동 시 tuple 사용, NoSQL 연동 시 dict 사용

--5. insert, delete, update
---연결 객체로부터 cursor를 가져옴
cur = 변수2. cursor()

---> cursor를 이용해서 sql실행
cur.exeute('sql 구문')
cur.execute('매개변수를 이용한 sql구문 작성', (매개변수에 해당하는 데이터 나열))
----두번째 방법 권장

---> 작업 완료는
cur.commit()

--6. 작업 도중 오류 발생
---에러 메시지가 ORA로 시작하면 이건 오라클 접속오류나 sql에러임

--dept테이블 삽입

--매개변수 없이 삽입
CURSOR = con.cursor()
CURSOR.execute("insert into dept(deptno, dname, loc) values(51, '총무', '광주')")
con.commit()

--python 입력 내용은 아래와 같음(Macafree 방화벽 끄고 해야 함)
import cx_Oracle
import sys
try:
    #데이터베이스 접속 정보 생성
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #데이터베이스 접속 객체 생성 - 접속
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #데이터베이스에  쿼리를 던질 수 있는 객체 생성
    cursor = con.cursor()
    #쿼리 실행
    cursor.execute("insert into dept(deptno, dname, loc) values(51, '총무', '광주')")
    #작업한 내역을 원본에 반영
    con.commit()
    #SQL 문장 실행
    cursor.execute('select * from DEPT')
    print('삽입 성공')
    #SQL TABLE 확인
    print(cursor.fetchall())
except Exception as e:
    print('exception', e)
finally:
    con.close()

--db table 확인
SELECT *
FROM dept;
--51 총무 광주 들어간 것을 볼 수 있음

--7. 파라미터를 이용한 실행
---SQL 구문을 만들 때:
---번호 형태로 매개변수를 만들고 두 번째 매개변수로: 번호 자리에 매핑될 튜플을 대입하는 방법으로 실행이 가능
cursor = con.cursor()
cursor.execute("insert into dept(deptno, dname, loc) values(:1, :2, :3)", (53, '비서실', '부산'))
con.commit()
---> 매핑하는 구조를 이용하면 데이터를 입력받아서 사용하는 것이 편리
---> python editor에 insert구문만 바꿔주면 됨

--입력값으로 바로 넣기
deptno = input("부서번호")
dname = input("부서명")
loc = input("지역")

--좋은 방법(따옴표 신경 안 써도 됨)
cursor.execute("insert into dept(deptno, dname, loc) values(:1, :2, :3)", (int(deptno), dname, loc))
--일반 방법
--cursor.execute("insert into dept(deptno, dname, loc) values(" + deptno + ",'" + dname + "','" + loc + "')')


--deptno와 dname, loc을 입력받아서 deptno에 해당하는 데이터의 dname과 loc 수정
--python idle editor 입력 내용

import cx_Oracle
import sys
try:
    #데이터베이스 접속 정보 생성
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #데이터베이스 접속 객체 생성 - 접속
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #데이터베이스에  쿼리를 던질 수 있는 객체 생성
    cursor = con.cursor()

    #데이터 입력받기
    deptno = input('부서번호: ')
    dname = input('부서명: ')
    loc = input('지역: ')

    #수정 구문 실행
    cursor.execute('update dept set dname = :1, loc = :2, where deptno = :3',
                   (dname, loc, int(deptno)))

    #작업한 내역을 원본에 반영
    con.commit()
    #SQL 문장 실행
    cursor.execute('select * from DEPT')
    print('삽입 성공')
    print(cursor.fetchall())
except Exception as e:
    print('exception', e)
finally:
    con.close()

    
--**데이터 읽기
--execute까지는 같은데 cursor 객체의 fetchall이라는 메소드를 호출하면 select한 결과의 튜플의 튜플로 만들어짐
--fetchone이라는 메소드를 호출하면 1개만 튜플로 return
import cx_Oracle
import sys
try:
    #데이터베이스 접속 정보 생성
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #데이터베이스 접속 객체 생성 - 접속
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #데이터베이스에  쿼리를 던질 수 있는 객체 생성
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #데이터 읽기
    #1개 데이터 가져오기
    data = cursor.fetchone()
    #불러온 데이터 쪼개서 보기
    for imsi in data:
        print(imsi)
        
    #작업한 내역을 원본에 반영(읽기 모드라 없어도 됨)
    #con.commit()
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
--전체 데이터 (튜플로) 가져와서 보기(fetchall())
import cx_Oracle
import sys
try:
    #데이터베이스 접속 정보 생성
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #데이터베이스 접속 객체 생성 - 접속
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #데이터베이스에  쿼리를 던질 수 있는 객체 생성
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #데이터 읽기
    
    #여러 개 데이터 다 가져오기
    data = cursor.fetchall()
    #불러온 데이터 쪼개서 보기
    for imsi in data:
        print(imsi)
    #작업한 내역을 원본에 반영(읽기 모드라 없어도 됨)
    #con.commit()
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
    
--variables는 dict나 class로 바꿔줘도 됨
--단, 이름을 지정해줘야 함(데이터를 볼 때는)
--dict의 list로 만들어주는 게 좋음
--(머신 러닝이나 딥 러닝은 values를 이용하지만)
--dict의 list 만들기
import cx_Oracle
import sys
try:
    #데이터베이스 접속 정보 생성
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #데이터베이스 접속 객체 생성 - 접속
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #데이터베이스에  쿼리를 던질 수 있는 객체 생성
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #데이터 읽기
    #여러 개 데이터 다 가져오기
    data = cursor.fetchall()

    #데이터를 저장할 list 생성
    li = []

    for imsi in data:
        dic = {'부서번호' : imsi[0], '부서명' : imsi[1], '지역' : imsi[2]}
        li.append(dic)
    print(li)
    #작업한 내역을 원본에 반영(읽기 모드는 영향이 없기 때문에 commit문 없어도 됨)
    #con.commit()
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
    
--튜플의 데이터 개수(data 있을 때: 14<--1이상이면 검색될 data가 있다는 것)
    print(len.data())
--튜플의 데이터 개수(data 없으면 0)
import cx_Oracle
import sys
try:
    #데이터베이스 접속 정보 생성
    dsnStr = cx_Oracle.makedsn('211.183.7.81', '1521', 'xe')
    #데이터베이스 접속 객체 생성 - 접속
    con = cx_Oracle.connect(user = 'scott', password = 'tiger', dsn = dsnStr)
    #데이터베이스에  쿼리를 던질 수 있는 객체 생성
    cursor = con.cursor()

    cursor.execute('select * from dept')

    #데이터 읽기
    #여러 개 데이터 다 가져오기
    data = cursor.fetchall()
    #데이터 개수 출력: 0개면 검색된 데이터 없음
    #1이상이면 검색된 데이터 있음
    print(len(data))

    #데이터를 저장할 list 생성
    li = []

    for imsi in data:
        dic = {'부서번호' : imsi[0], '부서명' : imsi[1], '지역' : imsi[2]}
        li.append(dic)
    print(li)
except Exception as e:
    print('exception', e)
finally:
    con.close()
    
--**로그인
--아이디와 비밀번호를 입력받아서 아이디와 비밀번호에 해당하는 데이터가 있으면 로그인 성공
--해당하는 데이터 없으면 로그인 실패
--비밀번호는 반드시 암호화해서 저장하고 복호화가 불가능하도록 해야 함
    
--**데이터베이스 연동 프로그램의 가장 기본은 CRUD(CREATE, READ, UPDATE, DELETE)
--데이터 삽입, 수정, 삭제
--데이터 전체 또는 페이지 단위로 가져오기, 기본키를 가지고 하나의 데이터를 조회

--
--
--** 프로시저 실행**

--#파이참에서 함

--=> 커서.callproc('프로시저이름', (프로시저의 매개변수 나열))

--1. dept 테이블에서 데이터를 삽입하는 프로시저를 생성
CREATE OR REPLACE procedure SCOTT.insert_dept(
--scott으로 접속되어 있으면 scott 안 써도 됨
--아마 예전에 안 지웠어서 그런가
    vdeptno dept.deptno%type,
    vdname dept.dname%type,
    vloc dept.loc%type
)
is
begin
    insert into dept(deptno, dname, loc)
    values(vdeptno, vdname, vloc);
END;

--2. 프로시저 테스트
BEGIN
	insert_dept(13, '영업', '서울');
END;

--table 실행
SELECT *
FROM dept;

--**blob 저장과 읽기
--blob: 파일 내용을 저장하기 이한 오라클 자료형.
------- 프로그래밍 언어에서는 byte집합으로 간주(python의 경우 bytes)

--1. blob를 저장하기 위한 테이블을 생성
--데이터베이스에서 작업
--파일이름과 파일 내용을 저장할 수 있는 테이블 생성
CREATE TABLE filesave(
    filename varchar2(50),
    filecontent blob);
--이 명령 수행에 실패하거나 수행하지 않으면 파이썬에서 VIEW 또는  TABLE이 없다는 에러 메시지
   
SELECT *
FROM filesave;

--**MongoDB

--MEAN(MongoDB, Express.js, Angular.js, Node.js)
--몽고디비는 자바스크립트 문법으로 데이터베이스 작업,
--Express.js는 서버 생성
--Angular.js는 서버의 데이터를 MVC 패턴으로 출력
--Angular.js 자리는 최근에 react나 vue로 구현하기도 함
--Node.js는 서버 사이드 언어의 역할

--예전의 웹 프로그래밍
--1. 관계형 데이터베이스(Oracle, MySQL..-SQL)
--2. 서버 사이드 프로그래밍 언어(Java-jsp&servlet, C#-asp.net, Php)
--3. 클라이언트 사이드 프로그래밍 언어(HTML, CSS, JavaScript)

--완전한 OPEN SOURCE가 아님
----MEAN(MongoDB, Express.js, Angular.js, Node.js)
--몽고디비는 자바스크립트 문법으로 데이터베이스 작업,
--Express.js는 서버 생성
--Angular.js는 서버의 데이터를 MVC 패턴으로 출력
--Node.js는 서버 사이드 언어의 역할

--JSON Type의 데이터를 BSON(Binary JSON) 형태로 저장
--dict({"key" : "value"}) -> javascript에서는 객체임
--list([]) -->javascript에서는 배열임
--서버 -> csv, xml, json
--데이터를 줄 때는 json형태로 주는 게 제일 좋다

--예전에 구글이 주식 파일을 json형태로 줬기 때문에 python에서 활용하기 좋았던 것
--파이썬과 몽고db 연동이 좋음

--몽고db는 테이블을 만들지 않고 바로 저장 가능
--ROW가 아닌 Document

--데이터는 JSON Type으로 저장되는 데 정형화된 Scheme이 없음
--DTO       | dict(map)
--RDBMS     | NoSQL
--구조                 | 구조생성 없이 바로 데이터 생성 가능
-- ↓
--데이터
--강력한 트랜잭션 | 구조 변경 쉬움, 확장 용이

--DATABASE -> DATABASE
--TABLE -> collection
--ROW -> document
--COLUMN -> field
--INDEX -> INDEX
--JOIN -> embedding & linking
--SELECT 구문의 결과로 ROW 집합을 반환 -> CURSOR 반환

--JSON 형태로 데이터가 저장됨 - {'key': 'value'} 구조
--문서의 키/값 쌍은 정렬되는데 키와 값의  요소는 같으나 순서가 다른 문서는 서로 다른 문서
--.과 $ 문자는 사용할 수 없음
-- _로 시작하는 문자는 사용하지 않음(예약어일 가능성이 높음)
--대소문자 및 데이터 형을 정확히 구분하며 대소문자가 다르거나 데이터 형이 다르면 서로 다른 문서로 인식
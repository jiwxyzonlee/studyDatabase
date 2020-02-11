
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
    
    #불러온 데이터 쪼개서 보기
    #for imsi in data:
    #    print(imsi)

    #데이터 입력받기
    #deptno = input('부서번호: ')
    #dname = input('부서명: ')
    #loc = input('지역: ')
    #쿼리 실행
    #cursor.execute("insert into dept(deptno, dname, loc) values(:1, :2, :3)", (53, '비서실', '부산'))

    #수정 구문 실행
    #cursor.execute('update dept set dname = :1, loc = :2, where deptno = :3', (dname, loc, int(deptno)))


    #작업한 내역을 원본에 반영
    #con.commit()
    #SQL 문장 실행
    #cursor.execute('select * from DEPT')
    #print('삽입 성공')
    #print(cursor.fetchall())
except Exception as e:
    print('exception', e)
finally:
    con.close()

CREATE USER yjb
IDENTIFIED BY yoon;

GRANT connect,resource TO yjb;

SELECT *
FROM system_privilege_map;

GRANT create role TO scott;

REVOKE create role FROM scott;

SELECT *
FROM table_privilege_map;

REVOKE select ON emp FROM yjb;

CREATE ROLE level1;

GRANT CREATE SESSION,CREATE TABLE,CREATE VIEW
TO level1;

CREATE USER test1
IDENTIFIED BY tiger1;

CREATE USER test2
IDENTIFIED BY tiger2;

GRANT level1 TO test1,test2;







-- 테이블 새로 만들기
DROP TABLE newbook;
--case 1)
CREATE TABLE newbook(
       bookid NUMBER PRIMARY KEY,
       bookname VARCHAR2(20),
       publisher VARCHAR2(20),
       price NUMBER);
select * from newbook;
INSERT INTO newbook VALUES(1,'데이터베이스','한빛',30000);
commit;
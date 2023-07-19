/* 1. 고객이 주문한 내용의 변경이 발생할 경우 로그테이블에 변경전 변경후 데이터를 기록하는 트리거 를 작성하고 동작됨을 보이시오.(배점 25점 ? 테이블 7점, 시퀀스 3점, 트리거 15점)
   [요구사항]   1. 로그 테이블명: orders_log 
               2. 순차기록을 위한 no속성 추가하고 시퀀스 사용할 것 (시퀀스명: orders_log_no_seq)
               3. 변경일시를 기록하기 위한 udate 속성이 추가
               4. 주문번호 기준으로 변경 전후 내역이 기록되어야한다. */
 CREATE table orders_log(
   orderid   number(2)
      CONSTRAINT orderid PRIMARY KEY
,  custid    number(2)
,  bookid    number(2)
,  saleprice number(8)
,  orderdate date
,  gubun     varchar2(10)
   );
commit;

CREATE or REPLACE trigger orders_log_no_seq
   AFTER INSERT or UPDATE or DELETE on orders_log
   REFERENCING OLD AS OLD NEW AS NEW 
   FOR EACH ROW
BEGIN
   IF INSERTING THEN
      INSERT INTO orders_log
      VALUES(orders_log_no_seq.NEXTVAL,custid,bookid,saleprice,SYSDATE,'INSERTING');
      DBMS_OUTPUT.PUT_LINE('변경 전 값 = ' || :OLD.bookid );
      DBMS_OUTPUT.PUT_LINE('변경 후 값 = ' || :NEW.bookid );
   ELSIF UPDATING THEN
      INSERT INTO orders_log
      VALUES(orders_log_no_seq.NEXTVAL,custid,bookid,saleprice,SYSDATE,'UPDATING');
   ELSIF DELETING THEN
      INSERT INTO orders_log
      VALUES(orders_log_no_seq.NEXTVAL,custid,bookid,saleprice,SYSDATE,'DELETING');
   END IF;
END orders_log_no_seq;
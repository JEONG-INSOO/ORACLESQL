/* 1. ���� �ֹ��� ������ ������ �߻��� ��� �α����̺� ������ ������ �����͸� ����ϴ� Ʈ���� �� �ۼ��ϰ� ���۵��� ���̽ÿ�.(���� 25�� ? ���̺� 7��, ������ 3��, Ʈ���� 15��)
   [�䱸����]   1. �α� ���̺��: orders_log 
               2. ��������� ���� no�Ӽ� �߰��ϰ� ������ ����� �� (��������: orders_log_no_seq)
               3. �����Ͻø� ����ϱ� ���� udate �Ӽ��� �߰�
               4. �ֹ���ȣ �������� ���� ���� ������ ��ϵǾ���Ѵ�. */
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
      DBMS_OUTPUT.PUT_LINE('���� �� �� = ' || :OLD.bookid );
      DBMS_OUTPUT.PUT_LINE('���� �� �� = ' || :NEW.bookid );
   ELSIF UPDATING THEN
      INSERT INTO orders_log
      VALUES(orders_log_no_seq.NEXTVAL,custid,bookid,saleprice,SYSDATE,'UPDATING');
   ELSIF DELETING THEN
      INSERT INTO orders_log
      VALUES(orders_log_no_seq.NEXTVAL,custid,bookid,saleprice,SYSDATE,'DELETING');
   END IF;
END orders_log_no_seq;
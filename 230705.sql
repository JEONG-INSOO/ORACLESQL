--�������� ���缭�� ������ �� ����
select count(*)
  from book;
  
--���� ������ ������ ����ϴ� ���ǻ��� �� ����
select count(distinct publisher) "���ǻ��Ѱ���"
  from book;
  
--��� ���� �̸�, �ּ�
select name, address
  from customer;
  
--2020�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ����� ������ �ֹ���ȣ
select orderid
  from orders
 where orderdate between '20200704' and '20200707' ;
 
select orderid
  from orders
 where orderdate >= '20200704' 
   and orderdate <= '20200707' ;
   
--2020�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ� ���� ������ ������ ������ �ֹ���ȣ
select orderid
  from orders
 where orderdate between '20200704' and '20200707' ;
 
select orderid
  from orders
 where not(orderdate >= '20200704' 
   and orderdate <= '20200707') ;
   
select orderid
  from orders
 where orderdate < '20200704' 
    or orderdate > '20200707' ;
    
--���� �达�� ���� �̸��� �ּ�
select name "�̸�" , address "�ּ�"
  from customer
 where name like '��%';
 
--���� �达�̰� �̸��� �Ʒ� ������ ���� �̸��� �ּ�
select name "�̸�" , address "�ּ�"
  from customer
 where name like '��%��';

--case1)
INSERT INTO Book(bookid, bookname, publisher, price)
VALUES (11, '������ ����', '�Ѽ����м���', 90000);
--case2)
INSERT INTO Book
VALUES (11, '������ ����', '�Ѽ����м���', 90000);
--case3)
INSERT INTO Book(bookid, publisher, bookname)
VALUES (11, '�Ѽ����м���', '������ ����');

UPDATE book 
   SET price = 90000
 WHERE bookid = 11;
SELECT * FROM BOOK;
commit;   --���̺� ������ ���� �Ŀ� ���������� �����ͺ��̽��� �ݿ��ϰڴٴ� �ǹ�.

DELETE FROM book
 WHERE bookid = 11;
 
ROLLBACK;  --���� �ֱ� commit�� ������ ���� ������ �����ϰڴٴ� �ǹ�.


select * from book;
select * from imported_book;

insert into book(bookid, bookname, publisher, price)
select bookid,bookname, publisher, price
  from imported_book;
  
--customer ���̺��� ����ȣ�� 5�� ���� �ּҸ� '���ѹα� �λ�'���� �����Ͻÿ�
UPDATE customer
   SET address='���ѹα� �λ�'
 WHERE custid = 5;
select * from customer;

DELETE FROM Customer;

--�������� ) ���ο� ���� ('����������','���ѹ̵��',10000��)�� ���缭���� �԰�Ǿ���.
Insert into book
 values('������ ����','���ѹ̵��',10000);
 
--�������� ) '�Ｚ�翡�� ������ ������ �����ؾ��Ѵ�.
 select * from book;
Delete from book
  where publisher like '�Ｚ��'; 
  
--�������� ) '�̻�̵��'���� ������ ������ �����ؾ��Ѵ�. ������ �ȵɰ�� ������ �����غ���
Delete from book
  where publisher like '�̻�̵��';
  
select * from imported_book;
  
--�������� ) ���ǻ� '���ѹ̵��'�� '�������ǻ�'�� �̸��� �ٲپ���.
UPDATE book 
   SET publisher = '�������ǻ�'
 WHERE publisher = '���ѹ̵��';
SELECT * FROM BOOK;
SELECT * FROM ORDERS;

 
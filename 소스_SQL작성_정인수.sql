CREATE USER c##sqltest1 IDENTIFIED BY sqltest1 DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##sqltest1;
GRANT CREATE VIEW, CREATE SYNONYM TO c##sqltest1;
GRANT UNLIMITED TABLESPACE TO c##sqltest1;
ALTER USER c##sqltest1 ACCOUNT UNLOCK;

-- 1 ) ���� �̸�, �ּ�, ����ó�� ���̽ÿ�.
select name "�̸�", 
    address "�ּ�", 
      phone "����ó"
  from customer;

-- 2 ) ���ѹα��� �����ϴ� ���� ���̽ÿ�.
select * 
  from customer 
 where address like '���ѹα�%';

-- 3 ) ����ó�� ���� ���� �̸��� ���̽ÿ�.
 select name "�̸�"
   from customer
 where phone is null;

-- 4 ) �������� ����ϴ� ���ǻ��� �� ������ ���̽ÿ�.
select count(distinct publisher) "���ǻ� �� ����"
  from book;
  
-- 5 ) ���� ���� "����"�� �����ϴ� ������ ���̽ÿ�.
select bookname " ���� ���� "
  from book
 where bookname like '%����%';
 
-- 6 ) �ֹ��Ǽ�, ����Ǹž�, �ִ��Ǹž�, �ּ��Ǹž�, �� �Ǹž��� ���̽ÿ�.
select count(orderid) "�ֹ��Ǽ�", 
         avg(saleprice) "����Ǹž�", 
         max(saleprice) "�ִ��Ǹž�", 
         min(saleprice) "�ּ��Ǹž�", 
         sum(saleprice) "�� �Ǹž�"
  from orders;

-- 7 ) ���ǻ纰 �����Ǽ��� ������������ ���̽ÿ�.
  select publisher "���ǻ�",
      count(bookid) "������ ��"
    from book
group by publisher
order by count(bookid) desc;

-- 8 ) ���ǻ纰 ���� �Ǽ�, �ְ���, ��������, ���������� ���� ���ǻ� �̸������� ���̽ÿ�.
  select publisher "���ǻ�",
         count(bookid) "������ ��",
         max(price) "�ְ���",
         min(price) "��������",
         sum(price) "���� ������ ��"
    from book
group by publisher
order by publisher asc;

-- 9 ) ���������� ���� ��� ������ ���� �ѵ����� �������̸� ���̽ÿ�.
select max(price) "���� ��� ����",
       min(price) "���� �� ����",
       max(price)-min(price) "��������"
  from book;
  
-- 10 ) �� �� ���ŰǼ��� 2ȸ �̻��� ����ȣ, ���ŰǼ��� ���ŰǼ� ������ ���̽ÿ�.
  select custid "����ȣ",
         count(custid) "���ŰǼ�"
    from orders 
group by custid
  having count(custid)>= 2
order by count(custid);
-- 11 ) 2020�� 7�� 4�� ~ 7�� 7�� ���̿� �ֹ� ���� ������ ������ ������ �ֹ���ȣ�� ���̽ÿ�.
select orderid "�ֹ���ȣ"
  from orders
 where orderdate not between '20200704' and '20200707' ;
 
-- 12 ) �ֹ����ں� ������� ����� ������������ ���̽ÿ�.
  select sum(saleprice) "�����",
         orderdate "�ֹ�����"
    from orders
group by orderdate
order by sum(saleprice) desc;

-- 13 ) 2020�� 7�� 2�� ���Ŀ� �ֹ��Ϻ� ������� 20,000���� �ʰ��ϴ� �ֹ����ڸ� �ֱ� ���ڼ����� ���̽ÿ�.
  select orderdate "�ֹ�����"
    from orders
   where '20200702' < orderdate
group by orderdate
  having sum(saleprice) > 20000
order by orderdate desc;

-- 14 ) ���ǻ纰 �����Ǽ��� 2�� �̻��� ���ǻ縦 ���̽ÿ�.
   select publisher "���ǻ�", 
          count(bookid) "�����Ǽ�"
     from book
 group by publisher
   having count(bookid) >= 2
 order by publisher;

-- 15 ) ���ο� ������ �Ʒ� �԰� �Ǿ���. �߰��� ����� ���̽ÿ�.
-- ���� : �����ͺ��̽�, ���ǻ� : �Ѻ�, ���� : 30,000
insert into book
values (11,'�����ͺ��̽�','�Ѻ�',30000);

commit;

select * from book;
 
-- 16 ) ���ǻ� "���ѹ̵��"�� "�������ǻ�"�� �̸��� �ٲ����. ����� ����� ���̽ÿ�.
update book 
   set publisher = '�������ǻ�'
 where publisher = '���ѹ̵��';

commit;

select * from BOOK;

-- 17 ) �½����� ���ǻ� ������ ������ 10% �λ��Ͽ���. ����� ����� ���̽ÿ�.
   update book
      set price = price * 1.1
    where publisher = '�½�����';
 
 commit;
 
    select  bookname "���� ����",
            publisher "���ǻ�", 
            price "�ǸŰ���"
     from book
    where publisher = '�½�����'
 group by bookname,
          publisher,
          price
 order by publisher;

-- 18 ) �߽ż� ���� �ּҰ� "���ѹα� ���"���� ����Ǿ���. ����� ����� ���̽ÿ�.
update customer
   set  address = '���ѹα� ���'
 where  name = '�߽ż�';
 
commit;

select name "�̸�",
       address "�ּ�"
  from customer
 where name = '�߽ż�';


-- 19 ) ��ȭ��ȣ�� ���� ���� �����ϰ� �ݿ��� ����� ���̽ÿ�.
delete from customer
 where phone is null;
 
commit; 
 
select *
  from customer;

-- 20 ) '������' ���� �����ؾ� �Ѵ�. ������ �� �� ��� ������ �ۼ��Ͻÿ�.
delete from customer
 where name like '������';

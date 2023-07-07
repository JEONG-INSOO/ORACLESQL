select *
  from book t1 left outer join orders t2 on t1.bookid = t2.bookid;
  
  select *
  from orders t1 left outer join book t2 on t1.bookid = t2.bookid;
  
select *
  from orders t1 right outer join book t2 on t1.bookid = t2.bookid;
  
  select *
  from book t1 right outer join orders t2 on t1.bookid = t2.bookid;
  
  select *
  from orders t1 full outer join book t2 on t1.bookid = t2.bookid;
  
  CREATE TABLE fruits (
	fruit_id INTEGER PRIMARY KEY,
	fruit_name VARCHAR (255) NOT NULL,
	basket_id INTEGER
);

CREATE TABLE baskets (
	basket_id INTEGER PRIMARY KEY,
	basket_name VARCHAR (255) NOT NULL
);

INSERT INTO baskets (basket_id, basket_name)
VALUES (1, 'A');
INSERT INTO baskets (basket_id, basket_name)
VALUES	(2, 'B');
INSERT INTO baskets (basket_id, basket_name)
VALUES	(3, 'C');

INSERT INTO fruits (
   fruit_id,
   fruit_name,
   basket_id
)
VALUES
   (1, 'Apple', 1);
INSERT INTO fruits (
   fruit_id,
   fruit_name,
   basket_id
)
VALUES    
   (2, 'Orange', 1);
INSERT INTO fruits (
   fruit_id,
   fruit_name,
   basket_id
)
VALUES    
   (3, 'Banana', 2);
INSERT INTO fruits (
   fruit_id,
   fruit_name,
   basket_id
)
VALUES    
   (4, 'Strawberry', NULL);  
   commit;
   
--īƼ�ǰ�
select *
  from fruits t1, baskets t2;
--��������: �ٱ��Ͽ� ����ִ� ����
select *
  from fruits t1, baskets t2;
 where t1.basket_id = t2.basket_id;

--�ܺ����� (left outer join) 
select *
  from fruits t1, kaskets t2
 where t1.basket_id = t2.basket_id(+);
select *
  from fruits t1 left outer join baskets t2 on t1.basket_id = t2.basket_id;

select *
  from baskets t1 left outer join fruits t2 on t1.basket_id = t2.basket_id;
  
--full outer join
select *
  from baskets t1 full outer join fruits t2 on t1.basket_id = t2.basket_id;
  
  
--���� 3-29) ������ ������ ���� �ִ� ���� �̸��� �˻��Ͻÿ�
select distinct custid
  from orders;

select name
  from customer
  where custid in( select distinct custid
                     from orders);
                     
select name
  from customer
 where custid in (1,2,4,3);

select distinct name
  from orders t1, customer t2
 where t1.custid = t2.custid;
 
select distinct name
  from orders t1 inner join customer t2 on t1.custid = t2.custid;
 
select *
  from book
 where publisher = '�������ǻ�';
 
select *
  from orders
 where bookid in (select bookid
                    from book
                   where publisher = '�������ǻ�');

select t3.name
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t2.publisher = '�������ǻ�';
   
select t3.name
  from orders t1 inner join book t2 on t1.bookid = t2.bookid
                 inner join customer t3 on t1.custid = t3.custid
 where t2.publisher = '�������ǻ�';
  
  
--��������) ���缭���� ���� �䱸�ϴ� ���� ������ ���� SQL���� �ۼ��Ͻÿ�
--5) �������� ������ ������ ���ǻ� ��
select count (distinct t2.publisher) "�������� ������ ������ ���ǻ� ��"
  from orders t1 inner join book t2 on t1.bookid = t2.bookid
                 inner join customer t3 on t1.custid = t3.custid
 where t3.name = '������';
 
select * 
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t3.name = '������';
 
select count(distinct publisher) "���ǻ� ��"
  from book
 where bookid in (select bookid
                    from orders
                   where custid in (select custid 
                                      from customer
                                     where name = '������'));

select count(distinct publisher) "���ǻ� ��"
  from book
 where bookid in (select bookid
                    from orders t1, customer t2
                   where t1.custid = t2.custid
                     and t2.name = '������');   
   
select custid
  from customer
 where name = '������';
   
--6) �������� ������ ������ �̸�, ����, ������ �ǸŰ����� ����
select t2.bookname "���� ����" , t2.price "����", t1.saleprice - t2.price "������ �Ǹ� ������ ����"
  from orders t1 inner join book t2 on t1.bookid = t2.bookid
                 inner join customer t3 on t1.custid = t3.custid
 where t3.name = '������';

select t2.bookname "������", 
       t1.saleprice "����", 
       t2.price "����", 
       t1.saleprice - t2.price "������ �Ǹ� ������ ����" 
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t3.name = '������';

--7) �������� �������� ���� ������ �̸�
--case 1)�������� �̿� : ��� ���� - �������� ������ ����
select bookname
  from book
 MINUS
select bookname
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t3.name = '������';
--case 2)���� ���� : ���� ���̺��� �������� ������ ���������� ����
select bookname
  from book
 where bookid not in ( select t1.bookid
                         from orders t1, customer t2
                        where t1.custid = t2.custid
                          and t2.name = '������');
--case 3)������� :  exist
select bookname
  from book t3
 where not exists ( select *
                      from orders t1, customer t2
                     where t1.custid = t2.custid
                       and t3.bookid = t1.bookid
                       and t2.name = '������');
                          
--case4) left outer join
select t1.bookname
  from book t1, orders t2, customer t3
 where t1.bookid = t2.bookid(+)
   and t2.custid = t3.custid(+)
   and (t3.name <> '������' or t3.name is null);
   
select t1.bookname
  from book t1 left outer join orders t2 on t1.bookid = t2.bookid
               left outer join customer t3 on t2.custid = t3.custid
 where (t3.name <> '������' or t3.name is null);.
 
--�������� 8) �ֹ����� ���� ���� �̸�(�μ����� ���)
select name "�ֹ����� ���� �� �̸�"
  from customer
 MINUS
select name
  from customer t1, orders t2
  where t1.custid = t2.custid;
  
--�μ�����
select t1.name
  from customer t1
 where not exists ( select *
                     from orders t2
                    where t2.custid = t1.custid);
select t1.name
  from customer t1
 where t1.custid not in( select t2.custid
                           from orders t2
                          where t2.custid = t1.custid);
                    
  
--�������� 9) �ֹ��ݾ��� �Ѿװ� �ֹ��� ��� �ݾ�
select sum(saleprice) "�ֹ� �Ѿ�", 
       avg(saleprice) "�ֹ� ��ձݾ�"
  from orders;
  

--�������� 10) ���� �̸��� ���� ���ž�
select t2.name, sum(t1.saleprice)
    from orders t1, customer t2
   where t1.custid = t2.custid
group by t1.custid, t2.name;
 
--�������� 11) ���� �̸��� ���� ������ ���� ���
select t3.name "�̸�" , t2.bookname "������", t2.publisher "���ǻ�",t2.price "����"
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid;

--�������� 12) ������ ���� (book ���̺�)�� �ǸŰ���(orders ���̺�) �� ���̰� ���� ���� �ֹ�
select t1.orderid "�ֹ���ȣ" 
  from orders t1, book t2
 where t1.bookid = t2.bookid
   and t2.price - t1.saleprice = (select max(t2.price - t1.saleprice)
                                    from orders t1, book t2
                                   where t1.bookid = t2.bookid);
                                   
-- �������� 13) ������ �Ǹž� ��պ��� �ڽ��� ���ž� ����� �� ���� ���� �̸�
  select t2.custid, t2.name, avg(t1.saleprice)
    from orders t1, customer t2
   where t1.custid = t2.custid
group by t2.custid, t2.name
  having avg(t1.saleprice) > ( select avg(saleprice) 
                                 from orders);


                                
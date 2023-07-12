--�丸���
   CREATE view vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
as select od.orderid, od.custid, cs.name,
          od.bookid, bk.bookname, od.saleprice, od.orderdate
     from orders od, customer cs, book bk
    where od.custid = cs.custid and od.bookid = bk.bookid;
    
--�䱸��
  select orderid, bookname, saleprice
    from vw_orders
   where name = '�迬��';
   
  select *
    from customer
   where address like '%���ѹα�%';
   
  select *
    from vw_customer;
    
  CREATE or REPLACE view vw_customer(custid2,name2,address2) as
  select custid, name, address
    from customer
   where address like '%���ѹα�%';
   
  select name2
    from vw_customer;

  DROP view vw_book;
  DROP view vw_customer;
  
  CREATE view highorders(bookid, bookname, name, publisher, saleprice) as
  select bk.bookid, bk.bookname,bk.publisher,
         cs.name, od.saleprice
    from orders od, book bk, customer cs
   where od.custid = cs.custid and od.bookid = bk.bookid
     and od.saleprice >= 20000;
  
  DROP view highorders;
   select bookname, name
     from highorders;
     
  CREATE or REPLACE view vw_highorders as
  select bk.bookid, bk.bookname,bk.publisher,
         cs.name
    from orders od, book bk, customer cs
   where od.custid = cs.custid and od.bookid = bk.bookid
     and od.custid = cs.custid;
     
--�ε��� �����
  CREATE index ix_book on book(bookname);
  CREATE index ix_book2 on book(publisher, price);
--�ε��� ��ȸ
  select *
    from book
   where publisher = '���ѹ̵��'
     and price >= 30000;

--�ε��� �����
  ALTER index ix_book rebuild;
--�ε��� ����
   DROP index ix_book;
  
--�������� 4-16
  select name 
    from customer 
   where name like '�ڼ���';

  CREATE index ix_name on customer(name);
    DROP index ix_name;
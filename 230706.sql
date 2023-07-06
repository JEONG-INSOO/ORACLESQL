select *
  from customer, orders;
  
select *
  from customer, orders
 where customer.custid = orders.custid;
 
select *
  from customer t1, order t2
 where t1.custid = t2.custid;
 
select t1.*, t2*
  from customer t1, orders t2
 where t1.custid = t2.custid;
 
select t2.orderid "�ֹ���ȣ", 
       t1.name "����", 
       t2.orderdate "�ֹ���", 
       t2.bookid "������ȣ", 
       t2.saleprice "�Ǹűݾ�"
  from customer t1, orders t2
 where t1.custid = t2.custid
   and t1.custid = 1;
 
 select t2.orderid "�ֹ���ȣ", 
       t1.name "����", 
       t2.orderdate "�ֹ���", 
       t2.bookid "������ȣ", 
       t2.saleprice "�Ǹűݾ�"
  from customer t1 inner join orders t2 on t1.custid = t2.custid
 where t1.custid = 1;
 
select *
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid
   and t1.bookid = t3.bookid;

select * from book;
select * from customer;
select * from orders;

--���� �ֹ��̷��� ���̽ÿ�.
  select t2.*, t1.*
    from orders t1, customer t2
   where t1.custid = t2.custid
order by t1.custid;
 
--�ֹ��̷��� �ִ� ������ ���̽ÿ�.
  select distinct t2.name
    from orders t1, customer t2
   where t1.custid = t2.custid
order by t2.name;

--�ֹ��̷��� ���� ������ ���̽ÿ�.
--���� ���̺��� ������� �����ϰ� ���������̺� ��Ī�Ǵ� ���� �����Ѵ�
         select *
           from customer t1
left outer join orders t2
             on t1.custid = t2.custid
          where t2.orderid is null   ;
            
         select *
           from book t1
left outer join orders t2
             on t1.bookid = t2.bookid
          where t2.orderid is null   ;     
          
    select *
      from customer t1
inner join orders t2
        on t1.custid = t2.custid;        
 
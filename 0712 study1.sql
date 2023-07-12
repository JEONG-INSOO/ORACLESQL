--뷰만들기
   CREATE view vw_orders(orderid, custid, name, bookid, bookname, saleprice, orderdate)
as select od.orderid, od.custid, cs.name,
          od.bookid, bk.bookname, od.saleprice, od.orderdate
     from orders od, customer cs, book bk
    where od.custid = cs.custid and od.bookid = bk.bookid;
    
--뷰구경
  select orderid, bookname, saleprice
    from vw_orders
   where name = '김연아';
   
  select *
    from customer
   where address like '%대한민국%';
   
  select *
    from vw_customer;
    
  CREATE or REPLACE view vw_customer(custid2,name2,address2) as
  select custid, name, address
    from customer
   where address like '%대한민국%';
   
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
     
--인덱스 만들기
  CREATE index ix_book on book(bookname);
  CREATE index ix_book2 on book(publisher, price);
--인덱스 조회
  select *
    from book
   where publisher = '대한미디어'
     and price >= 30000;

--인덱스 재생성
  ALTER index ix_book rebuild;
--인덱스 삭제
   DROP index ix_book;
  
--연습문제 4-16
  select name 
    from customer 
   where name like '박세리';

  CREATE index ix_name on customer(name);
    DROP index ix_name;
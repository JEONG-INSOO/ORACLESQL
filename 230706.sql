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
 
select t2.orderid "주문번호", 
       t1.name "고객명", 
       t2.orderdate "주문일", 
       t2.bookid "도서번호", 
       t2.saleprice "판매금액"
  from customer t1, orders t2
 where t1.custid = t2.custid
   and t1.custid = 1;
 
 select t2.orderid "주문번호", 
       t1.name "고객명", 
       t2.orderdate "주문일", 
       t2.bookid "도서번호", 
       t2.saleprice "판매금액"
  from customer t1 inner join orders t2 on t1.custid = t2.custid
 where t1.custid = 1;
 
select *
  from orders t1, customer t2, book t3
 where t1.custid = t2.custid
   and t1.bookid = t3.bookid;

select * from book;
select * from customer;
select * from orders;

--고객의 주문이력을 보이시오.
  select t2.*, t1.*
    from orders t1, customer t2
   where t1.custid = t2.custid
order by t1.custid;
 
--주문이력이 있는 고객명을 보이시오.
  select distinct t2.name
    from orders t1, customer t2
   where t1.custid = t2.custid
order by t2.name;

--주문이력이 없는 고객명을 보이시오.
--왼쪽 테이블의 모든행을 나열하고 오른쪽테이블에 매칭되는 행을 나열한다
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
 
select avg(sal), count(sal)
  from bonus;

select orderid "주문번호",
       to_char(orderdate,'yyyy-mm-dd dy') "주문일",
       custid "고객번호",
       bookid "도서번호"
  from orders
 where orderdate=to_date('20200707','yyyymmdd'); 
 
 select orderid "주문번호",
       to_char(orderdate,'yyyy-mm-dd') "주문일",
       to_char(orderdate,'dy') "요일",
       custid "고객번호",
       bookid "도서번호"
  from orders
 where orderdate=to_date('20200707','yyyymmdd') + 1; 
 
  select orderid "주문번호",
       to_char(orderdate,'yyyy-mm-dd') "주문일",
       to_char(orderdate,'dy') "요일",
       custid "고객번호",
       bookid "도서번호"
  from orders
 where orderdate='20200707'; 
 
 select sysdate, systimestamp
   from dual;
   
 select to_char(sysdate, 'yyyy-mm-dd hh24:mi:ss'),
        to_char(sysdate, 'ddd')
   from dual;
   

select trunc(11/4) "몫", mod(11,4) "나머지"
  from dual;

select power(3,2)
  from dual;
select lpad('Page 1',15,'*.'),rpad('Page 1',15,'*.')
  from dual;
  
select ltrim('  Page 1  ') "1",
       rtrim('  Page 1  ') "2",
       trim('  Page 1  ') "3"
  from dual;
  
select ltrim('0001','0') "1",
       rtrim('1000','0') "2"
  from dual;  
  
select TRIM(LEADING 0 FROM '00AA00')
  from dual;
select TRIM(BOTH 0 FROM '00AA00')
  from dual;  
  select TRIM(trailing 0 FROM '00AA00')
  from dual; 
  
select INSTR('CORPORATE FLOOR','OR', 3, 2)
  from dual;
  
select next_day(sysdate,'목')
  from dual;
  
  
select to_char(round(sysdate),'yyyy-mm-dd hh24,mi,ss')
  from dual;
  
select decode(1,1,'같다','다르다')
  from dual;
  
  
select decode(20,10,'자유게시판',
                20,'Q_A',
                30,'공지사항','없음')
  from dual;
  
select name, phone, nvl(phone,'연락처없음')
  from customer;
  
select NULLIF(123, 345),NULLIF(123, 123)
  from dual;
  
--nvl2
select nvl2(null,1,2),nvl2(1,1,2)
  from dual;


select null + 10
  from dual;
  
select rownum,t1.*
  from customer t1;  
  
select rownum,t1.*
  from customer t1
 where rownum <= 3; 
 
select rownum,t1.*
  from customer t1
 where rownum >= 4;  

 
select rownum,t1.*
  from customer t1
 where rownum between 2 and 3;  
 
 
select rownum "순번", custid, name phone
  from customer;

select rownum "순번", custid, name phone
  from customer  
 where rownum <=2;  

  select rownum "순번", custid, name phone
    from customer  
   where rownum <=2
order by name;  

--도서가격을 높은순으로 3위까지를 순위와함께 보이시오
select rownum "순위", t1.bookname, t1.price
from ( select *
         from book
     order by price desc ) t1 
where rownum <= 3;  

--도서가격을 높은순으로 3~5위까지를 순위와함께 보이시오.

select rank,bookname,price
  from (
    select rownum rank, t1.bookname, t1.price
    from ( select *
             from book
         order by price desc ) t1 ) t2
where rank between 3 and 5;
     

select ROWNUM "순위", t1.bookname, t1.price
  from (select *
          from book
         ORDER by price desc) t1
 where ROWNUM <= 5
 minus
 select ROWNUM "순위", t1.bookname, t1.price
  from (select *
          from book
         ORDER by price desc) t1
 where ROWNUM <= 2; 
   
   
    select rownum "순위" , t1.*
from   (select *
        from book
        order by price desc) t1
where rownum <= 5
minus
    select rownum "순위" , t1.*
from   (select *
        from book
        order by price desc) t1
where rownum <= 2;   

SELECT *
FROM (SELECT *
      FROM (SELECT * FROM book ORDER BY price DESC)t1
      WHERE ROWNUM <= 5           
      ORDER BY price)t2
WHERE ROWNUM <= 3
ORDER BY price desc;


SELECT t2.num "순위", t2.bookname "도서명", t2.price "가격"
  FROM (SELECT ROWNUM num, bookname, price
          FROM (SELECT * FROM book ORDER BY price DESC)t1
         WHERE ROWNUM <= 5           
      ORDER BY price) t2
 WHERE ROWNUM <= 3
order by t2.price desc;



select bookname,
       price,
       rank() over (order by price desc) rank,
       dense_rank() over (order by price desc) dense_rank,
       row_number() over (order by price desc) row_number
  from book;



select distinct (select name 
                   from customer 
                  where custid=t1.custid)
  from orders t1;

select saleprice
   from orders
  where custid = '3';
                          

select orderid, saleprice
  from orders
 where saleprice > all ( select saleprice
                           from orders
                          where custid = '3' ) ;  
 
select orderid, saleprice
  from orders
 where saleprice >   ( select max(saleprice)
                           from orders
                          where custid = '3' ) ;  

select orderid, saleprice
  from orders
 where saleprice < all ( select saleprice
                           from orders
                          where custid = '3' ) ;  
                          
select orderid, saleprice
  from orders
 where saleprice <     ( select min(saleprice)
                           from orders
                          where custid = '3' ) ;  


    select custid "고객번호", (select name 
                                from customer  
                               where custid=t1.custid) "이름" , 
           sum(saleprice) "판매액"
      from orders t1
  group by custid;    


    select t2.name, sum(t1.saleprice)
      from orders t1, customer t2
     where t1.custid = t2.custid  
  group by t2.custid, t2.name;    


create view vw_book as
select *
  from book
 where bookname like '%축구%';
 
select sum(price) 
  from vw_book
 where bookid >= 3 ;
 
drop view vw_book; 
 


create view vw_book as
select bookname, publisher
  from book
 where bookname like '%축구%';


select *
  from vw_book;
  






  CREATE table book_log(
    bookid_1    number
,   bookname_1  varchar2(40)
,   publisher_1 varchar2(40)
,   price_1     number
);

  CREATE or REPLACE trigger afterinsertbook
   after insert on book for each row
 declare 
     average number;
   begin 
     insert into book_log
     values (:new.bookid, :new.bookname, :new.publisher, :new.price);
     dbms_output.put_line('삽입행을 book_log 테이블에 백업..');
   end;
      
  INSERT into book
  VALUES(20,'스포츠과학 1', '이상미디어',25000);
  
  select * from book;
  select * from book_log;
  
commit;  
rollback;

  CREATE or REPLACE function fnc_interest(
   price number
)  return int
as
  myinterest number;
  begin 
    if price >= 30000 then
       myinterest :=price *0.1;

    else
       myinterest := price * 0.05;
    end if;
    return myinterest;
  end;
  
  select orderid, custid, saleprice, fnc_interest(saleprice) interest
    from orders;
    
--연습문제08-1) insertbook() 프로시저를 수정하여 고객을 새로 등록하는 insertCustomer() 프로시저를 작성하시오
CREATE or REPLACE procedure insertCustomer (
  p_custid  in  customer.custid %type
, p_name    in  customer.name   %type
, p_address in  customer.address%type
, p_phone   in  customer.phone  %type) 
  as
   begin 
      insert into customer
      values(p_custid,p_name,p_address,p_phone);
   end;
  select * from customer;
  exec insertcustomer(6,'홍길동','동에 번쩍 서에 번쩍','010-1234-5678');
  
--연습문제08-2) BookInsertOrUpdate() 프로시저를 수정하여 삽입 작업을 수행하는 프로시저를 작성하시오.
  CREATE or REPLACE procedure BookInsertOrUpdate(
  p_bookid    in  book.bookid   %type
, p_bookname  in  book.bookname %type
, p_publisher in  book.publisher%type
, p_price     in  book.price    %type)   
  as
      l_cntofbook number := 0;
      l_price     number := 0;
  begin
      select count(*) into l_cntofbook
        from book
       where bookname  = p_bookname
         and publisher = p_publisher;
         
       if l_cntofbook = 0 then
          INSERT into book
          VALUES (p_bookid, p_bookname, p_publisher, p_price);
     else
     --동일한 도서가 있으면
      select price into l_price
        from book
       where bookname  = p_bookname
         and publisher = p_publisher;  
     --삽입하려는 도서가격이 높을때만 변경    
       if    p_price > l_price then
      UPDATE book
         SET price     = p_price
       where bookname  = p_bookname
         and publisher = p_publisher;
         end if;
       end if;
  end;
  
  commit;
  select * from book;
  exec BookInsertOrUpdate(21, '데이터베이스3', '한빛', 40000);
  
--연습문제09-01) 출판사가 '이상미디어'인 도서의 이름과 가격을 보여 주는 프로시저를 작성하시오
  CREATE or REPLACE procedure ISangMedia 
  as
      l_bookname book.bookname%type;
      l_price    book.price   %type;
       cursor c_book is        select bookname, price
                                 from book
                                where publisher = '이상미디어' ;
  begin
      open c_book;
      dbms_output.put_line(rpad('도서명',40,' ')||rpad('가격',40,' '));
      loop
         fetch c_book into l_bookname, l_price;
          exit when c_book%notfound;
          dbms_output.put_line(rpad(l_bookname,40,' ')||rpad(l_price,40,' '));
       end loop;
  end;
  set serverout on;
  exec ISangMedia;
 
  CREATE or REPLACE procedure ISangMedia1 
  as
       cursor c_book is        select bookname, price
                                 from book
                                where publisher = '이상미디어' ;
  begin
      dbms_output.put_line(rpad('도서명',40,' ')||rpad('가격',40,' '));
       for rec in c_book
      loop
          dbms_output.put_line(rpad(rec.bookname,40,' ')||rpad(rec.price,40,' '));
       end loop;
  end; 
  
  exec ISangMedia1;  
  
  select t2.publisher, sum(t1.saleprice)
    from orders t1, book t2
   where t1.bookid = t2.bookid
group by t2.publisher;

  CREATE or REPLACE procedure excercis9_2
  as
    cursor c_salesbypublisher is select t2.publisher, sum(t1.saleprice) sales
                                   from orders t1, book t2
                                  where t1.bookid = t2.bookid
                               group by t2.publisher;
  begin
    for rec in c_salesbypublisher
    loop
    dbms_output.put_line(rec.publisher || '-' || rec.sales);
    end loop;
    end;
  exec excercis9_2;
      CREATE or REPLACE procedure excercis9_2_2
  as
  begin
    for rec in (select t2.publisher, sum(t1.saleprice) sales
                  from orders t1, book t2
                 where t1.bookid = t2.bookid
              group by t2.publisher)
    loop
    dbms_output.put_line(rec.publisher || '-' || rec.sales);
    end loop;
    end;
  exec excercis9_2_2;
  
--연습문제 9-3) 출판사별로 도서의 평균가보다 비싼 도서의 이름을 보이시오.
  CREATE or REPLACE procedure excercise9_3 
  as    
  begin
       for rec in (   select t1.bookname, t1.price, t1.publisher
                        from book t1
                       where t1.price>(select avg(t2.price)
                                         from book t2
                                        where t2.publisher = t1.publisher))
      loop 
          dbms_output.put_line(rec.bookname);
      end loop;
  end;

  CREATE or REPLACE procedure excercise9_3_2
  as    
   l_avg number := 0.0;
  begin
       for rec1 in (select bookname, price, publisher
                     from book)
      loop 
           select avg(price) into l_avg
             from book
            where publisher = rec1.publisher;
         
          if rec1.price > l_avg then
          dbms_output.put_line(rec1.bookname);
          end if;
      end loop;
  end;
exec excercise9_3_2;

--연습문제 09-04) 고객별로 도서를 몇 권 구입했는지와 총 구매액을 보이시오
  CREATE or REPLACE procedure excercise9_4
  as
    cursor c_q1 is select t2.name, count(t1.orderid) cnt, sum(t1.saleprice) sum
                     from orders t1, customer t2
                    where t1.custid = t2.custid
                 group by t2.custid, t2.name;
  begin 
     for rec in c_q1
     loop
       dbms_output.put_line(rec.name || ',' || rec.cnt ||','||rec.sum);
     end loop;
  end;
  exec excercise9_4;

--연습문제 09-05) 주문이 있는 고객의 이름과 주문 총액을 출력하고, 주문이 없는 고객은 이름만 출력하는 프로시저를 작성하시오.
  CREATE or REPLACE procedure excercise9_5
  as
    cursor c_q1 is select custid, name
                     from customer;
    l_sales number := 0.0;
  begin 
    for rec in c_q1 loop
    
      select sum(saleprice) into l_sales
        from orders
       where custid = rec.custid; 
       --주문없는 고객
       if l_sales = 0 then
          dbms_output.put_line(rec.name);
       --주문있는 고객
       else
          dbms_output.put_line(rec.name || ',' || l_sales);
       end if;
    end loop;
 end;
exec excercise9_5;

  CREATE or REPLACE procedure excercise9_5_2
  as
    --주문있는 고객
    cursor c1 is select custid, name
                   from customer t1
                  where exists( select * 
                                  from orders t2
                                 where custid = t1.custid);
    --주문없는 고객
    cursor c2 is select custid, name
                   from customer t1
                  where not exists( select * 
                                      from orders t2
                                     where custid = t1.custid);
     l_sales number := 0.0;
  begin
    --주문있는 고객
    for rec in c1 loop
       select sum(saleprice)into l_sales
         from orders 
        where custid = rec.custid;
         dbms_output.put_line( rec.name || ',' || l_sales); 
    end loop;
    --주문없는 고객
    for rec in c2 loop
         dbms_output.put_line( rec.name );  
    end loop;
end;
exec excercise9_5_2;

CREATE or REPLACE function grade(
  p_sales number
) return varchar2
as
begin
  if p_sales >= 20000 then
     return '우수';
  else
     return '보통'; 
  end if;
end;

  select t2.custid "고객번호"
,        t2.name "고객이름" 
,        sum(t1.saleprice) "판매액" 
,        grade(sum(t1.saleprice)) "등급"
    from orders t1, customer t2
   where t1.custid = t2.custid
group by t2.custid,  t2.name;

  CREATE or REPLACE function domestic(
     p_address varchar2
) return varchar2
as
begin
    if p_address like '%대한민국%' then
      return '국내거주';
    else
      return '해외거주';
    end if;
end;

select name, address, domestic(address)
  from customer;
  
  select domestic(t2.address) "국내외구분", sum(t1.saleprice) "판매총액"
    from orders t1, customer t2
   where t1.custid = t2.custid
group by domestic(t2.address);
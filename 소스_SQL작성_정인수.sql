CREATE USER c##sqltest1 IDENTIFIED BY sqltest1 DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##sqltest1;
GRANT CREATE VIEW, CREATE SYNONYM TO c##sqltest1;
GRANT UNLIMITED TABLESPACE TO c##sqltest1;
ALTER USER c##sqltest1 ACCOUNT UNLOCK;

-- 1 ) 고객의 이름, 주소, 연락처를 보이시오.
select name "이름", 
    address "주소", 
      phone "연락처"
  from customer;

-- 2 ) 대한민국에 거주하는 고객을 보이시오.
select * 
  from customer 
 where address like '대한민국%';

-- 3 ) 연락처가 없는 고객의 이름을 보이시오.
 select name "이름"
   from customer
 where phone is null;

-- 4 ) 서점에서 취급하는 출판사의 총 갯수를 보이시오.
select count(distinct publisher) "출판사 총 개수"
  from book;
  
-- 5 ) 도서 제목에 "골프"를 포함하는 도서를 보이시오.
select bookname " 도서 제목 "
  from book
 where bookname like '%골프%';
 
-- 6 ) 주문건수, 평균판매액, 최대판매액, 최소판매액, 총 판매액을 보이시오.
select count(orderid) "주문건수", 
         avg(saleprice) "평균판매액", 
         max(saleprice) "최대판매액", 
         min(saleprice) "최소판매액", 
         sum(saleprice) "총 판매액"
  from orders;

-- 7 ) 출판사별 도서건수를 내림차순으로 보이시오.
  select publisher "출판사",
      count(bookid) "도서건 수"
    from book
group by publisher
order by count(bookid) desc;

-- 8 ) 출판사별 도서 건수, 최고가격, 최저가격, 도서가격의 합을 출판사 이름순으로 보이시오.
  select publisher "출판사",
         count(bookid) "도서건 수",
         max(price) "최고가격",
         min(price) "최저가격",
         sum(price) "도서 가격의 합"
    from book
group by publisher
order by publisher asc;

-- 9 ) 도서가격이 가장 비싼 도서와 가장 싼도서의 가격차이를 보이시오.
select max(price) "가장 비싼 도서",
       min(price) "가장 싼 도서",
       max(price)-min(price) "가격차이"
  from book;
  
-- 10 ) 고객 중 구매건수가 2회 이상인 고객번호, 구매건수를 구매건수 순으로 보이시오.
  select custid "고객번호",
         count(custid) "구매건수"
    from orders 
group by custid
  having count(custid)>= 2
order by count(custid);
-- 11 ) 2020년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호를 보이시오.
select orderid "주문번호"
  from orders
 where orderdate not between '20200704' and '20200707' ;
 
-- 12 ) 주문일자별 매출액을 매출액 내림차순으로 보이시오.
  select sum(saleprice) "매출액",
         orderdate "주문일자"
    from orders
group by orderdate
order by sum(saleprice) desc;

-- 13 ) 2020년 7월 2일 이후에 주문일별 매출액이 20,000원을 초과하는 주문일자를 최근 일자순으로 보이시오.
  select orderdate "주문일자"
    from orders
   where '20200702' < orderdate
group by orderdate
  having sum(saleprice) > 20000
order by orderdate desc;

-- 14 ) 출판사별 도서건수가 2건 이상인 출판사를 보이시오.
   select publisher "출판사", 
          count(bookid) "도서건수"
     from book
 group by publisher
   having count(bookid) >= 2
 order by publisher;

-- 15 ) 새로운 도서가 아래 입고 되었다. 추가된 결과를 보이시오.
-- 제목 : 데이터베이스, 출판사 : 한빛, 가격 : 30,000
insert into book
values (11,'데이터베이스','한빛',30000);

commit;

select * from book;
 
-- 16 ) 출판사 "대한미디어"가 "대한출판사"로 이름이 바뀌었다. 변경된 결과를 보이시오.
update book 
   set publisher = '대한출판사'
 where publisher = '대한미디어';

commit;

select * from BOOK;

-- 17 ) 굿스포츠 출판사 도서의 가격을 10% 인상하였다. 변경된 결과를 보이시오.
   update book
      set price = price * 1.1
    where publisher = '굿스포츠';
 
 commit;
 
    select  bookname "도서 제목",
            publisher "출판사", 
            price "판매가격"
     from book
    where publisher = '굿스포츠'
 group by bookname,
          publisher,
          price
 order by publisher;

-- 18 ) 추신수 고객의 주소가 "대한민국 울산"으로 변경되었다. 변경된 결과를 보이시오.
update customer
   set  address = '대한민국 울산'
 where  name = '추신수';
 
commit;

select name "이름",
       address "주소"
  from customer
 where name = '추신수';


-- 19 ) 전화번호가 없는 고객을 삭제하고 반영된 결과를 보이시오.
delete from customer
 where phone is null;
 
commit; 
 
select *
  from customer;

-- 20 ) '박지성' 고객을 삭제해야 한다. 삭제가 안 될 경우 이유를 작성하시오.
delete from customer
 where name like '박지성';
 
 

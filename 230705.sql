--연습문자 마당서점 도서의 총 개수
select count(*)
  from book;
  
--마당 서점에 도서를 출고하는 출판사의 총 개수
select count(distinct publisher) "출판사총개수"
  from book;
  
--모든 고객의 이름, 주소
select name, address
  from customer;
  
--2020년 7월 4일 ~ 7월 7일 사이에 주문받은 도서의 주문번호
select orderid
  from orders
 where orderdate between '20200704' and '20200707' ;
 
select orderid
  from orders
 where orderdate >= '20200704' 
   and orderdate <= '20200707' ;
   
--2020년 7월 4일 ~ 7월 7일 사이에 주문 받은 도서를 제외한 도서의 주문번호
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
    
--성이 김씨인 고객의 이름과 주소
select name "이름" , address "주소"
  from customer
 where name like '김%';
 
--성이 김씨이고 이름이 아로 끝나는 고객의 이름과 주소
select name "이름" , address "주소"
  from customer
 where name like '김%아';

--case1)
INSERT INTO Book(bookid, bookname, publisher, price)
VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
--case2)
INSERT INTO Book
VALUES (11, '스포츠 의학', '한솔의학서적', 90000);
--case3)
INSERT INTO Book(bookid, publisher, bookname)
VALUES (11, '한솔의학서적', '스포츠 의학');

UPDATE book 
   SET price = 90000
 WHERE bookid = 11;
SELECT * FROM BOOK;
commit;   --테이블 데이터 변경 후에 최종적으로 데이터베이스에 반영하겠다는 의미.

DELETE FROM book
 WHERE bookid = 11;
 
ROLLBACK;  --가장 최근 commit한 이후의 변경 사항을 원복하겠다는 의미.


select * from book;
select * from imported_book;

insert into book(bookid, bookname, publisher, price)
select bookid,bookname, publisher, price
  from imported_book;
  
--customer 테이블에서 고객번호가 5인 고객의 주소를 '대한민국 부산'으로 변경하시오
UPDATE customer
   SET address='대한민국 부산'
 WHERE custid = 5;
select * from customer;

DELETE FROM Customer;

--연습문제 ) 새로운 도서 ('스포츠세계','대한미디어',10000원)이 마당서점에 입고되었다.
Insert into book
 values('스포츠 세계','대한미디어',10000);
 
--연습문제 ) '삼성당에서 출판한 도서를 삭제해야한다.
 select * from book;
Delete from book
  where publisher like '삼성당'; 
  
--연습문제 ) '이상미디어'에서 출판한 도서를 삭제해야한다. 삭제가 안될경우 원인을 생각해보자
Delete from book
  where publisher like '이상미디어';
  
select * from imported_book;
  
--연습문제 ) 출판사 '대한미디어'가 '대한출판사'로 이름을 바꾸었다.
UPDATE book 
   SET publisher = '대한출판사'
 WHERE publisher = '대한미디어';
SELECT * FROM BOOK;
SELECT * FROM ORDERS;

 
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
   
--카티션곱
select *
  from fruits t1, baskets t2;
--내부조인: 바구니에 담겨있는 과일
select *
  from fruits t1, baskets t2;
 where t1.basket_id = t2.basket_id;

--외부조인 (left outer join) 
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
  
  
--질의 3-29) 도서를 구매한 적이 있는 고객의 이름을 검색하시오
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
 where publisher = '대한출판사';
 
select *
  from orders
 where bookid in (select bookid
                    from book
                   where publisher = '대한출판사');

select t3.name
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t2.publisher = '대한출판사';
   
select t3.name
  from orders t1 inner join book t2 on t1.bookid = t2.bookid
                 inner join customer t3 on t1.custid = t3.custid
 where t2.publisher = '대한출판사';
  
  
--연습문제) 마당서점의 고객이 요구하는 다음 질문에 대해 SQL문을 작성하시오
--5) 박지성이 구매한 도서의 출판사 수
select count (distinct t2.publisher) "박지성이 구매한 도서의 출판사 수"
  from orders t1 inner join book t2 on t1.bookid = t2.bookid
                 inner join customer t3 on t1.custid = t3.custid
 where t3.name = '박지성';
 
select * 
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t3.name = '박지성';
 
select count(distinct publisher) "출판사 수"
  from book
 where bookid in (select bookid
                    from orders
                   where custid in (select custid 
                                      from customer
                                     where name = '박지성'));

select count(distinct publisher) "출판사 수"
  from book
 where bookid in (select bookid
                    from orders t1, customer t2
                   where t1.custid = t2.custid
                     and t2.name = '박지성');   
   
select custid
  from customer
 where name = '박지성';
   
--6) 박지성이 구매한 도서의 이름, 가격, 정가와 판매가격의 차이
select t2.bookname "도서 제목" , t2.price "가격", t1.saleprice - t2.price "정가와 판매 가격의 차이"
  from orders t1 inner join book t2 on t1.bookid = t2.bookid
                 inner join customer t3 on t1.custid = t3.custid
 where t3.name = '박지성';

select t2.bookname "도서명", 
       t1.saleprice "가격", 
       t2.price "정가", 
       t1.saleprice - t2.price "정가와 판매 가격의 차이" 
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t3.name = '박지성';

--7) 박지성이 구매하지 않은 도서의 이름
--case 1)차집합을 이용 : 모든 도서 - 박지성이 구매한 도서
select bookname
  from book
 MINUS
select bookname
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid
   and t3.name = '박지성';
--case 2)비상관 쿼리 : 도서 테이블에서 박지성이 구매한 도서정보를 제외
select bookname
  from book
 where bookid not in ( select t1.bookid
                         from orders t1, customer t2
                        where t1.custid = t2.custid
                          and t2.name = '박지성');
--case 3)상관쿼리 :  exist
select bookname
  from book t3
 where not exists ( select *
                      from orders t1, customer t2
                     where t1.custid = t2.custid
                       and t3.bookid = t1.bookid
                       and t2.name = '박지성');
                          
--case4) left outer join
select t1.bookname
  from book t1, orders t2, customer t3
 where t1.bookid = t2.bookid(+)
   and t2.custid = t3.custid(+)
   and (t3.name <> '박지성' or t3.name is null);
   
select t1.bookname
  from book t1 left outer join orders t2 on t1.bookid = t2.bookid
               left outer join customer t3 on t2.custid = t3.custid
 where (t3.name <> '박지성' or t3.name is null);.
 
--연습문제 8) 주문하지 않은 고객의 이름(부속질의 사용)
select name "주문하지 않은 고객 이름"
  from customer
 MINUS
select name
  from customer t1, orders t2
  where t1.custid = t2.custid;
  
--부속질의
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
                    
  
--연습문제 9) 주문금액의 총액과 주문의 평균 금액
select sum(saleprice) "주문 총액", 
       avg(saleprice) "주문 평균금액"
  from orders;
  

--연습문제 10) 고객의 이름과 고객별 구매액
select t2.name, sum(t1.saleprice)
    from orders t1, customer t2
   where t1.custid = t2.custid
group by t1.custid, t2.name;
 
--연습문제 11) 고객의 이름과 고객이 구매한 도서 목록
select t3.name "이름" , t2.bookname "도서명", t2.publisher "출판사",t2.price "정가"
  from orders t1, book t2, customer t3
 where t1.bookid = t2.bookid
   and t1.custid = t3.custid;

--연습문제 12) 도서의 가격 (book 테이블)과 판매가격(orders 테이블) 의 차이가 가장 많은 주문
select t1.orderid "주문번호" 
  from orders t1, book t2
 where t1.bookid = t2.bookid
   and t2.price - t1.saleprice = (select max(t2.price - t1.saleprice)
                                    from orders t1, book t2
                                   where t1.bookid = t2.bookid);
                                   
-- 연습문제 13) 도서의 판매액 평균보다 자신의 구매액 평균이 더 높은 고객의 이름
  select t2.custid, t2.name, avg(t1.saleprice)
    from orders t1, customer t2
   where t1.custid = t2.custid
group by t2.custid, t2.name
  having avg(t1.saleprice) > ( select avg(saleprice) 
                                 from orders);


                                
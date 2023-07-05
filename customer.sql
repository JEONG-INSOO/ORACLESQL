select count(*)
  from customer;
  
select count(phone)
  from customer;
  
select count(custid)
  from customer;
 
 --고객별로 주문한 도서의 총 수량과 총 판매액 
  select custid, count(*) as 도서수량, sum(saleprice) as 총액
    from orders
group by custid
order by sum(saleprice) desc;

--주문테이블에서 판매가격이 만원이상인 주문중에 고객id를 그룹화하고 그 중에 3만원 이상인 것들의 고객id, 총 건수, 매출 합계를 매출합계 내림차순으로 정렬하여라.
  select custid, count(*), sum(saleprice) 
    from orders
   where saleprice >= 10000
group by custid
  having sum(saleprice) >= 30000
order by sum(saleprice) desc;

-- 주의사항
-- 1) group by를 사용하면 select절에는 group by절에 나열된 속성과 집계함수만 올 수 있다.
  select bookid, custid, count(*)
    from orders
group by bookid, custid;

-- 2) having 절을 사용하면 검색조건에 집계함수가 와야한다.
  select custid, count(*), sum(saleprice)
    from orders
   where saleprice >= 10000
group by custid
having sum(saleprice) >= 30000;

--연습문제 1-1) 도서번호가 1인 도서의 이름
select bookname, bookid
  from book
 where bookid = 1;
 
--연습문제 1-2) 가격이 20,000원 이상인 도서의 이름
select bookname, saleprice
  from orders, book
 where saleprice > 20000;

--연습문제 1-3) 박지성의 총구매액
 select sum(saleprice)
   from orders
  where custid = 1;
--연습문제 1-4) 박지성이 구매한 도서의 수
  select count(*)
    from orders
   where custid = 1;
   
--연습문제 2-1) 마당서점 도서의 총수
  select count(*)
    from book;

 
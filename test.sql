select *
  from customer
 where name = '김연아';
    
select phone "연락처"
  from customer
 where name = '김연아';
    
    /* 여러줄 주석 */
    --. 한줄 주석
    -- 10000원 이상인 도서를 대상으로 출판사별 도서 합계가 20000원 이상
select publisher "출판사" , sum(price) "총계"
  from book
 where price >= 10000                         --레코드 필터링
   group by publisher                           --특정 컬럼으로 그루핑하여 집계
    having sum(price) >= 20000                   --그루핑한 결과를 필터링
    order by publisher desc;                     --정렬
    
--출판사 목록 출력하기 ( 중복 제거 )
select distinct publisher
    from book;
    
select bookname, price
  from book; 

--모든 도서의 도서번호, 도서이름, 출판사, 가격을 검색하시오.
select bookid, bookname, publisher, price
  from book;
  
--도서 테이블에 있는 모든 출판사를 검색하시오
select publisher
  from book;
  
--중복 제거
select distinct publisher
  from book;

--가격이 20000원 미만인 도서를 검색하시오
select *
  from book
 where price < 20000;
 
--책제목에 '축구'가 들어간 책 정보
select *
  from book
 where bookname like '%축구%';
   
--고객정보 중에 이씨 정보
select *
  from customer
 where name like '박%';

select *
  from book
 where bookname like '_구%';
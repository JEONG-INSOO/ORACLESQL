--질의 4-3 고객별 평균주문금액을 백원단위로 반올림한 값을 구하시오.
  select custid "고객번호", round(sum(saleprice)/count(*),-2) "평균금액"
    from orders
group by custid;
--질의 4-4 도서 제목에 '야구'가 포함된 도서를 '농구'로 변경한 후 도서 목록을 보이시오.
  select bookid, replace(bookname, '야구','농구') bookname, publisher, price
    from book;
--질의 4-5 굿스포츠에서 출판한 도서의 제목과 제목의 글자 수, 바이트수를 보이시오
  select bookname "제목", length(bookname) "글자수",
         lengthb(bookname) "바이트수"
    from book
   where publisher = '굿스포츠';
--질의 4-6 마당서점의 고객 중 같은 성을 가진 사람이 몇명이나 되는지 성별 인원수를 구하시오.
  select substr(name,1,1) "성", count(*) "인원"
    from customer
group by substr(name,1,1);
--질의 4-7 마당서점은 주문일로부터 10일 후 매출을 확정한다. 각 주문의 확정일자를 구하시오
  select orderid "주문번호", orderdate "주문일", orderdate+10 "확정일"
    from orders;

--질의 4-8 마당서점이 2020년 7월7일에 주문받은 도서의 주문번호, 주문일, 고객번호, 도서번호를 모두 보이시오. 'yyyy-mm-dd'형태
  select orderid "주문번호", TO_CHAR(orderdate,'yyyy-mm-dd dy')"주문일",
         custid "고객번호", bookid "도서번호"
    from orders
   where orderdate = to_date('20200707','yyyymmdd');

    
  select to_char(sysdate,'yyyy/mm/dd')
    from dual;
  select last_day(sysdate)
    from dual;
  select sysdate, systimestamp
    from dual;
  select ltrim(' page_1  ') "1"
    from dual;
  select next_day(sysdate,'목')
    from dual;
  select to_char(round(sysdate),'yyyy-mm-dd hh24,mi,ss')
    from dual;
  select decode (1,1,'같다','다르다')
    from dual;
  select decode(30,10,'자유게시판',
                   20,'QnA',
                   30,'공지사항','없음')
    from dual;
  select name,phone
    from customer;
  select nvl2(null,1,2),nvl2(1,1,2)
    from dual;
    
  select cs.name, sum(od.saleprice) "total"
    from (select  custid, name
            from  customer
           where  custid<=2)cs,
          orders  od
   where cs.custid=od.custid
group by cs.name;

--연습문제 1) 고객별 고객아이디, 고객주소, 판매액을 보이시오.
  select custid, (select  address
                    from  customer cs
                   where  cs.custid = od.custid) "address",
                          sum(saleprice) "total"
    from orders od
group by od.custid;

--연습문제 2) 고객별 고객이름, 평균 판매액을 보이시오.
  select cs.name,s
    from (select custid,avg(saleprice)s
            from orders
        group by custid)od, customer cs
   where cs.custid = od.custid;
   
--연습문제 3) 고객번호가 3이하인 고객을 대상으로 판매 총액을 보이시오
  select sum(saleprice) "total"
    from orders od
   where exists (select *
                   from customer cs
                  where custid <= 3 and cs.custid = od.custid); 
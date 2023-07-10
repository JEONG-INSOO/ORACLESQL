drop table reservation;
drop table cinema;
drop table theater;
drop table customer;

--극장테이블
create table theater(
    theater_no      number(2),    --극장번호
    theater_name    varchar2(60), --극장명
    location        varchar2(30)  --위치
);
alter table theater add constraint theater_theater_no_pk primary key(theater_no);

--고객테이블
create table customer(
    cust_no         number(2),      --고객번호
    name            varchar2(12),   --고객명
    address         varchar2(90)    --주소
);
alter table customer add constraint customer_cust_no_pk primary key(cust_no);

--상영관 테이블
create table cinema(
    theater_no      number(2),      --극장번호
    cinema_no       number(2),      --상영관번호
    movie_title     varchar2(30),   --영화제목
    price           number(5),      --가격
    seats           number(3)       --좌석수
);
alter table cinema add constraint cinema_theater_no_cinema_no_pk 
    primary key(theater_no,cinema_no);
alter table cinema add constraint cinema_theater_no_fk
    foreign key(theater_no) references theater(theater_no);
alter table cinema add constraint cinema_price_ck
    check(price < 20000);
alter table cinema add constraint cinema_cinema_no
    check(cinema_no between 1 and 10 );


--예약 테이블
create table reservation(
    theater_no      number(2),      --극장번호
    cinema_no       number(2),      --상영관번호
    cust_no         number(2),      --고객번호
    seat_no         number(2),      --좌석번호
    screening_date  date            --예약일
);
alter table reservation add constraint reservation_theater_no_cinema_no_cust_no_pk
    primary key(theater_no,cinema_no,cust_no);
alter table reservation add constraint reservation_theater_no_cinema_no_fk
    foreign key(theater_no,cinema_no) references cinema(theater_no,cinema_no);
alter table reservation add constraint reservation_cust_no_fk
    foreign key(cust_no) references customer(cust_no);
alter table reservation add constraint reservation_cust_no_seat_no_uq
    unique (cust_no,seat_no);
    
--극장 샘플 데이터
insert into theater values(1,'롯데','잠실');
insert into theater values(2,'메가','강남');
insert into theater values(3,'대한','잠실');

--고객 샘플 데이터
insert into customer values(3,'홍길동','강남');
insert into customer values(4,'김철수','잠실');
insert into customer values(9,'박영희','강남');

--상영관 샘플 데이터
insert into cinema values(1,1,'어려운 영화',15000,48);
insert into cinema values(3,1,'멋진 영화',7500,120);
insert into cinema values(3,2,'재밌는 영화',8000,110);

--예약 샘플 데이터
insert into reservation values(3,2,3,15,'20200901');
insert into reservation values(3,1,4,16,'20200901');
insert into reservation values(1,1,9,48,'20200901');
commit;
-- 1) 모든 극장의 이름과 위치를 보이시오
  select theater_name "극장 이름" , location "위치"
    from theater;
    
-- 2) '잠실'에 있는 극장을 보이시오
  select theater_name "극장 이름", location "위치"
    from theater
   where location = '잠실'
order by name;

-- 3) '잠실'에 사는 고객의 이름을 오름차순으로 보이시오.
  select name "고객 이름", address "주소"
    from customer
   where address = '잠실';
   
-- 4) 가격이 8,000원 이하인 영화의 극장번호, 상영관 번호, 영화 제목을 보이시오.
  select theater_no "극장 번호", cinema_no "상영관 번호", movie_title "영화제목"
    from cinema
   where price <= 8000;
   
-- 5) 극장 위치와 고객의 주소가 같은 고객을 보이시오.
  select distinct name "고객 이름", address "주소", location "극장 위치"
    from customer, theater
   where address = location;
   
-- 6) 극장의 수는 몇 개인가?
  select count(cinema_no) "극장의 수"
    from cinema;
    
-- 7) 상영되는 영화의 평균 가격은 얼마인가?
  select avg(price) "평균 가격"
    from cinema;
    
-- 8) 2020년 9월 1일에 영화를 관람한 고객의 수는 얼마인가?
  select count(cust_no) "고객의 수"
    from reservation
   where screening_date = '20200901';
   
-- 9) '대한'극장에서 상영된 영화제목을 보이시오.
  select movie_title "영화 제목", theater_name "극장 이름"
    from cinema t1, theater t2
   where t2.theater_no =t1.theater_no 
     and theater_name = '대한';
                   
  select movie_title "영화 제목", theater_name "극장 이름"
    from cinema t1 inner join theater t2 on t2.theater_no =t1.theater_no 
   where theater_name = '대한';
  
  select movie_title
    from cinema
   where theater_no =( select theater_no
                        from theater
                       where theater_name = '대한');
                                      
-- 10) '대한'극장에서 영화를 본 고객의 이름을 보이시오.
  select t4.name "고객 이름", t3.theater_name "극장이름"
    from reservation t1, cinema t2, theater t3, customer t4
   where t1.theater_no = t2.theater_no
     and t1.cust_no = t4.cust_no
     and t1.cinema_no = t2.cinema_no
     and t2.theater_no = t3.theater_no
     and theater_name = '대한';
     
-- 11) '대한' 극장의 전체 수입을 보이시오
  select sum(t2.price) "대한 극장의 전체 수입"
    from reservation t1, cinema t2, theater t3
   where t1.theater_no=t2.theater_no
     and t1.cinema_no = t2.cinema_no
     and t2.theater_no = t3.theater_no
     and t3.theater_name = '대한';

  select sum(t2.price) "대한 극장의 전체 수입"
    from reservation t1 inner join cinema t2  on  t1.theater_no=t2.theater_no
                                             and  t1.cinema_no = t2.cinema_no
                        inner join theater t3 on t2.theater_no = t3.theater_no
   where t3.theater_name = '대한';        
        
  select sum(t2.price) "대한 극장의 전체 수입"
    from reservation t1, cinema t2
   where t1.theater_no = t2.theater_no
     and t1.cinema_no = t2.cinema_no
     and t2.theater_no in ( select theater_no
                              from theater
                             where theater_name = '대한');
                             
-- 12)극장별 상영관 수를 보이시오.
  select t1.theater_name "극장 이름", count(*)
    from theater t1, cinema t2
   where t1.theater_no = t2.theater_no
group by t1.theater_no, t1.theater_name;

--13)'잠실' 에 있는 극장의 상영관을 보이시오.
  select t1.theater_name  "극장 이름", 
         t2.cinema_no     "상영관 번호",
         t2.movie_title   "영화 제목",
         t2.seats         "좌석수"
    from theater t1, cinema t2
   where t1.theater_no = t2.theater_no
     and t1.location like '%잠실%';

--14) 2020년 9월 1일의 극장별 평균 관람 고객 수를 보이시오.
  select t2.theater_name "극장명" , count(*) "관람수"
    from reservation t1, theater t2
   where t1.theater_no = t2.theater_no
     and t1.screening_date ='20200901'
group by t2.theater_no, t2.theater_name;

--15) 2020년 9월 1일에 가장 많은 고객이 관람한 영화를 보이시오.
  select t2.movie_title "영화 제목", count(*) "횟수"
    from reservation t1, cinema t2
   where t1.theater_no = t2.theater_no
     and t1.cinema_no=t2.cinema_no
group by t2.movie_title
  having count(*) in (  select max(count(*))
                          from reservation t1, cinema t2
                         where t1.theater_no = t2.theater_no
                           and t1.cinema_no = t2.cinema_no
                           and t1.screening_date = '20200901'
                      group by t2.movie_title);
                      
INSERT into cinema values(2,4,'검사 외전',10000,50);
commit;
INSERT into customer values(5,'정인수','경주 사는디');
commit;
INSERT into reservation values (3,1,3,10,'20200901');
commit;
INSERT into theater values (4,'CGV','분당');
commit;

UPDATE cinema set price= (price*1.1);
commit;
select price
  from cinema;
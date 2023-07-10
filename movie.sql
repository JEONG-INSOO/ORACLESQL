drop table reservation;
drop table cinema;
drop table theater;
drop table customer;

--�������̺�
create table theater(
    theater_no      number(2),    --�����ȣ
    theater_name    varchar2(60), --�����
    location        varchar2(30)  --��ġ
);
alter table theater add constraint theater_theater_no_pk primary key(theater_no);

--�����̺�
create table customer(
    cust_no         number(2),      --����ȣ
    name            varchar2(12),   --����
    address         varchar2(90)    --�ּ�
);
alter table customer add constraint customer_cust_no_pk primary key(cust_no);

--�󿵰� ���̺�
create table cinema(
    theater_no      number(2),      --�����ȣ
    cinema_no       number(2),      --�󿵰���ȣ
    movie_title     varchar2(30),   --��ȭ����
    price           number(5),      --����
    seats           number(3)       --�¼���
);
alter table cinema add constraint cinema_theater_no_cinema_no_pk 
    primary key(theater_no,cinema_no);
alter table cinema add constraint cinema_theater_no_fk
    foreign key(theater_no) references theater(theater_no);
alter table cinema add constraint cinema_price_ck
    check(price < 20000);
alter table cinema add constraint cinema_cinema_no
    check(cinema_no between 1 and 10 );


--���� ���̺�
create table reservation(
    theater_no      number(2),      --�����ȣ
    cinema_no       number(2),      --�󿵰���ȣ
    cust_no         number(2),      --����ȣ
    seat_no         number(2),      --�¼���ȣ
    screening_date  date            --������
);
alter table reservation add constraint reservation_theater_no_cinema_no_cust_no_pk
    primary key(theater_no,cinema_no,cust_no);
alter table reservation add constraint reservation_theater_no_cinema_no_fk
    foreign key(theater_no,cinema_no) references cinema(theater_no,cinema_no);
alter table reservation add constraint reservation_cust_no_fk
    foreign key(cust_no) references customer(cust_no);
alter table reservation add constraint reservation_cust_no_seat_no_uq
    unique (cust_no,seat_no);
    
--���� ���� ������
insert into theater values(1,'�Ե�','���');
insert into theater values(2,'�ް�','����');
insert into theater values(3,'����','���');

--�� ���� ������
insert into customer values(3,'ȫ�浿','����');
insert into customer values(4,'��ö��','���');
insert into customer values(9,'�ڿ���','����');

--�󿵰� ���� ������
insert into cinema values(1,1,'����� ��ȭ',15000,48);
insert into cinema values(3,1,'���� ��ȭ',7500,120);
insert into cinema values(3,2,'��մ� ��ȭ',8000,110);

--���� ���� ������
insert into reservation values(3,2,3,15,'20200901');
insert into reservation values(3,1,4,16,'20200901');
insert into reservation values(1,1,9,48,'20200901');
commit;
-- 1) ��� ������ �̸��� ��ġ�� ���̽ÿ�
  select theater_name "���� �̸�" , location "��ġ"
    from theater;
    
-- 2) '���'�� �ִ� ������ ���̽ÿ�
  select theater_name "���� �̸�", location "��ġ"
    from theater
   where location = '���'
order by name;

-- 3) '���'�� ��� ���� �̸��� ������������ ���̽ÿ�.
  select name "�� �̸�", address "�ּ�"
    from customer
   where address = '���';
   
-- 4) ������ 8,000�� ������ ��ȭ�� �����ȣ, �󿵰� ��ȣ, ��ȭ ������ ���̽ÿ�.
  select theater_no "���� ��ȣ", cinema_no "�󿵰� ��ȣ", movie_title "��ȭ����"
    from cinema
   where price <= 8000;
   
-- 5) ���� ��ġ�� ���� �ּҰ� ���� ���� ���̽ÿ�.
  select distinct name "�� �̸�", address "�ּ�", location "���� ��ġ"
    from customer, theater
   where address = location;
   
-- 6) ������ ���� �� ���ΰ�?
  select count(cinema_no) "������ ��"
    from cinema;
    
-- 7) �󿵵Ǵ� ��ȭ�� ��� ������ ���ΰ�?
  select avg(price) "��� ����"
    from cinema;
    
-- 8) 2020�� 9�� 1�Ͽ� ��ȭ�� ������ ���� ���� ���ΰ�?
  select count(cust_no) "���� ��"
    from reservation
   where screening_date = '20200901';
   
-- 9) '����'���忡�� �󿵵� ��ȭ������ ���̽ÿ�.
  select movie_title "��ȭ ����", theater_name "���� �̸�"
    from cinema t1, theater t2
   where t2.theater_no =t1.theater_no 
     and theater_name = '����';
                   
  select movie_title "��ȭ ����", theater_name "���� �̸�"
    from cinema t1 inner join theater t2 on t2.theater_no =t1.theater_no 
   where theater_name = '����';
  
  select movie_title
    from cinema
   where theater_no =( select theater_no
                        from theater
                       where theater_name = '����');
                                      
-- 10) '����'���忡�� ��ȭ�� �� ���� �̸��� ���̽ÿ�.
  select t4.name "�� �̸�", t3.theater_name "�����̸�"
    from reservation t1, cinema t2, theater t3, customer t4
   where t1.theater_no = t2.theater_no
     and t1.cust_no = t4.cust_no
     and t1.cinema_no = t2.cinema_no
     and t2.theater_no = t3.theater_no
     and theater_name = '����';
     
-- 11) '����' ������ ��ü ������ ���̽ÿ�
  select sum(t2.price) "���� ������ ��ü ����"
    from reservation t1, cinema t2, theater t3
   where t1.theater_no=t2.theater_no
     and t1.cinema_no = t2.cinema_no
     and t2.theater_no = t3.theater_no
     and t3.theater_name = '����';

  select sum(t2.price) "���� ������ ��ü ����"
    from reservation t1 inner join cinema t2  on  t1.theater_no=t2.theater_no
                                             and  t1.cinema_no = t2.cinema_no
                        inner join theater t3 on t2.theater_no = t3.theater_no
   where t3.theater_name = '����';        
        
  select sum(t2.price) "���� ������ ��ü ����"
    from reservation t1, cinema t2
   where t1.theater_no = t2.theater_no
     and t1.cinema_no = t2.cinema_no
     and t2.theater_no in ( select theater_no
                              from theater
                             where theater_name = '����');
                             
-- 12)���庰 �󿵰� ���� ���̽ÿ�.
  select t1.theater_name "���� �̸�", count(*)
    from theater t1, cinema t2
   where t1.theater_no = t2.theater_no
group by t1.theater_no, t1.theater_name;

--13)'���' �� �ִ� ������ �󿵰��� ���̽ÿ�.
  select t1.theater_name  "���� �̸�", 
         t2.cinema_no     "�󿵰� ��ȣ",
         t2.movie_title   "��ȭ ����",
         t2.seats         "�¼���"
    from theater t1, cinema t2
   where t1.theater_no = t2.theater_no
     and t1.location like '%���%';

--14) 2020�� 9�� 1���� ���庰 ��� ���� �� ���� ���̽ÿ�.
  select t2.theater_name "�����" , count(*) "������"
    from reservation t1, theater t2
   where t1.theater_no = t2.theater_no
     and t1.screening_date ='20200901'
group by t2.theater_no, t2.theater_name;

--15) 2020�� 9�� 1�Ͽ� ���� ���� ���� ������ ��ȭ�� ���̽ÿ�.
  select t2.movie_title "��ȭ ����", count(*) "Ƚ��"
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
                      
INSERT into cinema values(2,4,'�˻� ����',10000,50);
commit;
INSERT into customer values(5,'���μ�','���� ��µ�');
commit;
INSERT into reservation values (3,1,3,10,'20200901');
commit;
INSERT into theater values (4,'CGV','�д�');
commit;

UPDATE cinema set price= (price*1.1);
commit;
select price
  from cinema;
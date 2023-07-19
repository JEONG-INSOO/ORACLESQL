--1. 단일행, 단일열) 연락처가 없는 고객이름을 출력하는 프로시저를 작성하시오.
  CREATE or REPLACE procedure exam1
  as
  l_name customer.name%type;
  begin
    select name into l_name
      from customer
     where phone is null; 
     dbms_output.put_line('이름 : '|| l_name);
  exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  exec exam1;
--2. 단일행, 다중열) 고객의 이름을 입력받아 연락처와 주소를 출력하는 프로시저를 작성.
  CREATE or REPLACE procedure exam2(
  p_name    customer.name%type
  )
  as
  type customer_rec_type is record(
  name    customer.name   %type
, address customer.address%type
, phone   customer.phone  %type
  );
  
  l_rec_customer customer_rec_type;
  begin
    select name, phone, address
      bulk collect into l_rec_customer
      from customer
     where name = p_name;
      dbms_output.put_line(l_rec_customer.name   ||','||
                           l_rec_customer.address||','||
                           l_rec_customer.phone);
  exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  exec exam2('박지성');
--3. 다중행, 단일열)모든 고객이름을 출력하는 프로시저를 작성하시오.
  CREATE or REPLACE procedure exam3
  as
    cursor c1 is 
      select distinct name
        from customer;
  begin
    for rec in c1 loop
        dbms_output.put_line(rec.name);
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  exec exam3;
--4. 다중행, 다중열)고객이름, 주소, 연락처를 출력하는 프로시저를 작성하시오.
  CREATE or REPLACE procedure exam4
  as
    cursor c1 is select *
                   from customer;
  begin
    for rec in c1 loop
     dbms_output.put_line(rec.name    || ' ' ||
                          rec.address || ' ' ||
                          rec.phone);
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  set serveroutput on;
  exec exam4;
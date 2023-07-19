--1. ������, ���Ͽ�) ����ó�� ���� ���̸��� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
  CREATE or REPLACE procedure exam1
  as
  l_name customer.name%type;
  begin
    select name into l_name
      from customer
     where phone is null; 
     dbms_output.put_line('�̸� : '|| l_name);
  exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  exec exam1;
--2. ������, ���߿�) ���� �̸��� �Է¹޾� ����ó�� �ּҸ� ����ϴ� ���ν����� �ۼ�.
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
  exec exam2('������');
--3. ������, ���Ͽ�)��� ���̸��� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
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
--4. ������, ���߿�)���̸�, �ּ�, ����ó�� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
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
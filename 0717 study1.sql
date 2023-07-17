  CREATE table book_log(
    bookid_1    number
,   bookname_1  varchar2(40)
,   publisher_1 varchar2(40)
,   price_1     number
);

  CREATE or REPLACE trigger afterinsertbook
   after insert on book for each row
 declare 
     average number;
   begin 
     insert into book_log
     values (:new.bookid, :new.bookname, :new.publisher, :new.price);
     dbms_output.put_line('�������� book_log ���̺� ���..');
   end;
      
  INSERT into book
  VALUES(20,'���������� 1', '�̻�̵��',25000);
  
  select * from book;
  select * from book_log;
  
commit;  
rollback;

  CREATE or REPLACE function fnc_interest(
   price number
)  return int
as
  myinterest number;
  begin 
    if price >= 30000 then
       myinterest :=price *0.1;

    else
       myinterest := price * 0.05;
    end if;
    return myinterest;
  end;
  
  select orderid, custid, saleprice, fnc_interest(saleprice) interest
    from orders;
    
--��������08-1) insertbook() ���ν����� �����Ͽ� ���� ���� ����ϴ� insertCustomer() ���ν����� �ۼ��Ͻÿ�
CREATE or REPLACE procedure insertCustomer (
  p_custid  in  customer.custid %type
, p_name    in  customer.name   %type
, p_address in  customer.address%type
, p_phone   in  customer.phone  %type) 
  as
   begin 
      insert into customer
      values(p_custid,p_name,p_address,p_phone);
   end;
  select * from customer;
  exec insertcustomer(6,'ȫ�浿','���� ��½ ���� ��½','010-1234-5678');
  
--��������08-2) BookInsertOrUpdate() ���ν����� �����Ͽ� ���� �۾��� �����ϴ� ���ν����� �ۼ��Ͻÿ�.
  CREATE or REPLACE procedure BookInsertOrUpdate(
  p_bookid    in  book.bookid   %type
, p_bookname  in  book.bookname %type
, p_publisher in  book.publisher%type
, p_price     in  book.price    %type)   
  as
      l_cntofbook number := 0;
      l_price     number := 0;
  begin
      select count(*) into l_cntofbook
        from book
       where bookname  = p_bookname
         and publisher = p_publisher;
         
       if l_cntofbook = 0 then
          INSERT into book
          VALUES (p_bookid, p_bookname, p_publisher, p_price);
     else
     --������ ������ ������
      select price into l_price
        from book
       where bookname  = p_bookname
         and publisher = p_publisher;  
     --�����Ϸ��� ���������� �������� ����    
       if    p_price > l_price then
      UPDATE book
         SET price     = p_price
       where bookname  = p_bookname
         and publisher = p_publisher;
         end if;
       end if;
  end;
  
  commit;
  select * from book;
  exec BookInsertOrUpdate(21, '�����ͺ��̽�3', '�Ѻ�', 40000);
  
--��������09-01) ���ǻ簡 '�̻�̵��'�� ������ �̸��� ������ ���� �ִ� ���ν����� �ۼ��Ͻÿ�
  CREATE or REPLACE procedure ISangMedia 
  as
      l_bookname book.bookname%type;
      l_price    book.price   %type;
       cursor c_book is        select bookname, price
                                 from book
                                where publisher = '�̻�̵��' ;
  begin
      open c_book;
      dbms_output.put_line(rpad('������',40,' ')||rpad('����',40,' '));
      loop
         fetch c_book into l_bookname, l_price;
          exit when c_book%notfound;
          dbms_output.put_line(rpad(l_bookname,40,' ')||rpad(l_price,40,' '));
       end loop;
  end;
  set serverout on;
  exec ISangMedia;
 
  CREATE or REPLACE procedure ISangMedia1 
  as
       cursor c_book is        select bookname, price
                                 from book
                                where publisher = '�̻�̵��' ;
  begin
      dbms_output.put_line(rpad('������',40,' ')||rpad('����',40,' '));
       for rec in c_book
      loop
          dbms_output.put_line(rpad(rec.bookname,40,' ')||rpad(rec.price,40,' '));
       end loop;
  end; 
  
  exec ISangMedia1;  
  
  select t2.publisher, sum(t1.saleprice)
    from orders t1, book t2
   where t1.bookid = t2.bookid
group by t2.publisher;

  CREATE or REPLACE procedure excercis9_2
  as
    cursor c_salesbypublisher is select t2.publisher, sum(t1.saleprice) sales
                                   from orders t1, book t2
                                  where t1.bookid = t2.bookid
                               group by t2.publisher;
  begin
    for rec in c_salesbypublisher
    loop
    dbms_output.put_line(rec.publisher || '-' || rec.sales);
    end loop;
    end;
  exec excercis9_2;
      CREATE or REPLACE procedure excercis9_2_2
  as
  begin
    for rec in (select t2.publisher, sum(t1.saleprice) sales
                  from orders t1, book t2
                 where t1.bookid = t2.bookid
              group by t2.publisher)
    loop
    dbms_output.put_line(rec.publisher || '-' || rec.sales);
    end loop;
    end;
  exec excercis9_2_2;
  
--�������� 9-3) ���ǻ纰�� ������ ��հ����� ��� ������ �̸��� ���̽ÿ�.
  CREATE or REPLACE procedure excercise9_3 
  as    
  begin
       for rec in (   select t1.bookname, t1.price, t1.publisher
                        from book t1
                       where t1.price>(select avg(t2.price)
                                         from book t2
                                        where t2.publisher = t1.publisher))
      loop 
          dbms_output.put_line(rec.bookname);
      end loop;
  end;

  CREATE or REPLACE procedure excercise9_3_2
  as    
   l_avg number := 0.0;
  begin
       for rec1 in (select bookname, price, publisher
                     from book)
      loop 
           select avg(price) into l_avg
             from book
            where publisher = rec1.publisher;
         
          if rec1.price > l_avg then
          dbms_output.put_line(rec1.bookname);
          end if;
      end loop;
  end;
exec excercise9_3_2;

--�������� 09-04) ������ ������ �� �� �����ߴ����� �� ���ž��� ���̽ÿ�
  CREATE or REPLACE procedure excercise9_4
  as
    cursor c_q1 is select t2.name, count(t1.orderid) cnt, sum(t1.saleprice) sum
                     from orders t1, customer t2
                    where t1.custid = t2.custid
                 group by t2.custid, t2.name;
  begin 
     for rec in c_q1
     loop
       dbms_output.put_line(rec.name || ',' || rec.cnt ||','||rec.sum);
     end loop;
  end;
  exec excercise9_4;

--�������� 09-05) �ֹ��� �ִ� ���� �̸��� �ֹ� �Ѿ��� ����ϰ�, �ֹ��� ���� ���� �̸��� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
  CREATE or REPLACE procedure excercise9_5
  as
    cursor c_q1 is select custid, name
                     from customer;
    l_sales number := 0.0;
  begin 
    for rec in c_q1 loop
    
      select sum(saleprice) into l_sales
        from orders
       where custid = rec.custid; 
       --�ֹ����� ��
       if l_sales = 0 then
          dbms_output.put_line(rec.name);
       --�ֹ��ִ� ��
       else
          dbms_output.put_line(rec.name || ',' || l_sales);
       end if;
    end loop;
 end;
exec excercise9_5;

  CREATE or REPLACE procedure excercise9_5_2
  as
    --�ֹ��ִ� ��
    cursor c1 is select custid, name
                   from customer t1
                  where exists( select * 
                                  from orders t2
                                 where custid = t1.custid);
    --�ֹ����� ��
    cursor c2 is select custid, name
                   from customer t1
                  where not exists( select * 
                                      from orders t2
                                     where custid = t1.custid);
     l_sales number := 0.0;
  begin
    --�ֹ��ִ� ��
    for rec in c1 loop
       select sum(saleprice)into l_sales
         from orders 
        where custid = rec.custid;
         dbms_output.put_line( rec.name || ',' || l_sales); 
    end loop;
    --�ֹ����� ��
    for rec in c2 loop
         dbms_output.put_line( rec.name );  
    end loop;
end;
exec excercise9_5_2;

CREATE or REPLACE function grade(
  p_sales number
) return varchar2
as
begin
  if p_sales >= 20000 then
     return '���';
  else
     return '����'; 
  end if;
end;

  select t2.custid "����ȣ"
,        t2.name "���̸�" 
,        sum(t1.saleprice) "�Ǹž�" 
,        grade(sum(t1.saleprice)) "���"
    from orders t1, customer t2
   where t1.custid = t2.custid
group by t2.custid,  t2.name;

  CREATE or REPLACE function domestic(
     p_address varchar2
) return varchar2
as
begin
    if p_address like '%���ѹα�%' then
      return '��������';
    else
      return '�ؿܰ���';
    end if;
end;

select name, address, domestic(address)
  from customer;
  
  select domestic(t2.address) "�����ܱ���", sum(t1.saleprice) "�Ǹ��Ѿ�"
    from orders t1, customer t2
   where t1.custid = t2.custid
group by domestic(t2.address);
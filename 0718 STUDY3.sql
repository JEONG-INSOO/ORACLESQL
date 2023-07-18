--1.������ / ���Ͽ� ) ������ �� ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�. 
  CREATE or REPLACE procedure proc1
  as
    l_count number;
  begin
    select count(*) into l_count
      from book;
    dbms_output.put_line('�����Ǽ� : '|| l_count);
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
--2.������ / ���߿� ) ������ȣ�� �Է¹޾� �ش� ���� ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�.
--case2-1) ���������� ����
  CREATE or REPLACE procedure proc2_1(
    p_bookid    book.bookid   %type
  )
  as
    l_bookname  book.bookname %type;
    l_publisher book.publisher%type;
    l_price     book.price    %type;
  begin
    select bookname, publisher, price
      into l_bookname, l_publisher, l_price
      from book
     where bookid = p_bookid ;
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
--case2-2) ���ڵ庯���� ����
  CREATE or REPLACE procedure proc2_2(
    p_bookid    book.bookid   %type
  )
  as
    type book_rec_type is record(
    bookname   book.bookname %type
,   publisher  book.publisher%type
,   price      book.price    %type
    );
    
    l_rec_book book_rec_type;
  begin
    select bookname, publisher, price
      into l_rec_book
      from book
     where bookid = p_bookid ;
      dbms_output.put_line(l_rec_book.bookname ||','||
                           l_rec_book.publisher||','||
                           l_rec_book.price);
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
--3.������ / ���Ͽ� ) ��� ���ǻ� �̸��� ����ϴ� ���ν����� �ۼ��Ͻÿ�.
  CREATE or REPLACE procedure proc3_1
  as
    type public_table_type is table of emp.publisher%type 
        index by binary_interger;
    l_public_table public_table_type;
  begin
    select distinct publisher bulk collect into l_public_table
      from book;
    for idx in 1..l_public_table.count loop
        dbms_output.put_line(l_public_table(idx).publisher);
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
--case3-2)
  CREATE or REPLACE procedure proc3_2
  as
    cursor c1 is 
      select distinct publisher
        from book;
  begin
    for rec in c1 loop
        dbms_output.put_line(rec.publisher);
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
--4.������ / ���߿� ) ���� ������ ����ϴ� ���ν����� �ۼ��Ͻÿ�.
--case1)
  CREATE or REPLACE procedure proc4_1
  as
    type book_table_type is table of book%rowtype
        index by binary_integer;
    l_book_table   book_table_type;
  begin
    select * bulk collect into l_book_table
      from book;
    for idx in 1..l_book_table.count loop
     dbms_output.put_line(l_book_table(idx).bookname);
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
--case2)
  CREATE or REPLACE procedure proc4_2
  as
    cursor c1 is select *
                   from book;
  begin
    for rec in c1 loop
     dbms_output.put_line(rec.bookname);
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
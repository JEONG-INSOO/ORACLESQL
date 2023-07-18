--1.단일행 / 단일열 ) 도서의 총 개수를 출력하는 프로시저를 작성하시오. 
  CREATE or REPLACE procedure proc1
  as
    l_count number;
  begin
    select count(*) into l_count
      from book;
    dbms_output.put_line('도서건수 : '|| l_count);
    exception
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
--2.단일행 / 다중열 ) 도서번호를 입력받아 해당 도서 정보를 출력하는 프로시저를 작성하시오.
--case2-1) 개별변수로 저장
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
--case2-2) 레코드변수로 저장
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
--3.다중행 / 단일열 ) 모든 출판사 이름을 출력하는 프로시저를 작성하시오.
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
--4.다중행 / 다중열 ) 도서 정보를 출력하는 프로시저를 작성하시오.
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
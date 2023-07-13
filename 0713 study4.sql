--스칼라타입 (단일타입)
  declare
    l_bookid    number;
    l_bookname  varchar2(40);
    l_publisher varchar2(40);
    l_price     number;
  begin
    select bookid, bookname, publisher, price
      into l_bookid, l_bookname, l_publisher, l_price
      from book
     where bookid = 1;
     
     dbms_output.put_line(l_bookid || '-' || l_bookname || '-' || l_publisher || '-' || l_price);
  end;
  
--%type
  declare
    l_bookid    book.bookid%type;
    l_bookname  book.bookname%type;
    l_publisher book.publisher%type;
    l_price     book.price%type;
  begin
    select bookid, bookname, publisher, price
      into l_bookid, l_bookname, l_publisher, l_price
      from book
     where bookid = 1;
     
     dbms_output.put_line(l_bookid || '-' || l_bookname || '-' || l_publisher || '-' || l_price);
  end;

--%rowtype
  declare
    rec_book book%rowtype;
  begin
    select bookid, bookname, publisher, price
      into rec_book
      from book
     where bookid = 1;
     
     dbms_output.put_line(rec_book.bookid || '-' || rec_book.bookname || '-' || rec_book.publisher || '-' || rec_book.price);
  end;
  
--%recordtype
  declare
    type book_rec_type is record (
    bookname book.bookname%type,
    publisher book.publisher%type
    );
    rec_book book_rec_type;
    rec_book2 book_rec_type;
  begin
    select bookname, publisher
      into rec_book
      from book
     where bookid = 1;
     
     dbms_output.put_line(rec_book.bookname || '-' || rec_book.publisher);
  end;
  
--%tabletype 
  declare
    type book_rec_type is record (
    bookname book.bookname%type,
    publisher book.publisher%type
    );
  type book_table_type is table of book_rec_type index by binary_integer;
  book_table  book_table_type;
  begin
    select bookname, publisher
      bulk collect into book_table
      from book
     where price > 20000;
       for idx in 1..book_table.count
     loop
     dbms_output.put_line(book_table(idx).bookname || '-' || book_table(idx).publisher);
     end loop;
  end;
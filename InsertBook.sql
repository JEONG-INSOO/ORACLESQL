  CREATE OR REPLACE PROCEDURE InsertBook (
  mybookid    in number,
  mybookname  in varchar2,
  mypublisher in varchar2,
  myprice     in number) as
   begin 
  insert into book(bookid,bookname,publisher,price)
  values(mybookid,mybookname,mypublisher,myprice);
     end;

  DROP PROCEDURE insertbook;
commit;
  select *
    from book;
    
    exec insertbook(13,'����������','������м���',25000);
    

CREATE OR REPLACE PROCEDURE averageprice(
averageval out number
)
as
begin
select avg(price) into averageval
from book
where price is not null;
end;

DECLARE
    averageval number;
begin
    averageprice(averageval);
    dbms_output.put_line('도서가격 : ' || round(averageval,2));
end;

--정수를 입력받아 1을 더해서 반환하는 프로시저를 구현하시오.
CREATE or REPLACE procedure incress_number(
  p_val in out int
)as
begin
  p_val := p_val + 1;
end;
  
declare 
    l_val int;
  begin
    l_val :=10;
    incress_number(l_val);
    dbms_output.put_line(l_val);
    end;
    
  CREATE or REPLACE procedure interest 
  as
    myinterest numeric;
    price      numeric;
    cursor interestcursor is select saleprice
                               from orders;
  begin
    myinterest := 0.0;
    open interestcursor;
    LOOP
        fetch interestcursor into price;
        exit when interestcursor%notfound;
        if price >= 30000 then
           myinterest := myinterest + price * 0.1;
        else
           myinterest := myinterest + price * 0.05;
        end if;
    end LOOP;
    CLOSE interestcursor;
    dbms_output.put_line('전체 이익 금액 =' || myinterest);
    end;
    
    exec interest;
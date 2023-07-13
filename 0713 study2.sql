  CREATE OR REPLACE PROCEDURE AveragePrice(
    AverageVal OUT NUMBER)
  AS
  BEGIN
    SELECT AVG(price) INTO AverageVal FROM Book WHERE price IS NOT NULL;
    END;
/* 프로시저 AveragePrice를 테스트하는 부분 */
  SET SERVEROUTPUT ON;
  DECLARE
    AverageVal NUMBER;
  BEGIN
    AveragePrice(AverageVal);
    DBMS_OUTPUT.PUT_LINE('책값 평균: ' || AverageVal);
    END;
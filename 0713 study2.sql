  CREATE OR REPLACE PROCEDURE AveragePrice(
    AverageVal OUT NUMBER)
  AS
  BEGIN
    SELECT AVG(price) INTO AverageVal FROM Book WHERE price IS NOT NULL;
    END;
/* ���ν��� AveragePrice�� �׽�Ʈ�ϴ� �κ� */
  SET SERVEROUTPUT ON;
  DECLARE
    AverageVal NUMBER;
  BEGIN
    AveragePrice(AverageVal);
    DBMS_OUTPUT.PUT_LINE('å�� ���: ' || AverageVal);
    END;
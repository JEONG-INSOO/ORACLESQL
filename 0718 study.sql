CREATE OR REPLACE TRIGGER emp_sal_chk
BEFORE UPDATE OF sal ON emp
FOR EACH ROW WHEN (NEW.sal < OLD.sal 
      OR NEW.sal > OLD.sal * 1.1)
BEGIN
   raise_application_error(-20502,                         --예외 에러코드
      'May not decrease salary. Increase must be < 10%');  --예외 메세지
END;

drop trigger emp_sal_chk;
alter trigger emp_sal_chk disable;
alter trigger emp_sal_chk enable;

select * from emp;

update emp
    set sal= 700
    where ename = 'SMITH';

CREATE OR REPLACE TRIGGER emp_resource
   BEFORE insert OR update OR delete ON emp
BEGIN
   IF TO_CHAR(SYSDATE,'DY') IN ('토','일')
      OR TO_NUMBER(TO_CHAR(SYSDATE,'HH24'))
         NOT BETWEEN 9 AND 18 THEN
      raise_application_error(-20502,
         '작업할 수 없는 시간 입니다.');
   END IF;
END;

select to_char(sysdate, 'HH24')
    from dual;

CREATE SEQUENCE emp_audit_tr
   INCREMENT BY 1
   START WITH 1
   MAXVALUE 999999
   MINVALUE 1
   NOCYCLE
   NOCACHE;

DROP sequence emp_audit_tr;

CREATE TABLE emp_audit(
   e_id   NUMBER(6)
      CONSTRAINT emp_audit_pk PRIMARY KEY,
   e_name   VARCHAR2(30),
   e_gubun   VARCHAR2(10),
   e_date   DATE);

CREATE OR REPLACE TRIGGER emp_audit_tr
   AFTER insert OR update OR delete ON emp
BEGIN
   IF INSERTING THEN
      INSERT INTO emp_audit
      VALUES(emp_audit_tr.NEXTVAL,USER,'inserting',SYSDATE);
   ELSIF UPDATING THEN
      INSERT INTO emp_audit
      VALUES(emp_audit_tr.NEXTVAL,USER,'updating',SYSDATE);
   ELSIF DELETING THEN
      INSERT INTO emp_audit
      VALUES(emp_audit_tr.NEXTVAL,USER,'deleting',SYSDATE);
   END IF;
END;

--시퀀스의 다음번호 생성
select EMP_AUDIT_TR.nextval
    from dual;
--시퀀스의 최근확인
select EMP_AUDIT_TR.currval
    from dual;

CREATE TABLE emp_audit(
   e_id   NUMBER(6)
      CONSTRAINT emp_audit_pk PRIMARY KEY,
   e_name   VARCHAR2(30),
   e_gubun   VARCHAR2(10),
   e_date   DATE);    
   
select * from emp;
select * from emp_audit;

INSERT into emp
VALUES (9000,'홍길동','회계',7839,to_date('23/07/18','yy/mm/dd'),1000,null,20);

  UPDATE emp
     set sal = 1100
   where empno = 9000;
 
  CREATE table emp_sal_tot as
  select deptno, sum(sal) sal_tot
    from emp
group by deptno;

  select * from emp_sal_tot;
  
create or replace trigger emp_sal_tot_tr
after insert or update of sal or delete on emp
for each row
declare
    l_difference number := 0;
begin
    if inserting then  
        update emp_sal_tot
           set sal_tot = sal_tot + :new.sal
         where deptno = :new.deptno;
    elsif updating then
        l_difference := :old.sal - :new.sal;
        if  l_difference > 0 then
            update emp_sal_tot
               set sal_tot = sal_tot - abs(l_difference)
             where deptno = :new.deptno;
        elsif  l_difference < 0  then
            update emp_sal_tot
               set sal_tot = sal_tot + abs(l_difference)
             where deptno = :new.deptno;
        else
            null;
        end if;
    elsif deleting then
            update emp_sal_tot
           set sal_tot = sal_tot - :old.sal
         where deptno = :old.deptno;
    end if;
end;
select * from emp_sal_tot_tr;
insert into emp
    values(9000,'홍길동','회계',7839,to_date('23/07/18','yy/mm/dd'),1000,null,20);

update emp
   set sal = 1100
where empno = 9000;

delete from emp where empno = 9000;

select max(sal)
  from emp
 where deptno = 20;
 
CREATE or REPLACE function max_salary(
 p_deptno  emp.deptno%type
)return number
as
  l_maxsal number := 0;
begin
  select max(sal) into l_maxsal
  from emp
 where deptno = p_deptno;
 
return l_maxsal;
end;

select max_salary(10)
  from dual;
select distinct deptno, max_salary(deptno)
  from emp;
   
CREATE or REPLACE procedure find_dname2(
 p_ename  emp.ename%type
)as
  l_dname dept.dname%type;
  l_deptno dept.dname%type;
begin
  select deptno into l_deptno
    from emp
   where ename = p_ename;
  if l_deptno is not null then
  select dname into l_dname
    from dept
   where deptno = l_deptno;
  end if;
  dbms_output.put_line(l_dname);
  exception
        when no_data_found then
            dbms_output.put_line(p_ename||'님의 사원 정보가 없습니다');
        when others then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
end;

exec find_dname2('홍길동');

 CREATE or REPLACE procedure sample_procedure(
 --매개변수
 )as
 --지역변수
begin

 --예외처리
 exception
    when others then
        dbms_output.put_line(SQLCODE ||'-'||SQLERRM);
end;



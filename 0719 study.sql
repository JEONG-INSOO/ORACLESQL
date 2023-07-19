--���� 1) �̸�, �޿�, �μ���ȣ�� �Է¹޾� EMP ���̺� �ڷḦ ����ϴ� ��ũ��Ʈ�� �ۼ��ض�.
--       ��, 10�� �μ��� ��� �Է��� �޿��� 20%�� �߰��ϰ�, �ʱⰪ�� 9000���� 9999���� 1�� �����ϴ� �������� �ۼ��Ͽ� ����ϰ� �Ʒ��� ǥ�� ����.

  CREATE or REPLACE procedure exec18_1(
  p_ename   in emp.ename %type
, p_deptno  in emp.deptno%type
, p_sal     in emp.sal   %type
) 
  as
    l_sal emp.sal%type := p_sal;
  begin
    if p_deptno = 10 then
       l_sal := p_sal * 1.2;
    end if;
    INSERT into emp(empno, ename, deptno, sal)
    VALUES(emp_empno_seq.nextval, p_ename, p_deptno, p_sal);
    exception
       when others then
         dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  
  exec exec18_1('ȫ�浿',10,1000);
  exec exec18_1('ȫ�浿2',20,1000);
  select *
    from emp;
    
  DROP sequence emp_empno_seq;
  CREATE sequence emp_empno_seq
    increment by 1
    start with 9000
    minvalue 9000
    maxvalue 99999
    nocycle  --��ȯ���� �ʰڴ�
    nocache; --�̸� ������ ��ȣ�� �������� �ʰڴ�.
    
  select emp_empno_seq.nextval
    from dual;
  select emp_empno_seq.currval
    from dual;
 
  CREATE or REPLACE procedure exec18_2(
  p_name    in emp.ename%type
  )
  as
    l_job emp.job%type;
    l_sal emp.sal%type;
  begin
    select job, sal into l_job,l_sal
      from emp
     where ename = p_name;
     dbms_output.put_line(l_job);
     if l_job in ('MANAGER','ANALYST') then
          l_sal := l_sal *1.5;
     else 
          l_sal := l_sal *1.2;     
     end if;
     UPDATE emp
        set sal = l_sal
      where ename = p_ename;
      dbms_output.put_line(SQL%ROWCOUNT || '���� ���� ���ŵǾ����ϴ�.');
    exception
        when other then
            dbms_output.put_line(SQLCODE||'-'||SQLERRM);
  end;
  
  select *
    from emp;
    exec exec18_2('SCOTT');

  select *
    from emp
   where ename = 'SCOTT'; 
   
-- 1~10������ ���� ���ϴ� ���ν����� �ۼ��Ͻÿ�  
-- 1) basic loop ��
create or replace procedure basicloop
as
    l_sum number := 0;
    l_cnt number := 0;
begin
    loop 
         l_cnt := l_cnt +1;
         l_sum := l_sum + l_cnt;
        exit when l_cnt = 10;
    end loop;
    dbms_output.put_line(l_sum);
end;
-- 2) while loop ��
create or replace procedure whileloop
as
    l_sum number := 0;
    l_cnt number := 0;
begin
    while l_cnt < 10  loop
      l_cnt := l_cnt + 1;
      l_sum := l_sum + l_cnt;
    end loop;
    dbms_output.put_line(l_sum);
end;
-- 3) for loop ��
create or replace procedure forloop
as
    l_sum number := 0;
begin
    for val in 1..10 loop
        l_sum := l_sum + val;
    end loop;
    dbms_output.put_line(l_sum);
end;  

--������ �Է� �޾� ��,��,��,��,���� ����ϱ�
  CREATE or REPLACE procedure grade(
  p_score in number
  )
  as
    l_result varchar2(3);
  begin
    case 
        when p_score >= 90 then
            l_result := '��';
        when p_score >= 80 then
            l_result := '��';
        when p_score >= 70 then
            l_result := '��';
        when p_score >= 60 then
            l_result := '��';        
    else
            l_result := '��';      
    end case;
      dbms_output.put_line(l_result);
end;
  CREATE or REPLACE procedure grade2(
  p_score in number
  )
  as
    l_score number := trunc(p_score / 10);
    l_result varchar2(3);
  begin
    case l_score
        when  9 then
            l_result := '��';
        when  8 then
            l_result := '��';
        when  7 then
            l_result := '��';
        when  6 then
            l_result := '��';        
    else
            l_result := '��';      
    end case;
      dbms_output.put_line(l_result);
end;

/*�޿��� �Է� �޾� �ϳ� �̻��� ���� return �ϸ� ���� ó���⿡�� " ����� �Ѹ� �̽��Դϴ�"�� ����ϰ�,
���� ������ "����� �����ϴ�"�� ����ϰ� �Ѹ� ������ �̸�, ����, �޿��� ����ض�.*/
  select *
    from emp;
    
  ACCEPT p_sal prompt '�޿��� �Է��ϼ���'
  DECLARE
    l_sal emp.sal%type := &p_sal;
    type emp_rec_type is record(
        ename emp.ename%type
,       job   emp.job  %type
,       sal   emp.sal  %type
    );
    l_emp_rec emp_rec_type;
  BEGIN
    select ename, job, sal --������ ���߿� : �������� ������ �� ���̳�, ���ڵ� ������ �����ؼ� ���ڵ带 �޴´�.
      into l_emp_rec
      from emp
    where sal = l_sal;
    dbms_output.put_line(l_emp_rec.ename || 
','||                      l_emp_rec.job ||
','||                      l_emp_rec.sal);
    
    exception
        when no_data_found then
            dbms_output.put_line('�޿��� �´� ����� �����ϴ�.');
        when too_many_rows then
            dbms_output.put_line('2�� �̻��� ����� ��ȸ�Ǿ����ϴ�.');
        when others then
            dbms_output.put_line(SQLCODE ||'-'|| SQLERRM);
end;

set serveroutput on;
/* �޿��� �Է� �޾� -100���� +100 ������ ��� ����� ����Ͽ���. */
  
  CREATE or REPLACE procedure exec21_2(
    p_sal   emp.sal%type
  )as
    cursor c_sal_of_emp is     select ename, sal
                                 from emp
                                where sal between p_sal -100 and p_sal+100; 
  begin
    for rec in c_sal_of_emp loop
        dbms_output.put_line(rec.ename ||','|| rec.sal );
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE ||','|| SQLERRM );
  end;

  CREATE or REPLACE procedure exec21_2_2(
    p_sal   emp.sal%type
  )as
    type emp_rec_type is record(
         ename emp.ename%type
,        sal   emp.sal  %type
);
  type emp_tab_type is table of emp_rec_type index by binary_integer;
  l_emp_tab emp_tab_type;
  begin
    select ename, sal
    bulk collect into l_emp_tab
      from emp
     where sal between p_sal -100 and p_sal +100;
     
    for idx in 1..l_emp_tab.count loop
        dbms_output.put_line(l_emp_tab(idx).ename ||','|| l_emp_tab(idx).sal );
    end loop;
    exception
        when others then
            dbms_output.put_line(SQLCODE ||','|| SQLERRM );
  end;
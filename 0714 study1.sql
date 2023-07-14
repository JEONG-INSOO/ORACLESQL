/*CREATE USER c##sqltest2 IDENTIFIED BY sqltest2 DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##sqltest2;
GRANT CREATE VIEW, CREATE SYNONYM TO c##sqltest2;
GRANT UNLIMITED TABLESPACE TO c##sqltest2;
ALTER USER c##sqltest2 ACCOUNT UNLOCK;*/

/*���̺� ����
DROP table works;
DROP table department;
DROP table project;
DROP table employee;
*/

/*[ �������� ]
1. Employee.salary number(7), 
Works.hoursworked number(3), 
Employee.empno number(4),
Department.deptno number(2), 
Project.projno number(3),
Employee.empno, 
Departmemt.manager �÷��� ���� �������̴�.

2. ��ü ���Ἲ ���������� �ݿ��Ѵ�.
3. ���� ���Ἲ ���������� �ݿ��Ѵ�. 
4. Employee.sex�� char(3)Ÿ��, ����' or '��'�� ������ ������ �� �ִ�. 
5. Works.hoursworked �÷��� ������� ������ �� �ִ�. 
6. ������ Į���� varchar2(20)���� �����Ѵ�. 
7. Employee.name, Department.deptname, Project.projname�� not null �̾���Ѵ�.*/

--[ ���� ]
--1. ���̺��� �����ϴ� create���� �ۼ��ϰ� ������ ���̽ÿ�. �������� �̹ݿ��� 2�� ����. 
--��� ���̺�
CREATE table employee(
     empno       number(4) PRIMARY KEY   --�����ȣ
,    name        varchar2(20)            --�����
,    phoneno     varchar2(20)            --��ġ
,    address     varchar2(20)            --�ּ�
,    sex         varchar2(20)            --����
,    position    varchar2(20)            --����
,    salary      number(7)               --����
,    deptno      number(2)               --�μ���ȣ
    );
ALTER table employee modify(salary number(7));
ALTER table employee modify(empno number(4));
ALTER table employee modify(sex char(3));
ALTER table employee add constraint sex_check check (sex in('��','��'));
ALTER table employee modify name constraint name_not_null not null; 
--�μ� ���̺�
CREATE table department(
     deptno      number(2) PRIMARY KEY   --�μ���ȣ
,    deptname    varchar2(20)            --�μ��̸�
,    manager     number(4)               --�Ŵ��������ȣ
    );
ALTER table department modify(deptno number(2));
ALTER table department modify deptname constraint deptname_not_null not null; 
--������Ʈ ���̺�
CREATE table project(
     projno      number(3) PRIMARY KEY   --������Ʈ ��ȣ
,    projname    varchar(20)             --������Ʈ��
,    deptno      number(2)               --�μ���ȣ
    );
ALTER table project modify(projno number(3));
ALTER table project modify projname constraint projname_not_null not null; 

--�� ���̺�
CREATE table works(
    empno       number(4)                --�����ȣ
,   projno      number(3)                --������Ʈ��ȣ
,   hoursworked number(3)                --������Ʈ �ð�
    );
ALTER table works modify(hoursworked number(3));
ALTER table works add constraint hoursworked_only_plus check (hoursworked > 0 );
ALTER table works add constraint works_empno_fk
    foreign key(empno) references employee(empno);
ALTER table works add constraint works_projno_fk
    foreign key(projno) references project(projno);    
--2. �����͸� �����ϴ� insert���� �ۼ��ϰ� ����� ����� ���̽ÿ�. 
--��� ������
INSERT into employee values(1001,'ȫ�浿1','010-111-1001','���1','��','����',7000000,10);
INSERT into employee values(1002,'ȫ�浿2','010-111-1002','���2','��','����1',4000000,10);
INSERT into employee values(1003,'ȫ�浿3','010-111-1003','���3','��','����2',3000000,10);
INSERT into employee values(1004,'ȫ�浿4','010-111-1004','�λ�1','��','����',6000000,20);
INSERT into employee values(1005,'ȫ�浿5','010-111-1005','�λ�2','��','����1',3500000,20);
INSERT into employee values(1006,'ȫ�浿6','010-111-1006','�λ�3','��','����2',2500000,20);
INSERT into employee values(1007,'ȫ�浿7','010-111-1007','����1','��','����',5000000,30);
INSERT into employee values(1008,'ȫ�浿8','010-111-1008','����2','��','����1',4000000,30);
INSERT into employee values(1009,'ȫ�浿9','010-111-1009','����3','��','����2',3000000,30);
INSERT into employee values(1010,'ȫ�浿10','','����4','��','����3',2000000,30);
INSERT into employee values(1011,'ȫ�浿11','010-111-1011','�뱸1','��','����',5500000,40);
INSERT into employee values(1012,'ȫ�浿12','010-111-1012','�뱸2','��','����1',2000000,40);
INSERT into employee values(1013,'ȫ�浿13','010-111-1013','����1','��','����',6500000,50);
INSERT into employee values(1014,'ȫ�浿14','010-111-1014','����2','��','����1',3500000,50);

--�μ� ������
INSERT into department values(10,'������',1001);
INSERT into department values(20,'ȸ����',1004);
INSERT into department values(30,'������',1007);
INSERT into department values(40,'�ѹ���',1011);
INSERT into department values(50,'�λ���',1013);

--������Ʈ ������
INSERT into project values(101,'������ ����',10);
INSERT into project values(102,'IFRS',20);
INSERT into project values(103,'������',30);

--�� ���̺�
INSERT into works values(1001,101,800);
INSERT into works values(1002,101,400);
INSERT into works values(1003,101,300);
INSERT into works values(1004,102,700);
INSERT into works values(1005,102,500);
INSERT into works values(1006,102,200);
INSERT into works values(1007,103,500);
INSERT into works values(1008,103,400);
INSERT into works values(1009,103,300);
INSERT into works values(1010,103,200);

--3. ���� ����� �̸�, ����ó, �ּҸ� ���̽ÿ�. 
  select name "�̸�", phoneno "����ó", address "�ּ�", sex "����"
    from employee
   where sex = '��';
   
--4. ������ �޿��� 10%�λ��� ���̽ÿ�. (��, department ���̺��� Ȱ���Ͻÿ�.)
  UPDATE employee 
     SET salary = salary * 1.1
   where empno in ( select empno
                      from employee, department
                     where employee.empno = department.manager);      
                     
  commit;
  select * from employee
          where position = '����'; 
          
--5. ��� �� ���� ��(��)�� ���� ����� �� ���̳� �Ǵ��� ���� �ο����� ���Ͻÿ�.
  select substr(name,1,1) "��"
,        count(*)        "�ο�"
    from employee
group by substr(name,1,1);

--6. ������' �μ����� ���ϴ� ����� �̸�, ����ó, �ּҸ� ���̽ÿ�. 
--  (�� ����ó ������ '����ó ����' , ����ó ��4�ڸ� �� ��2�ڸ��� ��ǥ* �� ǥ���Ͻÿ�. (����. 010-111-**78)
  select name "�̸�"
,        nvl2(phoneno,substr(phoneno,1,8) || '**' || substr(phoneno,11,2),'����ó ����') "����ó" 
,        address "�ּ�"
,        t2.deptname "�μ�"
    from employee   t1
,        department t2
   where t1.deptno   = t2.deptno
     and t2.deptname = '������';
     
--7. 'ȫ�浿7' ����(manager) �μ����� ���ϴ� ������ ���� ���̽ÿ�. 
  select count(empno)-1 "������ ��"
    from employee
   where deptno = ( select deptno
                      from employee
                     where name = 'ȫ�浿7');

--8. ������Ʈ�� �������� ���� ����� �̸��� ���̽ÿ�. 
  select name "�̸�"
    from employee t1
   where not exists (select deptno
                       from project t2
                      where t1.deptno = t2.deptno)
order by deptno;

--9. �޿� ���� TOP3�� ������ �Բ� ���̽ÿ�. 
  select rownum "����", name "�̸�", salary "�޿�"
    from    (select name, salary
               from employee
           order by salary desc)
   where rownum <= 3;
   
--10. ������� ���� �ð� ���� �μ���, ��� �̸��� ������������ ���̽ÿ�. 
  select t2.deptname    "�μ� �̸�"
,        t1.name        "��� �̸�"
,        t3.hoursworked "���� �ð� ��"
    from employee t1
,        department t2
,        works t3
   where t1.deptno = t2.deptno
     and t1.empno  = t3.empno
group by t1.name
,        t2.deptname 
,        t3.hoursworked
order by t2.deptname asc
,        regexp_replace(t1.name, '[0-9]') 
,        to_number(regexp_replace(t1.name, '[^0-9]')) asc;

--11. 2�� �̻��� ����� ������ ������Ʈ�� ��ȣ, ������Ʈ��, ����� ���� ���̽ÿ�
  select t1.projno "������Ʈ ��ȣ"
,        t1.projname "������Ʈ��"
,        count(t2.empno) "���� ��� ��"
    from project t1
,        employee t2
   where t1.deptno = t2.deptno
group by t1.projno, t1.projname
  having count(t2.empno) >= 2;
  
--12. 3�� �̻��� ����� �ִ� �μ��� ��� �̸��� ���̽ÿ�. 
  select name     "����̸�"
,        deptname "�μ��̸�"
    from employee   t1
,        department t2
   where t1.deptno = t2.deptno
     and t1.deptno in ( select deptno
                          from employee
                      group by deptno 
                        having count(deptno) > 2)
order by deptname;

--13. ������Ʈ�� �����ð��� ���� ���� ����� ���� ����� �̸��� ���̽ÿ�. 
--? �������� ����

  select max(t1.name) keep(dense_rank first order by t2.hoursworked desc) "���� ���� ���",
         max(t2.hoursworked) "MAX TIME",
         min(t1.name) keep(dense_rank last order by t2.hoursworked desc) "���� ���� ���",
         min(t2.hoursworked) "MIN TIME"
    from employee t1, works t2
   where t1.empno = t2.empno;    
     
--14. ����� ������ ������Ʈ�� ���� �����, ������Ʈ��, �����ð��� ���̴� �並 �ۼ��Ͻÿ�.
    DROP view vw_test;
  CREATE view vw_test as
  select t1.name          "����̸�"
,        t2.projname      "������ ������Ʈ"
,        t3.hoursworked   "�����ð�"
    from employee t1
,        project  t2
,        works    t3
   where t1.deptno = t2.deptno
     and t1.empno  = t3.empno
     and t2.projno = t3.projno;

  select * from vw_test;
     
  commit;
  
--15. EXISTS �����ڷ� '������ ����' ������Ʈ�� �����ϴ� ����� �̸��� ���̽ÿ�. 
  select t1.name     "��� �̸�"
,        t2.projname "������Ʈ ��"
    from employee t1
,        project  t2
   where t1.deptno = t2.deptno
     and exists (select projname
                   from project t3
                  where projname  = '������ ����' 
                    and t3.deptno = t1.deptno);
--16. employee ���̺��� name,phoneno ���� ������� �ε����� �����Ͻÿ�. (��.�ε������� ix_employee2)
  CREATE index ix_employee2 on employee (name , phoneno);
  
  DROP index ix_employee2;
  
  commit;
--17. �μ����� �޿��� �μ���� �޿� ���� ���� ����� �̸��� ������ ���̽ÿ�. 
  select t1.deptname "�μ� �̸�"
,        t2.name     "����̸�"
,        t2.salary   "�޿�"
    from department t1
,        employee t2 right outer join (select deptno, 
                                              avg(salary) avg_salary 
                                         from employee 
                                     group by deptno) t3
      on t2.deptno = t3.deptno 
     and t2.salary > t3.avg_salary
   where t1.deptno = t2.deptno;
   
--18. �μ��� �޿� ���� ��������� 2�� ������ ���̽ÿ�.
  select *
    from(
       select t1.name       "��� �̸�"
,             t1.salary     "�޿�"
,             t2.deptname   "�μ��̸�"
,             row_number() over(partition by t2.deptname 
                                    order by t2.deptname
,                                            t1.salary    desc) "����"
         from employee    t1
,             department  t2
        where t1.deptno = t2.deptno
     order by deptname, salary desc
)
   where "����" <= 2;
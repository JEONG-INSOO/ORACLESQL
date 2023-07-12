desc emp;
desc dept;
--1) ����� �̸��� ������ ����Ͻÿ�.
  select ename "����̸�", 
         job   "�������"
    from emp;
    
--2) 30�� �μ��� �ٹ��ϴ� ��� ����� �̸��� �޿��� ����Ͻÿ�.
  select ename "����̸�",
         sal   "�޿�"
    from emp
   where deptno = 30;
   
--3) �����ȣ�� �̸�, ���� �޿�, 10%�λ�� �޿��� �����ȣ ������ ����Ͻÿ�.
  select ename   "����̸�",
         sal     "����޿�",
         sal*0.1 "������ �޿���",
         sal*1.1 "�λ�� �޿�"
    from emp
order by empno;

--4) 'S'�� �����ϴ� ��� ����� �μ���ȣ�� ����Ͻÿ�.
  select ename  "����̸�",
         deptno "�μ���ȣ"
    from emp
   where ename like 'S%';
   
--5) ��� ����� �ִ� �� �ּ� �޿�, �հ� �� ��� �޿��� ����Ͻÿ�.
   select round(max(sal)) "�ִ� �޿�",
          round(min(sal)) "�ּ� �޿�",
          round(sum(sal)) "�հ�",
          round(avg(sal)) "��� �޿�"
     from emp;
     
--6) ���� �̸��� ������ ������ �ϴ� ��� ���� ����Ͻÿ�.
  select job "������", 
         count(job) "������ �����"
    from emp
group by job;

--7) ����� �ִ�޿��� �ּұ޿��� ������ ����Ͻÿ�.
  select max(sal) "�ִ�޿�",
         min(sal) "�ּұ޿�",
         max(sal) - min(sal) "����"
    from emp
   where job = 'CLERK';
   
--8) 30�� �μ��� ��� ���� ����� �޿��� �հ�� ����� ����Ͻÿ�.
  select count(*) "��� ��",
         sum(sal) "�޿��� �հ�",
         round(avg(sal)) "�޿��� ���"
    from emp
   where deptno = 30;
   
--9) ��� �޿��� ���� ���� �μ��� ��ȣ�� ����Ͻÿ�
  select deptno   "�μ� ��ȣ",
         round(avg(sal)) "��� �޿�"
    from emp
group by deptno
  having avg(sal) = (select max(avg(sal))
                       from emp
                   group by deptno);
                 
--10) ��������� �����ϰ�, �� ������ ����� �� �޿��� 3,000�̻��� �� ������ ���ؼ�, ������� �� ������ ��� �޿��� ����Ͻÿ�.
  select job "������", round(avg(sal),2) "��ձ޿�"
--  select job "������", round(avg(sal),-2) "��ձ޿�"
    from emp t1, dept t2
   where t1.deptno = t2.deptno
     and t1.job <> 'SALESMAN'
--    and t1.job != 'SALESMAN'
--    and t1.job not in ('SALESMAN')
     and t1.job in (  select job
                         from emp
                     group by job
                       having sum(sal) >= 3000)
group by t1.job
order by round(avg(t1.sal),2) desc;

--11) ��ü ��� ��� ���ӻ���� �ִ� ����� ���� ����Ͻÿ�.
  select count(empno) "����� ��"
    from emp
   where mgr is not null;
   
--12) emp ���̺��� �̸�, �޿�, Ŀ�̼Ǳݾ�, �Ѿ��� ���Ͽ� �Ѿ��� ���� ������� ����Ͻÿ�. �� ī�̼��� null �� ����� ����
  select ename "�̸�", sal "�޿�", comm "Ŀ�̼�", sal*12+comm "����"
    from emp
   where comm is not null
order by "����" desc;
--13) �� �μ����� ���� ������ �ϴ� ����� �ο����� ���Ͽ� �μ���ȣ, ���� �̸�, �ο����� ����Ͻÿ�.
  select deptno "�μ���ȣ", job "������" , count(empno)"�ο���"
    from emp
group by deptno, job
order by deptno, job;

--14) ����� 1�� ���� �μ��� �̸��� ����Ͻÿ�.
--case1)
  select t1.dname"�μ� �̸�", t1.deptno "�μ���ȣ"
    from dept t1
   where not EXISTS ( select empno
                        from emp t2
                       where t2.deptno = t1.deptno);
select count(empno) from emp where deptno = '40';
--case 2) 
  select t1.deptno, t1.dname
    from dept t1, emp t2
   where t1.deptno = t2.deptno(+)
     and t2.empno is null;
     
  select t1.deptno, t1.dname
    from dept t1 left outer join emp t2
      on t1.deptno = t2.deptno
   where t2.empno is null;
--case3)
  select deptno, dname
    from dept
   where deptno = ( 
  select t1.deptno
    from dept t1
   minus  
  select t2.deptno
    from emp t2);
--case4)
  select deptno, dname
    from dept
   where deptno not in ( select distinct deptno
                           from emp);
--15) ���� ������ �ϴ� ����� ���� 4�̻��� ������ �ο����� ����Ͻÿ�
  select job "���� �̸�", count(empno) "�ο���"
    from emp
group by job
  having count(empno) >= 4;
  
--16) �����ȣ 7400 �̻� 7600 ������ ����� �̸��� ����Ͻÿ�.
  select ename "����̸�", empno "��� ��ȣ"
    from emp
   where empno between 7400 and 7600;
--case2)
  select ename "����̸�", empno "��� ��ȣ"
    from emp
   where empno >= 7400 and empno < 7600;
--17) ����� �̸��� ����� �μ��̸��� ����Ͻÿ�.
  select t1.ename "��� �̸�", t2.dname "�μ��̸�"
    from emp t1, dept t2
   where t1.deptno = t2.deptno;
    
--18) ����� �̸��� ������ �̸��� ����Ͻÿ�
  select t1.ename "���� �̸�", t2.ename "��� �̸�"
    from emp t1, emp t2
   where t2.mgr = t1.empno;
  
--19) ��� scott���� �޿��� ���� �޴� ����� �̸��� ����Ͻÿ�
  select ename "��� �̸�", sal "�޿�"
    from emp
   where sal  >  (select sal
                    from emp
                   where ename = 'SCOTT');

--20) ��� scott�� ���ϴ� �μ���ȣ Ȥ�� dallas�� �ִ� �μ���ȣ�� ����Ͻÿ�.
  select distinct t1.deptno
    from dept t1, emp t2
   where t1.deptno(+) = t2.deptno
     and t2.ename = 'SCOTT' or t1.loc = 'DALLAS';
--case 2)
  select deptno
    from emp
   where ename = 'SCOTT'
   union
  select deptno
    from dept
   where loc = 'DALLAS';
   
--�������� 4-15)
  CREATE view salesmanview as
  select t1.empno, t1.ename, t1.sal, t2.dname
    from emp t1, dept t2
   where t1.deptno = t2.deptno
     and job = 'SALESMAN';
     
  select empno, ename, sal
    from salesmanview
   where rownum <= 3;
   
  CREATE view salestop as
  select empno, ename, sal, dname
    from salesmanview
   where sal>=1500;
   
  select *
    from salestop;
--self join
select t2.ename "�����" , t1.ename "�����ڸ�"
  from emp t1, emp t2
 where t1.empno = t2.mgr;
 
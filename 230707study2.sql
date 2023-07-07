--self join
select t2.ename "사원명" , t1.ename "관리자명"
  from emp t1, emp t2
 where t1.empno = t2.mgr;
 
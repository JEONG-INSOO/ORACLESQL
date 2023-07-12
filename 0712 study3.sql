desc emp;
desc dept;
--1) 사원의 이름과 업무를 출력하시오.
  select ename "사원이름", 
         job   "사원업무"
    from emp;
    
--2) 30분 부서에 근무하는 모든 사원의 이름과 급여를 출력하시오.
  select ename "사원이름",
         sal   "급여"
    from emp
   where deptno = 30;
   
--3) 사원번호와 이름, 현재 급여, 10%인상된 급여를 사원번호 순으로 출력하시오.
  select ename   "사원이름",
         sal     "현재급여",
         sal*0.1 "증가된 급여분",
         sal*1.1 "인상된 급여"
    from emp
order by empno;

--4) 'S'로 시작하는 모든 사원과 부서번호를 출력하시오.
  select ename  "사원이름",
         deptno "부서번호"
    from emp
   where ename like 'S%';
   
--5) 모든 사원의 최대 및 최소 급여, 합계 및 평균 급여를 출력하시오.
   select round(max(sal)) "최대 급여",
          round(min(sal)) "최소 급여",
          round(sum(sal)) "합계",
          round(avg(sal)) "평균 급여"
     from emp;
     
--6) 업무 이름과 동일한 업무를 하는 사원 수를 출력하시오.
  select job "업무명", 
         count(job) "업무별 사원수"
    from emp
group by job;

--7) 사원의 최대급여와 최소급여의 차액을 출력하시오.
  select max(sal) "최대급여",
         min(sal) "최소급여",
         max(sal) - min(sal) "차액"
    from emp
   where job = 'CLERK';
   
--8) 30번 부서의 사원 수와 사원들 급여의 합계와 평균을 출력하시오.
  select count(*) "사원 수",
         sum(sal) "급여의 합계",
         round(avg(sal)) "급여의 평균"
    from emp
   where deptno = 30;
   
--9) 평균 급여가 가장 높은 부서의 번호를 출력하시오
  select deptno   "부서 번호",
         round(avg(sal)) "평균 급여"
    from emp
group by deptno
  having avg(sal) = (select max(avg(sal))
                       from emp
                   group by deptno);
                 
--10) 세일즈맨을 제외하고, 각 업무별 사원의 총 급여가 3,000이상인 각 업무에 대해서, 업무명과 각 업무별 평균 급여를 출력하시오.
  select job "업무명", round(avg(sal),2) "평균급여"
--  select job "업무명", round(avg(sal),-2) "평균급여"
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

--11) 전체 사원 가운데 직속상관이 있는 사원의 수를 출력하시오.
  select count(empno) "사원의 수"
    from emp
   where mgr is not null;
   
--12) emp 테이블에서 이름, 급여, 커미션금액, 총액을 구하여 총액이 많은 순서대로 출력하시오. 단 카미션이 null 인 사람은 제외
  select ename "이름", sal "급여", comm "커미션", sal*12+comm "연봉"
    from emp
   where comm is not null
order by "연봉" desc;
--13) 각 부서별로 같은 업무를 하는 사람의 인원수를 구하여 부서번호, 업무 이름, 인원수를 출력하시오.
  select deptno "부서번호", job "업무명" , count(empno)"인원수"
    from emp
group by deptno, job
order by deptno, job;

--14) 사원이 1명도 없는 부서의 이름을 출력하시오.
--case1)
  select t1.dname"부서 이름", t1.deptno "부서번호"
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
--15) 같은 업무를 하는 사람의 수가 4이상인 업무와 인원수를 출력하시오
  select job "업무 이름", count(empno) "인원수"
    from emp
group by job
  having count(empno) >= 4;
  
--16) 사원번호 7400 이상 7600 이하인 사원의 이름을 출력하시오.
  select ename "사원이름", empno "사원 번호"
    from emp
   where empno between 7400 and 7600;
--case2)
  select ename "사원이름", empno "사원 번호"
    from emp
   where empno >= 7400 and empno < 7600;
--17) 사원의 이름과 사원의 부서이름을 출력하시오.
  select t1.ename "사원 이름", t2.dname "부서이름"
    from emp t1, dept t2
   where t1.deptno = t2.deptno;
    
--18) 사원의 이름과 팀장의 이름을 출력하시오
  select t1.ename "팀장 이름", t2.ename "사원 이름"
    from emp t1, emp t2
   where t2.mgr = t1.empno;
  
--19) 사원 scott보다 급여를 많이 받는 사람의 이름을 출력하시오
  select ename "사원 이름", sal "급여"
    from emp
   where sal  >  (select sal
                    from emp
                   where ename = 'SCOTT');

--20) 사원 scott이 일하는 부서번호 혹은 dallas에 있는 부서번호를 출력하시오.
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
   
--연습문제 4-15)
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
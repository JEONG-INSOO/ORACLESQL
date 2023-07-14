/*CREATE USER c##sqltest2 IDENTIFIED BY sqltest2 DEFAULT TABLESPACE users TEMPORARY TABLESPACE temp PROFILE DEFAULT;
GRANT CONNECT, RESOURCE TO c##sqltest2;
GRANT CREATE VIEW, CREATE SYNONYM TO c##sqltest2;
GRANT UNLIMITED TABLESPACE TO c##sqltest2;
ALTER USER c##sqltest2 ACCOUNT UNLOCK;*/

/*테이블 삭제
DROP table works;
DROP table department;
DROP table project;
DROP table employee;
*/

/*[ 제약조건 ]
1. Employee.salary number(7), 
Works.hoursworked number(3), 
Employee.empno number(4),
Department.deptno number(2), 
Project.projno number(3),
Employee.empno, 
Departmemt.manager 컬럼은 동일 도메인이다.

2. 개체 무결성 제약조건을 반영한다.
3. 참조 무결성 제약조건을 반영한다. 
4. Employee.sex는 char(3)타입, ‘남' or '여'의 값만을 저장할 수 있다. 
5. Works.hoursworked 컬럼은 양수값만 저장할 수 있다. 
6. 나머지 칼럼은 varchar2(20)으로 정의한다. 
7. Employee.name, Department.deptname, Project.projname은 not null 이어야한다.*/

--[ 문제 ]
--1. 테이블을 생성하는 create문을 작성하고 구조를 보이시오. 제약조건 미반영시 2점 감점. 
--사원 테이블
CREATE table employee(
     empno       number(4) PRIMARY KEY   --사원번호
,    name        varchar2(20)            --극장명
,    phoneno     varchar2(20)            --위치
,    address     varchar2(20)            --주소
,    sex         varchar2(20)            --성별
,    position    varchar2(20)            --직급
,    salary      number(7)               --월급
,    deptno      number(2)               --부서번호
    );
ALTER table employee modify(salary number(7));
ALTER table employee modify(empno number(4));
ALTER table employee modify(sex char(3));
ALTER table employee add constraint sex_check check (sex in('남','여'));
ALTER table employee modify name constraint name_not_null not null; 
--부서 테이블
CREATE table department(
     deptno      number(2) PRIMARY KEY   --부서번호
,    deptname    varchar2(20)            --부서이름
,    manager     number(4)               --매니저사원번호
    );
ALTER table department modify(deptno number(2));
ALTER table department modify deptname constraint deptname_not_null not null; 
--프로젝트 테이블
CREATE table project(
     projno      number(3) PRIMARY KEY   --프로젝트 번호
,    projname    varchar(20)             --프로젝트명
,    deptno      number(2)               --부서번호
    );
ALTER table project modify(projno number(3));
ALTER table project modify projname constraint projname_not_null not null; 

--일 테이블
CREATE table works(
    empno       number(4)                --사원번호
,   projno      number(3)                --프로젝트번호
,   hoursworked number(3)                --프로젝트 시간
    );
ALTER table works modify(hoursworked number(3));
ALTER table works add constraint hoursworked_only_plus check (hoursworked > 0 );
ALTER table works add constraint works_empno_fk
    foreign key(empno) references employee(empno);
ALTER table works add constraint works_projno_fk
    foreign key(projno) references project(projno);    
--2. 데이터를 삽입하는 insert문을 작성하고 저장된 결과를 보이시오. 
--사원 데이터
INSERT into employee values(1001,'홍길동1','010-111-1001','울산1','남','팀장',7000000,10);
INSERT into employee values(1002,'홍길동2','010-111-1002','울산2','남','팀원1',4000000,10);
INSERT into employee values(1003,'홍길동3','010-111-1003','울산3','남','팀원2',3000000,10);
INSERT into employee values(1004,'홍길동4','010-111-1004','부산1','여','팀장',6000000,20);
INSERT into employee values(1005,'홍길동5','010-111-1005','부산2','남','팀원1',3500000,20);
INSERT into employee values(1006,'홍길동6','010-111-1006','부산3','남','팀원2',2500000,20);
INSERT into employee values(1007,'홍길동7','010-111-1007','서울1','남','팀장',5000000,30);
INSERT into employee values(1008,'홍길동8','010-111-1008','서울2','남','팀원1',4000000,30);
INSERT into employee values(1009,'홍길동9','010-111-1009','서울3','남','팀원2',3000000,30);
INSERT into employee values(1010,'홍길동10','','서울4','남','팀원3',2000000,30);
INSERT into employee values(1011,'홍길동11','010-111-1011','대구1','여','팀장',5500000,40);
INSERT into employee values(1012,'홍길동12','010-111-1012','대구2','남','팀원1',2000000,40);
INSERT into employee values(1013,'홍길동13','010-111-1013','제주1','남','팀장',6500000,50);
INSERT into employee values(1014,'홍길동14','010-111-1014','제주2','남','팀원1',3500000,50);

--부서 데이터
INSERT into department values(10,'전산팀',1001);
INSERT into department values(20,'회계팀',1004);
INSERT into department values(30,'영업팀',1007);
INSERT into department values(40,'총무팀',1011);
INSERT into department values(50,'인사팀',1013);

--프로젝트 데이터
INSERT into project values(101,'빅데이터 구축',10);
INSERT into project values(102,'IFRS',20);
INSERT into project values(103,'마케팅',30);

--일 테이블
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

--3. 여자 사원의 이름, 연락처, 주소를 보이시오. 
  select name "이름", phoneno "연락처", address "주소", sex "성별"
    from employee
   where sex = '여';
   
--4. 팀장의 급여를 10%인상해 보이시오. (단, department 테이블을 활용하시오.)
  UPDATE employee 
     SET salary = salary * 1.1
   where empno in ( select empno
                      from employee, department
                     where employee.empno = department.manager);      
                     
  commit;
  select * from employee
          where position = '팀장'; 
          
--5. 사원 중 같은 성(姓)을 가진 사람이 몇 명이나 되는지 성별 인원수를 구하시오.
  select substr(name,1,1) "성"
,        count(*)        "인원"
    from employee
group by substr(name,1,1);

--6. 영업팀' 부서에서 일하는 사원의 이름, 연락처, 주소를 보이시오. 
--  (단 연락처 없으면 '연락처 없음' , 연락처 끝4자리 중 앞2자리는 별표* 로 표시하시오. (예시. 010-111-**78)
  select name "이름"
,        nvl2(phoneno,substr(phoneno,1,8) || '**' || substr(phoneno,11,2),'연락처 없음') "연락처" 
,        address "주소"
,        t2.deptname "부서"
    from employee   t1
,        department t2
   where t1.deptno   = t2.deptno
     and t2.deptname = '영업팀';
     
--7. '홍길동7' 팀장(manager) 부서에서 일하는 팀원의 수를 보이시오. 
  select count(empno)-1 "팀원의 수"
    from employee
   where deptno = ( select deptno
                      from employee
                     where name = '홍길동7');

--8. 프로젝트에 참여하지 않은 사원의 이름을 보이시오. 
  select name "이름"
    from employee t1
   where not exists (select deptno
                       from project t2
                      where t1.deptno = t2.deptno)
order by deptno;

--9. 급여 상위 TOP3를 순위와 함께 보이시오. 
  select rownum "순위", name "이름", salary "급여"
    from    (select name, salary
               from employee
           order by salary desc)
   where rownum <= 3;
   
--10. 사원들이 일한 시간 수를 부서별, 사원 이름별 오름차순으로 보이시오. 
  select t2.deptname    "부서 이름"
,        t1.name        "사원 이름"
,        t3.hoursworked "일한 시간 수"
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

--11. 2명 이상의 사원이 참여한 프로젝트의 번호, 프로젝트명, 사원의 수를 보이시오
  select t1.projno "프로젝트 번호"
,        t1.projname "프로젝트명"
,        count(t2.empno) "투입 사원 수"
    from project t1
,        employee t2
   where t1.deptno = t2.deptno
group by t1.projno, t1.projname
  having count(t2.empno) >= 2;
  
--12. 3명 이상의 사원이 있는 부서의 사원 이름을 보이시오. 
  select name     "사원이름"
,        deptname "부서이름"
    from employee   t1
,        department t2
   where t1.deptno = t2.deptno
     and t1.deptno in ( select deptno
                          from employee
                      group by deptno 
                        having count(deptno) > 2)
order by deptname;

--13. 프로젝트에 참여시간이 가장 많은 사원과 적은 사원의 이름을 보이시오. 
--? 공동꼴찌 구분

  select max(t1.name) keep(dense_rank first order by t2.hoursworked desc) "가장 많은 사원",
         max(t2.hoursworked) "MAX TIME",
         min(t1.name) keep(dense_rank last order by t2.hoursworked desc) "가장 적은 사원",
         min(t2.hoursworked) "MIN TIME"
    from employee t1, works t2
   where t1.empno = t2.empno;    
     
--14. 사원이 참여한 프로젝트에 대해 사원명, 프로젝트명, 참여시간을 보이는 뷰를 작성하시오.
    DROP view vw_test;
  CREATE view vw_test as
  select t1.name          "사원이름"
,        t2.projname      "참가한 프로젝트"
,        t3.hoursworked   "참가시간"
    from employee t1
,        project  t2
,        works    t3
   where t1.deptno = t2.deptno
     and t1.empno  = t3.empno
     and t2.projno = t3.projno;

  select * from vw_test;
     
  commit;
  
--15. EXISTS 연산자로 '빅데이터 구축' 프로젝트에 참여하는 사원의 이름을 보이시오. 
  select t1.name     "사원 이름"
,        t2.projname "프로젝트 명"
    from employee t1
,        project  t2
   where t1.deptno = t2.deptno
     and exists (select projname
                   from project t3
                  where projname  = '빅데이터 구축' 
                    and t3.deptno = t1.deptno);
--16. employee 테이블의 name,phoneno 열을 대상으로 인덱스를 생성하시오. (단.인덱스명은 ix_employee2)
  CREATE index ix_employee2 on employee (name , phoneno);
  
  DROP index ix_employee2;
  
  commit;
--17. 부서별로 급여가 부서평균 급여 보다 높은 사원의 이름과 월급을 보이시오. 
  select t1.deptname "부서 이름"
,        t2.name     "사원이름"
,        t2.salary   "급여"
    from department t1
,        employee t2 right outer join (select deptno, 
                                              avg(salary) avg_salary 
                                         from employee 
                                     group by deptno) t3
      on t2.deptno = t3.deptno 
     and t2.salary > t3.avg_salary
   where t1.deptno = t2.deptno;
   
--18. 부서별 급여 높은 사원순으로 2위 까지만 보이시오.
  select *
    from(
       select t1.name       "사원 이름"
,             t1.salary     "급여"
,             t2.deptname   "부서이름"
,             row_number() over(partition by t2.deptname 
                                    order by t2.deptname
,                                            t1.salary    desc) "순위"
         from employee    t1
,             department  t2
        where t1.deptno = t2.deptno
     order by deptname, salary desc
)
   where "순위" <= 2;
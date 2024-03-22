-- 조인: 2개이상의 테이블을 조회하여 하나의 결과를 반환.
-- ANSI SQL 문법을 사용하여, DBMS마다 SQL문의 호환이 가능하다.

-- CROSS JOIN : 테이블 A와 테이블 B의 모든 행의 조합, 카타시안 곱

select count(*) 
from 부서; -- 4
select count(*)
from 사원; -- 10

select 부서.부서번호 
	,부서명, 이름
	,사원.부서번호 
from 부서
cross join 사원; -- 40: 4*10

-- inner 조인: 두 테이블 사이의 공통된 값을 기준으로 결과를 반환
-- 1. 등가조인(이퀴조인): = 등호로 조인한다.
-- 2. 비등가조인(논이퀴 조인): 등호 외 비교연산자로 조인한다.

select  사원번호, 직위, 사원.부서번호, 부서명
from  사원
inner join 부서
on 사원.부서번호 = 부서.부서번호 
where 이름 ='이소미'

-- 조인 + group by 절
select 고객.고객번호,담당자명,고객회사명,count(*) as 주문건수
from 고객
inner join 주문
on 고객.고객번호 =주문.고객번호
group by 1,2,3;

-- 3개의 테이블에서 inner 등가조인 예)
-- 고객번호별로 주문금액합을 구하자.
select 고객.고객번호, 담당자명, 고객회사명,sum(주문수량*단가) as 주문금액합 
from 고객
inner join 주문
on 고객.고객번호 = 주문.고객번호
inner join 주문세부
on 주문.주문번호 =주문세부.주문번호
group by 1,2,3
order by 4 desc;

-- inner 조인 : 비등가 조인
select 고객번호, 마일리지, 담당자명, 등급명
from 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
and 담당자명='이은광';

-- outer join: 조건(등가, 비등가)에 맞지않는 행도 결과값으로 나옴

-- 사원테이블에서 부서명이 null인 행도 출력한다.
select 부서명, 사원.*
from 사원
right outer join 부서
on 사원.부서번호=부서.부서번호;

select 이름,부서.*
from 사원
left outer join 부서
on 사원.부서번호=부서.부서번호
where 부서.부서번호 is null;

-- 셀프조인: 한개의 테이블을 대상으로 조인하는 것.
select 사원.사원번호, 사원.이름, 상사.사원번호 as '상사의 사원번호'
	,상사.이름 as '상사의 이름'
from 사원
inner join 사원 as 상사
on 사원.상사번호 = 상사.사원번호;











-- 단일행 서브쿼리
-- 최고 마일리지를 보유한 고객의 정보를 구하시오
select *
from  고객
where 마일리지=(select max(마일리지)
			from 고객);
			
select 고객회사명, 담당자명
from 고객
where 고객번호=(select 고객번호 from 주문
where 주문번호 ='H0250');

-- 복수행 서브 쿼리: 복수행 비교연산자 in, any/some, all, exists

-- 부산광역시 고객이 주문한 주문건수를 출력하기

select count(*) as 주문건수
from 주문
where 고객번호 in (select 고객번호 from 고객
				where 도시='부산광역시');
				
			
select 담당자명, 고객회사명, 마일리지
from 고객
where 마일리지>any(select 마일리지 from 고객
				where 도시='부산광역시'); -- 최솟값보다 큰거
				
select 담당자명, 고객회사명, 마일리지
from 고객
where 마일리지> all(select avg(마일리지) from 고객
				group by 지역); -- 최댓값보다 큰거
				
-- exists: 행의 존재여부로 비교
select 고객번호, 고객회사명
from 고객
where exists (select * from 주문 where 고객번호=고객.고객번호); 

-- 인라인 뷰:from 절 안의 서브쿼리
select 담당자명, 고객회사명, 마일리지,고객.도시, 도시_평균마일리지, 도시_평균마일리지-마일리지 as 차이
from 고객,
	(
		select 도시, avg(마일리지) as 도시_평균마일리지
		from 고객
		group by 도시
	) as 도시별요약
where 고객.도시 = 도시별요약.도시;

-- 스칼라 서브쿼리: 메인쿼리의 select문 안에 사용되는 서브쿼리
-- 행을 0개 반환하면 null이 되고, 2개이상 반환하면 오류 발생
select 고객번호,담당자명,(select max(주문일) from 주문 where 주문.고객번호=고객.고객번호) as 최종주문일
from 고객;

-- CTE(Common Table Expression)
-- 임시 테이블
with 도시별요약 as
(
	select 도시,avg(마일리지)as 도시_평균마일리지
	from 고객
	group by 도시
)
select 담당자명, 고객회사명, 마일리지, 고객.도시, 도시_평균마일리지,도시_평균마일리지-마일리지 as 차이
from 고객, 도시별요약
where 고객.도시 = 도시별요약.도시;
			
			
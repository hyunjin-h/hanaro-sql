-- ch04
-- 집계함수

select 담당자직위, max(마일리지) as 최대마일리지
from 고객
where 도시 like '%광역시'
group by 담당자직위
having max(마일리지)>=10000;

select count(*) from 고객; -- null을 포함한 모든 행의 개수

-- 컬럼의 개수는 null을 빼고 집계한다.
select count(고객번호),count(도시),count(지역) from 고객;

select sum(마일리지),avg(마일리지),min(마일리지),max(마일리지)
from 고객
where 도시='서울특별시';

-- group by : 특정컬럼에 대한 집계를 할때
select 도시, count(*) as '도시별 고객수'
	,avg(마일리지) as '도시별 평균마일리지'
from 고객
group by 도시;

-- group by 컴
select 담당자직위, 도시
	, count(*) as 고객수
	, avg(마일리지) as 마일리지평균
from 고객
group by 1, 2
order by 1, 2;

-- having: select문에 들어가는 컬럼과 집계함수에만 적용 가능;
select 도시
	,count(*) as 고객수
	,avg(마일리지) as 평균마일리지
from 고객
group by 도시
having count(*)>=10;

-- where절과 having절을 같이쓸 때
select 도시
	,고객번호
	,sum(마일리지)
from 고객
where 고객번호 like 'T%'
group by 도시,고객번호
having sum(마일리지)>=1000;

-- rollup
select ifnull(도시,'총계')
	,count(*) as 고객수
	,avg(마일리지) as 평균마일리지
from 고객
group by 도시
with rollup;

select 담당자직위, 도시
	,count(*) as 고객수
from 고객
group by 담당자직위,도시
with rollup;

select 지역
	,count(*) as 고객수
	,grouping(지역) as 구분 -- 1이면 rollup 행, 0이면 아님
from 고객
where 담당자직위='대표 이사'
group by 지역
with rollup;

-- group_concat(): 여러행의 문자열을 결합해줌
-- 사원테이블의 이름을 모두 결합하여 출력
select group_concat(이름)
from 사원;

select group_concat(distinct 지역)
from 고객;

select 도시
	,group_concat(distinct 고객회사명) as 고객회사명목록 
from 고객
group by 도시;

























 
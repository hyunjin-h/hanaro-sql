use 세계무역;

select * from 고객;

-- 출력되는 행의 개수
select count(*)
from 고객;

select 고객번호,담당자명, 고객회사명,마일리지 as 포인트
		,마일리지*1.1 as "10% 인상된 마일리지"
from 고객
where 마일리지>=100000
order by 포인트;

-- 집합 연산자 union union all
-- union : 두개의 select결과를 합쳐줌.
-- 	     : 컬럼의 갯수와 타ㅣㅇㅂ을 일치시켜야함
-- union all : 중복되는 레코드도 다 출력해줌

select 고객번호, 도시, 마일리지
from 고객
where 도시='부산광역시'
union
select 고객번호, 도시, 마일리지
from 고객
where 마일리지 <1000
order by 마일리지;


select  고객번호, 담당자명, 마일리지,도시
from 고객
where 도시='부산광역시' or 마일리지<1000
order by 1;

-- is null 연산자

select count(*)
from 고객
where 지역 is null; -- null은 명시적으로 들어가있어야함
-- update 전에는 count->0 후에는 ->66
-- csv의 비어있는 데이터를 임포트할 때, ''빈문자열로 들어와서!

select count(*)
from 고객
where 지역 ='';

-- update를 활용하여 빈문자열을 null로 처리
update 고객
set 지역=null
where 지역='';

select *
from 고객
where 지역 is null;
-- ~중의 하나, where or를 간결화
select 고객번호
from 고객
where 담당자직위 in ('영업 과장','마케팅 과장');
-- ~에서 ~까지의 논리, where and를 간결화
select 담당자명, 마일리지
from 고객
where 마일리지 between 100000 and 200000;

-- like 절 : 유사한 문자열을 검색할 때
select * 
from 고객
where 도시 like '%광역시'
and (고객번호 like '_C%' or 고객번호 like '__C%');

select * from 고객 where 전화번호 like '%45';
select * from 고객 where 전화번호 like '%45_';
select * from 고객 where 전화번호 like '%45%';

select * from 고객 where 도시='서울특별시' and 마일리지 between 15000 and 20000;
select distinct 지역,도시 from 고객 order by 지역, 도시;
select *
from 고객
where 도시 in('춘천시','과천시','광명시')
and (담당자직위 like '%이사%'or 담당자직위 like '%사원%');

select *
from 고객
where not(도시 like '%특별시%' or 도시 like '%광역시%')
order by 마일리지 desc
limit 3;

select *
from 고객
where 지역 is not null and 담당자직위<>'대표 이사';


select * from 제품 where 제품명 like '%주스%';
select * from 제품 where (단가 between 5000 and 10000) and 제품명 like '%주스%';
select * from 제품 where 제품번호 in (1,2,4,7,11,20);
select 제품번호, 제품명, 단가, 재고, 단가 * 재고 as 재고금액
from 제품
order by 재고금액 desc
limit 10;
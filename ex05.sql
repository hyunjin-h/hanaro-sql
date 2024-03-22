select 제품명, sum(주문수량) 주문수량합, sum(주문수량*주문세부.단가) 주문금액합
from 제품
inner join 주문세부
on 제품.제품번호=주문세부.제품번호
group by 제품명;

select * from 주문;
select * from 주문세부;
select * from 제품;

select year(주문.주문일) 주문년도, 제품.제품명, sum(주문세부.주문수량) 주문수량합
from 주문
inner join 주문세부
on 주문.주문번호=주문세부.주문번호
inner join 제품
on 주문세부.제품번호 = 제품.제품번호
where 제품명 like '%아이스크림%'
group by 주문년도, 제품명;

select 제품명, sum(주문수량) 주문수량합
from 제품
left outer join 주문세부
on 제품.제품번호=주문세부.제품번호
group by 제품명;

select * from 고객;
select * from 마일리지등급;

select 고객번호, 고객회사명, 담당자명, 등급명,마일리지
from 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
where 등급명 = 'A';


-- 실전문제
select 등급명, count(고객번호) 고객수ㅁ
from 고객
inner join 마일리지등급
on 마일리지 between 하한마일리지 and 상한마일리지
group by 등급명
order by 등급명;

select 주문번호,고객.*
from 주문
left outer join 고객
on 주문.고객번호=고객.고객번호
where 주문번호='H0249';

select 주문일,고객.*
from 주문
left outer join 고객
on 주문.고객번호=고객.고객번호
where 주문일='2020-04-09';

select 도시, sum(단가*주문수량) 주문금액합
from 주문
left outer join 주문세부
on 주문.주문번호 =주문세부.주문번호 
left outer join 고객
on 주문.고객번호 = 고객.고객번호
group by 도시
order by 주문금액합 desc
limit 5;

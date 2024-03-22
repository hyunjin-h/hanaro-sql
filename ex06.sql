-- 1
select 부서명
from 부서
join 사원
on 부서.부서번호 =사원.부서번호
where 이름='배재용';

-- 2
select 제품.*
from 제품
left outer join 주문세부
on 제품.제품번호 =주문세부.제품번호
where 주문번호 is null;

-- 3
select 담당자명,고객회사명,count(*) 주문건수, min(주문일) 최초주문일,max(주문일) 최종주문일
from 고객
left outer join 주문
on 주문.고객번호 = 고객.고객번호
group by 고객.고객번호
having 최초주문일 is not null;


-- 실전문제

select 제품명 from 제품 
where 단가=(select max(단가) from 제품);


select 제품명, sum(주문수량) 주문수량합
from 주문세부
join 제품
on 주문세부.제품번호 =제품.제품번호 
where 제품.단가=(select max(단가)from 제품)
group by 주문세부.제품번호;

select 제품명, sum(주문수량) 주문수량합
from 주문세부
join 제품
on 주문세부.제품번호 =제품.제품번호
where 제품명 like '%아이스크림%'
group by 주문세부.제품번호;

select year(주문일) 주문년도, count(*) 주문건수
from 주문
left outer join 고객
on 주문.고객번호 = 고객.고객번호
where 도시='서울특별시'
group by 주문년도;


-- 정답
-- 연습문제
-- 3
select 담당자명, 고객회사명, 주문건수, 최초주문일, 최종주문일
from 고객, (select 고객번호, count(*) as 주문건수, min(주문일) as 최초주문일, max(주문일) as 최종주문일
			from 주문
			group by 고객번호
            ) as 주문요약
where 고객.고객번호 = 주문요약.고객번호;

-- 실전문제
-- 3
select sum(주문수량) 주문수량합
from 주문세부
where 주문세부.제품번호 in (select 제품번호 from 제품 where 제품명 like '%아이스크림%');
-- 4
SELECT YEAR(주문일) AS 주문년도, COUNT(*) AS 주문건수 
FROM 주문
WHERE 고객번호 IN (SELECT 고객번호 FROM 고객
					WHERE 도시 = "서울특별시")
GROUP BY 주문년도 with rollup;

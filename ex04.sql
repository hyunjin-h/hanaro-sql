-- 1
select count(도시),count(distinct 도시)
from 고객;

-- 2
select year(주문일) as 주문년도, count(*) as 주문건수
from 주문
group by 주문년도;

-- 3
select year(주문일) as 주문년도
	, quarter(주문일) as 분기
	, count(*) as 주문건수
from 주문
group by 주문년도, 분기 with rollup;

-- 4
select month(주문일)as 주문월
	,count(*) as 주문건수
from 주문
where datediff(요청일,발송일)<0 --  요청일<발송일 도 가능!
group by 주문월
order by 주문월;

-- 5
select 제품명, sum(재고) as 재고합
from 제품
where 제품명 like '%아이스크림%'
group by 제품명;

-- 6
select if(마일리지>50000,'VIP고객','일반고객') as 고객구분
,count(*) as 고객수
,avg(마일리지) as 평균마일리지
from 고객
group by 고객구분;



-- 실전문제
select sum(주문수량) as 주문수량합
, sum(단가*주문수량) as 주문금액합
from 주문세부;

select 주문번호, 제품번호, sum(단가*주문수량) as 주문금액합
from 주문세부
group by 주문번호, 제품번호
order by 주문번호;

select 고객번호,count(*) as 주문건수
from 주문
where year(주문일)=2021
group by 고객번호
order by 주문건수 desc
limit 3;

select * from 사원;
select 직위, 이름,count(*) as 사원수
from 사원
group by 직위, 이름 with rollup;






-- 정답
-- 연습문제
-- 1. 고객 테이블의 도시 컬럼에는 몇 개의 도시가 들어있을까? 도시 수와 중복 값을 제외한 도시 수를 보이시오.
--   COUNT()안에 DISTINCT를 넣으면 중복 값을 한 번씩만 셉니다.
SELECT 도시
	  ,COUNT(도시)
      ,COUNT(DISTINCT 도시)
FROM 고객
GROUP BY 도시;
-- 2. 주문 테이블에서 주문년도별로 주문건수를 조회하시오.
-- GROUP BY절에는 SELECT절에 있는 집계 함수를 제외한 나머지 컬럼이나 함수, 수식을 반드시 넣어주어야 합니다.
SELECT YEAR(주문일) AS 주문년도
       ,COUNT(*) AS 주문건수
FROM 주문
GROUP BY YEAR(주문일);
-- 3. 결과 화면을 참조하여 주문 테이블에서 (주문년도, 분기)별 주문건수, 주문년도별 주문건수, 전체 주문건수를 한번에 조회하시오.
-- YEAR()를 사용하면 주문년도만 얻을 수 있고, QUARTER()를 사용하면 분기만 얻을 수 있습니다.
-- WITH ROLLUP을 추가하면 GROUP BY의 결과와 함께 주문년도별 주문건수와 전체 주문건수도 한번에 확인 할 수 있습니다.
-- WITH ROLLUP : 분류별 소계를 구하는 구문
SELECT YEAR(주문일) AS 주문년도
      ,QUARTER(주문일) AS 분기
      ,COUNT(*) AS 주문건수
FROM 주문
GROUP BY YEAR(주문일)
        ,QUARTER(주문일)
WITH ROLLUP;
-- 4. 주문 테이블에서 요청일보다 발송이 늦어진 주문내역이 월별로 몇 건씩인지 요약하여 조회하시오. 이때 주문월 순서대로 정렬하여 보이시오.
-- MONTH() 함수를 사용하면 주문일 컬럼에서 월을 얻을 수 있습니다.
SELECT MONTH(주문일) AS 주문월
      ,COUNT(*) AS 주문건수
FROM 주문
WHERE 요청일 < 발송일
GROUP BY MONTH(주문일)
ORDER BY MONTH(주문일);
-- 5.제품 테이블에서 ‘아이스크림’제품들에 대해서 제품명별로 재고합을 보이시오.
SELECT 제품명
      ,SUM(재고) AS 재고합
FROM 제품
WHERE 제품명 LIKE '%아이스크림%'
GROUP BY 제품명;
-- 6. 고객 테이블에서 마일리지가 50,000점 이상인 고객은 ‘VIP고객’,
--  나머지 고객은 ‘일반고객’으로 구분하고, 고객구분별로 고객수와 평균마일리지를 보이시오.
SELECT IF(마일리지 >= 50000, 'VIP고객', '일반고객') AS 고객구분
	  ,COUNT(*) AS 고객수
      ,AVG(마일리지) AS 평균마일리지
FROM 고객
GROUP BY IF(마일리지 >= 50000, 'VIP고객', '일반고객');
-- 실전문제
-- 1. 주문세부 테이블에서 주문수량합과 주문금액합을 보이시오.
SELECT *
FROM 주문세부;
SELECT SUM(주문수량) AS 주문수량합
	 ,SUM(단가 * 주문수량) AS 주문금액합
FROM 주문세부;
-- 2. 주문세부 테이블에서 주문번호별로 주문된 제품번호의 목록과 주문금액합을 보이시오.
SELECT 주문번호,
		제품번호,
		SUM(단가*주문수량) AS 주문금액합
FROM 주문세부
GROUP BY 주문번호, 제품번호
ORDER BY 주문번호;
-- 3. 주문 테이블에서 2021년 주문내역에 대해서 고객번호별로 주문건수를 보이된,
--     주문건수가 많은 상위 3건의 고객의 정보만 보이시오.
SELECT 고객번호,
	COUNT(*) AS 주문건수
FROM 주문
WHERE YEAR(주문일) = 2021
GROUP BY 고객번호
ORDER BY 주문건수 DESC
LIMIT 3;
-- 4. 사원 테이블에서 직위별로 사원수와 사원이름목록을 보이시오.
SELECT 직위, COUNT(직위), 이름
FROM 사원
GROUP BY 직위, 이름
ORDER BY 직위;

SELECT 직위, COUNT(직위), GROUP_CONCAT(이름 SEPARATOR ', ')
FROM 사원
GROUP BY 직위
ORDER BY 직위;

use 세계무역;
select * from 고객;
-- 1
select 고객회사명
	,concat('**', substr(고객회사명, 3)) 고객회사명2
	,전화번호
	,substr(replace(전화번호,')','-'),2) 전화번호2
from 고객;

select * from 주문세부;
-- 2
select  *, 주문수량*단가 as 주문금액
	,truncate(주문수량 * 단가 * 할인율,-1) as 할인금액
	,truncate((주문수량 * 단가) *(1-할인율),-1) as 실주문금액
from 주문세부;

-- 3
select 이름, 생일
	,timestampdiff(year,생일,now()) as 만나이
	,입사일
	,datediff(now(),입사일) as 입사일수
	,adddate(입사일,500) as `입사 500일후`
from 사원;

-- 4
select 담당자명, 고객회사명, 도시
	,if((도시 like '%특별시%') or (도시 like '%광역시%'), '대도시','도시') as 도시구분
	,마일리지
	,case when 마일리지>100000 then 'VVIP고객'
		when 마일리지>10000 then'VIP고객'
		else '일반고객' end 고객구분
	from 고객;

select 주문번호, 고객번호, 주문일
	,year(주문일) as 주문년도
	,quarter(주문일) as 분기
	,month(주문일) as 월
	,day(주문일) as 일
	,weekday(주문일) as 주문요일
	,case weekday(주문일)
	when 0 then '월요일'
	when 1 then '화요일'
	when 2 then '수요일'
	when 3 then '목요일'
	when 4 then '금요일'
	when 5 then '토요일'
	when 6 then '일요일' end 한글요일
from 주문;

select *,datediff(발송일,요청일) as 지연일수
from 주문
where datediff(발송일,요청일)>=7;

select 담당자명
from 고객
where 담당자명 like '%정%';

select *,quarter(주문일) as 분기
from 주문
where quarter(주문일)=2; 

select 제품번호, 제품명, 재고
	,case when 재고>100 then '과다재고'
	when 재고>10 then '적정'
	else '재고부족' end 재고구분
from 제품;

select 이름, 부서번호, 직위, 입사일
	,datediff(now(),입사일) as 입사일수
	,timestampdiff(month, 입사일, now()) as 입사개월수
from 사원
where timestampdiff(month, 입사일, now())>40;
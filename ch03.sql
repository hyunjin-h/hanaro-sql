-- 글자 길이
SELECT CHAR_LENGTH('HELLO')		-- 글자 길이
	, LENGTH('HELLO')			-- 글자 바이트 수
    , CHAR_LENGTH('한글')
    , LENGTH('한글');			-- utf8 유니코드(한글자 3바이트)

-- 문자열 연결
SELECT CONCAT('DREAMS', 'COME', 'TRUE');

-- 구분자를 이용한 문자열 연결
SELECT CONCAT_WS('-','2024','03','19');

-- 문자열 일부 가져오기
SELECT LEFT('SQL 완전정복', 3);
SELECT RIGHT('SQL 완전정복', 4);
SELECT SUBSTR('SQL 완전정복', 2, 5);	-- 시작인덱스(1부터 시작), 개수
SELECT SUBSTR('SQL 완전정복', 2);		-- 인덱스부터 끝까지

-- 문자열 제거후 가져오기
SELECT SUBSTRING_INDEX('서울시 동작구 흑석로',' ',2);	-- 양수면 왼쪽에서
SELECT SUBSTRING_INDEX('서울시 동작구 흑석로',' ',-2);	-- 음수면 오른쪽에서

-- 자릿수 채움 문자
SELECT LPAD('SQL', 10, '#');	-- #######SQL
SELECT RPAD('SQL', 5, '*');		-- SQL**

-- 공백 제거
SELECT LENGTH(LTRIM('   sql'));
SELECT LENGTH(rtrim ('   sql    '));

-- 특정문자 제거(trim)
select trim(both '###' from '###SQL###');
select trim(both '#'from '###SQL###');
select trim(both '##'from '###SQL###');

select trim(both 'abc' from 'abcSQLSQLabcabc');
select trim(leading 'abc' from 'abcSQLSQLabcabc');
select trim(trailing 'abc' from 'abcSQLSQLabcabc');



-- 문자열 선택
select field('java','sql','java','c');-- 2 반환
select find_in_set('java','SQL,java,c'); -- 2 반환
select instr('네 인생을 살아라','인생');-- 3반환
select locate('인생','네 인생을 살아라');-- 3반환
select elt(2,'sql','java','c'); -- 'java' 반환

-- 문자열 중복
select repeat ('x',6);
select concat(repeat ('x',6), 'star');

-- 문자열 치환
select replace('010.5597.7436','.','-');

-- 문자열 거꾸로
select reverse('olleh');

-- 소수점 관련 함수들
select ceiling(123.56);
select floor(123.56);
select round(123.56,1);
select round(1234.56,-1); -- 일의 자리에서 반올림
select truncate(123.56,1);
select truncate(123.56,-1); -- 일의 자리에서 버림

-- 절대값
select abs(-1);

-- 부호
select sign(-200);

-- 나머지
select mod(203,4), 203%4, 203 mod 4;


-- 제곱
select power(2,3);

-- 제곱근
select sqrt(4);

-- 랜덤
select rand(); 
select rand(100); -- 안에 seed를 설정하면 매번 동일한 임의의 값을 얻을 수 있다.
select round(rand()*100); -- 0.0~0.999 *100 => 99.5~99.9=> 0~100
select round(rand()*100+1); -- 1~100값


-- 현재 날짜시간 가져오기
select now(), sysdate();

-- 현재 날짜 가져오기
select curdate();

-- 현재 시간 가져오기
select curtime(); 

-- 날짜 간격 구하기
select now(), datediff('2025-12-20',now())  -- (640)
			, datediff(now(),'2025-12-20');	-- (-640)

select timestampdiff(year,now(),'2025-12-20')
		,timestampdiff(month,now(),'2025-12-20')
		,timestampdiff(day,now(),'2025-12-20');
	

select datediff('2024-03-21 9:34',now()) -- 자정기준
		,timestampdiff(day,now(),'2024-03-21 9:34');-- 만 24시간까지 고려

select now()
		,adddate(now(),50)
		,adddate(now(), interval 50 day)	-- 50일 후
		,adddate(now(), interval 50 month) 	-- 50달 후
		,subdate(now(),interval 50 hour); 	-- 50시간전

select last_day(now()) -- 이번달의 마지막일
		,dayofyear(now()) -- 올해의 지난 날
		,monthname(now()) -- 이번달의 이름 (March)
		,weekday(now());-- 월요일(0) ~일요일(6)

-- 형변환
select cast('1' as unsigned); -- 부호없는 숫자로 변환
select cast(2 as char(1)); -- char형 1자리로 변환
select convert('1', unsigned);
select convert(2,char(1));

-- 조건함수
select if(10>20,'10','20');
select if(12500*450>50000,'초과달성','미달성');
-- null체크함수
select ifnull(1,0);
select ifnull(null,0);
select ifnull(null,'null입니다') ;

select nullif(12*10,120); -- 1항과 2항이 같으면 null, 같지않으면 1항 반환
select nullif(12*100,120);

-- 조건문 select case문
select case 
	when 10 <20 then '20보다 작음'
	when 10<30 then'30보다 작음'
	else '그외의 수'
end;



 
		
		
-- 내가 태어난 지 
select datediff(now(),'2001-08-23');
select adddate('2001-08-23',10000); 
select case weekday('2001-08-23')
	when 0 then '월요일'
	when 1 then '화요일'
	when 2 then '수요일'
	when 3 then '목요일'
	when 4 then '금요일'
	when 5 then '토요일'
	when 6 then '일요일' end `내 생일 요일`;










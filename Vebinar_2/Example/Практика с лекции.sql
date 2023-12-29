Комментарии

--лдаптдлывтп валдптвфдыалптсми вкпфвап
/*select customer_id--, store_id
from customer */

select customer_id, /*store_id,*/ email
from customer 

/*
 * dfkjgakdsfg
 * sd;lfkg;ldsfg
 * dlfmg;ldsf
 * dl;'fg;'df
 */

Отличие ' ' от " "

'' - указания значений
"" - указания сущностей

set search_path to "dvd-rental"

Зарезервированные слова

select "name"
from "language" 

select "name"
from "language" 

select select
from from

синтаксический порядок инструкции select;

select - все, что нужно вывести в результат, столбцы, вычисления
from - указывается основная таблица 
join - указываете все остальные таблицы, которые нужно использовать в рамках запроса
on - условие на основании которого будут присоединяться данные
where - условие, которое фильтрует результат
group by - группирует данные
having - условие, кторое фильтрует по результату агрегации
order by - сортировка данных

логический порядок инструкции select;

from
on
join
where
group by
having
over
select -- указание алиасов
order by

select customer_id
from customer 
where first_name = 'MARY'

pg_typeof(), приведение типов

select pg_typeof('100')

int 		| text 
100::int	100::text

select pg_typeof('100'::int::varchar::numeric)

select pg_typeof(cast('100' as numeric))

1. Получите атрибуты id фильма, название, описание, год релиза из таблицы фильмы.
Переименуйте поля так, чтобы все они начинались со слова Film (FilmTitle вместо title и тп)
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- as - для задания синонимов 

select film_id, title, description, release_year
from film 

select film_id as FilmFilm_id, title as FilmTitle, description as FilmDescription, release_year as FilmRelease_Year
from film 

select film_id FilmFilm_id, title FilmTitle, description FilmDescription, release_year FilmRelease_Year
from film 

select film_id "FilmFilm_id", title "FilmTitle", description "FilmDescription", release_year "Год выпуска фильма"
from film 

select 1 as "когда Вы пишите название ну очень длинное и не хорошее"

идентификатор "когда Вы пишите название ну очень длинное и не хорошее" будет усечён до 
"когда Вы пишите название ну очень "

64 байта
32 символа

select 1 / 2 as x

select "Год выпуска фильма", staff_first_name
from (
	select c.first_name as "Год выпуска фильма", s.first_name staff_first_name
	from customer c, staff s) t

2. В одной из таблиц есть два атрибута:
rental_duration - длина периода аренды в днях  
rental_rate - стоимость аренды фильма на этот промежуток времени. 
Для каждого фильма из данной таблицы получите стоимость его аренды в день,
задайте вычисленному столбцу псевдоним cost_per_day
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- стоимость аренды в день - отношение rental_rate к rental_duration
- as - для задания синонимов 

integer 
numeric - строго финансы
float - допустима погрешность, важна скорость
numeric(8, 2) 999999.99

999989.99
999999.99

2.5 -> 3
2.5 -> 2

select title, rental_rate / rental_duration as cost_per_day
from film 

2*
- арифметические действия
- оператор round

select title, rental_rate / rental_duration as cost_per_day,
	rental_rate + rental_duration as cost_per_day,
	rental_rate - rental_duration as cost_per_day,
	rental_rate * rental_duration as cost_per_day,
	power(rental_rate, rental_duration) as cost_per_day,
	mod(rental_rate, rental_duration) as cost_per_day
from film 

select title, rental_rate / rental_duration as cost_per_day
from film 

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 

round(numeric, int)

round(float)

select title, (rental_rate / rental_duration)::numeric(5,2) as cost_per_day
from film 

select x,
	round(x::numeric) num,
	round(x::float) fl
from generate_series(0.5, 10.5, 1) x

3.1 Отсортировать список фильмов по убыванию стоимости за день аренды (п.2)
- используйте order by (по умолчанию сортирует по возрастанию)
- desc - сортировка по убыванию

select title, (rental_rate / rental_duration)::numeric(5,2) as cost_per_day
from film 
order by (rental_rate / rental_duration)::numeric(5,2) --asc

select title, (rental_rate / rental_duration)::numeric(5,2) as cost_per_day
from film 
order by (rental_rate / rental_duration)::numeric(5,2) desc

select title, (rental_rate / rental_duration)::numeric(5,2) as cost_per_day
from film 
order by cost_per_day desc

select title, (rental_rate / rental_duration)::numeric(5,2) as cost_per_day
from film 
order by 2 desc

select title, (rental_rate / rental_duration)::numeric(5,2) as cost_per_day
from film 
order by 2 desc, film_id

3.1* Отсортируйте таблицу платежей по возрастанию суммы платежа (amount)
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- используйте order by 
- asc - сортировка по возрастанию 

select *
from payment
order by amount

3.2 Вывести топ-10 самых дорогих фильмов по стоимости за день аренды
- используйте limit

1 - 1000
2,3,4 - 990
5-20 - 980
топ 3 
1 + два случайных из 2,3,4
1-20

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
limit 10

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
fetch first 10 rows only

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
limit 10

--ранжирование - оконные функции
--агрегацию с подзапросом
--лимит с остатком c 13 версии

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
fetch first 10 rows with ties

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by title
fetch first 10 rows with ties

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc, title
fetch first 10 rows with ties

3.2.1 Вывести топ-1 самых дорогих фильмов по стоимости за день аренды, то есть вывести все 62 фильма
--начиная с 13 версии

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
fetch first 1 rows with ties

3.3 Вывести топ-10 самых дорогих фильмов по стоимости аренды за день, начиная с 58-ой позиции
- воспользуйтесь Limit и offset

select title, round(rental_rate / rental_duration, 2) as cost_per_day
from film 
order by 2 desc
offset 57
limit 10

3.3* Вывести топ-15 самых низких платежей, начиная с позиции 14000
- воспользуйтесь Limit и offset

select *
from payment 
order by amount
offset 13999
limit 15

4. Вывести все уникальные годы выпуска фильмов
- воспользуйтесь distinct

explain analyze --122.33 / 0.41
select distinct film_id, release_year
from film
order by 1

explain analyze --93.46 / 0.22
select film_id, release_year
from film 
order by 1

4* Вывести уникальные имена покупателей
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- воспользуйтесь distinct

select first_name --599
from customer 

select distinct first_name --591
from customer 

4.1 нужно получить последний платеж каждого пользователя

select distinct on (customer_id) *
from payment 
order by customer_id, payment_date desc

select distinct on (customer_id) *
from payment 
order by customer_id, payment_date 

5.1. Вывести весь список фильмов, имеющих рейтинг 'PG-13', в виде: "название - год выпуска"
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- "||" - оператор конкатенации, отличие от concat
- where - конструкция фильтрации
- "=" - оператор сравнения

select title, release_year, rating
from film 

select title || ' - ' || release_year, rating
from film 

select concat(title, ' - ', release_year), rating
from film 

select 'hello' || null

select concat('hello', null)

select concat(last_name, ' ', first_name, ' ', middle_name)
from person p

select concat_ws(' ', last_name, first_name, middle_name)
from person p

select *, concat_ws(' ', *)
from person p

select concat(title, ' - ', release_year), rating
from film 
where rating = 'PG-13'

5.2 Вывести весь список фильмов, имеющих рейтинг, начинающийся на 'PG'
- cast(название столбца as тип) - преобразование
- like - поиск по шаблону
- ilike - регистронезависимый поиск
- lower
- upper
- length

like 
% - любое кол-во символов
_ - один любой символ

select concat(title, ' - ', release_year), rating
from film 
where rating like 'PG%'

SQL Error [42883]: ОШИБКА: оператор не существует: mpaa_rating ~~ unknown

select concat(title, ' - ', release_year), pg_typeof(rating)
from film 

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like '%3'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'PG___'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like '%-%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text not like '%-%'

select concat(title, ' - ', release_year), rating
from film 
where title like '%-%-%'

select concat(title, ' - ', release_year), rating
from film 
where rating::text like 'P%3'

select concat(title, ' - ', release_year), rating
from film 
where rating::text ilike 'pG%'

select concat(title, ' - ', release_year), rating
from film 
where title like '%\%%'

select concat(title, ' - ', release_year), rating
from film 
where title like '%~%%' escape '~'

select upper(concat_ws(' ', last_name, first_name, middle_name))
from person p

select lower(upper(concat_ws(' ', last_name, first_name, middle_name)))
from person p

select initcap(lower(upper(concat_ws(' ', last_name, first_name, middle_name))))
from person p

select initcap('aaa.bbb7ccc ddd%eee')

select concat_ws(' ', last_name, first_name, middle_name)
from person p
where last_name like 'А__________'

select concat_ws(' ', last_name, first_name, middle_name)
from person p
where last_name like 'А%' and char_length(last_name) = 10

select character_length('привет мир')

select char_length('привет мир')

select length('привет мир')

select octet_length('привет мир')

5.2* Получить информацию по покупателям с именем содержашим подстроку'jam' (независимо от регистра написания),
в виде: "имя фамилия" - одной строкой.
- "||" - оператор конкатенации
- where - конструкция фильтрации
- ilike - регистронезависимый поиск
- strpos
- character_length
- overlay
- substring
- split_part

select strpos('hello world', 'world')

select substring('hello world' from 3 for 3)

select substring('hello world', 3, 3)

select left('hello world', 3)

select left('hello world', -3)

select right('hello world', 3)

select right('hello world', -3)

select split_part(concat_ws(' ', last_name, first_name, middle_name), ' ', 1) s1,
	split_part(concat_ws(' ', last_name, first_name, middle_name), ' ', 2) s2,
	split_part(concat_ws(' ', last_name, first_name, middle_name), ' ', 3) s3
from person p

Литвинова 1
Амелия 2
Егоровна 3

select concat_ws(' ', last_name, first_name, middle_name), 
	overlay(concat_ws(' ', last_name, first_name, middle_name) placing 'Nikolay'
	from strpos(concat_ws(' ', last_name, first_name, middle_name), 'Николай') 
	for char_length('Николай'))
from person p
where first_name = 'Николай'

6. Получить id покупателей, арендовавших фильмы в срок с 27-05-2005 по 28-05-2005 включительно
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- between - задает промежуток (аналог ... >= ... and ... <= ...)
- date_part()
- date_trunc()
- interval

timestamp 
date 
time 
timestamptz 
timetz 
interval

ЛОКАЛЬ !!!

select payment_date
from payment 
where payment_date = '13.08.2006'

show lc_collate

yyyy-mm-dd
dd-mm-yyyy

select '2023-03-30 21:33:28.545659+10'::timestamptz
		2023-03-30 15:33:28.545659+04
	
--ложный запрос
select *
from payment p
where payment_date >= '27-05-2005' and payment_date <= '28-05-2005'

--ложный запрос
select *
from payment p
where payment_date between '27-05-2005 00:00:00' and '28-05-2005 00:00:00'
order by payment_date desc

--можно, но не нужно
select *
from payment p
where payment_date between '27-05-2005 00:00:00' and '28-05-2005 24:00:00'
order by payment_date desc

select *
from payment p
where payment_date between '27-05-2005 00:00:00' and '29-05-2005'
order by payment_date desc

select *
from payment p
where payment_date between '27-05-2005 00:00:00' and '28-05-2005'::date + interval '1d'
order by payment_date desc

--как нужно
select *
from payment p
where payment_date::date between '27-05-2005' and '28-05-2005'
order by payment_date desc

6* Вывести платежи поступившие после 2005-07-08
- используйте ER - диаграмму, чтобы найти подходящую таблицу
- > - строгое больше (< - строгое меньше)

select *
from payment p
where payment_date::date > '2005-07-08'

7. Получить количество дней с '30-04-2007' по сегодняшний день.
Получить количество месяцев с '30-04-2007' по сегодняшний день.
Получить количество лет с '30-04-2007' по сегодняшний день.

select current_timestamp

select current_time

select current_date

select current_user

select current_schema

select now()

select date_part('year', now()),
	date_part('month', now()),
	date_part('day', now()),
	date_part('hour', now()),
	date_part('minutes', now()),
	date_part('seconds', now()),
	date_part('isodow', now()),
	date_part('epoch', now()),
	date_part('quarter', now())
	
3 / 2023  sum(amount)
3 / 2022  sum(amount)
	
select date_trunc('year', now()),
	date_trunc('month', now()),
	date_trunc('day', now()),
	date_trunc('hour', now()),
	date_trunc('minutes', now()),
	date_trunc('seconds', now()),
	date_trunc('quarter', now())
	
3 / 2023  sum(amount)
3 / 2022  sum(amount)	

timestamp - timestamp = interval 
date - date = integer

--дни:
select current_date - '30-04-2007'

--Месяцы:
select date_part('year',age('30-04-2007'::timestamp)) * 12 + date_part('month',age('30-04-2007'::timestamp)) 

--Года:
select current_timestamp - '30-04-2007'

select age(current_timestamp, '30-04-2007')

select date_part('year',age('30-04-2007'::timestamp))

8. Булев тип

true 1 'yes' 'on' 'y'
false 0 'no' 'off' 'n'

select *
from customer
where activebool

select *
from customer
where activebool is TRUE

select *
from customer
where activebool = false 

select *
from customer
where activebool is false 

9 Логические операторы and и or

and - *
or - +

select customer_id, amount
from payment 
where (customer_id = 1 or customer_id = 2) and (amount = 2.99 or amount = 4.99)

where (a + b) * (c + d)

select customer_id, amount
from payment 
where customer_id < 3 and (amount = 2.99 or amount = 4.99)

select customer_id, amount
from payment 
where true or false and true


Есть вопрос больше практический - из 1 таблицы нужно выдернуть выборку по типу:
1) Заказы в статусе №1 по конкретному магазину
2) Заказы в статусе №2 по конкретному магазину
3) Заказы в статусе №3 по конкретному магазину
4) Заказы в статусе №4 по конкретному магазину
DBeaver ругается в стиле - "В ответе более 2 строк" причем по факту данные хранятся в одной таблице  и по заказам  и по 
их кол-ву и по магазинам
при этом магазины должны быть отсортированы по убыванию

select customer_id, amount
from payment 
order by 1, 2

select staff_id, coalesce(dt::text, 'итого'), count
from (
	select staff_id, date_part('month', payment_date) dt, count(*)
	from payment p
	where date_part('month', payment_date) in (6,7,8)
	group by cube (1, 2)
	order by 1, 2) t 
	
select x::text
from (
	select x
	from generate_series(6,8,1) x
	order by 1) t
union all
select 'итого'

select *
from hr_for_check.crosstab($$
select staff_id, coalesce(dt::text, 'итого'), count
from (
	select staff_id, date_part('month', payment_date) dt, count(*)
	from payment p
	where date_part('month', payment_date) in (6,7,8)
	group by cube (1, 2)
	order by 1, 2) t $$,
	$$
	select x::text
	from (
		select x
		from generate_series(6,8,1) x
		order by 1) t
	union all
	select 'итого'$$) as cst ("staff_id" int, "6" int, "7" int, "8" int, "итого" int )
	
$$ = '


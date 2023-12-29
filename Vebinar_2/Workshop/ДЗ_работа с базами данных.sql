--=============== МОДУЛЬ 2. РАБОТА С БАЗАМИ ДАННЫХ =======================================
--= ПОМНИТЕ, ЧТО НЕОБХОДИМО УСТАНОВИТЬ ВЕРНОЕ СОЕДИНЕНИЕ И ВЫБРАТЬ СХЕМУ PUBLIC===========
SET search_path TO public;

--======== ОСНОВНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите уникальные названия городов из таблицы городов.
{code:sql}
SELECT
	DISTINCT c.city
FROM
	city c
{code}


--ЗАДАНИЕ №2
--Доработайте запрос из предыдущего задания, чтобы запрос выводил только те города,
--названия которых начинаются на “L” и заканчиваются на “a”, и названия не содержат пробелов.
SELECT
	DISTINCT t.city
FROM
	city t
WHERE
	POSITION (' ' IN t.city) = 0
	AND t.city LIKE 'L%a'



--ЗАДАНИЕ №3
--Получите из таблицы платежей за прокат фильмов информацию по платежам, которые выполнялись 
--в промежуток с 17 июня 2005 года по 19 июня 2005 года включительно, 
--и стоимость которых превышает 1.00.
--Платежи нужно отсортировать по дате платежа.

SELECT
	t.*
FROM
	payment t
WHERE
	t.payment_date :: date BETWEEN '2005-06-17' AND '2005-06-19' AND t.amount > 1
ORDER BY t.payment_date 


--ЗАДАНИЕ №4
-- Выведите информацию о 10-ти последних платежах за прокат фильмов.

SELECT
	*
FROM
	payment t
ORDER BY
	t.payment_date DESC
LIMIT 10




--ЗАДАНИЕ №5
--Выведите следующую информацию по покупателям:
--  1. Фамилия и имя (в одной колонке через пробел)
--  2. Электронная почта
--  3. Длину значения поля email
--  4. Дату последнего обновления записи о покупателе (без времени)
--Каждой колонке задайте наименование на русском языке.

SELECT
	concat_ws (' ', t.first_name, t.last_name) AS "Покупатель" 
	,t.email AS "Адрес"
	,char_length(t.email) AS "Длина поля"
	,t.last_update::date AS "Дата обовления"
FROM
	customer t



--ЗАДАНИЕ №6
--Выведите одним запросом только активных покупателей, имена которых KELLY или WILLIE.
--Все буквы в фамилии и имени из верхнего регистра должны быть переведены в нижний регистр.

SELECT
	t.customer_id, 
	t.store_id, 
	lower(t.first_name)  first_name,
	lower(t.last_name)  last_name,
	t.email,
	t.address_id,
	t.activebool,
	t.create_date,
	t.last_update,
	t.active 
FROM
	customer t
WHERE
	t.first_name IN ('KELLY', 'WILLIE')
	AND t.active = 1



--======== ДОПОЛНИТЕЛЬНАЯ ЧАСТЬ ==============

--ЗАДАНИЕ №1
--Выведите информацию о фильмах, у которых рейтинг “R” и стоимость аренды указана от 
--0.00 до 3.00 включительно, а также фильмы c рейтингом “PG-13” и стоимостью аренды больше или равной 4.00.

SELECT
	*
FROM
	film t
WHERE
	t.rating = 'R'
	AND t.rental_rate BETWEEN 0 AND 3
	OR (t.rating = 'PG-13'
		AND t.rental_rate >= 4)


--ЗАДАНИЕ №2
--Получите информацию о трёх фильмах с самым длинным описанием фильма.

SELECT
	char_length(t.description),
	t.*
FROM
	film t
ORDER BY char_length(t.description) desc 
LIMIT 3

--ЗАДАНИЕ №3
-- Выведите Email каждого покупателя, разделив значение Email на 2 отдельных колонки:
--в первой колонке должно быть значение, указанное до @, 
--во второй колонке должно быть значение, указанное после @.
SELECT
	split_part(t.email,'@', 1) AS "before @",
	split_part(t.email,'@', 2) AS "after @"
FROM
	customer t



--ЗАДАНИЕ №4
--Доработайте запрос из предыдущего задания, скорректируйте значения в новых колонках: 
--первая буква строки должна быть заглавной, остальные строчными.

SELECT
	initcap(split_part(t.email,'@', 1)) AS "before @",
	initcap(split_part(t.email,'@', 2)) AS "after @"
FROM
	customer t;

SELECT
	concat_ws('',substring(split_part(t.email,'@', 1),1,1),lower(substring(split_part(t.email,'@', 1),2, char_length(split_part(t.email,'@', 1))-1))) AS "before @",
	concat_ws('',upper(substring(split_part(t.email,'@', 2),1,1)), lower(substring(split_part(t.email,'@', 2),2, char_length(split_part(t.email,'@', 2))-1))) AS "after @"
FROM
	customer t



-- PERINTAH SELECT
SELECT * FROM employees;

SELECT employee_id, first_name, last_name
FROM employees;

SELECT first_name, last_name, hire_date, salary
FROM employees;

-- select and where
SELECT * FROM employees
WHERE salary > 40000;

SELECT * FROM employees
WHERE salary > 40000 AND coffeeshop_id = 2;

SELECT * FROM employees
WHERE salary > 40000 AND coffeeshop_id = 2 AND gender = 'M';

SELECT * FROM suppliers
WHERE supplier_name = 'Beans and Barley'

SELECT * FROM suppliers
WHERE NOT supplier_name = 'Beans and Barley'

SELECT * FROM suppliers
WHERE supplier_name != 'Beans and Barley'

SELECT * FROM suppliers
WHERE supplier_name <> 'Beans and Barley' -- sama seperti NOT, !=

SELECT * FROM suppliers
WHERE coffee_type IN ('Robusta', 'Arabica') -- menampilkan nilai yang ada Robusta dan Arabica di coffee_type

SELECT * FROM suppliers
WHERE coffee_type ='Robusta' OR coffee_type ='Arabica'; -- sama seperti IN

SELECT * FROM employees
WHERE email IS NULL;

SELECT * FROM employees
WHERE NOT email IS NULL;

SELECT * FROM employees
WHERE email IS NOT NULL; -- penampatan NOT yang sama

SELECT * FROM employees
WHERE salary BETWEEN 40000 AND 50000;


-- PERINTAH ORDER BY, LIMIT, DISTINCT, Rename coloumns

SELECT * FROM employees
ORDER BY salary; -- default ASC

SELECT * FROM employees
ORDER BY salary DESC;

SELECT * FROM employees
ORDER BY first_name, salary DESC; -- diurutkan berdasarkan first_name dahulu, kemudian berdasarkan salary


SELECT * FROM employees
ORDER BY first_name, salary DESC
LIMIT 7; -- menampilkan 7 teratas


SELECT DISTINCT coffeeshop_id
FROM employees; -- menampilkan data yang uniqe atau tidak sama

SELECT
	email AS email_address,
	salary AS pay
FROM employees;


SELECT
	email AS email_address,
	salary AS pay
FROM employees
ORDER BY salary;


SELECT
	email AS email_address,
	salary AS pay
FROM employees
ORDER BY pay; -- bisa juga order dengan nama yang baru


-- PERINTAH EXTRACT

SELECT
	hire_date,
	EXTRACT(YEAR FROM hire_date) AS year,
	EXTRACT(MONTH FROM hire_date) AS month,
	EXTRACT(DAY FROM hire_date) AS day
FROM employees;


SELECT
	EXTRACT(YEAR FROM hire_date) AS year,
	EXTRACT(MONTH FROM hire_date) AS month,
	EXTRACT(DAY FROM hire_date) AS day
FROM employees
ORDER BY year, month, day;


-- PERINTAH UPPER, LOWER, TRIM, LENGHT

SELECT 
	UPPER(first_name) AS first_name_upper,
	LOWER(last_name) AS last_name_lower
FROM employees;

SELECT
	email,
	LENGTH(email) AS email_length
FROM employees;

SELECT
	email,
	LENGTH(email) AS email_length
FROM employees
WHERE email IS NOT NULL
ORDER BY email_length DESC;

SELECT
	LENGTH('  HI  ') AS hi_with_spaces,
	LENGTH('HI') AS hi_with_no_spaces,
	LENGTH(TRIM('  HI  ')) AS hi_witH_TRIM -- TRIM menghilankan space/whitespace
	
	
-- PERINTAH CONCATENATION, BOOLEAN EXPRESSIONS, WILDCARDS

SELECT first_name || ' ' || last_name AS full_name -- menggunakan '||' untuk concate
FROM employees;

SELECT
	first_name || ' ' || last_name || 'makes ' || salary AS result
FROM employees;

SELECT 
	first_name || ' ' || last_name AS full_name,
	(salary < 40000) AS less_than_40k  -- akan menghasilkan nilai TRUE/FALSE. (didalam ini adalah kondisi)
FROM employees;

SELECT 
	first_name || ' ' || last_name AS full_name,
	gender, salary,
	(salary < 40000 AND gender = 'F') AS less_than_40k_female
FROM employees;

SELECT
	email,
	(email LIKE '%.com') AS email_dotcom -- '%' adalah wildcards artinya bisa diisi character apapun dan jumlahnya berapapun
FROM employees;


-- PERINTAH SUBSTRING, POSITION, COALESCE

-- SUBSTRING = mengambil STRING dari urutan yang ditentukan
SELECT
	email,
	SUBSTRING (email FROM 5)
FROM employees;
-- eg: String="1234567", resultnya = "567"


-- POSITION = menghasilkan nomer urutan dari Char yang ditentuan
SELECT
	email,
	POSITION ('@' in email)
FROM employees;
-- resultnya: Char '@' berada di urutan berapa

SELECT
	email,
	SUBSTRING (email FROM (POSITION ('@' IN email)+1))
FROM employees;


-- COALESCE = menambahkan nilai pada missing value yang ada
SELECT
	email,
	COALESCE (email, 'TIDAK ADA YANG EMAIL TERSEDIA')
FROM employees;
-- result: kolom email yang null akan diganti menjadi 'TIDAK ADA YANG EMAIL TERSEDIA'


-- PERINTAH MIN, MAX, AVG, SUM, COUNT
SELECT
	MIN(salary) AS min_salary
FROM employees;

SELECT
	MAX(salary) AS max_salary
FROM employees;

SELECT
	AVG(salary) AS AVG_salary
FROM employees;

SELECT
	ROUND(AVG(salary)) AS AVG_salary
FROM employees;

SELECT
	SUM(salary) AS SUM_salary
FROM employees;

SELECT
	COUNT(salary)AS count_salary
FROM employees;


-- PERINTAH GROUP BY, HAVING

-- GROUP BY = membuat "grup" pada entry dan harus ada kolom lain yang di-agregatkan
SELECT
	coffeeshop_id,
	COUNT(employee_id) -- kolom ini yang di-agregatkan
FROM employees
GROUP BY coffeeshop_id;

SELECT
	coffeeshop_id,
	SUM(employee_id) -- kolom ini yang di-agregatkan
FROM employees
GROUP BY coffeeshop_id;

-- task: hasilkan jumlah karyawan, avg dan max dan min dan total gaji pada tiap coffeeshop
SELECT
	coffeeshop_id,
	COUNT(employee_id) AS total_karyawan,
	ROUND(AVG(salary)) AS rerata_gaji,
	MAX(salary) AS gaji_tertinggi,
	MIN(salary) AS gaji_terendah,
	SUM(salary) AS total_gaji
FROM employees
GROUP BY coffeeshop_id;

-- HAVING = merupakan 'WHERE Clause' untuk perintah GROUP BY

-- task yang sama seperti GROUP BY tapi hanya tampilkan rerata gaji < 39K
SELECT
	coffeeshop_id,
	COUNT(employee_id) AS total_karyawan,
	ROUND(AVG(salary)) AS rerata_gaji,
	MAX(salary) AS gaji_tertinggi,
	MIN(salary) AS gaji_terendah,
	SUM(salary) AS total_gaji
FROM employees
GROUP BY coffeeshop_id
HAVING AVG(salary) < 39000;


-- PERINTAH CASE = sama seperti perintah IF

SELECT
	employee_id,
	first_name,
	last_name,
	salary,
	CASE
		WHEN salary < 50000 THEN 'low pay'
		WHEN salary > 50000 THEN 'High pay'
	END
FROM employees;

SELECT
	employee_id,
	first_name,
	last_name,
	salary,
	CASE
		WHEN salary < 20000 THEN 'low pay'
		WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
		WHEN salary > 50000 THEN 'high pay'
	END
FROM employees;

-- task : tampilkan jumlah karyawan sesuai dengan kategori gaji
SELECT
	COUNT(employee_id) AS total_karyawan,
	CASE
		WHEN salary < 20000 THEN 'low pay'
		WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
		WHEN salary > 50000 THEN 'high pay'
	END
FROM employees
GROUP BY
	CASE
		WHEN salary < 20000 THEN 'low pay'
		WHEN salary BETWEEN 20000 AND 50000 THEN 'medium pay'
		WHEN salary > 50000 THEN 'high pay'
	END;
-- penyelesainnya juga bisa menggunakan SUBQUERIES, akan dibahasa di bawah



-- PERINTAH JOIN DAN UNION

INSERT INTO locations VALUES (4, 'Jakarta', 'Indonesia');
INSERT INTO shops VALUES (6, 'Jakarta Brew', NULL);

-- INNER JOIN / JOIN = menggabugkan data yang hanya cocok/ada di tiap tabel yang digabungkan
SELECT s.coffeeshop_name, l.city, l.country
FROM shops AS s
INNER JOIN locations AS l
ON s.city_id = l.city_id;

-- LEFT JOIN = menggabugkan data, tapi tabel sebelah kiri/atas semua valuenya akan ditampilkan
SELECT s.coffeeshop_name, l.city, l.country
FROM shops AS s
LEFT JOIN locations AS l
ON s.city_id = l.city_id;

-- RIGHT JOIN = menggabugkan data, tapi tabel sebelah kanan/bawah semua valuenya akan ditampilkan
SELECT s.coffeeshop_name, l.city, l.country
FROM shops AS s
RIGHT JOIN locations AS l
ON s.city_id = l.city_id;

-- FULL JOIN = menggabugkan SEMUA data pada tiap tabel
SELECT s.coffeeshop_name, l.city, l.country
FROM shops AS s
FULL JOIN locations AS l
ON s.city_id = l.city_id;

DELETE FROM locations WHERE city_id = 4;
DELETE FROM shops WHERE coffeeshop_id = 6;

-- UNION = stack data secara vertikal, dan remove duplicate
SELECT city FROM locations
UNION 
SELECT country FROM locations;
-- bisa ditambahkan union lagi setelah ini

SELECT city FROM locations
UNION ALL-- stack data tapi tidak menghapus duplicate data
SELECT city FROM locations


-- PERINTAH SUBQUERIES
-- SUBQUERIES = seperti membuat tabel baru yang imajiner dan dapat kita gunakan
--              SUBQUERIES bisa terdapat di Clause SELECT, FROM, WHERE

-- SUBQUERIES di clausa SELECT
SELECT
	first_name,
	last_name,
	salary,
	(SELECT AVG(salary) FROM employees)
FROM employees;

SELECT
	first_name,
	last_name,
	salary,
	ROUND(salary - (SELECT AVG(salary) FROM employees)) AS gaji_dari_rerata
FROM employees;

-- jika kita tidak menggunakan subqueries, hasilnya akan error karena fungsi agregat(AVG) harus mempunyai perintah GROUP BY
SELECT
	first_name,
	last_name,
	salary,
	ROUND(salary - AVG(salary)) AS gaji_dari_rerata
FROM employees; 

-- SUBQUERIES di clausa FROM
SELECT *
FROM (SELECT * FROM employees WHERE coffeeshop_id IN (3,4))

SELECT *
FROM employees
WHERE coffeeshop_id IN (3,4);
-- dua perintah di atas menghasilkan nilai yang sama, tapi menggunakan SUBQUERIES lebih cepat


-- SUBQUERIES di clausa WHERE
-- task : tampilkan semua tabel karyawan yang berkerja di US Coffee Shop
SELECT *
FROM employees
WHERE coffeeshop_id IN
	(
	SELECT coffeeshop_id -- subqueries 1 outputnya (1,2,4,5) karena sesuai dengan hasil subqueries 2
	FROM shops
	WHERE city_id IN
		(SELECT city_id -- subqueries 2 outputnya (1,2) karena berada di US
		FROM locations
		WHERE country = 'United States')
	);
	

-- task: tampilkan karyawan yang bergaji>35k dan bekerja di US Coffee Shop
SELECT *
FROM employees
WHERE coffeeshop_id IN
	(
	SELECT coffeeshop_id -- subqueries 1 outputnya (1,2,4,5) karena sesuai dengan hasil subqueries 2
	FROM shops
	WHERE city_id IN
		(SELECT city_id -- subqueries 2 outputnya (1,2) karena berada di US
		FROM locations
		WHERE country = 'United States')
	)
	AND
	salary > 35000;

-- selesai
-- akan dilanjutkan untuk menyelesaikan study kasus

































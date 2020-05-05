-- 3 -- 
DESC employees;

-- 4 --
SELECT * 
FROM employees;

-- 5 --
SELECT employee_id, first_name, job_id, hire_date
FROM employees;

-- 6 --
SELECT DISTINCT job_id 
FROM employees; 

-- 7 --
SELECT last_name || ',' || job_id "Employee and title"
FROM employees; 

-- 8 --
SELECT employee_id || ',' || first_name || ',' || last_name || ',' || email || ',' || phone_number || ',' || hire_date 
       || ',' || job_id || ',' || salary || ',' || commission_pct || ',' || manager_id || ',' || department_id "Informatii complete"
FROM employees;

-- 9 --
SELECT last_name, salary
FROM employees
WHERE salary > 2850; 

-- 10 --
SELECT last_name, department_id
FROM employees
WHERE employee_id = 104;

-- 11 --
SELECT last_name, salary
FROM employees
WHERE salary NOT BETWEEN 1500 AND 2850;

-- 12 --
SELECT last_name, job_id, hire_date 
FROM employees
WHERE hire_date BETWEEN '20-FEB-1987' AND '1-MAY-1989'
ORDER BY hire_date;

-- 13 --
SELECT last_name, department_id
FROM employees
WHERE department_id IN (10, 30)
ORDER BY last_name;

-- 14 --
SELECT last_name "Employee", salary "Monthly salary"
FROM employees
WHERE salary > 3500 and department_id IN (10, 30);

-- 15 --
SELECT sysdate
FROM dual;

-- 16 --
SELECT first_name, last_name, hire_date
FROM employees
WHERE hire_date LIKE ('%87%');

SELECT first_name, last_name, hire_date
FROM employees
WHERE TO_CHAR(hire_date, 'YYYY')=1987; 

-- 17 -- nu o sa afiseze nimic pentru ca toti au manageri
SELECT last_name, job_id
FROM employees
WHERE manager_id IS NULL;

-- 18 --
SELECT last_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL
ORDER BY 
    salary DESC,
    commission_pct DESC;
         
-- 19 -- cele cu null apar inaintea celor cu valoare la comision
SELECT employee_id, last_name, salary, commission_pct
FROM employees
ORDER BY 
    salary DESC,
    commission_pct DESC;

-- 20 --
SELECT last_name
FROM employees
WHERE UPPER(concat(last_name, first_name)) LIKE '__A%';

-- 21 --
SELECT last_name, first_name, department_id, manager_id 
FROM employees
WHERE UPPER(concat(last_name, first_name)) LIKE '%L%L%' and (department_id = 30 or manager_id = 101);

-- 22 --
SELECT first_name, job_id, salary
FROM employees
WHERE UPPER(job_id) LIKE '%CLERK%' OR UPPER(job_id) LIKE '%REP%' and salary NOT IN (1000, 2000, 3000);

-- 23 --
SELECT first_name, salary, commission_pct
FROM employees
WHERE commission_pct IS NOT NULL and salary > salary * commission_pct * 5;


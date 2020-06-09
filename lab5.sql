-- 1 --
SELECT department_name, job_title, ROUND(AVG(salary))
FROM departments
JOIN employees USING(department_id)
JOIN jobs USING(job_id)
GROUP BY ROLLUP(department_name, job_title);


SELECT department_name, ROUND(AVG(salary))
FROM departments
JOIN employees USING(department_id)
JOIN jobs USING(job_id)
GROUP BY ROLLUP(department_name);

-- 5 --
SELECT emps.last_name, emps.salary
FROM employees emps
WHERE emps.salary > (SELECT AVG(emps2.salary)
                     FROM employees emps2
                     GROUP BY department_id
                     HAVING department_id = emps.department_id);
                
SELECT employee_id, last_name, salary
FROM employees e
WHERE salary > (SELECT AVG(salary) FROM employees
                WHERE department_id=e.department_id AND employee_id <> e.employee_id);
                
SELECT last_name "Nume", salary "Salariu", department_name "Nume departament", 
(SELECT ROUND(AVG(salary), 2) FROM employees WHERE department_id = emps.department_id) "Medie",
(SELECT COUNT(employee_id) FROM employees WHERE department_id = emps.department_id) "Nr angajati"
FROM employees emps JOIN departments deps ON (emps.department_id = deps.department_id)
WHERE salary > (SELECT AVG(salary) FROM employees WHERE department_id = emps.department_id);
      
SELECT employee_id, last_name, salary, department_name, medie
FROM employees e 
JOIN (SELECT AVG(salary) medie, department_id FROM employees 
GROUP BY department_id) aux ON (aux.department_id=e.department_id)
JOIN departments d ON(d.department_id = e.department_id)
WHERE salary > medie;

-- 6 --
SELECT last_name "Nume", salary "Salariu"
FROM employees emps
WHERE salary >ALL (SELECT AVG(salary) 
                   FROM employees
                   GROUP BY department_id);

SELECT last_name "Nume", salary "Salariu"
FROM employees emps
WHERE salary > (SELECT MAX(AVG(salary))
                FROM employees
                GROUP BY department_id);
                
-- 7 --
SELECT last_name, salary
FROM employees emps
WHERE salary = (SELECT MIN(salary)
                FROM employees
                GROUP BY department_id
                HAVING department_id = emps.department_id);

--var 2--
SELECT last_name, salary
FROM employees 
WHERE (salary,department_id) IN (SELECT MIN(salary), department_id FROM employees GROUP BY department_id);

--var 3--
SELECT last_name, salary
FROM employees e 
JOIN (SELECT MIN(salary) minim, department_id FROM employees GROUP BY department_id) aux
ON ( e.department_id = aux.department_id)
WHERE salary = minim;

-- 8 --
SELECT last_name, hire_date
FROM employees emps
WHERE hire_date = (SELECT MIN(hire_date)
                   FROM employees
                   WHERE department_id = emps.department_id);

-- 9 --
SELECT last_name
FROM employees e
WHERE EXISTS(SELECT 1 
             FROM employees
             WHERE e.department_id = department_id 
             and salary = (SELECT MAX(salary)
                            FROM employees
                            WHERE department_id = 30)
            );

-- 10 --
SELECT * 
FROM (SELECT last_name, salary
      FROM employees
      ORDER BY salary DESC) 
WHERE ROWNUM <= 3;

-- 11 --
SELECT employee_id, last_name, first_name
FROM employees emps
WHERE (SELECT COUNT(emps2.employee_id)
       FROM employees emps2
       WHERE emps2.manager_id = emps.employee_id) >= 2;
       
-- 12 --
SELECT city
FROM locations locs
WHERE (SELECT COUNT(department_id)
       FROM departments
       WHERE location_id = locs.location_id) > 0;

SELECT city
FROM locations
WHERE location_id IN(SELECT location_id
                    FROM departments);

SELECT city
FROM locations l
WHERE EXISTS(SELECT 1
             FROM departments d
             WHERE l.location_id = d.location_id);

-- 13 --
SELECT department_name
FROM departments d
WHERE (SELECT COUNT(employee_id)
       FROM employees
       WHERE d.department_id = department_id) = 0;
       
SELECT department_name
FROM departments d
WHERE NOT EXISTS(SELECT 'c'
                 FROM employees
                 WHERE d.department_id = department_id);

-- 14 --
SELECT LEVEL, employee_id, last_name, hire_date, salary, manager_id
FROM employees
WHERE LEVEL = 2
START WITH employee_id = (SELECT employee_id 
                          FROM employees
                          WHERE LOWER(last_name) LIKE 'de haan')
CONNECT BY manager_id = PRIOR employee_id;

SELECT LEVEL, employee_id, last_name, hire_date, salary, manager_id
FROM employees
START WITH employee_id = (SELECT employee_id 
                          FROM employees
                          WHERE LOWER(last_name) LIKE 'de haan')
CONNECT BY manager_id = PRIOR employee_id;

-- 15 --
SELECT LEVEL, employee_id, last_name, hire_date, salary, manager_id
FROM employees
START WITH employee_id = 114
CONNECT BY manager_id = PRIOR employee_id;

-- 16 --
SELECT LEVEL, employee_id, last_name, hire_date, salary, manager_id
FROM employees
WHERE LEVEL > 2
START WITH employee_id = (SELECT employee_id 
                          FROM employees
                          WHERE LOWER(last_name) LIKE 'de haan')
CONNECT BY manager_id = PRIOR employee_id;

-- 17 --
SELECT LEVEL, employee_id, manager_id
FROM employees 
CONNECT BY manager_id = PRIOR employee_id;

-- 18 --
SELECT LEVEL, employee_id, last_name, salary, manager_id
FROM employees
START WITH employee_id = (SELECT employee_id 
                          FROM employees
                          WHERE salary = (SELECT MAX(salary) FROM employees))
CONNECT BY manager_id = PRIOR employee_id and salary > 5000;

-- 19 --
WITH
total AS (SELECT SUM(salary) suma, department_id
          FROM employees
          GROUP BY department_id)
SELECT department_name, suma
FROM departments d
JOIN total t ON (d.department_id = t.department_id)
WHERE suma > (SELECT AVG(suma)
              FROM total);
              
-- 20 --
WITH
king AS (SELECT employee_id
         FROM employees
         WHERE LOWER(last_name) LIKE 'king' AND LOWER(first_name) LIKE 'steven')
SELECT e.employee_id, last_name || ' ' || first_name, job_id, hire_date
FROM employees e
CROSS JOIN king
WHERE /*hire_date = (SELECT MIN(hire_date)
                   FROM employees) 
                   AND*/ EXTRACT(year FROM hire_date) != 1970
START WITH e.employee_id = king.employee_id
CONNECT BY manager_id = PRIOR e.employee_id;

-- 21 --
 SELECT *
 FROM (SELECT last_name, salary
       FROM employees
       ORDER BY salary DESC)
WHERE ROWNUM <= 10;

-- 22 --
SELECT * 
FROM ( SELECT job_id
       FROM employees
       GROUP BY job_id
       ORDER BY AVG(salary)
)
WHERE ROWNUM <= 3;

SELECT *
FROM (SELECT job_title 
      FROM jobs
      ORDER BY (min_salary + max_salary) / 2)
WHERE ROWNUM <= 3;

-- 23 --
SELECT 'departamentul ' || department_name || ' este condus de '|| NVL(TO_CHAR(d.manager_id), ' nimeni ') || 
        ' are numarul de salariati ' || CASE WHEN nr > 0 THEN nr
                                        ELSE 0
                                        END  
        AS informatii
FROM departments d
LEFT JOIN (SELECT department_id, COUNT(employee_id) nr
      FROM employees  
      GROUP BY department_id) aux ON (d.department_id = aux.department_id);

-- 24 --
SELECT last_name, first_name, length(last_name)
FROM employees
WHERE  NULLIF(length(last_name), length(first_name)) IS NOT NULL;

-- 25 --
SELECT last_name, hire_date, salary,
DECODE (to_char(hire_date, 'yyyy'), 1989, salary*1.2, 1990, salary*1.15, 1991, salary*1.10, salary) marire
FROM employees;

-- 26 --
SELECT (SELECT sum(salary)
        FROM employees
        WHERE job_id like 'S%') suma, (SELECT AVG(salary)
                                        FROM employees
                                        WHERE (job_id, salary) IN (SELECT job_id, max(salary)
                                        FROM employees
                                        GROUP BY job_id)) medie
--,(SELECT min(salary) FROM employees WHERE job_id NOT LIKE 'S%' AND (job_id, salary)!=(SELECT... CEL LUUUNG) minim FROM employees
FROM DUAL;

-- 2 --
SELECT MAX(salary) "Maxim", 
       MIN(salary) "Minim", 
       SUM(salary) "Suma", 
       AVG(salary) "Media"
FROM employees;

-- 3 --
SELECT MAX(salary) "Maxim", 
       MIN(salary) "Minim", 
       SUM(salary) "Suma", 
       AVG(salary) "Media"
FROM employees
GROUP BY job_id;

-- 4 --
SELECT job_id, COUNT(employee_id) "Numar angajati"
FROM employees
GROUP BY job_id;

-- 5 --
SELECT COUNT(DISTINCT manager_id) "Numar manageri"
FROM employees
WHERE manager_id is not NULL;

-- 6 --
SELECT MAX(salary) - MIN(salary) "Diferenta"
FROM employees;

-- 7 --
SELECT department_name "Nume departament",
       city "Oras",
       count(employee_id) "Numar angajati",
       round(avg(salary)) "Media salariilor"
FROM employees
JOIN departments USING (department_id)
JOIN locations USING (location_id)
GROUP BY department_name, city;

-- 8 --
SELECT employee_id "Cod",
       last_name "Nume",
       salary "Salariu"
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees)
ORDER BY salary DESC;

-- 9 --
SELECT manager_id "Cod sef",
       MIN(salary) "Salariu minim"
FROM employees
WHERE manager_id is not NULL
GROUP BY manager_id
HAVING MIN(salary) > 1000
ORDER BY 2 DESC;

-- 10 --
SELECT department_id "Cod departament", 
       department_name "Nume departament",
       MAX(salary) "Salariu maxim"
FROM employees JOIN departments USING (department_id)
GROUP BY department_id, department_name
HAVING MAX(salary) > 3000;

-- 11 --
SELECT MIN(AVG(salary))
FROM employees
GROUP BY job_id;

-- 12 --
SELECT department_id, department_name, SUM(salary)
FROM employees JOIN departments USING (department_id)
GROUP BY department_id, department_name;

-- 13 --
SELECT ROUND(MAX(AVG(salary)), 2)
FROM employees
GROUP BY department_id;

-- 14 --
SELECT job_id, job_title, AVG(salary)
FROM employees
JOIN jobs USING (job_id)
GROUP BY job_id, job_title
HAVING AVG(salary) = (SELECT MIN(AVG(salary))
                      FROM employees
                      GROUP BY job_id);

-- 15 --
SELECT AVG(salary)
FROM employees
HAVING AVG(salary) > 2500;

-- 16 --
SELECT SUM(salary), department_id, job_id
FROM employees
GROUP BY department_id, job_id;

-- 17 --
SELECT department_name, MIN(salary)
FROM departments JOIN employees USING(department_id)
GROUP BY department_name
HAVING(AVG(salary)) = (SELECT MAX(AVG(salary))
                       FROM employees
                       GROUP BY department_id);

-- 18 --
SELECT department_id, department_name, COUNT(employee_id)
FROM departments
JOIN employees USING(department_id)
GROUP BY department_id, department_name
HAVING COUNT(employee_id) < 4;

SELECT department_id, department_name, COUNT(employee_id)
FROM departments
JOIN employees USING(department_id)
GROUP BY department_id, department_name
HAVING COUNT(employee_id) = (SELECT MAX(COUNT(employee_id))
                             FROM employees
                             GROUP BY department_id);
                             
-- 19 --
SELECT last_name
FROM employees
WHERE TO_CHAR(hire_date, 'DD') = (SELECT TO_CHAR(hire_date, 'DD')
                                	FROM employees
                                	GROUP BY TO_CHAR(hire_date, 'DD')
                                	HAVING COUNT(employee_id) = (SELECT MAX(COUNT(employee_id))
                                                                 FROM employees
                                                                 GROUP BY TO_CHAR(hire_date, 'DD')));
                                                                 
-- 20 --
SELECT COUNT(COUNT(department_id)) "NR DEPARTAMENTE"
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) >= 15;

-- 21 --
SELECT department_id "Cod departament",
       SUM(salary) "Suma salarii"
FROM employees
GROUP BY department_id
HAVING COUNT(employee_id) >= 10 AND department_id != 30;

-- 22 --
SELECT d.department_id, d.department_name, Nr, Medie, last_name, salary, e.job_id
FROM (SELECT department_id, COUNT(employee_id) AS Nr, ROUND(AVG(salary), 2) AS Medie
      FROM employees
      GROUP BY department_id) aux
RIGHT JOIN departments d ON(d.department_id = aux.department_id)
JOIN employees e ON(e.department_id = d.department_id);

-- 23 --
SELECT department_name "Nume departament",
       city "Oras", 
       job_title "Job", 
       SUM(salary) "Total salarii"
FROM employees
JOIN departments USING (department_id)
JOIN jobs USING (job_id)
JOIN locations USING (location_id)
GROUP BY department_name, job_title, city, department_id
HAVING department_id > 80;

-- 24 --
SELECT e.last_name, e.employee_id
FROM employees e
JOIN (SELECT employee_id, COUNT(job_id) nr
      FROM job_history
      GROUP BY employee_id) aux ON (e.employee_id = aux.employee_id)
WHERE nr >= 2;

-- 25 --
SELECT AVG(NVL(commission_pct,0))
FROM employees;

-- 27 --
SELECT job_title, (SELECT SUM(salary) FROM employees WHERE department_id = 30) "Dep30", 
                  (SELECT SUM(salary) FROM employees WHERE department_id = 50) "Dep50",
                  (SELECT SUM(salary) FROM employees WHERE department_id = 80) "Dep80",
                  (SELECT SUM(salary) FROM employees WHERE job_id = j.job_id) "Total"
FROM jobs j;

SELECT job_title,  SUM(DECODE(department_id, 30, salary, 0)) "Dep30", 
                   SUM(DECODE(department_id, 50, salary, 0)) "Dep50",
                   SUM(DECODE(department_id, 80, salary, 0)) "Dep80",
                   SUM(DECODE(e.job_id, j.job_id, salary, 0)) "Total"
FROM jobs j
JOIN employees e ON (j.job_id = e.job_id)
GROUP BY job_title;

-- 30 --
SELECT d.department_id, department_name, suma
FROM departments d
JOIN (SELECT department_id, SUM(salary) suma FROM employees GROUP BY department_id) aux
ON (D.department_id=aux.department_id);

-- 31 --
SELECT last_name, salary, e.department_id, salariu_mediu
FROM employees e
JOIN (SELECT department_id, AVG(salary) salariu_mediu FROM employees GROUP BY department_id) aux
ON (e.department_id=aux.department_id);

-- 32 --
SELECT last_name, salary, e.department_id, salariu_mediu, numar_angajati
FROM employees e
JOIN (SELECT department_id, AVG(salary) salariu_mediu, COUNT(employee_id) numar_angajati FROM employees GROUP BY department_id) aux
ON (e.department_id=aux.department_id);

-- 33 --
SELECT department_name, salariu_minim, last_name
FROM departments d JOIN employees emps on (d.department_id = emps.department_id)
JOIN (SELECT department_id, MIN(salary) salariu_minim FROM employees GROUP BY department_id) aux
ON (d.department_id = aux.department_id)
WHERE emps.salary = salariu_minim;

-- 34 --
SELECT d.department_id, department_name, numar_angajati, salariu_mediu, emps.last_name, emps.salary, emps.job_id
FROM departments d  RIGHT JOIN employees emps ON (d.department_id = emps.department_id)
RIGHT JOIN (SELECT department_id, COUNT(employee_id) numar_angajati, AVG(salary) salariu_mediu 
      FROM employees 
      GROUP BY department_id) aux
ON (d.department_id = aux.department_id);
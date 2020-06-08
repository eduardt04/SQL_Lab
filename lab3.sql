-- 1 --
SELECT colls.first_name || ' ' || colls.last_name "Nume",
       TO_CHAR(colls.hire_date, 'Month') "Luna angajarii",
       TO_CHAR(colls.hire_date, 'YYYY') "Anul angajarii"
FROM employees emps 
    JOIN employees colls ON (emps.department_id = colls.department_id)
WHERE upper(emps.last_name) = 'GATES' and UPPER(colls.last_name) LIKE '%A%' and emps.last_name != colls.last_name;

-- 2 --
SELECT UNIQUE 
       emps.first_name || ' ' || emps.last_name "Nume",
       emps.employee_id "Cod angajat",
       deps.department_name "Nume departament"
FROM employees emps
    JOIN employees colls ON (emps.department_id = colls.department_id)
    JOIN departments deps ON (emps.department_id = deps.department_id)
WHERE UPPER(colls.last_name) LIKE '%T%'
ORDER BY 1;

-- 3 --
SELECT emps.last_name "Nume",
       emps.salary "Salariu",
       jbs.job_title "Titlu job",
       locs.city "Oras",
       ctrs.country_name "Tara"
FROM employees emps 
    JOIN employees mgrs ON (emps.manager_id = mgrs.employee_id)
    JOIN jobs jbs ON (emps.job_id = jbs.job_id)
    JOIN departments deps ON (deps.department_id = emps.department_id)
    JOIN locations locs ON (locs.location_id = deps.location_id)
    JOIN countries ctrs ON (ctrs.country_id = locs.country_id)
WHERE UPPER(mgrs.last_name) = 'KING';

-- 4 --
SELECT deps.department_name "Nume departament",
       deps.department_id "Cod departament ", 
       emps.first_name "Nume",
       jbs.job_title "Job",
       TO_CHAR(emps.salary, '$99,000.00') "Salariu"
FROM departments deps
    LEFT JOIN employees emps ON (deps.department_id = emps.department_id)
    LEFT JOIN jobs jbs ON (jbs.job_id = emps.job_id)
WHERE UPPER(deps.department_name) LIKE '%TI%'
ORDER BY 1, 3;

-- 5 --
SELECT emps.first_name || ' ' || emps.last_name "Nume",
       deps.department_id "Numar departament",
       deps.department_name "Nume departament",
       locs.city "Oras",
       jbs.job_title "Titlu job"
FROM employees emps
    JOIN departments deps ON (emps.department_id = deps.department_id)
    JOIN locations locs ON (locs.location_id = deps.location_id)
    LEFT JOIN jobs jbs ON (emps.job_id = jbs.job_id)
WHERE INITCAP(locs.city) = 'Oxford';

-- 6 --
SELECT DISTINCT emps1.employee_id "Cod angajat", 
                emps1.last_name "Nume angajat",
                emps1.salary "Salariu angajat"
FROM employees emps1
    JOIN jobs jbs ON(emps1.job_id = jbs.job_id)
    JOIN employees emps2 ON(emps1.department_id = emps2.department_id)
WHERE emps1.salary > (jbs.min_salary + jbs.max_salary) / 2 AND LOWER(emps2.last_name) LIKE ('%t%');

-- 7 --
SELECT 
    emps.first_name "Nume",
    deps.department_name "Nume departament"
FROM employees emps
    LEFT JOIN departments deps ON (deps.department_id = emps.department_id);

-- 8 --
SELECT 
    emps.first_name "Nume",
    deps.department_name "Nume departament"
FROM employees emps
    RIGHT JOIN departments deps ON (deps.department_id = emps.department_id)
ORDER BY 2;

    
-- 10 --
SELECT department_id 
FROM departments
WHERE UPPER(department_name) LIKE '%RE%'
UNION
SELECT department_id
FROM employees
WHERE UPPER(job_id) LIKE '%SA_REP%';

-- 12 --
SELECT DISTINCT department_id
FROM departments
MINUS
SELECT DISTINCT department_id
FROM employees;

SELECT department_id
FROM departments
WHERE ( SELECT COUNT(employee_id) 
        FROM employees
        WHERE employees.department_id = departments.department_id ) = 0;
        
-- 13 --
SELECT department_id
FROM departments
WHERE UPPER(department_name) LIKE '%RE%'
INTERSECT
SELECT department_id
FROM employees
WHERE UPPER(job_id) LIKE '%HR_REP%';

-- 14 --
SELECT employee_id "Cod angajat", 
       job_id "Cod job", 
       last_name "Nume"
FROM employees
WHERE salary > 3000
UNION
SELECT employee_id "Cod angajat", 
       job_id "Cod job", 
       last_name "Nume"
FROM employees JOIN jobs USING(job_id)
WHERE employees.salary = (jobs.min_salary + jobs.max_salary) / 2;

-- 15 --
SELECT last_name "Nume",
       hire_date "Data"
FROM employees
WHERE hire_date > ( SELECT hire_date
                    FROM employees
                    WHERE UPPER(last_name) LIKE '%GATES%');

-- 16 --
SELECT last_name "Nume",
       salary "Salariu"
FROM employees
WHERE department_id IN (SELECT department_id
                        FROM employees
                        WHERE UPPER(last_name) LIKE '%GATES%'); 

-- 17 --
SELECT last_name "Nume",
       salary "Salariu"
FROM employees
WHERE manager_id = (SELECT employee_id
                    FROM employees
                    WHERE manager_id is NULL);

-- 18 --
SELECT last_name "Nume",
       department_id "Cod departament",
       salary "Salariu"
FROM employees
WHERE (department_id, salary) IN (SELECT department_id, salary
                                  FROM employees
                                  WHERE commission_pct IS NOT NULL);

-- 19 --
SELECT employee_id "Cod",
       last_name "Nume",
       salary "Salariu"
FROM employees
JOIN jobs USING (job_id)
WHERE salary > (min_salary + max_salary)/2 AND
department_id IN (SELECT department_id
                  FROM employees
                  WHERE UPPER(last_name) LIKE '%T%');
                  
-- 20 --
SELECT last_name "Nume",
       department_id "Cod departament",
       salary "Salariu"
FROM employees
WHERE salary >ALL (SELECT salary
                   FROM employees
                   WHERE UPPER(job_id) LIKE '%CLERK%'); 

-- 21 --
SELECT emps.last_name "Nume",
       deps.department_name "Nume departament",
       emps.salary "Salariu"
FROM employees emps JOIN departments deps USING (department_id)
WHERE emps.commission_pct IS NULL
AND emps.manager_id IN (SELECT emps2.manager_id 
                        FROM employees emps2
                        WHERE emps2.commission_pct IS NOT NULL);
                        
-- 22 --
SELECT last_name "Nume",
       department_id "Departament",
       salary "Salariu"
FROM employees
WHERE (salary, commission_pct) IN (SELECT salary, commission_pct
                                   FROM employees 
                                   JOIN departments USING (department_id)
                                   JOIN locations USING(location_id)
                                   WHERE UPPER(city) LIKE '%OXFORD%');

-- 23 --
SELECT last_name "Nume",
       department_id "Cod departament",
       job_id "Cod job"
FROM employees
WHERE department_id IN (SELECT department_id 
                        FROM departments JOIN locations USING (location_id)
                        WHERE UPPER(city) LIKE '%TORONTO%');
                        
                                   
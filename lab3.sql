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
    
-- 9 --
SELECT 
    emps.first_name "Nume",
    deps.department_id "Cod departament"
FROM employees emps
    LEFT JOIN departments deps ON (emps.department_id = deps.department_id);
    

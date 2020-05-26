-- 1 --
SELECT CONCAT(first_name,
        CONCAT(' ',
         CONCAT(last_name, 
          CONCAT(' castiga ', 
           CONCAT(salary, 
            CONCAT(' lunar dar doreste ', salary * 3))))))  "Salariu ideal" 
FROM employees;

SELECT first_name || ' ' || last_name || ' castiga ' || salary || ' lunar dar doreste ' || salary * 3 "Salariu ideal"
FROM employees;

-- 2 --
SELECT INITCAP(first_name) "Prenume", 
       UPPER(last_name) "Nume", 
       LENGTH(CONCAT(first_name, last_name)) "Lungime nume"
FROM employees
WHERE last_name LIKE 'J%' or last_name LIKE 'M%' or UPPER(last_name) like '__A%'
ORDER BY 3 DESC; -- se foloseste 3 pt a sorta descrescator dupa a 3-a coloana, care este lungimea numelui --

SELECT INITCAP(first_name) "Prenume", 
       UPPER(last_name) "Nume", 
       LENGTH(CONCAT(first_name, last_name)) "Lungime nume"
FROM employees
WHERE SUBSTR(last_name, 1, 1) in ('J', 'M') or SUBSTR(UPPER(last_name), 3, 1) = 'A'
ORDER BY 3 DESC;

-- 3 --
SELECT employee_id, last_name, department_id
FROM employees
WHERE UPPER(LTRIM(RTRIM(first_name))) = 'STEVEN';

-- 4 --
SELECT employee_id "Cod", 
       last_name "Nume",
       LENGTH(last_name) "Lungime nume",
       INSTR(last_name, 'a') "Aparitia lui 'a'" -- se cauta doar a nu si A --
FROM employees
WHERE SUBSTR(LOWER(last_name), LENGTH(last_name)) = 'e';

-- 5 --
SELECT last_name, first_name, hire_date, TO_DATE(SYSDATE, 'DD/MM/YYYY') - hire_date "Zile angajare"
FROM employees
WHERE MOD(TO_DATE(SYSDATE, 'DD/MM/YYYY') - hire_date, 7) = 0;

-- 6 --
SELECT employee_id, first_name, salary, ROUND(salary * 1.15, 2) "Salariu nou", ROUND(salary * 1.15, -2) "Numar sute"
FROM employees
WHERE MOD(salary, 1000) != 0;

-- 7 --
SELECT first_name || last_name "Nume angajat", hire_date "Data angajarii" 
FROM employees
WHERE commission_pct IS NOT NULL;

-- 8 --
SELECT TO_CHAR(SYSDATE + 30, 'dd-mm-yy hh24:mi:ss')
FROM dual;

-- 9 --
SELECT TO_DATE('31-12-' || TO_CHAR(SYSDATE, 'yyyy')) - TO_DATE(TO_CHAR(SYSDATE, 'dd-mm-yyyy')) "Zile ramase"
FROM dual;

-- 10 --
SELECT TO_CHAR(SYSDATE + 0.5, 'dd-mm-yyyy')
FROM dual;

SELECT TO_CHAR(SYSDATE + 1/(24*12), 'dd-mm-yyyy')
FROM dual;

-- 11 --
SELECT first_name || last_name "Nume", hire_date "Data angajarii", 
       ADD_MONTHS(hire_date, 6) - TO_NUMBER(TO_CHAR(hire_date, 'D')) + 2 "Negociere"
FROM employees;

-- 12 --
SELECT first_name || last_name "Nume", 
       ROUND(MONTHS_BETWEEN(SYSDATE, hire_date)) "Luni lucrate"
FROM employees
ORDER BY 2;

-- 13 --
SELECT first_name || last_name "Nume", 
       hire_date "Data angajarii", 
       TO_CHAR(hire_date, 'day') "Ziua angajarii"
FROM employees
ORDER BY TO_CHAR(hire_date, 'd');

-- 14 --
SELECT first_name || last_name "Nume", 
       DECODE(commission_pct, NULL, 'Fara comision', commission_pct) "Comision"
FROM employees;

-- 15 --
SELECT first_name || ' ' || last_name "Nume", 
       salary "Salariu", commission_pct "Comision"
FROM employees
WHERE salary >= 10000 or (commission_pct IS NOT NULL and salary * (1 + commission_pct) > 10000);

-- 16 --
SELECT first_name || ' ' || last_name "Nume", 
       job_id "Job", salary "Salariu",
CASE
    WHEN job_id = 'IT_PROG' THEN salary * 1.2
    WHEN job_id = 'SA_REP' THEN salary * 1.25
    WHEN job_id = 'SA_MAN' THEN salary * 1.35
    ELSE salary
END AS "Salariu renegociat"
FROM employees;

-- 17 --
SELECT emps.first_name|| ' ' || emps.last_name "Nume", 
       emps.employee_id "Cod", 
       deps.department_name "Nume departament"
FROM employees emps
    JOIN departments deps ON (emps.department_id = deps.department_id);

-- 18 --
SELECT jbs.job_title
FROM employees emps
    JOIN jobs jbs ON (emps.job_id = jbs.job_id)
WHERE emps.department_id = 30;

-- 19 --
SELECT emps.first_name|| ' ' || emps.last_name "Nume", 
       deps.department_name "Nume departament",
       locs.street_address || ', ' || locs.postal_code || ', ' ||  locs.city || ', ' || ctrs.country_name "Locatie"
FROM employees emps
    JOIN departments deps ON (emps.department_id = deps.department_id)
    JOIN locations locs ON (deps.location_id = locs.location_id)
    JOIN countries ctrs ON (locs.country_id = ctrs.country_id)
WHERE emps.commission_pct IS NOT NULL;   

-- 20 --
SELECT emps.first_name || ' ' || emps.last_name "Nume", 
       deps.department_name "Nume departament"
FROM employees emps
    JOIN departments deps ON (emps.department_id = deps.department_id)
WHERE upper(emps.first_name || emps.last_name) LIKE '%A%';

-- 21 --
SELECT emps.first_name|| ' ' || emps.last_name "Nume", 
       emps.job_id "Job", emps.employee_id "Cod", 
       deps.department_name "Nume departament"
FROM employees emps
    JOIN departments deps ON (emps.department_id = deps.department_id)
    JOIN locations locs ON (deps.location_id = locs.location_id)
    JOIN countries ctrs ON (locs.country_id = ctrs.country_id)
WHERE locs.city = 'Oxford';   

-- 22 --
SELECT emps.employee_id "Ang#", emps.first_name || ' ' || emps.last_name "Angajat",
       man.employee_id "Mgr#", man.first_name || ' ' || man.last_name "Manager"
FROM employees emps
    JOIN employees man ON (emps.manager_id = man.employee_id);
    
-- 23 --
SELECT emps.employee_id "Ang#", 
       emps.first_name || ' ' || emps.last_name "Angajat",
       man.employee_id "Mgr#", 
       man.first_name || ' ' || man.last_name "Manager"
FROM employees emps
       LEFT JOIN employees man ON (emps.manager_id = man.employee_id);
    
-- 24 --
SELECT emps.first_name || ' ' || emps.last_name "Nume", 
       emps.department_id "Cod departament", 
       emps2.last_name "Coleg"
FROM employees emps
    JOIN employees emps2 ON (emps.department_id = emps2.department_id AND emps.employee_id < emps2.employee_id)
ORDER BY 3;
    
-- 25 --
SELECT emps.first_name || ' ' || emps.last_name "Nume", 
       emps.job_id "Job id", 
       jbs.job_title "Titlu job", 
       deps.department_name "Nume departament", 
       emps.salary "Salariu"
FROM employees emps
    JOIN departments deps on (emps.department_id = deps.department_id)
    JOIN jobs jbs on (emps.job_id = jbs.job_id);
    
-- 26 --
SELECT emps2.first_name || ' ' || emps2.last_name "Nume", emps2.hire_date "Data angajarii"
FROM employees emps
    JOIN employees emps2 ON (emps.hire_date < emps2.hire_date)
WHERE emps.last_name = 'Gates'
ORDER BY 2;

SELECT emps2.first_name || ' ' || emps2.last_name "Nume", emps2.hire_date "Data angajarii"
FROM employees emps
    JOIN employees emps2 ON (emps.hire_date < emps2.hire_date AND UPPER(emps.last_name) LIKE 'GATES' )
ORDER BY 2;

-- 27 --
SELECT emps.first_name || ' ' || emps.last_name "Angajat",
       emps.hire_date "Data_ang",
       man.first_name || ' ' || man.last_name "Manager",
       man.hire_date "Data_manager"
FROM employees emps
    JOIN employees man ON (emps.manager_id = man.employee_id)
WHERE man.hire_date > emps.hire_date;

SELECT emps.first_name || ' ' || emps.last_name "Angajat",
       emps.hire_date "Data_ang",
       man.first_name || ' ' || man.last_name "Manager",
       man.hire_date "Data_manager"
FROM employees emps
    JOIN employees man ON (emps.manager_id = man.employee_id AND man.hire_date > emps.hire_date)

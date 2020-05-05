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

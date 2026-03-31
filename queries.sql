-- Q1: Employee Directory with Departments
SELECT 
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
ORDER BY d.name ASC, e.salary DESC;


-- Q2: Department Salary Analysis
SELECT 
    d.name,
    SUM(e.salary) AS total_salary
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id
GROUP BY d.name
HAVING SUM(e.salary) > 150000;


-- Q3: Highest-Paid Employee per Department
SELECT first_name, last_name, department_name, salary
FROM (
    SELECT 
        e.first_name,
        e.last_name,
        d.name AS department_name,
        e.salary,
        ROW_NUMBER() OVER (
            PARTITION BY e.department_id 
            ORDER BY e.salary DESC
        ) AS rn
    FROM employees e
    JOIN departments d 
        ON e.department_id = d.department_id
) t
WHERE rn = 1;


-- Q4: Project Staffing Overview
SELECT 
    p.name,
    COUNT(pa.employee_id) AS num_employees,
    COALESCE(SUM(pa.hours_allocated), 0) AS total_hours
FROM projects p
LEFT JOIN project_assignments pa 
    ON p.project_id = pa.project_id
GROUP BY p.name;


-- Q5: Above-Average Departments
WITH company_avg AS (
    SELECT AVG(salary) AS avg_salary FROM employees
),
dept_avg AS (
    SELECT 
        d.name,
        AVG(e.salary) AS dept_avg_salary
    FROM employees e
    JOIN departments d 
        ON e.department_id = d.department_id
    GROUP BY d.name
)
SELECT 
    d.name,
    d.dept_avg_salary,
    c.avg_salary
FROM dept_avg d, company_avg c
WHERE d.dept_avg_salary > c.avg_salary;


-- Q6: Running Salary Total
SELECT 
    e.first_name,
    e.last_name,
    d.name AS department_name,
    e.salary,
    SUM(e.salary) OVER (
        PARTITION BY e.department_id
        ORDER BY e.hire_date
    ) AS running_total
FROM employees e
JOIN departments d 
    ON e.department_id = d.department_id;


-- Q7: Unassigned Employees
SELECT 
    e.first_name,
    e.last_name
FROM employees e
LEFT JOIN project_assignments pa 
    ON e.employee_id = pa.employee_id
WHERE pa.employee_id IS NULL;


-- Q8: Hiring Trends
SELECT 
    EXTRACT(YEAR FROM hire_date) AS year,
    EXTRACT(MONTH FROM hire_date) AS month,
    COUNT(*) AS hires
FROM employees
GROUP BY year, month
ORDER BY year, month;


-- Q9: Schema Design — Employee Certifications
CREATE TABLE certifications (
    certification_id SERIAL PRIMARY KEY,
    name VARCHAR NOT NULL,
    issuing_org VARCHAR,
    level VARCHAR
);

CREATE TABLE employee_certifications (
    id SERIAL PRIMARY KEY,
    employee_id INT REFERENCES employees(employee_id),
    certification_id INT REFERENCES certifications(certification_id),
    certification_date DATE NOT NULL
);

INSERT INTO certifications (name, issuing_org, level) VALUES
('AWS Cloud Practitioner', 'Amazon', 'Beginner'),
('Data Analysis', 'Google', 'Intermediate'),
('Cyber Security', 'Cisco', 'Advanced');

INSERT INTO employee_certifications (employee_id, certification_id, certification_date) VALUES
(1, 1, '2024-01-10'),
(2, 2, '2024-02-15'),
(3, 3, '2024-03-20'),
(1, 2, '2024-04-10'),
(4, 1, '2024-05-05');

SELECT 
    e.first_name,
    e.last_name,
    c.name AS certification_name,
    c.issuing_org,
    ec.certification_date
FROM employee_certifications ec
JOIN employees e 
    ON ec.employee_id = e.employee_id
JOIN certifications c 
    ON ec.certification_id = c.certification_id;
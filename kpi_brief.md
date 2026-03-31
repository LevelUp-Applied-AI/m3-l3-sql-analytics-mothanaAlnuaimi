# KPI Brief — Levant Tech Solutions

## KPI 1: High-Salary Department Count

**Definition:**  
Number of departments whose total salary expenditure exceeds 150,000.  
This KPI is calculated from **Q2** using `SUM(salary)` grouped by department with a `HAVING` filter.

**Current value:**  
[Put the number of departments returned by Q2 here]

**Interpretation:**  
This shows how many departments have a high payroll burden and may require closer budget monitoring.

---

## KPI 2: Above-Average Department Count

**Definition:**  
Number of departments where the average employee salary is higher than the company-wide average salary.  
This KPI is calculated from **Q5** using department average salary compared with overall company average salary.

**Current value:**  
[Put the number of departments returned by Q5 here]

**Interpretation:**  
This indicates which departments pay above the company norm and may reflect specialized talent needs or salary imbalance.

---

## KPI 3: Unassigned Employee Count

**Definition:**  
Number of employees who are not assigned to any project.  
This KPI is calculated from **Q7** using a `LEFT JOIN` and `NULL` check on project assignments.

**Current value:**  
[Put the number of employees returned by Q7 here]

**Interpretation:**  
This measures unused workforce capacity and may highlight opportunities to improve employee utilization.

---

## KPI 4: Average Project Staffing Level

**Definition:**  
Average number of assigned employees per project.  
This KPI is calculated from **Q4** by averaging the `num_employees` values across all projects.

**Current value:**  
[Calculate the average from Q4 results and put it here]

**Interpretation:**  
This shows how heavily projects are staffed on average and helps assess whether resources are distributed evenly.

---

## KPI 5: Certification Coverage

**Definition:**  
Number of employee certification records entered in the employee certifications system.  
This KPI is calculated from **Q9** using the total rows in `employee_certifications`.

**Current value:**  
[Put the total number of certification records inserted in Q9 here]

**Interpretation:**  
This reflects how much certified training activity is being tracked across employees and supports workforce development planning.
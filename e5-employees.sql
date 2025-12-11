SELECT e.employee_name AS 'Employee Name',
       m.employee_name AS 'Manager Name'
FROM Employee e
        LEFT JOIN
     Employee m ON e.manager_id = m.employee_id
ORDER BY e.employee_id;

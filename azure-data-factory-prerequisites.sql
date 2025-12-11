DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee(
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT NULL,
)
GO

DROP DATABASE IF EXISTS employees;
GO

CREATE DATABASE employees;
GO

USE employees;
GO

DROP TABLE IF EXISTS Employee;
CREATE TABLE Employee(
    employee_id INT IDENTITY PRIMARY KEY,
    employee_name VARCHAR(100),
    manager_id INT NULL,
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id)
)
GO

BULK INSERT Employee
FROM '/var/opt/mssql/import/data/data - Employee.csv'
WITH (
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
);
GO
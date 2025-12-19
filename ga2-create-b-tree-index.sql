CREATE NONCLUSTERED INDEX customer_dob_idx
ON Customer(date_of_birth);

DROP INDEX customer_dob_idx
ON Customer;
CREATE NONCLUSTERED COLUMNSTORE INDEX sales_amount_columnstore_idx
ON Sales(amount);

EXEC sp_helpindex 'Sales';
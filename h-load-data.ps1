docker cp .\data\oracle-customers2.csv oracle_db_server:/tmp/oracle-customers2.csv
docker cp .\data\oracle-orders.csv oracle_db_server:/tmp/oracle-orders.csv

$ctl = @'
LOAD DATA
INFILE '/tmp/oracle-customers2.csv'
BADFILE '/tmp/oracle-customers2.bad'
DISCARDFILE '/tmp/oracle-customers2.dis'
INTO TABLE CustomerErrors
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    customer_id     INTEGER EXTERNAL,
    name            CHAR(98)
)
'@

$localCtl = Join-Path $PSScriptRoot 'customers.ctl'
[System.IO.File]::WriteAllText($localCtl, $ctl, (New-Object System.Text.UTF8Encoding $false))

docker cp $localCtl oracle_db_server:/tmp/customers.ctl
docker exec -i oracle_db_server bash -lc "sqlldr system/test123@//localhost:1521/orclpdb1 control=/tmp/customers.ctl log=/tmp/customers.log"

docker cp .\data\oracle-orders.csv oracle_db_server:/tmp/oracle-orders.csv

$ctl = @'
LOAD DATA
INFILE '/tmp/oracle-orders.csv'
BADFILE '/tmp/oracle-orders.bad'
DISCARDFILE '/tmp/oracle-orders.dis'
INTO TABLE Orders
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    order_id      INTEGER EXTERNAL,
    "DATE"          DATE "YYYY-MM-DD",
    customer_id   INTEGER EXTERNAL,
    amount        DECIMAL EXTERNAL
)
'@

$localCtl = Join-Path $PSScriptRoot 'orders.ctl'
[System.IO.File]::WriteAllText($localCtl, $ctl, (New-Object System.Text.UTF8Encoding $false))

docker cp $localCtl oracle_db_server:/tmp/orders.ctl
docker exec -i oracle_db_server bash -lc "sqlldr system/test123@//localhost:1521/orclpdb1 control=/tmp/orders.ctl log=/tmp/orders.log"
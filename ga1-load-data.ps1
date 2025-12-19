docker cp .\data\oracle-customers.csv oracle_db_server:/tmp/oracle-customers.csv

$ctl = @'
LOAD DATA
INFILE '/tmp/oracle-customers.csv'
BADFILE '/tmp/oracle-customers.bad'
DISCARDFILE '/tmp/oracle-customers.dis'
INTO TABLE Customer
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
  customer_id INTEGER EXTERNAL,
  name CHAR(100),
  gender CHAR(1),
  is_homeowner INTEGER EXTERNAL,
  MARITAL_STATUS CHAR(100) TERMINATED BY WHITESPACE)
'@

$localCtl = Join-Path $PSScriptRoot 'customers.ctl'
[System.IO.File]::WriteAllText($localCtl, $ctl, (New-Object System.Text.UTF8Encoding $false))

docker cp $localCtl oracle_db_server:/tmp/customers.ctl
docker exec -i oracle_db_server bash -lc "sqlldr system/test123@//localhost:1521/orclpdb1 control=/tmp/customers.ctl log=/tmp/customers.log"

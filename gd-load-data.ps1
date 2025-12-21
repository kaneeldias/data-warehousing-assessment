docker cp .\data\oracle-products.csv oracle_db_server:/tmp/oracle-products.csv

$ctl = @'
LOAD DATA
INFILE '/tmp/oracle-products.csv'
BADFILE '/tmp/oracle-products.bad'
DISCARDFILE '/tmp/oracle-products.dis'
INTO TABLE ProductSalesPartitioned
FIELDS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"'
TRAILING NULLCOLS
(
    product_id      INTEGER EXTERNAL,
    year            INTEGER EXTERNAL,
    country         CHAR(2),
    sales           INTEGER EXTERNAL
)
'@

$localCtl = Join-Path $PSScriptRoot 'products.ctl'
[System.IO.File]::WriteAllText($localCtl, $ctl, (New-Object System.Text.UTF8Encoding $false))

docker cp $localCtl oracle_db_server:/tmp/products.ctl
docker exec -i oracle_db_server bash -lc "sqlldr system/test123@//localhost:1521/orclpdb1 control=/tmp/products.ctl log=/tmp/products.log"

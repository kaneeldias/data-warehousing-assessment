

SELECT name, is_cdc_enabled FROM sys.databases WHERE name = 'oltp';

USE [oltp];
SELECT capture_instance, source_object_id, start_lsn, supports_net_changes
FROM cdc.change_tables;

SELECT s.name AS schema_name, o.name AS object_name, o.type_desc
FROM sys.objects o
JOIN sys.schemas s ON o.schema_id = s.schema_id
WHERE s.name = 'cdc';

SELECT table_schema, table_name
FROM information_schema.tables
WHERE table_schema = 'cdc';

SELECT servicename, status_desc
FROM sys.dm_server_services
WHERE servicename LIKE '%SQL Server Agent%';

USE msdb;
SELECT job_id, name, enabled
FROM dbo.sysjobs
WHERE name LIKE 'cdc%';

SELECT j.name AS job_name, s.step_id, s.step_name, s.command
FROM dbo.sysjobs j
JOIN dbo.sysjobsteps s ON j.job_id = s.job_id
WHERE j.name LIKE 'cdc%';
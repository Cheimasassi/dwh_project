if exists (select 1 from sys.databases where name ='DataWarehouse')
begin
	alter Database Datawarehouse SET SINGLE8USER WITH ROLLBACK IMMEDIATE ;
	DROP DATABASE DataWarehouse;
END;
Go


create database DataWarehouse;
use DataWarehouse;
Go
create SCHEMA bronze;
Go
create SCHEMA Silver;
Go
create SCHEMA Gold;

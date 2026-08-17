/*
===============================================================================
Data Warehouse Initialization
===============================================================================
Purpose:
    - Creates the DataWarehouse database and its data warehouse schemas.
    - Removes the existing database when a previous version is present.

Schemas:
    - Bronze: Raw data loaded from source systems.
    - Silver: Cleaned and transformed data.
    - Gold: Business-ready data for reporting and analytics.
===============================================================================
*/


-- =============================================================================
-- Create Database
-- =============================================================================

IF EXISTS (
    SELECT 1
    FROM sys.databases
    WHERE name = 'DataWarehouse'
)
BEGIN
    ALTER DATABASE DataWarehouse
        SET SINGLE_USER
        WITH ROLLBACK IMMEDIATE;

    DROP DATABASE DataWarehouse;
END;
GO

CREATE DATABASE DataWarehouse;
GO

USE DataWarehouse;
GO


-- =============================================================================
-- Create Data Warehouse Schemas
-- =============================================================================

CREATE SCHEMA Bronze;
GO

CREATE SCHEMA Silver;
GO

CREATE SCHEMA Gold;
GO

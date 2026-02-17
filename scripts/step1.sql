-- Create database if not exists
IF DB_ID('Datawarehouse') IS NULL
BEGIN
    PRINT 'Creating Datawarehouse database...';
    CREATE DATABASE Datawarehouse;
END;
GO

USE Datawarehouse;


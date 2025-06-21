--Step 1: Create login
CREATE LOGIN app_user_login WITH PASSWORD = 'MySecurePassword';

-- Step 2: Switch to your database
USE AdventureWorks2022;
GO

-- Step 3: Create user in database
CREATE USER app_user FOR LOGIN app_user_login;

-- Step 4: Grant db_owner role
ALTER ROLE db_owner ADD MEMBER app_user;

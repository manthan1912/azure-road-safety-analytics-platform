CREATE DATABASE roadsafetydb;
GO
-- 
-- Step 13B: Create security and lake access objects
-- Do not commit this password to GitHub.
CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'Password@123456';
GO

CREATE DATABASE SCOPED CREDENTIAL WorkspaceIdentity
WITH IDENTITY = 'Managed Identity';
GO

CREATE EXTERNAL DATA SOURCE RoadSafetyLake
WITH
(
    LOCATION = 'https://stroadsafetydevmm0105.dfs.core.windows.net/roadsafety',
    CREDENTIAL = WorkspaceIdentity
);
GO
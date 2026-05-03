-- Step 15: Create reusable raw view over KSI collision CSV

CREATE OR ALTER VIEW dbo.vw_raw_ksi_collisions
AS
SELECT
    *
FROM OPENROWSET(
    BULK 'raw/collisions/ksi_collisions_2006_2023_raw.csv',
    DATA_SOURCE = 'RoadSafetyLake',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE
)
WITH (
    OBJECTID varchar(100),
    [INDEX] varchar(100),
    ACCNUM varchar(100),
    [DATE] varchar(100),
    [TIME] varchar(100),
    STREET1 varchar(500),
    STREET2 varchar(500),
    [OFFSET] varchar(500),
    ROAD_CLASS varchar(200),
    DISTRICT varchar(200),
    LATITUDE varchar(100),
    LONGITUDE varchar(100),
    ACCLOC varchar(500),
    TRAFFCTL varchar(500),
    VISIBILITY varchar(500),
    LIGHT varchar(500),
    RDSFCOND varchar(500),
    ACCLASS varchar(500),
    IMPACTYPE varchar(500),
    INVTYPE varchar(500),
    INVAGE varchar(100),
    INJURY varchar(500),
    FATAL_NO varchar(100),
    INITDIR varchar(100),
    VEHTYPE varchar(500),
    MANOEUVER varchar(500),
    DRIVACT varchar(500),
    DRIVCOND varchar(500),
    PEDTYPE varchar(500),
    PEDACT varchar(500),
    PEDCOND varchar(500),
    CYCLISTYPE varchar(500),
    CYCACT varchar(500),
    CYCCOND varchar(500),
    PEDESTRIAN varchar(100),
    CYCLIST varchar(100),
    AUTOMOBILE varchar(100),
    MOTORCYCLE varchar(100),
    TRUCK varchar(100),
    TRSN_CITY_VEH varchar(100),
    EMERG_VEH varchar(100),
    PASSENGER varchar(100),
    SPEEDING varchar(100),
    AG_DRIV varchar(100),
    REDLIGHT varchar(100),
    ALCOHOL varchar(100),
    DISABILITY varchar(100),
    HOOD_158 varchar(100),
    NEIGHBOURHOOD_158 varchar(500),
    HOOD_140 varchar(100),
    NEIGHBOURHOOD_140 varchar(500),
    DIVISION varchar(100),
    x varchar(100),
    y varchar(100)
) AS raw_ksi;
GO

-- 
SELECT TOP 10 *
FROM dbo.vw_raw_ksi_collisions;
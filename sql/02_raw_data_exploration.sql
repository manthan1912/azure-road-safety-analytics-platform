-- Raw data exploration for Canadian Road Safety Analytics Platform
-- Dataset: Toronto Police Service KSI collision data
-- Layer: raw/collisions

SELECT TOP 100
    *
FROM OPENROWSET(
    BULK 'raw/collisions/ksi_collisions_2006_2023_raw.csv',
    DATA_SOURCE = 'RoadSafetyLake',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE
) AS raw_ksi;


SELECT
    COUNT_BIG(*) AS raw_record_count
FROM OPENROWSET(
    BULK 'raw/collisions/ksi_collisions_2006_2023_raw.csv',
    DATA_SOURCE = 'RoadSafetyLake',
    FORMAT = 'CSV',
    PARSER_VERSION = '2.0',
    HEADER_ROW = TRUE
) AS raw_ksi;
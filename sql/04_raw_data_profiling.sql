-- Step 16A: Confirm raw view count
SELECT
    COUNT_BIG(*) AS raw_view_record_count
FROM dbo.vw_raw_ksi_collisions;

-- Step 16B: Raw view column inventory
SELECT
    COLUMN_NAME,
    DATA_TYPE,
    ORDINAL_POSITION
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'dbo'
  AND TABLE_NAME = 'vw_raw_ksi_collisions'
ORDER BY ORDINAL_POSITION;

-- 
SELECT TOP 20
    [DATE],
    TRY_CONVERT(date, [DATE]) AS parsed_collision_date,
    TIME,
    ACCNUM,
    ACCLASS,
    STREET1,
    STREET2,
    LATITUDE,
    LONGITUDE
FROM dbo.vw_raw_ksi_collisions;

-- Step 16C: First-pass raw data profiling
-- Step 16C: Revised first-pass raw data profiling
SELECT
    COUNT_BIG(*) AS total_rows,
    COUNT(DISTINCT ACCNUM) AS distinct_collision_numbers,

    MIN(TRY_CONVERT(date, [DATE])) AS min_collision_date,
    MAX(TRY_CONVERT(date, [DATE])) AS max_collision_date,

    MIN(YEAR(TRY_CONVERT(date, [DATE]))) AS min_collision_year,
    MAX(YEAR(TRY_CONVERT(date, [DATE]))) AS max_collision_year,

    SUM(CASE WHEN ACCNUM IS NULL THEN 1 ELSE 0 END) AS null_accnum_count,
    SUM(CASE WHEN [DATE] IS NULL THEN 1 ELSE 0 END) AS null_date_count,
    SUM(CASE WHEN TRY_CONVERT(date, [DATE]) IS NULL THEN 1 ELSE 0 END) AS invalid_date_format_count,
    SUM(CASE WHEN LATITUDE IS NULL THEN 1 ELSE 0 END) AS null_latitude_count,
    SUM(CASE WHEN LONGITUDE IS NULL THEN 1 ELSE 0 END) AS null_longitude_count,

    SUM(CASE WHEN LATITUDE NOT BETWEEN 43.0 AND 44.5 THEN 1 ELSE 0 END) AS suspicious_latitude_count,
    SUM(CASE WHEN LONGITUDE NOT BETWEEN -80.0 AND -78.0 THEN 1 ELSE 0 END) AS suspicious_longitude_count
FROM dbo.vw_raw_ksi_collisions;
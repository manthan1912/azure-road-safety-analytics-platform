-- Step 18A: Raw-to-cleaned count reconciliation

SELECT
    raw_counts.raw_record_count,
    cleaned_counts.cleaned_record_count,
    raw_counts.raw_record_count - cleaned_counts.cleaned_record_count AS count_difference
FROM
    (SELECT COUNT_BIG(*) AS raw_record_count FROM dbo.vw_raw_ksi_collisions) raw_counts
CROSS JOIN
    (SELECT COUNT_BIG(*) AS cleaned_record_count FROM dbo.vw_cleaned_ksi_collisions) cleaned_counts;


-- Step 18B: Cleaned data quality flag summary

SELECT
    COUNT_BIG(*) AS total_rows,
    SUM(dq_missing_collision_id_flag) AS missing_collision_id_rows,
    SUM(dq_invalid_date_flag) AS invalid_date_rows,
    SUM(dq_invalid_coordinate_flag) AS invalid_coordinate_rows
FROM dbo.vw_cleaned_ksi_collisions;


-- Step 18C: Cleaned date coverage validation

SELECT
    MIN(collision_date) AS min_collision_date,
    MAX(collision_date) AS max_collision_date,
    MIN(collision_year) AS min_collision_year,
    MAX(collision_year) AS max_collision_year
FROM dbo.vw_cleaned_ksi_collisions;


-- Step 18D: Collision hour sanity check

SELECT
    MIN(collision_hour) AS min_collision_hour,
    MAX(collision_hour) AS max_collision_hour,
    SUM(CASE WHEN collision_hour NOT BETWEEN 0 AND 23 THEN 1 ELSE 0 END) AS invalid_collision_hour_rows
FROM dbo.vw_cleaned_ksi_collisions;

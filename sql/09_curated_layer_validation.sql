SELECT
    cleaned.cleaned_record_count,
    fact.fact_record_count,
    cleaned.cleaned_record_count - fact.fact_record_count AS count_difference
FROM
    (SELECT COUNT_BIG(*) AS cleaned_record_count FROM dbo.vw_cleaned_ksi_collisions) cleaned
CROSS JOIN
    (SELECT COUNT_BIG(*) AS fact_record_count FROM dbo.vw_fact_collision_events) fact;

SELECT 'fact_collision_events' AS object_name, COUNT_BIG(*) AS record_count
FROM dbo.vw_fact_collision_events

UNION ALL

SELECT 'dim_date' AS object_name, COUNT_BIG(*) AS record_count
FROM dbo.vw_dim_date

UNION ALL

SELECT 'dim_location' AS object_name, COUNT_BIG(*) AS record_count
FROM dbo.vw_dim_location

UNION ALL

SELECT 'dim_road_condition' AS object_name, COUNT_BIG(*) AS record_count
FROM dbo.vw_dim_road_condition

UNION ALL

SELECT 'dim_collision_factor' AS object_name, COUNT_BIG(*) AS record_count
FROM dbo.vw_dim_collision_factor;


-- 
SELECT
    COUNT_BIG(*) AS total_fact_records,
    SUM(is_analytics_ready_record) AS analytics_ready_records,
    COUNT_BIG(*) - SUM(is_analytics_ready_record) AS non_analytics_ready_records,
    SUM(dq_missing_collision_id_flag) AS missing_collision_id_records,
    SUM(dq_invalid_date_flag) AS invalid_date_records,
    SUM(dq_invalid_coordinate_flag) AS invalid_coordinate_records
FROM dbo.vw_fact_collision_events;

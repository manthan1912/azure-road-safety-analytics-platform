-- Step 21A: Annual collision trend view

CREATE OR ALTER VIEW dbo.vw_rpt_annual_collision_trend
AS
SELECT
    collision_year,
    COUNT_BIG(*) AS total_records,
    COUNT(DISTINCT collision_event_key) AS total_collision_events,
    SUM(CASE WHEN pedestrian_flag IS NOT NULL THEN 1 ELSE 0 END) AS pedestrian_related_records,
    SUM(CASE WHEN cyclist_flag IS NOT NULL THEN 1 ELSE 0 END) AS cyclist_related_records,
    SUM(CASE WHEN speeding_flag IS NOT NULL THEN 1 ELSE 0 END) AS speeding_related_records,
    SUM(CASE WHEN aggressive_driving_flag IS NOT NULL THEN 1 ELSE 0 END) AS aggressive_driving_related_records,
    SUM(CASE WHEN redlight_flag IS NOT NULL THEN 1 ELSE 0 END) AS redlight_related_records,
    SUM(CASE WHEN alcohol_flag IS NOT NULL THEN 1 ELSE 0 END) AS alcohol_related_records
FROM dbo.vw_fact_collision_events
WHERE collision_year IS NOT NULL
GROUP BY collision_year;
GO


-- Step 21B: District/neighbourhood risk summary view

CREATE OR ALTER VIEW dbo.vw_rpt_location_risk_summary
AS
SELECT
    district,
    neighbourhood_158_name,
    police_division,
    COUNT_BIG(*) AS total_records,
    COUNT(DISTINCT collision_event_key) AS total_collision_events,
    SUM(CASE WHEN pedestrian_flag IS NOT NULL THEN 1 ELSE 0 END) AS pedestrian_related_records,
    SUM(CASE WHEN cyclist_flag IS NOT NULL THEN 1 ELSE 0 END) AS cyclist_related_records,
    SUM(CASE WHEN motorcycle_flag IS NOT NULL THEN 1 ELSE 0 END) AS motorcycle_related_records,
    SUM(CASE WHEN speeding_flag IS NOT NULL THEN 1 ELSE 0 END) AS speeding_related_records,
    SUM(CASE WHEN aggressive_driving_flag IS NOT NULL THEN 1 ELSE 0 END) AS aggressive_driving_related_records,
    SUM(CASE WHEN redlight_flag IS NOT NULL THEN 1 ELSE 0 END) AS redlight_related_records,
    SUM(CASE WHEN alcohol_flag IS NOT NULL THEN 1 ELSE 0 END) AS alcohol_related_records
FROM dbo.vw_fact_collision_events
WHERE district IS NOT NULL
GROUP BY
    district,
    neighbourhood_158_name,
    police_division;
GO


-- Step 21C: Road and environmental condition summary view

CREATE OR ALTER VIEW dbo.vw_rpt_road_condition_summary
AS
SELECT
    road_surface_condition,
    visibility,
    light_condition,
    traffic_control,
    COUNT_BIG(*) AS total_records,
    COUNT(DISTINCT collision_event_key) AS total_collision_events
FROM dbo.vw_fact_collision_events
GROUP BY
    road_surface_condition,
    visibility,
    light_condition,
    traffic_control;
GO


-- Step 21D: Data quality reporting view

CREATE OR ALTER VIEW dbo.vw_rpt_data_quality_summary
AS
SELECT
    COUNT_BIG(*) AS total_fact_records,
    SUM(is_analytics_ready_record) AS analytics_ready_records,
    COUNT_BIG(*) - SUM(is_analytics_ready_record) AS non_analytics_ready_records,
    SUM(dq_missing_collision_id_flag) AS missing_collision_id_records,
    SUM(dq_invalid_date_flag) AS invalid_date_records,
    SUM(dq_invalid_coordinate_flag) AS invalid_coordinate_records
FROM dbo.vw_fact_collision_events;
GO

-- 
SELECT TOP 20 *
FROM dbo.vw_rpt_annual_collision_trend
ORDER BY collision_year;
-- 
SELECT TOP 20 *
FROM dbo.vw_rpt_location_risk_summary
ORDER BY total_collision_events DESC;
-- 
SELECT TOP 20 *
FROM dbo.vw_rpt_road_condition_summary
ORDER BY total_collision_events DESC;
-- 
SELECT *
FROM dbo.vw_rpt_data_quality_summary;

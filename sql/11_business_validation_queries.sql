-- Step 22A: Annual KSI collision trend

SELECT
    collision_year,
    total_records,
    total_collision_events,
    pedestrian_related_records,
    cyclist_related_records,
    speeding_related_records,
    aggressive_driving_related_records,
    redlight_related_records,
    alcohol_related_records
FROM dbo.vw_rpt_annual_collision_trend
ORDER BY collision_year;

-- Step 22B: Top 10 locations by collision events

SELECT TOP 10
    district,
    neighbourhood_158_name,
    police_division,
    total_records,
    total_collision_events,
    pedestrian_related_records,
    cyclist_related_records,
    motorcycle_related_records,
    speeding_related_records,
    aggressive_driving_related_records,
    redlight_related_records,
    alcohol_related_records
FROM dbo.vw_rpt_location_risk_summary
ORDER BY total_collision_events DESC;

-- Step 22C: Road condition / visibility summary

SELECT TOP 20
    road_surface_condition,
    visibility,
    light_condition,
    traffic_control,
    total_records,
    total_collision_events
FROM dbo.vw_rpt_road_condition_summary
ORDER BY total_collision_events DESC;

-- Step 22D: Final data quality summary

SELECT
    total_fact_records,
    analytics_ready_records,
    non_analytics_ready_records,
    missing_collision_id_records,
    invalid_date_records,
    invalid_coordinate_records
FROM dbo.vw_rpt_data_quality_summary;


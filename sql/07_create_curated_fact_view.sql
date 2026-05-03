-- Step 19: Create curated fact view for KSI collision analytics
-- Grain: one row per source KSI involvement/source record.
-- object_id is the technical row identifier.
-- collision_event_key supports event-level grouping where ACCNUM exists.

CREATE OR ALTER VIEW dbo.vw_fact_collision_events
AS
SELECT
    object_id AS fact_collision_record_id,
    source_index,
    collision_id,

    CASE
        WHEN collision_id IS NOT NULL THEN CAST(collision_id AS varchar(50))
        ELSE CONCAT('OBJECTID_', CAST(object_id AS varchar(50)))
    END AS collision_event_key,

    collision_date,
    collision_year,
    collision_month,
    collision_month_name,
    collision_day_name,
    collision_hour,

    street_1,
    street_2,
    district,
    police_division,
    road_class,
    latitude,
    longitude,

    neighbourhood_158_id,
    neighbourhood_158_name,
    neighbourhood_140_id,
    neighbourhood_140_name,

    accident_location,
    traffic_control,
    visibility,
    light_condition,
    road_surface_condition,
    accident_classification,
    impact_type,

    involvement_type,
    involved_age,
    injury_severity,
    fatal_number,
    vehicle_type,

    pedestrian_flag,
    cyclist_flag,
    automobile_flag,
    motorcycle_flag,
    truck_flag,
    transit_city_vehicle_flag,
    emergency_vehicle_flag,
    passenger_flag,

    speeding_flag,
    aggressive_driving_flag,
    redlight_flag,
    alcohol_flag,
    disability_flag,

    dq_missing_collision_id_flag,
    dq_invalid_date_flag,
    dq_invalid_coordinate_flag,

    CASE
        WHEN dq_invalid_date_flag = 0
         AND dq_invalid_coordinate_flag = 0
        THEN 1 ELSE 0
    END AS is_analytics_ready_record

FROM dbo.vw_cleaned_ksi_collisions;
GO

-- 
SELECT TOP 10 *
FROM dbo.vw_fact_collision_events;
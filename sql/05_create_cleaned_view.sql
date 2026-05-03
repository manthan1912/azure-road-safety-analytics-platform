-- Step 17: Create cleaned view over raw KSI collision data

CREATE OR ALTER VIEW dbo.vw_cleaned_ksi_collisions
AS
SELECT
    TRY_CAST(OBJECTID AS bigint) AS object_id,
    TRY_CAST([INDEX] AS bigint) AS source_index,
    TRY_CAST(ACCNUM AS bigint) AS collision_id,

    TRY_CONVERT(date, [DATE]) AS collision_date,
    TRY_CAST([TIME] AS int) AS collision_time_raw,

    CASE
        WHEN TRY_CAST([TIME] AS int) IS NULL THEN NULL
        ELSE TRY_CAST(LEFT(RIGHT('0000' + CAST(TRY_CAST([TIME] AS int) AS varchar(4)), 4), 2) AS int)
    END AS collision_hour,

    YEAR(TRY_CONVERT(date, [DATE])) AS collision_year,
    MONTH(TRY_CONVERT(date, [DATE])) AS collision_month,
    DATENAME(month, TRY_CONVERT(date, [DATE])) AS collision_month_name,
    DATENAME(weekday, TRY_CONVERT(date, [DATE])) AS collision_day_name,

    NULLIF(TRIM(STREET1), '') AS street_1,
    NULLIF(TRIM(STREET2), '') AS street_2,
    NULLIF(TRIM([OFFSET]), '') AS offset_location,

    NULLIF(TRIM(ROAD_CLASS), '') AS road_class,
    NULLIF(TRIM(DISTRICT), '') AS district,
    TRY_CAST(LATITUDE AS float) AS latitude,
    TRY_CAST(LONGITUDE AS float) AS longitude,

    NULLIF(TRIM(ACCLOC), '') AS accident_location,
    NULLIF(TRIM(TRAFFCTL), '') AS traffic_control,
    NULLIF(TRIM(VISIBILITY), '') AS visibility,
    NULLIF(TRIM(LIGHT), '') AS light_condition,
    NULLIF(TRIM(RDSFCOND), '') AS road_surface_condition,
    NULLIF(TRIM(ACCLASS), '') AS accident_classification,
    NULLIF(TRIM(IMPACTYPE), '') AS impact_type,

    NULLIF(TRIM(INVTYPE), '') AS involvement_type,
    NULLIF(TRIM(INVAGE), '') AS involved_age,
    NULLIF(TRIM(INJURY), '') AS injury_severity,
    NULLIF(TRIM(FATAL_NO), '') AS fatal_number,

    NULLIF(TRIM(INITDIR), '') AS initial_direction,
    NULLIF(TRIM(VEHTYPE), '') AS vehicle_type,
    NULLIF(TRIM(MANOEUVER), '') AS manoeuver,
    NULLIF(TRIM(DRIVACT), '') AS driver_action,
    NULLIF(TRIM(DRIVCOND), '') AS driver_condition,

    NULLIF(TRIM(PEDTYPE), '') AS pedestrian_type,
    NULLIF(TRIM(PEDACT), '') AS pedestrian_action,
    NULLIF(TRIM(PEDCOND), '') AS pedestrian_condition,

    NULLIF(TRIM(CYCLISTYPE), '') AS cyclist_type,
    NULLIF(TRIM(CYCACT), '') AS cyclist_action,
    NULLIF(TRIM(CYCCOND), '') AS cyclist_condition,

    NULLIF(TRIM(PEDESTRIAN), '') AS pedestrian_flag,
    NULLIF(TRIM(CYCLIST), '') AS cyclist_flag,
    NULLIF(TRIM(AUTOMOBILE), '') AS automobile_flag,
    NULLIF(TRIM(MOTORCYCLE), '') AS motorcycle_flag,
    NULLIF(TRIM(TRUCK), '') AS truck_flag,
    NULLIF(TRIM(TRSN_CITY_VEH), '') AS transit_city_vehicle_flag,
    NULLIF(TRIM(EMERG_VEH), '') AS emergency_vehicle_flag,
    NULLIF(TRIM(PASSENGER), '') AS passenger_flag,

    NULLIF(TRIM(SPEEDING), '') AS speeding_flag,
    NULLIF(TRIM(AG_DRIV), '') AS aggressive_driving_flag,
    NULLIF(TRIM(REDLIGHT), '') AS redlight_flag,
    NULLIF(TRIM(ALCOHOL), '') AS alcohol_flag,
    NULLIF(TRIM(DISABILITY), '') AS disability_flag,

    TRY_CAST(HOOD_158 AS bigint) AS neighbourhood_158_id,
    NULLIF(TRIM(NEIGHBOURHOOD_158), '') AS neighbourhood_158_name,
    TRY_CAST(HOOD_140 AS bigint) AS neighbourhood_140_id,
    NULLIF(TRIM(NEIGHBOURHOOD_140), '') AS neighbourhood_140_name,
    NULLIF(TRIM(DIVISION), '') AS police_division,

    TRY_CAST(x AS float) AS projected_x,
    TRY_CAST(y AS float) AS projected_y,

    CASE WHEN NULLIF(TRIM(ACCNUM), '') IS NULL THEN 1 ELSE 0 END AS dq_missing_collision_id_flag,
    CASE WHEN TRY_CONVERT(date, [DATE]) IS NULL THEN 1 ELSE 0 END AS dq_invalid_date_flag,
    CASE
        WHEN TRY_CAST(LATITUDE AS float) BETWEEN 43.0 AND 44.5
         AND TRY_CAST(LONGITUDE AS float) BETWEEN -80.0 AND -78.0
        THEN 0 ELSE 1
    END AS dq_invalid_coordinate_flag,

    CASE WHEN TRY_CAST(HOOD_158 AS bigint) IS NULL AND NULLIF(TRIM(HOOD_158), '') IS NOT NULL THEN 1 ELSE 0 END AS dq_invalid_neighbourhood_158_id_flag,
    CASE WHEN TRY_CAST(HOOD_140 AS bigint) IS NULL AND NULLIF(TRIM(HOOD_140), '') IS NOT NULL THEN 1 ELSE 0 END AS dq_invalid_neighbourhood_140_id_flag

FROM dbo.vw_raw_ksi_collisions;
GO
-- 
SELECT TOP 10 *
FROM dbo.vw_cleaned_ksi_collisions;

SELECT
    COUNT_BIG(*) AS cleaned_record_count,
    SUM(dq_invalid_neighbourhood_158_id_flag) AS invalid_hood_158_rows,
    SUM(dq_invalid_neighbourhood_140_id_flag) AS invalid_hood_140_rows
FROM dbo.vw_cleaned_ksi_collisions;

-- Step 20A: Create curated date dimension view

CREATE OR ALTER VIEW dbo.vw_dim_date
AS
SELECT DISTINCT
    collision_date AS date_key,
    collision_year,
    collision_month,
    collision_month_name,
    collision_day_name
FROM dbo.vw_cleaned_ksi_collisions
WHERE collision_date IS NOT NULL;
GO


-- Step 20B: Create curated location dimension view

CREATE OR ALTER VIEW dbo.vw_dim_location
AS
SELECT DISTINCT
    neighbourhood_158_id,
    neighbourhood_158_name,
    neighbourhood_140_id,
    neighbourhood_140_name,
    district,
    police_division,
    road_class,
    street_1,
    street_2,
    latitude,
    longitude
FROM dbo.vw_cleaned_ksi_collisions
WHERE latitude IS NOT NULL
  AND longitude IS NOT NULL;
GO


-- Step 20C: Create road condition dimension view

CREATE OR ALTER VIEW dbo.vw_dim_road_condition
AS
SELECT DISTINCT
    road_surface_condition,
    visibility,
    light_condition,
    traffic_control
FROM dbo.vw_cleaned_ksi_collisions;
GO


-- Step 20D: Create collision factor dimension view

CREATE OR ALTER VIEW dbo.vw_dim_collision_factor
AS
SELECT DISTINCT
    accident_classification,
    impact_type,
    involvement_type,
    injury_severity,
    vehicle_type,
    speeding_flag,
    aggressive_driving_flag,
    redlight_flag,
    alcohol_flag,
    disability_flag
FROM dbo.vw_cleaned_ksi_collisions;
GO

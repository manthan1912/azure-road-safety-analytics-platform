# Source Data

## Primary Dataset

**Dataset Name:** Killed and Seriously Injured Traffic Collision Data  
**Publisher:** Toronto Police Service Public Safety Data Portal  
**Business Domain:** Road Safety / Public Safety Analytics  
**Geography:** Toronto, Ontario, Canada  
**Coverage:** 2006–2023 archived records  
**Planned Ingestion Method:** Azure Data Factory HTTP/REST ingestion  
**Raw Landing Zone:** `roadsafety/raw/collisions/`  
**Format:** CSV or JSON, depending on available export endpoint  

## Why This Dataset Was Selected

This dataset supports road safety analytics by enabling analysis of serious collision patterns by year, location, road user type, road condition, visibility, and other attributes. It is suitable for an end-to-end Azure Data Engineering project because it contains real public-sector operational data and requires validation, cleaning, modeling, and reporting.

## QA-to-Data-Engineering Relevance

The dataset requires strong data quality checks, including validation for missing dates, duplicate records, invalid coordinates, inconsistent severity values, null road conditions, and record-count reconciliation between raw and curated layers.
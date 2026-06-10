# tx_curriculum_analysis

## Overview
This project analyzes the relationship between curriculum quality ratings from 
[edReports.org](https://edreports.org) and STAAR performance outcomes for districts 
in the Rio Grande Valley (RGV) of Texas.

**Key question:** Do districts using higher-rated curricula show stronger STAAR 
performance outcomes?

## Districts Analyzed
| District | Type | Location |
|---|---|---|
| Edinburg CISD | Traditional public | Edinburg, TX (RGV) |
| McAllen ISD | Traditional public | McAllen, TX (RGV) |
| Region One ESC | Education Service Center | Edinburg, TX (RGV) |

## Data Sources
- **TEA STAAR Aggregate Data** — Spring administrations 2018–2025, district level
- **edReports Curriculum Ratings** — Manually compiled for curricula adopted by each district

## Project Structure
models/
├── staging/
│   ├── stg_tea_staar_performance.sql
│   └── stg_edreports_curriculum_ratings.sql
└── marts/
└── mart_curriculum_staar_comparison.sql
seeds/
├── tea_staar_performance.csv
└── edreports_curriculum_ratings.csv

## Key Findings
- Edinburg CISD uses **Sharon Wells Mathematics** (K-5) as its primary math curriculum — 
  a Texas-specific program not submitted for edReports review
- McAllen ISD uses **HMH Texas Go Math!** which **Partially Meets Expectations** on edReports
- IDEA Public Schools uses **Eureka Math** and **Wit & Wisdom**, both rated 
  **Meets Expectations** — the highest edReports rating
- Both RGV traditional public districts use ELA curricula rated **Meets Expectations**

## Future Work
- Add IDEA Public Schools STAAR performance data for within-region comparison
- Expand to additional comparison districts (Alamo Heights ISD, Clear Creek ISD)
- Add campus-level analysis
- Build visualization layer

## Tools
- dbt Core / dbt Cloud
- Snowflake
- GitHub
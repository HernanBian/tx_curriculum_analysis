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

### Math Performance
Both districts use lower-rated math curricula — Edinburg CISD uses Sharon Wells 
Mathematics (not reviewed by edReports) and McAllen ISD uses HMH Texas Go Math! 
(Partially Meets Expectations). Despite this similarity, their performance trajectories differ:

| District | Math Curriculum | edReports Rating | Avg Math Meets % (2025) |
|---|---|---|---|
| Edinburg CISD | Sharon Wells Mathematics | Not Reviewed | 42.5% |
| McAllen ISD | HMH Texas Go Math! | Partially Meets Expectations | 48-54% |

### ELA Performance
Both districts use highly-rated ELA curricula (Meets Expectations) and show 
stronger reading performance than math:

| District | ELA Curriculum | edReports Rating | Avg Reading Meets % (2025) |
|---|---|---|---|
| Edinburg CISD | Texas myView Literacy | Meets Expectations | 53.7% |
| McAllen ISD | HMH Into Reading | Meets Expectations | 58-63% |

### Post-COVID Recovery
Both districts experienced a significant dip in Spring 2021. McAllen ISD showed 
stronger recovery in both math and reading by Spring 2022-2023, suggesting factors 
beyond curriculum rating — such as implementation quality, resources, and district 
support — play a significant role in student outcomes.

### Limitations
- Edinburg CISD's primary math curriculum (Sharon Wells) has no edReports rating, 
  making direct quality comparison difficult
- Analysis covers only 2 of 3 planned districts — IDEA Public Schools STAAR data 
  pending for within-region high-performing charter comparison
- Correlation between curriculum rating and performance is suggestive, not causal
- Grade band matching between STAAR grade integers and edReports grade band ranges uses a
  pattern-matching approach that may produce imprecise joins for certain grade levels —
  a BETWEEN-based approach using parsed grade band boundaries is a planned improvement

## Future Work
- Add IDEA Public Schools STAAR performance data for within-region comparison
- Expand to additional comparison districts (Alamo Heights ISD, Clear Creek ISD)
- Add campus-level analysis
- Build visualization layer

## Tools
- dbt Core / dbt Cloud - connected to Snowflake via RSA keypair authentication
- Snowflake - seeded manual data compilation from TEA and edReports public sources
- GitHub - Version Control

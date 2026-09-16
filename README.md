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
| IDEA Public Schools | High-performing charter network | Weslaco, TX (RGV) |

## Data Sources
- **TEA STAAR Aggregate Data** — Spring administrations 2018–2026, district level, grades 3-8
- **edReports Curriculum Ratings** — Manually compiled for curricula adopted by each district

## Project Structure
models/
├── staging/
│   ├── stg_tea_staar_performance.sql
│   └── stg_edreports_curriculum_ratings.sql
└── marts/
├── mart_curriculum_staar_comparison.sql
└── mart_curriculum_performance_summary.sql
seeds/
├── tea_staar_performance.csv
└── edreports_curriculum_ratings.csv

## Curriculum Overview
| District | Math Curriculum | Math Rating | ELA Curriculum | ELA Rating |
|---|---|---|---|---|
| Edinburg CISD | Sharon Wells Mathematics | Not Reviewed | Texas myView Literacy | Meets Expectations |
| McAllen ISD | HMH Texas Go Math! | Partially Meets Expectations | HMH Into Reading / Into Literature | Meets Expectations |
| IDEA Public Schools | Eureka Math | Meets Expectations | Wit & Wisdom | Meets Expectations |

## Key Findings

### Finding 1: Curriculum ratings alone do not predict STAAR performance
All three districts performed similarly in the pre-COVID baseline period (2018-2019) 
despite meaningfully different curriculum quality ratings. Math performance ranged 
only 1-2 percentage points across districts — suggesting that curriculum rating 
is not the primary driver of short-term performance differences.

### Finding 2: Post-COVID recovery patterns varied by district
All three districts experienced a significant performance dip in Spring 2021. 
IDEA Public Schools showed the strongest initial rebound in both Math and Reading 
(2021-2022), potentially reflecting advantages of their charter model in teacher 
support and instructional consistency during recovery.

### Math Performance Trends
| Year | Edinburg CISD | IDEA Public Schools | McAllen ISD |
|---|---|---|---|
| Spring 2018 | 48.0% | 48.3% | 48.8% |
| Spring 2019 | 48.8% | 47.5% | 48.5% |
| Spring 2021 | 17.5% | 25.0% | 25.8% |
| Spring 2022 | 39.3% | 43.2% | 45.2% |
| Spring 2023 | 42.3% | 40.8% | 48.2% |
| Spring 2024 | 40.8% | 41.5% | 48.5% |
| Spring 2025 | 42.5% | 37.2% | 51.8% |

### Reading Performance Trends
| Year | Edinburg CISD | IDEA Public Schools | McAllen ISD |
|---|---|---|---|
| Spring 2018 | 42.0% | 46.0% | 44.3% |
| Spring 2019 | 44.0% | 45.3% | 46.0% |
| Spring 2021 | 29.3% | 34.3% | 37.0% |
| Spring 2022 | 51.5% | 56.7% | 59.3% |
| Spring 2023 | 50.2% | 54.0% | 58.7% |
| Spring 2024 | 50.8% | 52.3% | 61.3% |
| Spring 2025 | 53.7% | 52.2% | 64.5% |

### Finding 3: McAllen ISD shows strongest recent performance trajectory
Despite using a Partially Meets Expectations Math curriculum, McAllen ISD has shown 
the most consistent improvement since 2022 — reaching 51.8% Math Meets and 64.5% 
Reading Meets in Spring 2025, the highest of the three districts in both subjects.

### Finding 4: IDEA's performance decline
IDEA Public Schools, which uses the highest-rated curricula of the three districts, 
has shown declining Math performance since 2023 (40.8% → 37.2%). Further development
of the analysis is necessary before drawing any conclusions about the relationship
between curriculum quality and student performance to include disaggregation of the
IDEA Public Schools data to include and aggregate only schools who are closer
geographically to create a more similar student population comparison.

### Overall Conclusion
At this time, the relationship between curriculum quality and student performance
is still under review. While bringing in IDEA Public Schools into the analysis proved
useful context, the realization that the charter network spans the entire state of
Texas requires a more complex analysis to disaggregate Edinburg and McAllen schools
and form a more close comparison of student populations.

## Limitations
- Analysis covers only 3 districts in a single region of Texas — findings 
  may not generalize to other contexts
- STAAR data for IDEA Public Schools reflects aggregate data including campuses
  across regions with different student populations. 
- Correlation between curriculum rating and performance is suggestive, not causal
- IDEA Public Schools data is missing grades 5 and 8 for Spring 2018, 2019, 
  and 2021 due to insufficient enrollment for TEA reporting thresholds
- Grade band matching between STAAR grade integers and edReports grade band 
  ranges uses explicit OR conditions (K-8, K-5, K-6) rather than a parsed 
  range approach — a BETWEEN-based solution using parsed grade_low and 
  grade_high bounds is a planned improvement
- McAllen ISD operates multiple curricula across grade bands — the is_primary 
  flag and grade band filtering may not perfectly isolate a single curriculum 
  per grade level

## Future Work
- Expand to additional high-performing districts across Texas for broader comparison
- A planned campus-level analysis aggregating those IDEA campuses located in Edinburg 
  and McAllen to create a geographically comparable grouping for more direct comparison
  to Edinburg CISD and McAllen ISD.
- Build visualization layer in Sigma or Tableau
- Implement BETWEEN-based grade band matching for more precise joins
- Investigate implementation quality factors beyond curriculum ratings

## Tools
- dbt Core / dbt Cloud — connected to Snowflake via RSA keypair authentication
- Snowflake — data warehouse
- GitHub — version control and project hosting

## Sample Queries

### Three-District Performance Comparison
```sql
select
    district_name,
    test_year,
    math_curriculum,
    math_curriculum_rating,
    avg_math_meets_pct,
    ela_curriculum,
    ela_curriculum_rating,
    avg_reading_meets_pct
from {{ ref('mart_curriculum_performance_summary') }}
order by test_year, district_name


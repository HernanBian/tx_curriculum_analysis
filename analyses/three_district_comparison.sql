analyses
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
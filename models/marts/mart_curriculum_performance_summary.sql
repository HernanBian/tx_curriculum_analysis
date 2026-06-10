with base as (
    select * from {{ ref('mart_curriculum_staar_comparison') }}
),

-- Average STAAR performance by district, curriculum, and rating
summary as (
    select
        district_name,
        test_year,
        math_curriculum,
        math_curriculum_rating,
        math_curriculum_score,
        ela_curriculum,
        ela_curriculum_rating,
        ela_curriculum_score,

        -- math performance averages across grades
        round(avg(math_meets_pct), 1)       as avg_math_meets_pct,
        round(avg(math_masters_pct), 1)     as avg_math_masters_pct,

        -- reading performance averages across grades
        round(avg(reading_meets_pct), 1)    as avg_reading_meets_pct,
        round(avg(reading_masters_pct), 1)  as avg_reading_masters_pct,

        -- test volume
        sum(math_tests_taken)               as total_math_tests,
        sum(reading_tests_taken)            as total_reading_tests,

        count(distinct grade)               as grades_tested

    from base
    where upper(district_name) in ('EDINBURG CISD', 'MCALLEN ISD')
    group by 1, 2, 3, 4, 5, 6, 7, 8
)

select * from summary
order by district_name, test_year
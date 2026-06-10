with staar as (
    select * from {{ ref('stg_tea_staar_performance') }}
),

edreports as (
    select * from {{ ref('stg_edreports_curriculum_ratings') }}
),

joined as (
    select
        -- district and year
        s.district_name,
        s.test_year,
        s.grade,

        -- staar performance
        s.math_tests_taken,
        s.math_meets_pct,
        s.math_masters_pct,
        s.reading_tests_taken,
        s.reading_meets_pct,
        s.reading_masters_pct,

        -- math curriculum ratings
        math_curr.curriculum_name           as math_curriculum,
        math_curr.overall_rating            as math_curriculum_rating,
        math_curr.overall_rating_score      as math_curriculum_score,

        -- ela curriculum ratings
        ela_curr.curriculum_name            as ela_curriculum,
        ela_curr.overall_rating             as ela_curriculum_rating,
        ela_curr.overall_rating_score       as ela_curriculum_score

    from staar s
    left join edreports math_curr
    on upper(s.district_name) = upper(math_curr.district_name)
    and math_curr.subject = 'Math'
    and math_curr.is_primary = 'true'
    and (
        math_curr.grade_band like '%' || s.grade || '%'
        or math_curr.grade_band = 'K-8'
        or math_curr.grade_band = 'K-5'
        or math_curr.grade_band = 'K-6'
    )
        
    left join edreports ela_curr
    on upper(s.district_name) = upper(ela_curr.district_name)
    and ela_curr.subject = 'ELA'
    and ela_curr.is_primary = 'true'
    and (
        ela_curr.grade_band like '%' || s.grade || '%'
        or ela_curr.grade_band = 'K-8'
        or ela_curr.grade_band = 'K-5'
        or ela_curr.grade_band = 'K-6'
    )
)

select * from joined
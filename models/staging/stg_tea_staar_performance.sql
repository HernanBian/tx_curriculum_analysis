with source as (
    select * from {{ ref('tea_staar_performance') }}
),

renamed as (
    select
        -- identifiers
        organization                        as district_name,
        id_cdc                              as district_id,
        
        -- test administration
        administration                      as test_year,
        tested_grade                        as grade,
        
        -- math performance
        staar_math_tests_taken              as math_tests_taken,
        staar_math_avg_scale_score          as math_avg_scale_score,
        staar_math_approaches_above_pct     as math_approaches_pct,
        staar_math_meets_above_pct          as math_meets_pct,
        staar_math_masters_pct              as math_masters_pct,

        -- reading performance
        staar_reading_tests_taken           as reading_tests_taken,
        staar_reading_avg_scale_score       as reading_avg_scale_score,
        staar_reading_approaches_above_pct  as reading_approaches_pct,
        staar_reading_meets_above_pct       as reading_meets_pct,
        staar_reading_masters_pct           as reading_masters_pct

    from source
)

select * from renamed
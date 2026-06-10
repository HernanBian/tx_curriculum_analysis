with source as (
    select * from {{ ref('edreports_curriculum_ratings') }}
),

renamed as (
    select
        district                                as district_name,
        curriculum_name,
        publisher,
        subject,
        grade_band,
        edreports_overall_rating                as overall_rating,
        gateway1_rating,
        gateway2_rating,
        gateway3_rating,
        review_year,
        notes,
        is_primary,

        -- derived field
        case
            when edreports_overall_rating = 'Meets Expectations' then 3
            when edreports_overall_rating = 'Partially Meets Expectations' then 2
            when edreports_overall_rating = 'Does Not Meet Expectations' then 1
            when edreports_overall_rating = 'Not Reviewed' then 0
            else null
        end                                     as overall_rating_score

    from source
)

select * from renamed
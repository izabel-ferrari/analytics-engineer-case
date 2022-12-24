WITH owners AS (
    SELECT * FROM {{ source('raw_data', 'owners') }}
)

SELECT
    id AS owner_id,
    -- name AS owner_name, -- as this field contains personal data, it is advisable to either mask or remove it
    team AS owner_team,
    job_position AS owner_job_position
FROM owners
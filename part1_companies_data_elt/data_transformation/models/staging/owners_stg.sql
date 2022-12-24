SELECT
    id AS owner_id,
    name AS owner_name,
    team AS owner_team,
    job_position AS owner_job_position
FROM {{ source('raw_data', 'owners') }}
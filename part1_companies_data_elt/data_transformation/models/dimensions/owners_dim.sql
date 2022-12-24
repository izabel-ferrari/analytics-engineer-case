WITH owners AS (
    SELECT * FROM {{ ref ('owners_stg') }}
)

SELECT
    owners.owner_id AS owner_id,
    owners.owner_team AS owner_team,
    owners.owner_job_position AS owner_job_position
FROM owners
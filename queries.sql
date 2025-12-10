-- most_popular_transport_types
--============================================================--
-- Query 1: Most Popular Transport Types in London (2010–2022)
-- Goal: Identify transport types ranked by total journey volume
--============================================================--

SELECT
    JOURNEY_TYPE,                                        -- Transport mode (e.g., Bus, Underground & DLR, etc.)
    SUM(JOURNEYS_MILLIONS) AS TOTAL_JOURNEYS_MILLIONS    -- Total number of journeys across all months/years
FROM
    TFL.JOURNEYS                                          -- Source table from the Snowflake dataset
GROUP BY
    JOURNEY_TYPE                                          -- Aggregate results by transport type
ORDER BY
    TOTAL_JOURNEYS_MILLIONS DESC;                         -- Sort from most to least popular

--=====================================================================--
-- Query 2: Emirates Airline Cable Car - Top 5 Most Popular Months
-- Goal: Identify the months/years with the highest journey volumes
--=====================================================================--

SELECT
    MONTH,                                                  -- Month number (1 = January)
    YEAR,                                                   -- Corresponding year
    ROUND(JOURNEYS_MILLIONS, 2) AS ROUNDED_JOURNEYS_MILLIONS -- Journeys rounded to 2 decimal places
FROM
    TFL.JOURNEYS                                            -- Source dataset table
WHERE
    JOURNEY_TYPE = 'Emirates Airline'             -- Filter only cable car transport type
    AND JOURNEYS_MILLIONS IS NOT NULL                       -- Exclude any missing data
ORDER BY
    JOURNEYS_MILLIONS DESC                                  -- Sort by journey volume (highest first)
LIMIT 5;                                                    -- Return only the top 5 most popular months

--======================================================================--
-- Query 3: Least Popular Years for Underground & DLR Transport Usage
-- Goal: Identify the 5 years with the lowest total journey volumes
--======================================================================--

SELECT
    YEAR,                                                   -- Year of reported journeys
    JOURNEY_TYPE,                                           -- Transport mode (Underground & DLR)
    SUM(JOURNEYS_MILLIONS) AS TOTAL_JOURNEYS_MILLIONS       -- Total journeys in millions for that year
FROM
    TFL.JOURNEYS                                            -- Source dataset table
WHERE
    JOURNEY_TYPE = 'Underground & DLR'                      -- Filter only London Underground & DLR combined usage
GROUP BY
    YEAR, JOURNEY_TYPE                                      -- Aggregate results by year and transport type
ORDER BY
    TOTAL_JOURNEYS_MILLIONS ASC                             -- Sort from lowest to highest
LIMIT 5;                                                    -- Keep only the least popular 5 years

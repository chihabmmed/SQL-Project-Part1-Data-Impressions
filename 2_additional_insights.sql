-- venue_ ------------------------------- venue_ --

-- City: Distinct city entries.
SELECT DISTINCT
    city
FROM
    venue_;


-- City: New York Venues Count
SELECT 
    SUM(venues_count) ny_venues_count
FROM
    (SELECT 
        city, COUNT(*) venues_count
    FROM
        venue_
    GROUP BY city
    HAVING city IN (SELECT DISTINCT
            city
        FROM
            venue_
        WHERE
            city LIKE '%New York%')) AS tbl1;

-- City: Chicago Venues count:
SELECT 
    SUM(venues_count) chicago_venues_count
FROM
    (SELECT 
        city, COUNT(*) venues_count
    FROM
        venue_
    GROUP BY city
    HAVING city IN (SELECT DISTINCT
            city
        FROM
            venue_
        WHERE
            city LIKE '%Chicago%')) AS tbl2;

-- City: San Francisco Venues count: 
SELECT 
    SUM(venues_count) san_francisco_venues_count
FROM
    (SELECT 
        city, COUNT(*) venues_count
    FROM
        venue_
    GROUP BY city
    HAVING city IN (SELECT DISTINCT
            city
        FROM
            venue_
        WHERE
            city LIKE '%San Francisco%')) AS tbl3;

-- All Cities counts Transposed
SELECT 
    *
FROM
    (SELECT 
        SUM(venues_count) ny_venues_count
    FROM
        (SELECT 
        city, COUNT(*) venues_count
    FROM
        venue_
    GROUP BY city
    HAVING city IN (SELECT DISTINCT
            city
        FROM
            venue_
        WHERE
            city LIKE '%New York%')) AS tbl1) AS tbla,
    (SELECT 
        SUM(venues_count) chicago_venues_count
    FROM
        (SELECT 
        city, COUNT(*) venues_count
    FROM
        venue_
    GROUP BY city
    HAVING city IN (SELECT DISTINCT
            city
        FROM
            venue_
        WHERE
            city LIKE '%Chicago%')) AS tbl2) AS tblb,
    (SELECT 
        SUM(venues_count) san_francisco_venues_count
    FROM
        (SELECT 
        city, COUNT(*) venues_count
    FROM
        venue_
    GROUP BY city
    HAVING city IN (SELECT DISTINCT
            city
        FROM
            venue_
        WHERE
            city LIKE '%San Francisco%')) AS tbl3) AS tblc;

/*
- Q: Is the data in city column in venue_ table consistant?
- A: No, the data entries in the city column in venue_ table is not consistant.
The data contains three main cities entered in diffrent ways in the column.
The consistant cities are as follows New York, Chicago, San Francisco.

- Q: After making data consistant, which city has the most venues and which one has the least?
- A: New York is the city that tops the city column with the most venues count at 526 counts.
In the second place comes Chicago with 288 counts, and at last San Francisco with 204 counts.
*/



-- grp ------------------------------- grp --

-- oldest 3 groups exploration
SELECT 
    group_id,
    group_name,
    join_mode,
    city.city,
    category.category_name,
    created,
    members
FROM
    grp
        JOIN
    city ON grp.city_id = city.city_id
        JOIN
    category ON grp.category_id = category.category_id
WHERE
    join_mode = 'open'
ORDER BY created ASC
LIMIT 3;

/*
- Q: What are the longest running 3 goups that are still open? 
- A: The oldest and longest running open 3 groups are: 
	New York City Poker Group - id 122787, 
	NYC Dining + Cooking - id 37994, 
	SF PHP Community - id 120903.

- Q: Which cities they are in? 
- A: Both of the groups id-122787 and id-37994 are in New York. The other group with id-120903 is in San Francisco.

- Q: When were they created?
- A: They were all created in 2002-10-08. 

- Q: How many members are in each group?
- A: Group id-122787 has 1797 members. 
	Group id-37994 has 16409 members.
    Group id-120903 has 2639 members.
    
- Q: What categories do these groups belong to?
- A: These groups are of the following categories:
	Group id-122787 is of Games category. 
	Group id-37994 is of Food & Drink category.
    Group id-120903 is of Tech category.
*/



-- grp_member ------------------------------- grp_member --

-- First member to join LetsMeet--
SELECT 
    member_id, member_name, joined, COUNT(group_id)
FROM
    grp_member
GROUP BY member_id
HAVING member_id = (SELECT 
        member_id
    FROM
        grp_member
    WHERE
        member_status = 'active'
    ORDER BY joined ASC
    LIMIT 1);


/*
- Q: Who is the first LetsMeet member that is still active?
- A: Cristine, id-257351, is the first member to join the LetsMeet. This member joined in on 2003-04-14. And It is part of only one single group.
*/



-- city ------------------------------- city --
SELECT 
    state, SUM(member_count) total_member_count
FROM
    city
GROUP BY state
ORDER BY total_member_count DESC;

/*
- Q: What is the sum of all members per state as per the city table?
- A: The sum of all members per state in the city table is as follows: NJ: 661,NY: 229393, IN: 31, MN: 5, IL: 91395, CA: 60866
NY, IL and CA comes with the highest member counts respectively as per the city table. 
*/



-- event ------------------------------- event --

-- avg duration in seconds, minutes and hours
SELECT 
    ROUND(avg_duration) avg_duration,
    ROUND(avg_duration / 60) avg_dur_minutes,
    ROUND(avg_duration / 3600) avg_dur_hours
FROM
    (SELECT 
        AVG(duration) avg_duration
    FROM
        event) AS tbl1;

/*
- Q: What is the average duration of all events? in minutes? in hours? Round to the nearest integer.
- A: The average duration of all events rounded to the nearest integer in seconds is 10769 s, And in minutes is 179 min, And in hours is 3 h.
*/


-- category ------------------------------- category --

-- Most popular categories; that have hiest members.
SELECT 
    category.category_id,
    category_name,
    COUNT(member_id) member_count
FROM
    grp
        JOIN
    category ON grp.category_id = category.category_id
        JOIN
    grp_member ON grp.group_id = grp_member.group_id
GROUP BY category_id
ORDER BY member_count DESC;

/*
- Q: What are the two most popular categories?
- A: The two most popular categories are: Teck, id-34, with 11882 members. And Career & Business, id-2, with 8195 members.
*/








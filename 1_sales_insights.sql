-- Answer the questions from the Sales team in this file.

-- Active Cities ------------------------------- Active Cities --
-- 1 --
SELECT DISTINCT
    city
FROM
    grp_member
WHERE
    member_status = 'active';
/* 
- What cities have active members?

- Cities that have active members are: West New York, West Chicago, South San Francisco, San Francisco, North Chicago, New York, East Chicago, Chicago Ridge, Chicago Heights, and Chicago.
*/
-- 2 --
SELECT DISTINCT
    city, state
FROM
    city
WHERE
    city.city NOT IN (SELECT DISTINCT
            city
        FROM
            grp_member
        WHERE
            member_status = 'active'); 

/* 
Are there any cities listed in the city table with no active members? 
if so, what state are those cities in? 

yes, there are three cities from three different states that have no active members. These cities and states are: 
New York Mills, NY
New York Mills, MN
Chicago Park, CA
*/



-- Groups ------------------------------- Groups --

-- 1 --
SELECT 
    join_mode, COUNT(*)
FROM
    grp
GROUP BY join_mode;

/* 
How many groups are currently open, waiting for approval, and/or closed?

There are 4340 groups in total.
There are 3602 open groups, 723 waiting for approval, and 15 closed.
*/




-- Categories ------------------------------- Categories --

-- 1 --
-- All categories ordered descendingly.
SELECT 
    grp.category_id, category_name, COUNT(*) grp_count
FROM
    grp
        JOIN
    category ON grp.category_id = category.category_id
GROUP BY grp.category_id
ORDER BY COUNT(*) DESC;

-- Five categories that contain the most groups.
SELECT 
    grp.category_id, category_name, COUNT(*) grp_count
FROM
    grp
        JOIN
    category ON grp.category_id = category.category_id
GROUP BY grp.category_id
ORDER BY COUNT(*) DESC
LIMIT 5;

-- Five categories that contain the least groups.
SELECT 
    grp.category_id, category_name, COUNT(*) grp_count
FROM
    grp
        JOIN
    category ON grp.category_id = category.category_id
GROUP BY grp.category_id
ORDER BY COUNT(*) ASC
LIMIT 5;
/*
What are the 5 categories that contain the most groups? What are the 5 categories that contain the least number of groups?

The 5 categories that contain the most groups are: Tech, Career & Business, Socializing, Health & Wellbeing, and Language & Ethnic Identity.

The 5 categories that contain the least number of groups: Paranormal, Cars & Motorcycles, Sci-Fi & Fantasy, Lifestyle, and Hobbies & Crafts, 
*/




-- Members ------------------------------- Members --

-- 1 --
SELECT 
    COUNT(DISTINCT member_id) total_members_count
FROM
    grp_member;
/*
How many members are there?

There are 39980 distinct members.
*/

-- 2 -- 
SELECT 
    (chicago_members_count / total_members_count) * 100 AS chicago_memb_percentage
FROM
    (SELECT 
        COUNT(DISTINCT member_id) chicago_members_count
    FROM
        grp_member
    GROUP BY city
    HAVING city = 'Chicago') AS ch_cont_tbl,
    (SELECT 
        COUNT(DISTINCT member_id) total_members_count
    FROM
        grp_member) AS total_cnt_tbl;

/*
What percentage of members are in Chihcago?

The percentage of members in Chihcago is around %21.2 or exactly %21.1931.
*/
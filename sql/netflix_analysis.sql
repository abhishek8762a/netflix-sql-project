-- ============================================================
--  NETFLIX CONTENT ANALYSIS  --  MySQL
--  Dataset: data/netflix.csv
--  Import the CSV into the `netflix` table (MySQL Workbench:
--  Table Data Import Wizard), then run the queries below.
-- ============================================================

CREATE DATABASE netflix_db;
USE netflix_db;

CREATE TABLE netflix (
    title VARCHAR(255),
    rating VARCHAR(10),
    ratinglevel TEXT,
    ratingdescription TEXT,
    release_year INT,
    user_rating_score FLOAT,
    user_rating_size INT
);

-- Q1. Total titles per rating

select  rating , count(*) as total
from netflix
group by rating
order by total desc;

-- Insight:
-- Shows which rating has the most content. The rating at the top is the
-- dominant category. TV-14 leads, so the platform carries more content for
-- a teen (14+) audience, which points to a youth-oriented content focus.


-- Q2. Top 10 titles by user rating score

SELECT distinct(title), user_rating_score
FROM netflix
ORDER BY user_rating_score DESC
LIMIT 10;

-- Insight:
-- Identifies the 10 highest-rated titles, i.e. what the audience liked most.
-- DISTINCT removes duplicate titles.
-- Top rated titles show a narrow score range indicating consistent content quality across multiple shows


-- Q3. Number of titles released per year

SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY total DESC;

-- Insight:
-- Shows how much content was released each year and when the peak was.
-- Useful for trend analysis (growth or decline).


SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY total DESC
limit 1;

-- Insight:
-- 2016 had the most releases (200 titles), which suggests content production
-- and library expansion peaked that year. Later years can be compared
-- against it to spot growth or decline.
-- 2016 show the highest content volume indicating a peak in content addition or production activity



-- Q4. Overall average user rating score

SELECT round(AVG(user_rating_score),2) AS avg_rating
FROM netflix;

-- Insight:
-- The overall average score represents the general content quality on the platform.


-- Q5. High-quality titles (score above 90)

SELECT title, user_rating_score
FROM netflix
WHERE user_rating_score > 90
ORDER BY user_rating_score DESC;

-- Insight:
-- Identifies high-quality content (score > 90), the titles the audience liked most.



-- Q6. Average user rating score per rating category

SELECT rating, ROUND(AVG(user_rating_score),2) AS avg_score
FROM netflix
GROUP BY rating
ORDER BY avg_score DESC;

-- Insight:
-- Shows which rating category has the highest-quality content.
-- TV-MA has the highest average score, so mature/adult content performs
-- best on quality.


-- Q7. Years with the highest average rating

SELECT release_year, ROUND(AVG(user_rating_score),2) AS avg_score
FROM netflix
GROUP BY release_year
ORDER BY avg_score DESC
LIMIT 5;

-- Insight:
-- Identifies the top-performing years for content quality.
-- 2017 has the highest average rating (~90.43), making it the strongest
-- year for quality.


-- Q8. Rating categories with more than 100 titles

SELECT rating, COUNT(*) AS total
FROM netflix
GROUP BY rating
HAVING total > 100
ORDER BY total DESC;

-- Insight:
-- Keeps only the popular rating categories.
-- TV-14 (188) and PG (119) have the most content, so most of the catalogue
-- targets teen and family audiences.


-- Q9. Lowest-rated titles

SELECT title, user_rating_score
FROM netflix
ORDER BY user_rating_score ASC
LIMIT 10;

-- Insight:
-- Identifies the lowest-performing content, which the audience liked least.




-- Q10. Number of distinct release years

SELECT COUNT(DISTINCT release_year) AS total_years
FROM netflix;

-- Insight:
-- The dataset covers 32 different release years, so the data spans a wide
-- time range.




-- Q11. Average number of titles per year

SELECT ROUND(AVG(total_per_year),2) AS avg_per_year
FROM (
    SELECT release_year, COUNT(*) AS total_per_year
    FROM netflix
    GROUP BY release_year
) AS yearly_data;

-- Insight:
-- On average ~18.91 titles were released per year, i.e. roughly 19 titles
-- added each year, which indicates consistent content production.



-- Q12. Year with the most content

SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY total DESC
LIMIT 1;

-- Insight:
-- Confirms 2016 as the peak content year in the dataset.



-- Q13. Split rating scores into performance buckets

SELECT
  CASE
    WHEN user_rating_score >= 90 THEN 'Excellent'
    WHEN user_rating_score >= 75 THEN 'Good'
    WHEN user_rating_score >= 60 THEN 'Average'
    ELSE 'Low'
  END AS rating_category,
  COUNT(*) AS total
FROM netflix
GROUP BY rating_category
ORDER BY total DESC;

-- Insight:
-- Shows the overall quality distribution.
-- 'Excellent' is the largest bucket (284), then Good (170), Average (124)
-- and Low (27), so most content is high quality and very little is low quality.


-- Q14. High-quality titles (score > 90) per rating category

SELECT rating, COUNT(*) AS high_quality_count
FROM netflix
WHERE user_rating_score > 90
GROUP BY rating
ORDER BY high_quality_count DESC;

-- Insight:
-- TV-14 has the most high-quality titles (> 90), so content for teen
-- audiences is strong on both volume and quality.

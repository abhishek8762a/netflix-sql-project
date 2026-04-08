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

-- total movies per rating

select  rating , count(*) as total 
from netflix 
group by rating 
order by total desc;

-- is  query say Pata chalta hai key konsa rating sabse Jyada content rakta hai 
-- jo rating sabse uper aayegi  (highest total ) whi dominant  category hai 
--  example Agar TV-14 sabse Jyada hai iska  MATLAB platform per teen age audience (14+)content Jyada hai 
--  Ye indicate karta hai Ki Netflix ka focus youth oriented content par jyada hai 


-- Objective: Highest user rating score wale top 10 shows/movies nikalna

SELECT distinct(title), user_rating_score
FROM netflix
ORDER BY user_rating_score DESC
LIMIT 10;

-- Insight:
-- Is query se top 10 highest rated content identify KIYA hai
-- Yeh batata hai kaun se shows/movies audience ko sabse zyada pasand aaye
-- DISTINCT ka use karke duplicates ko remove kiya 
-- Top rated titles show a narrow score range indicating consistent content quality across multiple shows 


-- Objective: Har saal mein kitna content release hua hai nikalna

SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY total DESC;

-- Insight:
-- Is query se pata chalta hai ki har saal kitna content release hua or sabse jyda kab hua hua 
-- Isse trend analysis kar sakte hain (growth ya decline)


SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY total DESC
limit 1;

-- Insight:
--  is Analysis se pata chala ki 2016 mein sabse zyada content release hua (200 titles)
-- Yeh indicate karta hai 2016 platform par content production/apna library expansion peak par tha
-- Iske baad ke years ko compare karke growth ya decline trend identify kiya ja sakta hai
-- 2016 show the highest content volume indicating a peak in content addition or production activity 



-- Objective: Overall average user rating score nikalna

SELECT round(AVG(user_rating_score),2) AS avg_rating
FROM netflix;

-- Insight:
-- Is query se overall dataset ka average rating score pata chalta hai
-- Yeh platform ki overall content quality ko represent karta hai


-- Objective: 90 se upar rating wale top quality shows nikalna

SELECT title, user_rating_score
FROM netflix
WHERE user_rating_score > 90
ORDER BY user_rating_score DESC;

-- Insight:
-- Is query se high-quality content (rating > 90) identify hota hai
-- Yeh shows audience ko sabse zyada pasand aaye hain



-- Objective: Har rating category ka average user rating score nikalna

SELECT rating, ROUND(AVG(user_rating_score),2) AS avg_score
FROM netflix
GROUP BY rating
ORDER BY avg_score DESC;

-- Insight:
-- Is query se pata chalta hai kaun si rating category ka content sabse high quality hai
-- Highest avg_score wali category best performing content ko represent karti hai jo ki TVMA hai 
-- mature /adult content quality  ke mamle me  best perform kr rha hai


-- Objective: Kaunse years mein average rating sabse high hai

SELECT release_year, ROUND(AVG(user_rating_score),2) AS avg_score
FROM netflix
GROUP BY release_year
ORDER BY avg_score DESC
LIMIT 5;

-- Insight:
-- Is query se top performing years identify hote hain jahan content quality sabse high thi
-- 2017 ka average rating ~90.43 hai, jo sabse highest hai
-- Yeh indicate karta hai ki is year ka content quality ke maamle mein sabse strong tha


 -- Objective: Sirf un rating categories ko dikhana jisme 100 se zyada shows hain

SELECT rating, COUNT(*) AS total
FROM netflix
GROUP BY rating
HAVING total > 100
ORDER BY total DESC;

-- Insight:
-- Is query se sirf popular rating categories identify hoti hain jisme content zyada hai
-- TV-14 (188) aur PG (119) categories mein sabse zyada content hai
-- Yeh indicate karta hai ki platform par majority content teen aur family audience ke liye targeted hai


-- Objective: Lowest rating wale shows identify karna

SELECT title, user_rating_score
FROM netflix
ORDER BY user_rating_score ASC
LIMIT 10;

-- Insight:
-- Is query se lowest performing content identify hota hai jise audience ne kam pasand kiya




-- Objective: Total unique release years nikalna

SELECT COUNT(DISTINCT release_year) AS total_years
FROM netflix;

-- Insight:
-- Is query se pata chalta hai ki dataset kitne alag-alag years ka data cover karta hai
-- 32 total yr Yeh indicate karta hai ki data kaafi wide time range mein spread hai




-- Objective: Har year ke content ka average count nikalna

SELECT ROUND(AVG(total_per_year),2) AS avg_per_year
FROM (
    SELECT release_year, COUNT(*) AS total_per_year
    FROM netflix
    GROUP BY release_year
) AS yearly_data;

-- Insight:
-- Is query se pata chalta hai ki average kitne shows har saal release hue
-- Har year average ~18.91 shows release hue hain
-- Iska matlab hai ki har saal lagbhag 19 shows ka content add hua hai
-- Yeh consistent content production ko indicate karta hai



-- Objective: Sabse zyada content wale year ko identify karna

SELECT release_year, COUNT(*) AS total
FROM netflix
GROUP BY release_year
ORDER BY total DESC
LIMIT 1;

-- Insight:
-- Yeh query highest content wale year ko confirm karti hai jo ki 2016 hai
-- Top year dataset ka peak content year represent karta hai



-- Objective: Rating score ko categories mein divide karna (performance buckets)

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
-- Is query se pata chalta hai ki kitna content Excellent, Good, Average aur Low category mein aata hai
-- Yeh overall quality distribution ko represent karta hai
-- Dataset mein 'Excellent' category sabse zyada hai (284), uske baad Good (170), Average (124) aur Low (27)
-- Yeh indicate karta hai ki majority content high quality ka hai aur low-quality content bahut kam hai


-- Objective: Har rating category mein high-quality shows (score > 90) ka count

SELECT rating, COUNT(*) AS high_quality_count
FROM netflix
WHERE user_rating_score > 90
GROUP BY rating
ORDER BY high_quality_count DESC;

-- Insight:
-- Is query se pata chalta hai ki kaunsi rating category mein sabse zyada high-quality content hai
-- TV-14 category mein sabse zyada high-quality shows (>90) hain
-- Yeh indicate karta hai ki teen audience ke liye content quantity ke saath quality bhi strong hai











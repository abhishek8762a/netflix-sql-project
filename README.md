<div align="center">

# 🎬 Netflix Content Analysis (SQL)

**Rating mix, release trends and content quality of Netflix titles, analysed with SQL in MySQL.**

![MySQL](https://img.shields.io/badge/MySQL-4479A1?style=flat-square&logo=mysql&logoColor=white)
![SQL](https://img.shields.io/badge/SQL-Analysis-0B1120?style=flat-square)
![Status](https://img.shields.io/badge/status-complete-22C55E?style=flat-square)

</div>

---

## 📌 Overview

Which ratings dominate the Netflix catalogue, which years released the most content, and how good is that content by audience score? This project answers those questions with plain SQL in MySQL Workbench: grouping, filtering, aggregates, sub-queries and `CASE`-based quality buckets.

## 📂 Dataset

| | |
|---|---|
| **File** | [`data/netflix.csv`](data/netflix.csv) |
| **Rows** | 1,000 titles |
| **Columns** | `title`, `rating`, `ratinglevel`, `ratingdescription`, `release_year`, `user_rating_score`, `user_rating_size` |

## 🔍 Questions Answered

| # | Question | SQL used |
|---|---|---|
| 1 | Which rating has the most titles? | `GROUP BY`, `COUNT` |
| 2 | Top 10 titles by user score | `DISTINCT`, `ORDER BY`, `LIMIT` |
| 3 | Titles released per year, and the peak year | `GROUP BY`, `ORDER BY` |
| 4 | Overall average user score | `AVG`, `ROUND` |
| 5 | High-quality titles (score > 90) | `WHERE` |
| 6 | Average score per rating category | `GROUP BY`, `AVG` |
| 7 | Years with the highest average score | `GROUP BY`, `LIMIT` |
| 8 | Rating categories with 100+ titles | `HAVING` |
| 9 | Lowest-rated titles | `ORDER BY ASC` |
| 10 | Number of release years covered | `COUNT(DISTINCT)` |
| 11 | Average titles released per year | Sub-query |
| 12 | Quality buckets (Excellent / Good / Average / Low) | `CASE` |
| 13 | High-quality titles per rating category | `WHERE` + `GROUP BY` |

All queries, with an insight under each one, are in [`sql/netflix_analysis.sql`](sql/netflix_analysis.sql).

## 📊 Key Insights

- **TV-14 is the largest rating category (188 titles)**, followed by PG (119). Most of the catalogue targets teen and family audiences.
- **2016 was the peak release year** with 200 titles. On average about 19 titles were released per year across 32 release years.
- **2017 had the highest average user score (~90.4).**
- **Quality is high overall:** Excellent (284) is the biggest bucket, then Good (170), Average (124) and Low (27).
- **TV-MA has the highest average score**, and TV-14 has the most titles scoring above 90.

## 💡 Recommendations

- Keep investing in high-scoring content (score > 90); it is already the largest bucket.
- TV-14 combines high volume and high quality, so it is the strongest category to grow.
- Keep a steady release pace; past years show consistent output of about 19 titles a year.

## 📁 Repository Structure

```
netflix-sql-project/
├── data/
│   └── netflix.csv              # dataset (1,000 titles)
├── sql/
│   └── netflix_analysis.sql     # table setup + queries with insights
└── README.md
```

## ▶️ How to Run

1. Open `sql/netflix_analysis.sql` in MySQL Workbench and run the `CREATE DATABASE` and `CREATE TABLE` statements.
2. Import `data/netflix.csv` into the `netflix` table (Table Data Import Wizard).
3. Run the queries one by one and read the insight under each.

---

## 👤 Author

**Abhishek Kumar** · MIS Data Analyst  
[LinkedIn](https://www.linkedin.com/in/abhikumar8762/) · [GitHub](https://github.com/abhishek8762a) · [Portfolio](https://abhishek-portfolio-8762.vercel.app) · [Email](mailto:abhiyadav8762@gmail.com)

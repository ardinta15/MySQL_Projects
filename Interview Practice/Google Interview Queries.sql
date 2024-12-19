--- GOOGLE INTERVIEW ---

CREATE TABLE interview.UserActivity
(
	username 	varchar (50),
	activity 	varchar (50),
	start_date	date,
    end_date	date
);

INSERT INTO interview.UserActivity (username, activity, start_date, end_date)
VALUES
('Amy','Travel','2020-02-12','2020-02-20'),
('Amy','Dancing','2020-02-21','2020-02-23'),
('Amy','Travel','2020-02-24','2020-02-28'),
('Joe','Travel','2020-02-11','2020-02-18'),
('Adam','Travel','2020-02-12','2020-02-20'),
('Adam','Dancing','2020-02-21','2020-02-23'),
('Adam','Singing','2020-02-24','2020-02-28'),
('Adam','Travel','2020-03-01','2020-03-28');

SELECT * FROM interview.UserActivity;

WITH ranked_activities AS 
(
SELECT *, 
ROW_NUMBER() OVER(PARTITION BY username ORDER BY start_date desc) AS rn,
COUNT(*) OVER(PARTITION BY username) AS count
FROM   interview.UserActivity
)
SELECT username, activity, start_date, end_date
FROM   ranked_activities
WHERE  rn=2 OR count=1
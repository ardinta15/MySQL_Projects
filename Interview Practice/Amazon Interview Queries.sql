--- AMAZON INTERVIEW ---

CREATE DATABASE interview;
CREATE TABLE interview.emp_attendance
(
	employee 	varchar(10),
	dates 		date,
	status 		varchar(20)
);


INSERT INTO interview.emp_attendance (employee, dates, status)
VALUES 
('A1', '2024-01-01', 'PRESENT'),
('A1', '2024-01-02', 'PRESENT'),
('A1', '2024-01-03', 'PRESENT'),
('A1', '2024-01-04', 'ABSENT'),
('A1', '2024-01-05', 'PRESENT'),
('A1', '2024-01-06', 'PRESENT'),
('A1', '2024-01-07', 'ABSENT'),
('A1', '2024-01-08', 'ABSENT'),
('A1', '2024-01-09', 'ABSENT'),
('A1', '2024-01-010', 'PRESENT'),
('A2', '2024-01-06', 'PRESENT'),
('A2', '2024-01-07', 'PRESENT'),
('A2', '2024-01-08', 'ABSENT'),
('A2', '2024-01-09', 'PRESENT'),
('A2', '2024-01-010', 'ABSENT');

SELECT * FROM interview.emp_attendance;

WITH cte AS 
(
SELECT *, ROW_NUMBER() OVER (PARTITION BY employee, STATUS ORDER BY dates) AS rw, 
dates - ROW_NUMBER() OVER (PARTITION BY employee ORDER BY employee) AS diff FROM interview.emp_attendance
ORDER BY employee, dates
)

SELECT employee, MIN(dates) AS from_date, MAX(dates) AS to_date, STATUS FROM cte
GROUP BY employee, status, diff


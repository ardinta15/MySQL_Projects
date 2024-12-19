--- CAPGEMINI INTERVIEW ---

CREATE TABLE interview.lifts
(
		id         	  	int,
	    capacity_kg     int
);

CREATE TABLE interview.lift_passengers
(
		passenger_name   	varchar(50),
		weight_kg     		int,
		lift_id				int
);

INSERT INTO interview.lifts (id, capacity_kg)
VALUES
(1,300),
(2,350);

INSERT INTO interview.lift_passengers (passenger_name, weight_kg,lift_id)
VALUES
('Rahul', 85, 1),
('Adarsh', 73, 1),
('Riti', 95, 1),
('Dheeraj', 80, 1),
('Vimal', 83, 2),
('Neha', 77, 2),
('Priti', 73, 2),
('Himanshi', 85, 2);

WITH cte AS 
(
SELECT * , 
SUM(weight_kg) OVER (PARTITION BY lift_id ORDER BY weight_kg) AS running_weight
FROM interview.lift_passengers lp JOIN
interview.lifts ON lift_id = id
)

SELECT lift_id,
GROUP_CONCAT(passenger_name) AS passengers FROM cte 
WHERE running_weight <=capacity_kg
GROUP BY lift_id;
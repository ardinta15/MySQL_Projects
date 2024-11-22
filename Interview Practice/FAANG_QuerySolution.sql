		-- FAANG Companies --
	# Facebook, Apple, Amazon, Netflix, Google #

CREATE DATABASE Warehouse;

CREATE TABLE `Warehouse`.warehouse
(
	ID						VARCHAR(20),
	OnHandQuantity			INT,
	OnHandQuantityDelta		INT,
	event_type				VARCHAR(20),
	event_datetime			TIMESTAMP
);

INSERT INTO `Warehouse`.warehouse (ID, OnHandQuantity, OnHandQuantityDelta, event_type, event_datetime)
VALUES 
('SH0013', 278,   99 ,   'OutBound', '2020-05-25 0:25'), 
('SH0012', 377,   31 ,   'InBound',  '2020-05-24 22:00'),
('SH0011', 346,   1  ,   'OutBound', '2020-05-24 15:01'),
('SH0010', 346,   1  ,   'OutBound', '2020-05-23 5:00'),
('SH009',  348,   102,   'InBound',  '2020-04-25 18:00'),
('SH008',  246,   43 ,   'InBound',  '2020-04-25 2:00'),
('SH007',  203,   2  ,   'OutBound', '2020-02-25 9:00'),
('SH006',  205,   129,   'OutBound', '2020-02-18 7:00'),
('SH005',  334,   1  ,   'OutBound', '2020-02-18 8:00'),
('SH004',  335,   27 ,   'OutBound', '2020-01-29 5:00'),
('SH003',  362,   120,   'InBound',  '2019-12-31 2:00'),
('SH002',  242,   8  ,   'OutBound', '2019-05-22 0:50'),
('SH001',  250,   250,   'InBound',  '2019-05-20 0:45');

WITH WH AS
	(SELECT * FROM `Warehouse`.warehouse ORDER BY event_datetime DESC),
	days AS
		(SELECT event_datetime, onhandquantity
		, date_sub(event_datetime, INTERVAL 90 day)  AS day90
		, date_sub(event_datetime, INTERVAL 180 day) AS day180
		, date_sub(event_datetime, INTERVAL 270 day) AS day270
		, date_sub(event_datetime, INTERVAL 365 day) AS day365
		 FROM WH limit 1), 
	inv_90_days AS
		(SELECT COALESCE(Sum(WH.OnHandQuantityDelta), 0) AS DaysOld_90
		 FROM WH CROSS JOIN days
		 WHERE WH.event_datetime >= days.day90
		 AND event_type = 'InBound'),
	inv_90_days_final AS
		(SELECT CASE WHEN DaysOld_90 > onhandquantity then onhandquantity 
		 ELSE DaysOld_90
		 END AS DaysOld_90
		 FROM inv_90_days x
		 CROSS JOIN days),

	inv_180_days AS
		(SELECT COALESCE(Sum(WH.OnHandQuantityDelta), 0) AS DaysOld_180
		 FROM WH CROSS JOIN days
		 WHERE WH.event_datetime BETWEEN days.day180 AND days.day90
		 AND event_type = 'InBound'),
	inv_180_days_final AS
		(SELECT CASE WHEN DaysOld_180 > (onhandquantity - DaysOld_90) then (onhandquantity - DaysOld_90) 
		 ELSE DaysOld_180
		 END AS DaysOld_180
		 FROM inv_180_days x
		 CROSS JOIN days
		 CROSS JOIN inv_90_days_final),

	inv_270_days AS
		(SELECT COALESCE(Sum(WH.OnHandQuantityDelta), 0) as DaysOld_270
		 FROM WH CROSS JOIN days
		 WHERE WH.event_datetime BETWEEN days.day270 AND days.day180
 		 AND event_type = 'InBound'),
	inv_270_days_final AS
		(SELECT CASE WHEN DaysOld_270 > (onhandquantity - (DaysOld_90 + DaysOld_180)) THEN (onhandquantity - (DaysOld_90 + DaysOld_180)) 
		 ELSE DaysOld_270
		 END AS DaysOld_270
		 FROM inv_270_days x
		 CROSS JOIN days
		 CROSS JOIN inv_90_days_final
		 CROSS JOIN inv_180_days_final),

	inv_365_days AS
		(SELECT COALESCE(Sum(WH.OnHandQuantityDelta), 0) AS DaysOld_365
		 FROM WH CROSS JOIN days
		 WHERE WH.event_datetime BETWEEN days.day365 AND days.day270
		 AND event_type = 'InBound'),
	inv_365_days_final AS
		(SELECT CASE WHEN DaysOld_365 > (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) THEN (onhandquantity - (DaysOld_90 + DaysOld_180 + DaysOld_270)) 
		 ELSE DaysOld_365
		 END AS DaysOld_365
		 FROM inv_365_days x
		 CROSS JOIN days
		 CROSS JOIN inv_90_days_final
		 CROSS JOIN inv_180_days_final
		 CROSS JOIN inv_270_days_final)

SELECT DaysOld_90 	AS '0-90 days old',
	   DaysOld_180 	AS '91-180 days old',
	   DaysOld_270 	AS '181-270 days old',
	   DaysOld_365 	AS '271-365 days old'
FROM 		inv_90_days_final
CROSS JOIN  inv_180_days_final
CROSS JOIN  inv_270_days_final
CROSS JOIN  inv_365_days_final
CROSS JOIN  days;
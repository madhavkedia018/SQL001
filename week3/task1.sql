create table projects_task1(task_id int primary key, start_date date, end_date date)
  
insert into projects_task1 values(1,'2015-10-01','2015-10-02')
insert into projects_task1 values(2,'2015-10-02','2015-10-03')
insert into projects_task1 values(3,'2015-10-03','2015-10-04')
insert into projects_task1 values(4,'2015-10-13','2015-10-14')
insert into projects_task1 values(5,'2015-10-14','2015-10-15')
insert into projects_task1 values(6,'2015-10-28','2015-10-29')
insert into projects_task1 values(7,'2015-10-30','2015-10-31')

WITH ProjectGroups AS (
  SELECT *,
         DATEADD(DAY, -ROW_NUMBER() OVER (ORDER BY start_date), start_date) AS grp
  FROM projects_task1
),
GroupedProjects AS (
  SELECT 
    MIN(start_date) AS project_start,
    MAX(end_date) AS project_end,
    DATEDIFF(DAY, MIN(start_date), MAX(end_date)) + 1 AS duration
  FROM ProjectGroups
  GROUP BY grp
)
SELECT project_start, project_end
FROM GroupedProjects
ORDER BY duration ASC, project_start ASC

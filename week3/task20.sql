CREATE TABLE source_table (
    id INT,
    name VARCHAR(50),
    department VARCHAR(50)
)
CREATE TABLE target_table (
    id INT,
    name VARCHAR(50),
    department VARCHAR(50)
)

-- Insert data into source_table
INSERT INTO source_table VALUES
(1, 'Alice', 'HR'),
(2, 'Bob', 'Finance'),
(3, 'Charlie', 'IT'),
(4, 'Diana', 'IT'),
(5, 'Ethan', 'HR')

-- Insert existing data into target_table
INSERT INTO target_table VALUES
(1, 'Alice', 'HR'),
(3, 'Charlie', 'IT')


INSERT INTO target_table (id, name, department)
SELECT s.id, s.name, s.department
FROM source_table s
WHERE NOT EXISTS (
    SELECT 1
    FROM target_table t
    WHERE t.id = s.id
      AND t.name = s.name
      AND t.department = s.department
)

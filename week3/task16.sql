CREATE TABLE Sample (
    id INT,
    a INT,
    b INT
);

INSERT INTO Sample VALUES
(1, 10, 20),
(2, 30, 40);


-- works for strings as well 
-- a and b must be of same datatype
UPDATE Sample
SET a = b,
    b = a

SELECT 
  ROUND( ABS(MAX(LAT_N) - MIN(LAT_N)) + ABS(MAX(LONG_W) - MIN(LONG_W) ) , 5)
   AS manhattan_distance
FROM STATION

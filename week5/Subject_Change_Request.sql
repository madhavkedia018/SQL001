CREATE PROCEDURE Process_Subject_Requests
AS
BEGIN
  
    DECLARE @StudentId VARCHAR(13)
    DECLARE @RequestedSubject VARCHAR(11)
    DECLARE @CurrentSubject VARCHAR(11)

    DECLARE request_cursor CURSOR FOR SELECT StudentId, SubjectId FROM SubjectRequest
    OPEN request_cursor

    FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubject

    WHILE @@FETCH_STATUS = 0
    BEGIN
        IF EXISTS (SELECT 1 FROM SubjectAllotments WHERE StudentId = @StudentId)
        BEGIN
            SELECT @CurrentSubject = SubjectId FROM SubjectAllotments
            WHERE StudentId = @StudentId AND Is_Valid = 1

            IF @CurrentSubject IS NULL OR @CurrentSubject != @RequestedSubject
            BEGIN
                UPDATE SubjectAllotments SET Is_Valid = 0
                WHERE StudentId = @StudentId AND Is_Valid = 1

                INSERT INTO SubjectAllotments VALUES (@StudentId, @RequestedSubject, 1)
            END
        END
  
        ELSE          -- for the student who is asking for subject allotment first time 
        BEGIN
            INSERT INTO SubjectAllotments VALUES (@StudentId, @RequestedSubject, 1)
        END

        FETCH NEXT FROM request_cursor INTO @StudentId, @RequestedSubject
    END

    CLOSE request_cursor
    DEALLOCATE request_cursor
END


  
EXEC Process_Subject_Requests  
SELECT * FROM SubjectAllotments ORDER BY StudentId, Is_Valid DESC

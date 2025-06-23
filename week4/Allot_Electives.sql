CREATE PROCEDURE AllotSubjects
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @StudentId INT,
            @Pref INT,
            @SubjectId VARCHAR(10),
            @RemainingSeats INT,
            @Allocated BIT;

    -- Clear previous results
    DELETE FROM Allotments;
    DELETE FROM UnallottedStudents;

    -- Cursor to iterate over students ordered by GPA descending
    DECLARE StudentCursor CURSOR FOR
        SELECT StudentId
        FROM StudentDetails
        ORDER BY GPA DESC;

    OPEN StudentCursor;
    FETCH NEXT FROM StudentCursor INTO @StudentId;

    WHILE @@FETCH_STATUS = 0
    BEGIN
        SET @Pref = 1;
        SET @Allocated = 0;

        WHILE @Pref <= 5 AND @Allocated = 0
        BEGIN
            -- Get the subject ID for the current preference
            SELECT @SubjectId = SubjectId
            FROM StudentPreference
            WHERE StudentId = @StudentId AND Preference = @Pref;

            IF @SubjectId IS NOT NULL
            BEGIN
                -- Get remaining seats
                SELECT @RemainingSeats = RemainingSeats
                FROM SubjectDetails
                WHERE SubjectId = @SubjectId;

                IF @RemainingSeats > 0
                BEGIN
                    -- Allot the student
                    INSERT INTO Allotments (SubjectId, StudentId)
                    VALUES (@SubjectId, @StudentId);

                    -- Decrease seat count
                    UPDATE SubjectDetails
                    SET RemainingSeats = RemainingSeats - 1
                    WHERE SubjectId = @SubjectId;

                    SET @Allocated = 1;
                END
            END

            SET @Pref = @Pref + 1;
        END

        -- If not allocated, insert into UnallottedStudents
        IF @Allocated = 0
        BEGIN
            INSERT INTO UnallottedStudents (StudentId)
            VALUES (@StudentId);
        END

        FETCH NEXT FROM StudentCursor INTO @StudentId;
    END

    CLOSE StudentCursor;
    DEALLOCATE StudentCursor;
END
GO

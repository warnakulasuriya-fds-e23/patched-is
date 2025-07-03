-- NOTE: This procedure assumes that the SAML IDP metadata is stored under the path
-- '/_system/governance/repository/identity/provider/saml' in the registry and only two corresponding RESOURCE entries
-- (one for the collection and one for the resource object) and one CONTENT entry exist for each SAML IDP metadata file.

--<![[Start of Procedure]]>--
BEGIN TRY
    DECLARE @batchSize INT
    DECLARE @chunkSize INT
    DECLARE @batchCount INT
    DECLARE @chunkCount INT
    DECLARE @rowCount INT
    DECLARE @enableLog BIT
    DECLARE @backupTables BIT

    SET @batchSize    = 10000
    SET @chunkSize    = 500000
    SET @enableLog    = 1
    SET @backupTables = 0

    SET @rowCount = 0
    SET @batchCount = 1
    SET @chunkCount = 1

    IF (@enableLog = 1)
    BEGIN
    SELECT '[' + convert(varchar, getdate(), 121) + '] WSO2_SAML_IDP_METADATA_CLEANUP() STARTED...!' AS 'INFO LOG'
    END

    DECLARE @RootPathIdList TABLE (ROOT_PATH_ID INT);
    INSERT INTO @RootPathIdList (ROOT_PATH_ID) SELECT REG_PATH_ID FROM REG_PATH WHERE REG_PATH_VALUE = '/_system/governance/repository/identity/provider/saml';

    DECLARE @PathIdList TABLE (REG_PATH_ID INT);
    INSERT INTO @PathIdList (REG_PATH_ID) SELECT REG_PATH_ID FROM REG_PATH WHERE REG_PATH_PARENT_ID IN (SELECT ROOT_PATH_ID FROM @RootPathIdList);

    IF (@backupTables = 1)
    BEGIN
        IF (@enableLog = 1)
        BEGIN
            SELECT '[' + convert(varchar, getdate(), 121) + '] TABLE BACKUP STARTED ... !' AS 'INFO LOG'
        END

        IF (EXISTS (SELECT * FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_NAME = 'BAK_REG_RESOURCE'))
        BEGIN
            IF (@enableLog = 1)
            BEGIN
                SELECT '[' + convert(varchar, getdate(), 121) + '] DELETING OLD BACKUP...' AS 'INFO LOG'
            END
            DROP TABLE BAK_REG_RESOURCE;
            DROP TABLE BAK_REG_CONTENT;
        END

        SELECT * INTO BAK_REG_RESOURCE FROM REG_RESOURCE WHERE REG_PATH_ID IN (SELECT REG_PATH_ID FROM @PathIdList);

        DECLARE @ContentIdList TABLE (REG_CONTENT_ID INT);
        INSERT INTO @ContentIdList (REG_CONTENT_ID) SELECT DISTINCT REG_CONTENT_ID FROM BAK_REG_RESOURCE WHERE REG_CONTENT_ID IS NOT NULL;
        SELECT * INTO BAK_REG_CONTENT FROM REG_CONTENT WHERE REG_CONTENT_ID IN (SELECT REG_CONTENT_ID FROM @ContentIdList);
    END

    BEGIN TRANSACTION

    WHILE (@chunkCount > 0)
    BEGIN
        DROP TABLE IF EXISTS REG_RESOURCE_CHUNK_TMP;
        DROP TABLE IF EXISTS REG_CONTENT_CHUNK_TMP;

        CREATE TABLE REG_RESOURCE_CHUNK_TMP(REG_VERSION INT, REG_TENANT_ID INT, REG_CONTENT_ID INT);
        CREATE TABLE REG_CONTENT_CHUNK_TMP(REG_CONTENT_ID INT);

        INSERT INTO REG_RESOURCE_CHUNK_TMP(REG_VERSION, REG_TENANT_ID, REG_CONTENT_ID) SELECT TOP (@chunkSize) REG_VERSION,
         REG_TENANT_ID, REG_CONTENT_ID FROM REG_RESOURCE WHERE REG_PATH_ID IN (SELECT REG_PATH_ID FROM @PathIdList);
        SET @chunkCount = @@ROWCOUNT;
        INSERT INTO REG_CONTENT_CHUNK_TMP(REG_CONTENT_ID) SELECT REG_CONTENT_ID FROM REG_RESOURCE_CHUNK_TMP
         WHERE REG_CONTENT_ID IS NOT NULL;

        IF (@chunkCount = 0)
        BEGIN
            BREAK;
        END

        CREATE INDEX REG_RESOURCE_CHUNK_TMP on REG_RESOURCE_CHUNK_TMP (REG_VERSION, REG_TENANT_ID, REG_CONTENT_ID);
        CREATE INDEX REG_CONTENT_CHUNK_TMP on REG_CONTENT_CHUNK_TMP (REG_CONTENT_ID);

        IF (@enableLog = 1)
        BEGIN
            SELECT '[' + convert(varchar, getdate(), 121) + '] CREATED REG_RESOURCE_CHUNK_TMP...' AS 'INFO LOG'
        END

        SET @batchCount = 1
        WHILE (@batchCount > 0)
        BEGIN
            DROP TABLE IF EXISTS REG_RESOURCE_BATCH_TMP;
            DROP TABLE IF EXISTS REG_CONTENT_BATCH_TMP;

            CREATE TABLE REG_RESOURCE_BATCH_TMP(REG_VERSION INT, REG_TENANT_ID INT, REG_CONTENT_ID INT);
            CREATE TABLE REG_CONTENT_BATCH_TMP(REG_CONTENT_ID INT);

            INSERT INTO REG_RESOURCE_BATCH_TMP(REG_VERSION, REG_TENANT_ID, REG_CONTENT_ID) SELECT TOP (@batchSize) REG_VERSION,
             REG_TENANT_ID, REG_CONTENT_ID FROM REG_RESOURCE_CHUNK_TMP;
            SET @batchCount = @@ROWCOUNT;
            INSERT INTO REG_CONTENT_BATCH_TMP(REG_CONTENT_ID) SELECT REG_CONTENT_ID FROM REG_RESOURCE_BATCH_TMP
             WHERE REG_CONTENT_ID IS NOT NULL;

            IF (@batchCount = 0)
            BEGIN
                BREAK;
            END

            CREATE INDEX REG_RESOURCE_BATCH_TMP on REG_RESOURCE_BATCH_TMP (REG_VERSION, REG_TENANT_ID);
            CREATE INDEX REG_CONTENT_BATCH_TMP on REG_CONTENT_BATCH_TMP (REG_CONTENT_ID);

            IF (@enableLog = 1)
            BEGIN
                SELECT '[' + convert(varchar, getdate(), 121) + '] CREATED REG_RESOURCE_BATCH_TMP...' AS 'INFO LOG'
            END

            IF (@enableLog = 1)
            BEGIN
                SELECT '[' + convert(varchar, getdate(), 121) + '] BATCH DELETE STARTED ON REG_RESOURCE...' AS 'INFO LOG'
            END

            DELETE r FROM REG_RESOURCE r INNER JOIN REG_RESOURCE_BATCH_TMP tmp ON r.REG_VERSION = tmp.REG_VERSION
             AND r.REG_TENANT_ID = tmp.REG_TENANT_ID;
            SET @rowCount = @@ROWCOUNT;
            DELETE FROM REG_CONTENT WHERE REG_CONTENT_ID IN (SELECT REG_CONTENT_ID FROM REG_CONTENT_BATCH_TMP);

            IF (@enableLog = 1)
            BEGIN
                SELECT CONCAT('BATCH DELETE FINISHED ON REG_RESOURCE : ', @rowCount) AS 'INFO LOG'
            END

            DELETE r FROM REG_RESOURCE_CHUNK_TMP r INNER JOIN  REG_RESOURCE_BATCH_TMP tmp ON
             r.REG_VERSION = tmp.REG_VERSION AND r.REG_TENANT_ID = tmp.REG_TENANT_ID;
        END
    END

    DROP TABLE IF EXISTS REG_RESOURCE_BATCH_TMP;
    DROP TABLE IF EXISTS REG_CONTENT_BATCH_TMP;
    DROP TABLE IF EXISTS REG_RESOURCE_CHUNK_TMP;
    DROP TABLE IF EXISTS REG_CONTENT_CHUNK_TMP;

    COMMIT TRANSACTION

    IF (@enableLog = 1)
    BEGIN
        SELECT '[' + convert(varchar, getdate(), 121) + '] CLEANUP COMPLETED...!' AS 'INFO_LOG'
    END

END TRY
BEGIN CATCH

    IF (@enableLog = 1)
    BEGIN
        SELECT '[' + convert(varchar, getdate(), 121) + '] ERROR OCCURRED: ' + ERROR_MESSAGE() AS 'ERROR LOG'
    END

    ROLLBACK TRANSACTION
END CATCH;
--<![[End of Procedure]]>--

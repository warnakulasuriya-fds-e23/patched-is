-- NOTE: This procedure assumes that the SAML IDP metadata is stored under the path
-- '/_system/governance/repository/identity/provider/saml' in the registry and only two corresponding RESOURCE entries
-- (one for the collection and one for the resource object) and one CONTENT entry exist for each SAML IDP metadata file.

--<![[Start of Procedure]]>--
DO $$
DECLARE
    batchSize INT;
    chunkSize INT;
    batchCount INT;
    chunkCount INT;
    rowCount INT;
    enableLog BOOLEAN;
    backupTables BOOLEAN;

BEGIN

    batchSize    := 10000;
    chunkSize    := 500000;
    enableLog    := TRUE;
    backupTables := TRUE;

    rowCount := 0;
    batchCount := 1;
    chunkCount := 1;

    IF (enableLog) THEN
        RAISE NOTICE 'WSO2_SAML_IDP_METADATA_CLEANUP() STARTED...!';
    END IF;

    CREATE TEMP TABLE rootpathidlist (root_path_id INT) ON COMMIT DROP;
    CREATE TEMP TABLE pathidlist (reg_path_id INT) ON COMMIT DROP;
    INSERT INTO rootpathidlist (root_path_id) SELECT reg_path_id FROM reg_path WHERE
     reg_path_value = '/_system/governance/repository/identity/provider/saml';
    INSERT INTO pathidlist (reg_path_id) SELECT reg_path_id FROM reg_path WHERE reg_path_parent_id IN ( SELECT
     root_path_id FROM rootpathidlist);

    IF (backupTables)
    THEN
        IF (enableLog)
        THEN
            RAISE NOTICE 'TABLE BACKUP STARTED...!';
        END IF;

        IF EXISTS (SELECT tablename FROM pg_catalog.pg_tables WHERE schemaname = current_schema() AND tablename IN ('bak_reg_resource'))
        THEN
            IF (enableLog)
            THEN
                RAISE NOTICE 'DELETING OLD BACKUP...';
            END IF;
            DROP TABLE bak_reg_resource;
            DROP TABLE bak_reg_content;
        END IF;

        CREATE TABLE bak_reg_resource AS SELECT * FROM reg_resource WHERE reg_path_id IN (SELECT reg_path_id FROM pathidlist);
        CREATE TEMP TABLE contentidlist (reg_content_id INT) ON COMMIT DROP;
        INSERT INTO contentidlist (reg_content_id) SELECT DISTINCT reg_content_id FROM bak_reg_resource WHERE reg_content_id IS NOT NULL;
        CREATE TABLE bak_reg_content AS SELECT * FROM reg_content WHERE reg_content_id IN (SELECT reg_content_id FROM contentidlist);

    END IF;

    BEGIN

        WHILE chunkCount > 0
        LOOP

            DROP TABLE IF EXISTS reg_resource_chunk_tmp;
            DROP TABLE IF EXISTS reg_content_chunk_tmp;

            CREATE TABLE reg_resource_chunk_tmp(reg_version INT, reg_tenant_id INT, reg_content_id INT);
            CREATE TABLE reg_content_chunk_tmp(reg_content_id INT);

            INSERT INTO reg_resource_chunk_tmp SELECT reg_version, reg_tenant_id, reg_content_id FROM reg_resource WHERE
             reg_path_id IN (SELECT reg_path_id FROM pathidlist) LIMIT chunkSize;
            GET DIAGNOSTICS chunkCount := ROW_COUNT;
            INSERT INTO reg_content_chunk_tmp SELECT reg_content_id FROM reg_resource_chunk_tmp WHERE
             reg_content_id IS NOT NULL;

            IF (chunkCount = 0)
            THEN
                EXIT;
            END IF;

            CREATE INDEX IF NOT EXISTS reg_resource_chunk_tmp_idx ON reg_resource_chunk_tmp (reg_version, reg_tenant_id, reg_content_id);
            CREATE INDEX IF NOT EXISTS reg_content_chunk_tmp_idx ON reg_content_chunk_tmp (reg_content_id);

            IF (enableLog)
            THEN
                RAISE NOTICE 'CREATED reg_resource_chunk_tmp...';
            END IF;

            batchCount := 1;
            WHILE batchCount > 0
            LOOP
                DROP TABLE IF EXISTS reg_resource_batch_tmp;
                DROP TABLE IF EXISTS reg_content_batch_tmp;

                CREATE TABLE reg_resource_batch_tmp(reg_version INT, reg_tenant_id INT, reg_content_id INT);
                CREATE TABLE reg_content_batch_tmp(reg_content_id INT);

                INSERT INTO reg_resource_batch_tmp(reg_version, reg_tenant_id, reg_content_id) SELECT reg_version,
                 reg_tenant_id, reg_content_id FROM reg_resource_chunk_tmp LIMIT batchSize;
                GET diagnostics batchCount := ROW_COUNT;
                INSERT INTO reg_content_batch_tmp SELECT reg_content_id FROM reg_resource_batch_tmp WHERE
                 reg_content_id IS NOT NULL;

                IF (batchCount = 0)
                THEN
                    EXIT;
                END IF;

                CREATE INDEX IF NOT EXISTS reg_resource_batch_tmp_idx ON reg_resource_batch_tmp (reg_version, reg_tenant_id);
                CREATE INDEX IF NOT EXISTS reg_content_batch_tmp_idx ON reg_content_batch_tmp (reg_content_id);

                IF (enableLog)
                THEN
                    RAISE NOTICE 'CREATED reg_resource_batch_tmp...';
                END IF;

                IF (enableLog)
                THEN
                    RAISE NOTICE 'BATCH DELETE STARTED ON reg_resource...';
                END IF;

                DELETE FROM reg_resource r USING reg_resource_batch_tmp tmp WHERE r.reg_version = tmp.reg_version
                 AND r.reg_tenant_id = tmp.reg_tenant_id;
                GET DIAGNOSTICS rowCount := ROW_COUNT;
                DELETE FROM reg_content WHERE reg_content_id IN (SELECT reg_content_id FROM reg_content_batch_tmp);

                IF (enableLog)
                THEN
                    RAISE NOTICE 'BATCH DELETE FINISHED ON reg_resource : %', rowCount;
                END IF;

                DELETE FROM reg_resource_chunk_tmp r USING reg_resource_batch_tmp tmp WHERE r.reg_version = tmp.reg_version
                 AND r.reg_tenant_id = tmp.reg_tenant_id;
            END LOOP;
        END LOOP;

        DROP TABLE IF EXISTS reg_resource_batch_tmp;
        DROP TABLE IF EXISTS reg_content_batch_tmp;
        DROP TABLE IF EXISTS reg_resource_chunk_tmp;
        DROP TABLE IF EXISTS reg_content_chunk_tmp;

        IF (enableLog)
        THEN
            RAISE NOTICE 'CLEANUP COMPLETED...!';
        END IF;

    END;

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'ERROR OCCURRED: %', SQLERRM;

END;
$$
LANGUAGE 'plpgsql';
--<![[End of Procedure]]>--

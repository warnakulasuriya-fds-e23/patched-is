DROP PROCEDURE IF EXISTS skip_index_if_exists;

CREATE PROCEDURE skip_index_if_exists(indexName varchar(64), tableName varchar(64), tableColumns varchar(255)) BEGIN BEGIN DECLARE CONTINUE HANDLER FOR SQLEXCEPTION BEGIN END; SET @s = CONCAT('CREATE INDEX ', indexName, ' ON ', tableName, tableColumns); PREPARE stmt FROM @s; EXECUTE stmt; END; END;

CALL skip_index_if_exists('IDX_TK_VALUE_TYPE','IDN_OAUTH2_TOKEN_BINDING','(TOKEN_BINDING_VALUE, TOKEN_BINDING_TYPE)');

DROP PROCEDURE IF EXISTS skip_index_if_exists;

-- --------------------------- INDEX CREATION -----------------------------

-- IDN_OIDC_PROPERTY --
CREATE INDEX IDX_IOP_CK ON IDN_OIDC_PROPERTY(CONSUMER_KEY);

-- --------------------------- REMOVE UNUSED INDICES -----------------------------

-- IDN_OAUTH2_ACCESS_TOKEN --
DROP PROCEDURE IF EXISTS drop_index_if_exists;
CREATE PROCEDURE drop_index_if_exists() BEGIN IF((SELECT COUNT(*) AS index_exists FROM information_schema.statistics WHERE TABLE_SCHEMA = DATABASE() and table_name = 'IDN_OAUTH2_ACCESS_TOKEN' AND index_name = 'IDX_AT_CK_AU') > 0) THEN SET @s = CONCAT('DROP INDEX ' , 'IDX_AT_CK_AU' , ' ON ' , 'IDN_OAUTH2_ACCESS_TOKEN'); PREPARE stmt FROM @s; EXECUTE stmt; END IF; END;
CALL drop_index_if_exists();

DROP PROCEDURE IF EXISTS drop_index_if_exists;
CREATE PROCEDURE drop_index_if_exists() BEGIN IF((SELECT COUNT(*) AS index_exists FROM information_schema.statistics WHERE TABLE_SCHEMA = DATABASE() and table_name = 'IDN_OAUTH2_ACCESS_TOKEN' AND index_name = 'IDX_AT_AU_TID_UD_TS_CKID') > 0) THEN SET @s = CONCAT('DROP INDEX ' , 'IDX_AT_AU_TID_UD_TS_CKID' , ' ON ' , 'IDN_OAUTH2_ACCESS_TOKEN'); PREPARE stmt FROM @s; EXECUTE stmt; END IF; END;
CALL drop_index_if_exists();

DROP PROCEDURE IF EXISTS drop_index_if_exists;
CREATE PROCEDURE drop_index_if_exists() BEGIN IF((SELECT COUNT(*) AS index_exists FROM information_schema.statistics WHERE TABLE_SCHEMA = DATABASE() and table_name = 'IDN_OAUTH2_ACCESS_TOKEN' AND index_name = 'IDX_AT_AU_CKID_TS_UT') > 0) THEN SET @s = CONCAT('DROP INDEX ' , 'IDX_AT_AU_CKID_TS_UT' , ' ON ' , 'IDN_OAUTH2_ACCESS_TOKEN'); PREPARE stmt FROM @s; EXECUTE stmt; END IF; END;
CALL drop_index_if_exists();

-- IDN_OIDC_PROPERTY --
DROP PROCEDURE IF EXISTS drop_index_if_exists;
CREATE PROCEDURE drop_index_if_exists() BEGIN IF((SELECT COUNT(*) AS index_exists FROM information_schema.statistics WHERE TABLE_SCHEMA = DATABASE() and table_name = 'IDN_OIDC_PROPERTY' AND index_name = 'IDX_IOP_TID_CK') > 0) THEN SET @s = CONCAT('DROP INDEX ' , 'IDX_IOP_TID_CK' , ' ON ' , 'IDN_OIDC_PROPERTY'); PREPARE stmt FROM @s; EXECUTE stmt; END IF; END;
CALL drop_index_if_exists();

------------------------ ORGANIZATION MANAGEMENT TABLES -------------------------

CREATE TABLE IF NOT EXISTS SP_SHARED_APP (
    ID INTEGER NOT NULL AUTO_INCREMENT,
    MAIN_APP_ID CHAR(36) NOT NULL,
    OWNER_ORG_ID CHAR(36) NOT NULL,
    SHARED_APP_ID CHAR(36) NOT NULL,
    SHARED_ORG_ID CHAR(36) NOT NULL,
    PRIMARY KEY (ID),
    FOREIGN KEY (MAIN_APP_ID) REFERENCES SP_APP(UUID) ON DELETE CASCADE,
    FOREIGN KEY (SHARED_APP_ID) REFERENCES SP_APP(UUID) ON DELETE CASCADE,
    UNIQUE (MAIN_APP_ID, OWNER_ORG_ID, SHARED_ORG_ID),
    UNIQUE (SHARED_APP_ID)
)ENGINE INNODB;

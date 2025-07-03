CREATE TABLE FIDO2_DEVICE_STORE (
      TENANT_ID INTEGER,
      DOMAIN_NAME VARCHAR(255) NOT NULL,
      USER_NAME VARCHAR(45) NOT NULL,
      TIME_REGISTERED TIMESTAMP,
      USER_HANDLE VARCHAR(64) NOT NULL,
      CREDENTIAL_ID VARCHAR(200) NOT NULL,
      PUBLIC_KEY_COSE VARCHAR(1024) NOT NULL,
      SIGNATURE_COUNT NUMBER(19),
      USER_IDENTITY VARCHAR(512) NOT NULL,
      PRIMARY KEY (CREDENTIAL_ID, USER_HANDLE))
/

CREATE TABLE IDN_AUTH_SESSION_APP_INFO (
      SESSION_ID VARCHAR (100) NOT NULL,
      SUBJECT VARCHAR (100) NOT NULL,
      APP_ID INTEGER NOT NULL,
      INBOUND_AUTH_TYPE VARCHAR (255) NOT NULL,
      PRIMARY KEY (SESSION_ID, SUBJECT, APP_ID, INBOUND_AUTH_TYPE))
/

CREATE TABLE IDN_AUTH_SESSION_META_DATA (
      SESSION_ID VARCHAR (100) NOT NULL,
      PROPERTY_TYPE VARCHAR (100) NOT NULL,
      VALUE VARCHAR (255) NOT NULL,
      PRIMARY KEY (SESSION_ID, PROPERTY_TYPE, VALUE))
/

CREATE TABLE IDN_FUNCTION_LIBRARY (
      NAME VARCHAR(255) NOT NULL,
      DESCRIPTION VARCHAR(1023),
      TYPE VARCHAR(255) NOT NULL,
      TENANT_ID INTEGER NOT NULL,
      DATA BLOB NOT NULL,
      PRIMARY KEY (TENANT_ID,NAME))
/

CREATE OR REPLACE PROCEDURE add_index_if_not_exists (query IN VARCHAR2)
  IS
BEGIN
  execute immediate query;
  dbms_output.put_line(query);
exception WHEN OTHERS THEN
  dbms_output.put_line( 'Skipped ');
END;
/

CALL add_index_if_not_exists('CREATE INDEX IDX_FIDO2_STR ON FIDO2_DEVICE_STORE(USER_NAME, TENANT_ID, DOMAIN_NAME, CREDENTIAL_ID, USER_HANDLE)')
/

DROP PROCEDURE add_index_if_not_exists
/

DECLARE
    v_constraint_count INTEGER;
BEGIN
    -- Check if the unique constraint exists
    SELECT COUNT(*)
    INTO v_constraint_count
    FROM user_constraints
    WHERE table_name = 'UM_HYBRID_ROLE'
      AND constraint_type = 'U'
      AND constraint_name IN (
          SELECT constraint_name
          FROM user_cons_columns
          WHERE table_name = 'UM_HYBRID_ROLE'
          AND column_name = 'UM_ROLE_NAME'
          INTERSECT
          SELECT constraint_name
          FROM user_cons_columns
          WHERE table_name = 'UM_HYBRID_ROLE'
          AND column_name = 'UM_TENANT_ID'
      );

    -- Add the unique constraint if it does not exist
    IF v_constraint_count = 0 THEN
        EXECUTE IMMEDIATE 'ALTER TABLE UM_HYBRID_ROLE ADD UNIQUE (UM_ROLE_NAME, UM_TENANT_ID)';
    END IF;
END;
/

DO $$ DECLARE drop_foreign_key_iop VARCHAR(200); BEGIN SELECT constraint_name INTO drop_foreign_key_iop FROM information_schema.table_constraints WHERE table_name = 'idn_oidc_property' AND constraint_type = 'FOREIGN KEY'; IF drop_foreign_key_iop IS NOT NULL THEN EXECUTE 'ALTER TABLE IDN_OIDC_PROPERTY DROP CONSTRAINT IF EXISTS '|| drop_foreign_key_iop || ';'; END IF; END; $$;

DO $$ DECLARE drop_foreign_key_iocac VARCHAR(200); BEGIN SELECT constraint_name INTO drop_foreign_key_iocac FROM information_schema.table_constraints WHERE table_name = 'idn_oauth2_ciba_auth_code' AND constraint_type = 'FOREIGN KEY'; IF drop_foreign_key_iocac IS NOT NULL THEN EXECUTE 'ALTER TABLE IDN_OAUTH2_CIBA_AUTH_CODE DROP CONSTRAINT IF EXISTS '|| drop_foreign_key_iocac || ';'; END IF; END; $$;

DROP INDEX IF EXISTS IDX_IOP_CK;

ALTER TABLE IDN_OAUTH_CONSUMER_APPS DROP CONSTRAINT CONSUMER_KEY_CONSTRAINT;

ALTER TABLE IDN_OAUTH_CONSUMER_APPS ADD CONSTRAINT CONSUMER_KEY_CONSTRAINT UNIQUE (TENANT_ID, CONSUMER_KEY);

CREATE INDEX IDX_IOP_CK ON IDN_OIDC_PROPERTY(TENANT_ID, CONSUMER_KEY);

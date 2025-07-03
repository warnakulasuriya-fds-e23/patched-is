--<![[Start of Procedure]]>--
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM information_schema.columns WHERE table_name = 'cm_sp_purpose_pii_cat_assoc' AND column_name = 'is_consented'
    ) THEN
        ALTER TABLE CM_SP_PURPOSE_PII_CAT_ASSOC ADD IS_CONSENTED BOOLEAN DEFAULT TRUE NOT NULL;
    END IF;
END;
$$
LANGUAGE 'plpgsql';
--<![[End of Procedure]]>--

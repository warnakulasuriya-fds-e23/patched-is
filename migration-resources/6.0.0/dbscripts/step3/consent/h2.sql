--<![CDATA[Start of Procedure]]>--
CREATE ALIAS MIGRATE_CM_SP_PURPOSE_PII_CAT_ASSOC AS $$
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
@CODE
void migrateCmSpPurposePiiCatAssoc(final Connection conn) throws SQLException {

    boolean isExists = false;
    PreparedStatement ps = conn.prepareStatement("SELECT COUNT(*) FROM INFORMATION_SCHEMA.COLUMNS WHERE TABLE_NAME='CM_SP_PURPOSE_PII_CAT_ASSOC' AND COLUMN_NAME='IS_CONSENTED'");
    ResultSet results =  ps.executeQuery();
    while (results.next()) {
        isExists = results.getBoolean(1);
    }

    if (!isExists) {
        ps = conn.prepareStatement("ALTER TABLE CM_SP_PURPOSE_PII_CAT_ASSOC ADD IS_CONSENTED BOOLEAN DEFAULT TRUE NOT NULL");
        ps.execute();
    }
}
$$;
--<![CDATA[End of Procedure]]>--

CALL MIGRATE_CM_SP_PURPOSE_PII_CAT_ASSOC();

DROP ALIAS IF EXISTS MIGRATE_CM_SP_PURPOSE_PII_CAT_ASSOC;

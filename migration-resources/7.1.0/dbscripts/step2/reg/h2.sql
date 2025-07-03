-- Remove alias if it exists.
DROP ALIAS IF EXISTS WSO2_SAML_IDP_METADATA_CLEANUP;

-- Create alias for the Java-based stored procedure.
CREATE ALIAS WSO2_SAML_IDP_METADATA_CLEANUP AS $$
void deleteSamlMetadata(final Connection conn) throws SQLException {

	conn.setAutoCommit(false); // Start TRANSACTION.
    try (Statement stmt = conn.createStatement()) {

        // Store SAML Metadata related REG_CONTENT_ID in a TEMPORARY TABLE.
        stmt.execute("DROP TABLE IF EXISTS TEMP_SAML_IDP_METADATA_CONTENT_ID");
        stmt.execute("CREATE LOCAL TEMPORARY TABLE TEMP_SAML_IDP_METADATA_CONTENT_ID (REG_CONTENT_ID INTEGER)");

        stmt.execute("INSERT INTO TEMP_SAML_IDP_METADATA_CONTENT_ID " +
                     "SELECT REG_CONTENT_ID FROM REG_RESOURCE " +
                     "WHERE REG_PATH_ID IN (" +
                     "SELECT REG_PATH_ID FROM REG_PATH WHERE REG_PATH_PARENT_ID IN (" +
                     "SELECT REG_PATH_ID FROM REG_PATH WHERE REG_PATH_VALUE = '/_system/governance/repository/identity/provider/saml'))");

        // DELETE SAML IDP Resources.
        stmt.executeUpdate(
            "DELETE FROM REG_RESOURCE WHERE REG_PATH_ID IN (" +
            "SELECT REG_PATH_ID FROM REG_PATH WHERE REG_PATH_PARENT_ID IN (" +
            "SELECT REG_PATH_ID FROM REG_PATH WHERE REG_PATH_VALUE = '/_system/governance/repository/identity/provider/saml'))"
        );

        // DELETE SAML IDP Resource Contents.
        stmt.executeUpdate(
            "DELETE FROM REG_CONTENT WHERE REG_CONTENT_ID IN (SELECT REG_CONTENT_ID FROM TEMP_SAML_IDP_METADATA_CONTENT_ID)"
        );

        // Drop temporary TABLE.
        stmt.execute("DROP TABLE IF EXISTS TEMP_SAML_IDP_METADATA_CONTENT_ID");

        // Commit the TRANSACTION.
        conn.commit();

    } catch (SQLException e) {
        conn.rollback(); // Rollback transaction on error.
        throw e;
    } finally {
        conn.setAutoCommit(true);
    }
}
$$;

-- Execute the stored procedure.
CALL WSO2_SAML_IDP_METADATA_CLEANUP();

-- Drop alias after execution.
DROP ALIAS IF EXISTS WSO2_SAML_IDP_METADATA_CLEANUP;

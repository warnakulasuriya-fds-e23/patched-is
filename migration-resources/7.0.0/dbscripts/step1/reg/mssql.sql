IF NOT EXISTS (
    SELECT 1
    FROM sys.indexes i
    JOIN sys.index_columns ic1 ON i.object_id = ic1.object_id AND i.index_id = ic1.index_id
    JOIN sys.columns c1 ON ic1.object_id = c1.object_id AND ic1.column_id = c1.column_id
    JOIN sys.index_columns ic2 ON i.object_id = ic2.object_id AND i.index_id = ic2.index_id
    JOIN sys.columns c2 ON ic2.object_id = c2.object_id AND ic2.column_id = c2.column_id
    WHERE i.object_id = OBJECT_ID('REG_RESOURCE_PROPERTY')
      AND i.is_hypothetical = 0
      AND c1.name = 'REG_TENANT_ID' AND ic1.key_ordinal = 1
      AND c2.name = 'REG_PROPERTY_ID' AND ic2.key_ordinal = 2
      AND i.index_id NOT IN (
          SELECT index_id
          FROM sys.index_columns
          WHERE object_id = OBJECT_ID('REG_RESOURCE_PROPERTY')
          GROUP BY index_id
          HAVING COUNT(*) > 2
      )
)
BEGIN
    EXEC('CREATE INDEX REG_RESC_PROP_BY_PROP_ID_TI ON REG_RESOURCE_PROPERTY(REG_TENANT_ID, REG_PROPERTY_ID)')
END

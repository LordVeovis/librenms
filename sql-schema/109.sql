DECLARE index_exists INTEGER;

CREATE TABLE tmp_table LIKE config;

SELECT COUNT(*) INTO index_exists
FROM INFORMATION_SCHEMA.statistics
WHERE table_schema=DATABASE()
	AND table_name='tmp_table'
	AND index_name='uniqueindex_configname';

IF index_exists = 0 THEN
	ALTER TABLE tmp_table ADD UNIQUE INDEX uniqueindex_configname (config_name);
END IF
INSERT IGNORE INTO tmp_table SELECT * FROM config;
DROP TABLE config;
RENAME TABLE tmp_table TO config;

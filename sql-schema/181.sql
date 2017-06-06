DECLARE index_exists INTEGER;

ALTER TABLE `applications` CHANGE `app_state_prev` `app_state_prev` VARCHAR(32) NULL;
ALTER TABLE `applications` ADD `discovered` TINYINT NOT NULL DEFAULT '0' AFTER `app_state`;

SELECT COUNT(*) INTO index_exists
FROM INFORMATION_SCHEMA.statistics
WHERE table_schema=DATABASE()
	AND table_name='applications'
	AND index_name='unique_index';

IF index_exists = 0 THEN
	ALTER TABLE `applications` ADD UNIQUE `unique_index`(`device_id`, `app_type`);
END IF

CREATE TABLE `samples` (
    `id` BIGINT UNSIGNED AUTO_INCREMENT NOT NULL,
    `name` VARCHAR(64) NOT NULL,
    `insert_id` VARCHAR(50) NOT NULL,
    `insert_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `update_id` VARCHAR(50) NOT NULL,
    `update_date` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`)
) COMMENT='サンプル';

INSERT INTO `samples` (`name`, `insert_id`, `update_id`)
VALUES ('sample name 1', 'user1', 'user1');

INSERT INTO `samples` (`name`, `insert_id`, `update_id`)
VALUES ('sample name 2', 'user2', 'user2');

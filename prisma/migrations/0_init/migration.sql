-- CreateTable
CREATE TABLE `ar_internal_metadata` (
    `key` VARCHAR(255) NOT NULL,
    `value` VARCHAR(255) NULL,
    `created_at` DATETIME(6) NOT NULL,
    `updated_at` DATETIME(6) NOT NULL,

    PRIMARY KEY (`key`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `authkeys` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `token` VARCHAR(128) NOT NULL,
    `service` BOOLEAN NOT NULL DEFAULT false,
    `description` TEXT NULL,
    `perms` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `token`(`token`),
    INDEX `fk_rails_a088a68405`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `comments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `text` TEXT NOT NULL,
    `meme_id` VARCHAR(10) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `parent` INTEGER NULL,
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_03de2dc08c`(`user_id`),
    INDEX `fk_rails_feda6535c7`(`meme_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `contests` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `start` DATE NOT NULL,
    `conclude` DATE NOT NULL,
    `name` TEXT NOT NULL,
    `slug` TEXT NOT NULL,
    `description` TEXT NOT NULL,
    `guidelines` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `credits` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `owner_id` BIGINT NOT NULL,
    `holder_id` BIGINT NULL,
    `note` TEXT NULL,
    `gift` BOOLEAN NOT NULL DEFAULT false,
    `link` TEXT NULL,
    `redeemed` BOOLEAN NOT NULL DEFAULT false,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `redeemed_at` TIMESTAMP(0) NULL,
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_c9ba5db92f`(`holder_id`),
    INDEX `fk_rails_ceacfd9dd2`(`owner_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `influencers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `code` VARCHAR(32) NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `integrations` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `kind` TEXT NOT NULL,
    `data` TEXT NOT NULL,
    `shown_data` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_99d169fb59`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `logs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `kind` TEXT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `ip` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_8fc980bf44`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `memes` (
    `id` VARCHAR(10) NOT NULL,
    `user_id` BIGINT NOT NULL,
    `caption` TEXT NULL,
    `age` INTEGER NOT NULL DEFAULT 1,
    `ocr` TEXT NULL,
    `ocrverified` BOOLEAN NOT NULL DEFAULT false,
    `disabled` BOOLEAN NOT NULL DEFAULT false,
    `approved` BOOLEAN NOT NULL DEFAULT false,
    `dmca` BOOLEAN NOT NULL DEFAULT false,
    `url` TEXT NOT NULL,
    `realm_id` INTEGER NULL,
    `contest_id` INTEGER NULL,
    `realmstatus` INTEGER NOT NULL DEFAULT 0,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_0dd3229ca9`(`user_id`),
    INDEX `fk_rails_5d879faad1`(`realm_id`),
    INDEX `fk_rails_c5e2beebb7`(`contest_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `modlogs` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NULL,
    `action` MEDIUMTEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_c8be2676f8`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `notifications` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `sender_id` BIGINT NOT NULL,
    `message` TEXT NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_8780923399`(`sender_id`),
    INDEX `fk_rails_b080fb4855`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `payments` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `stripe_id` TEXT NOT NULL,
    `processed` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `item` TEXT NOT NULL,
    `promo` TEXT NULL,
    `expires` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `expired` BOOLEAN NOT NULL DEFAULT false,
    `amount` INTEGER NOT NULL,
    `error` TEXT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_081dc04a02`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ratings` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `meme_id` VARCHAR(10) NOT NULL,
    `rating` INTEGER NOT NULL,
    `user_id` BIGINT NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_5e0ad156ae`(`meme_id`),
    INDEX `fk_rails_a7dfeb9f5f`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `realms` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `name` TEXT NOT NULL,
    `slug` TEXT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `created_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` DATETIME(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_4b86445131`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `relationships` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `follower_id` BIGINT NOT NULL,
    `following_id` BIGINT NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_8c9a6d4759`(`follower_id`),
    INDEX `fk_rails_99bf6afbfa`(`following_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `reports` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `meme_id` VARCHAR(10) NOT NULL,
    `reason` TEXT NOT NULL,
    `description` TEXT NOT NULL,
    `assignee_id` BIGINT NULL,
    `status` INTEGER NOT NULL DEFAULT 0,
    `comment` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `resolved_at` TIMESTAMP(0) NULL,

    INDEX `fk_rails_12eb92a4f5`(`assignee_id`),
    INDEX `fk_rails_c7699d537d`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `schema_migrations` (
    `version` VARCHAR(255) NOT NULL,

    PRIMARY KEY (`version`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `subscriptions` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` BIGINT NOT NULL,
    `started` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `expires` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `unlimited` BOOLEAN NOT NULL DEFAULT false,
    `expired` BOOLEAN NOT NULL DEFAULT false,
    `created_at` DATETIME(6) NOT NULL,
    `updated_at` DATETIME(6) NOT NULL,

    INDEX `fk_rails_933bdff476`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `transfers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `sender_id` BIGINT NOT NULL,
    `user_id` BIGINT NOT NULL,
    `meme_id` VARCHAR(10) NOT NULL,
    `status` INTEGER NOT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `fk_rails_29d6daaff8`(`sender_id`),
    INDEX `fk_rails_344b52b7fd`(`user_id`),
    INDEX `fk_rails_6f9fbfad2a`(`meme_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `users` (
    `id` BIGINT NOT NULL,
    `access_token` TEXT NULL,
    `permissions` INTEGER NOT NULL DEFAULT 0,
    `staff_perms` BIGINT NOT NULL DEFAULT 0,
    `status` INTEGER NOT NULL DEFAULT 0,
    `logging` INTEGER NOT NULL DEFAULT 0,
    `code` VARCHAR(32) NULL,
    `username` VARCHAR(37) NULL,
    `password` TEXT NULL,
    `fcmToken` TEXT NULL,
    `bio` TEXT NULL,
    `noti_meme` INTEGER NOT NULL DEFAULT 11,
    `noti_follow` INTEGER NOT NULL DEFAULT 11,
    `noti_reports` INTEGER NOT NULL DEFAULT 11,
    `dark` INTEGER NOT NULL DEFAULT 0,
    `age` INTEGER NOT NULL DEFAULT 2,
    `avatar` TEXT NULL,
    `disabled` BOOLEAN NOT NULL DEFAULT false,
    `name_color` TEXT NULL,
    `custom_bg_url` TEXT NULL,
    `custom_bg_loc` INTEGER NOT NULL DEFAULT 0,
    `user_bg_loc` INTEGER NOT NULL DEFAULT 0,
    `show_custom_bg` BOOLEAN NOT NULL DEFAULT true,
    `custom_bg_color` TEXT NULL,
    `logintype` INTEGER NOT NULL DEFAULT 0,
    `emailonfail` BOOLEAN NOT NULL DEFAULT false,
    `emailonsuccess` BOOLEAN NOT NULL DEFAULT false,
    `email` TEXT NULL,
    `email_status` INTEGER NOT NULL DEFAULT 0,
    `email_code` TEXT NULL,
    `resetpass_code` TEXT NULL,
    `mc_code` TEXT NULL,
    `mc_login_code` TEXT NULL,
    `created_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `last_login` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `tos` BOOLEAN NULL,

    UNIQUE INDEX `index_users_on_code`(`code`),
    UNIQUE INDEX `index_users_on_username`(`username`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `authkeys` ADD CONSTRAINT `fk_rails_a088a68405` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `fk_rails_03de2dc08c` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `comments` ADD CONSTRAINT `fk_rails_feda6535c7` FOREIGN KEY (`meme_id`) REFERENCES `memes`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `credits` ADD CONSTRAINT `fk_rails_c9ba5db92f` FOREIGN KEY (`holder_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `credits` ADD CONSTRAINT `fk_rails_ceacfd9dd2` FOREIGN KEY (`owner_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `integrations` ADD CONSTRAINT `fk_rails_99d169fb59` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `logs` ADD CONSTRAINT `fk_rails_8fc980bf44` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `memes` ADD CONSTRAINT `fk_rails_0dd3229ca9` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `memes` ADD CONSTRAINT `fk_rails_5d879faad1` FOREIGN KEY (`realm_id`) REFERENCES `realms`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `memes` ADD CONSTRAINT `fk_rails_c5e2beebb7` FOREIGN KEY (`contest_id`) REFERENCES `contests`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `modlogs` ADD CONSTRAINT `fk_rails_c8be2676f8` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `notifications` ADD CONSTRAINT `fk_rails_8780923399` FOREIGN KEY (`sender_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `notifications` ADD CONSTRAINT `fk_rails_b080fb4855` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `payments` ADD CONSTRAINT `fk_rails_081dc04a02` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ratings` ADD CONSTRAINT `fk_rails_5e0ad156ae` FOREIGN KEY (`meme_id`) REFERENCES `memes`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `ratings` ADD CONSTRAINT `fk_rails_a7dfeb9f5f` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `realms` ADD CONSTRAINT `fk_rails_4b86445131` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `relationships` ADD CONSTRAINT `fk_rails_8c9a6d4759` FOREIGN KEY (`follower_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `relationships` ADD CONSTRAINT `fk_rails_99bf6afbfa` FOREIGN KEY (`following_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `fk_rails_12eb92a4f5` FOREIGN KEY (`assignee_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `reports` ADD CONSTRAINT `fk_rails_c7699d537d` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `subscriptions` ADD CONSTRAINT `fk_rails_933bdff476` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `transfers` ADD CONSTRAINT `fk_rails_29d6daaff8` FOREIGN KEY (`sender_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `transfers` ADD CONSTRAINT `fk_rails_344b52b7fd` FOREIGN KEY (`user_id`) REFERENCES `users`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;

-- AddForeignKey
ALTER TABLE `transfers` ADD CONSTRAINT `fk_rails_6f9fbfad2a` FOREIGN KEY (`meme_id`) REFERENCES `memes`(`id`) ON DELETE RESTRICT ON UPDATE RESTRICT;


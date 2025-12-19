-- CreateTable
CREATE TABLE `ChatGroupMembers` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `user_id` INTEGER NULL,
    `chatGroupId` INTEGER NULL,
    `deletedBy` INTEGER NOT NULL DEFAULT 0,
    `isDeleted` BOOLEAN NOT NULL DEFAULT false,
    `deletedAt` TIMESTAMP(0) NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `chatGroupId`(`chatGroupId`),
    INDEX `user_id`(`user_id`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ChatGroups` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `keyForChatOne` VARCHAR(255) NULL,
    `name` VARCHAR(255) NULL,
    `type` ENUM('private', 'group') NULL DEFAULT 'private',
    `ownerId` INTEGER NULL,
    `deletedBy` INTEGER NOT NULL DEFAULT 0,
    `isDeleted` BOOLEAN NOT NULL DEFAULT false,
    `deletedAt` TIMESTAMP(0) NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `keyForChatOne`(`keyForChatOne`),
    INDEX `ownerId`(`ownerId`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `ChatMessages` (
    `id` INTEGER NOT NULL AUTO_INCREMENT,
    `chatGroupId` INTEGER NOT NULL,
    `userIdSender` INTEGER NOT NULL,
    `messageText` TEXT NULL,
    `deletedBy` INTEGER NOT NULL DEFAULT 0,
    `isDeleted` BOOLEAN NOT NULL DEFAULT false,
    `deletedAt` TIMESTAMP(0) NULL,
    `createdAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updatedAt` TIMESTAMP(0) NOT NULL DEFAULT CURRENT_TIMESTAMP(0),

    INDEX `chatGroupId`(`chatGroupId`),
    INDEX `userIdSender`(`userIdSender`),
    PRIMARY KEY (`id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- CreateTable
CREATE TABLE `Users` (
    `user_id` INTEGER NOT NULL AUTO_INCREMENT,
    `username` VARCHAR(100) NOT NULL,
    `password` VARCHAR(255) NULL,
    `email` VARCHAR(255) NULL,
    `avatar` VARCHAR(255) NULL,
    `phone` VARCHAR(20) NULL,
    `role` ENUM('user', 'admin') NULL DEFAULT 'user',
    `facebook_id` VARCHAR(255) NULL,
    `google_id` VARCHAR(255) NULL,
    `github_id` VARCHAR(255) NULL,
    `instagram_id` VARCHAR(255) NULL,
    `created_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),
    `updated_at` TIMESTAMP(0) NULL DEFAULT CURRENT_TIMESTAMP(0),

    UNIQUE INDEX `email`(`email`),
    UNIQUE INDEX `facebook_id`(`facebook_id`),
    UNIQUE INDEX `google_id`(`google_id`),
    UNIQUE INDEX `github_id`(`github_id`),
    UNIQUE INDEX `instagram_id`(`instagram_id`),
    PRIMARY KEY (`user_id`)
) DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- AddForeignKey
ALTER TABLE `ChatGroupMembers` ADD CONSTRAINT `ChatGroupMembers_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `Users`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ChatGroupMembers` ADD CONSTRAINT `ChatGroupMembers_ibfk_2` FOREIGN KEY (`chatGroupId`) REFERENCES `ChatGroups`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ChatGroups` ADD CONSTRAINT `ChatGroups_ibfk_1` FOREIGN KEY (`ownerId`) REFERENCES `Users`(`user_id`) ON DELETE SET NULL ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ChatMessages` ADD CONSTRAINT `ChatMessages_ibfk_1` FOREIGN KEY (`chatGroupId`) REFERENCES `ChatGroups`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

-- AddForeignKey
ALTER TABLE `ChatMessages` ADD CONSTRAINT `ChatMessages_ibfk_2` FOREIGN KEY (`userIdSender`) REFERENCES `Users`(`user_id`) ON DELETE CASCADE ON UPDATE CASCADE;

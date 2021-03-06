CREATE TABLE IF NOT EXISTS `users` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `login` VARCHAR(64) NOT NULL UNIQUE,  # GitHub login name
  `password_hash` VARCHAR(64) NOT NULL,
  `name` VARCHAR(64) NOT NULL,          # Account name
  `avatar_uri` VARCHAR(128) NOT NULL,   # Avatar icon's uri (directory path or link)
  `access_token` VARCHAR(40) NOT NULL,  # GitHub OAuth access token
  `admin` TINYINT NOT NULL DEFAULT 0,   # Adoministrator or Normal (BOOL)
  PRIMARY KEY (`id`)
) ENGINE = Innodb;

CREATE TABLE IF NOT EXISTS `diaries` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `author_id` INT NOT NULL,
  `title` VARCHAR(64),
  `body` TEXT,
  `create_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `last_update_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`),
  CONSTRAINT diaries_author_id_fk
    FOREIGN KEY (`author_id`)
      REFERENCES `users` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE = Innodb;

CREATE TABLE IF NOT EXISTS `comments` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `author_id` INT NOT NULL,
  `diary_id` INT NOT NULL,
  `body` TEXT NOT NULL,
  `create_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  `last_update_at` TIMESTAMP NOT NULL DEFAULT current_timestamp,
  PRIMARY KEY (`id`),
  CONSTRAINT comments_author_id_fk
    FOREIGN KEY (`author_id`)
      REFERENCES `users` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT comments_diary_id_fk
    FOREIGN KEY (`diary_id`)
      REFERENCES `diaries` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE = Innodb;

CREATE TABLE IF NOT EXISTS `events` (
  `id` INT NOT NULL AUTO_INCREMENT,
  `type` VARCHAR(32) NOT NULL,        # `posted` or `modified` or ...?
  `diary_id` INT,                     # Nullable
  `comment_id` INT,                   # Nullable
  PRIMARY KEY (`id`),
  CONSTRAINT events_diary_id_fk
    FOREIGN KEY (`diary_id`)
      REFERENCES `diaries` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE,
  CONSTRAINT events_comment_id_fk
    FOREIGN KEY (`comment_id`)
      REFERENCES `comments` (`id`)
    ON UPDATE CASCADE
    ON DELETE CASCADE
) ENGINE = Innodb;

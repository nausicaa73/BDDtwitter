--  ___________  __   __  ___   __  ___________  ___________  _______   _______       ________   ___      ___ 
-- ("     _   ")|"  |/  \|  "| |" \("     _   ")("     _   ")/"     "| /"      \     |"      "\ |"  \    /"  |
--  )__/  \\__/ |'  /    \:  | ||  |)__/  \\__/  )__/  \\__/(: ______)|:        |    (.  ___  :) \   \  //   |
--     \\_ /    |: /'        | |:  |   \\_ /        \\_ /    \/    |  |_____/   )    |: \   ) || /\\  \/.    |
--     |.  |     \//  /\'    | |.  |   |.  |        |.  |    // ___)_  //      /     (| (___\ |||: \.        |
--     \:  |     /   /  \\   | /\  |\  \:  |        \:  |   (:      "||:  __   \     |:       :)|.  \    /:  |
--      \__|    |___/    \___|(__\_|_)  \__|         \__|    \_______)|__|  \___)    (________/ |___|\__/|___|
                                                                                                        
-- Binome 1 : Je soussigné(e), Nom, Prénom, Badin Victor certifie qu’il s’agit d’un travail original et que toutes les sources utilisées ont été indiquées dans leur totalité. Fait à Grenoble le 24/10/2024.
-- Binome 2 : Je soussigné(e), Nom, Prénom, Martins Lucas certifie qu’il s’agit d’un travail original et que toutes les sources utilisées ont été indiquées dans leur totalité. Fait à Grenoble le 24/10/2024

-- Drop the existing database if exists
DROP DATABASE IF EXISTS db_twitter;

-- Create a new database
CREATE DATABASE db_twitter;

-- Connect to the database
\connect db_twitter

SET statement_timeout = 0;
SET lock_timeout = 0;
SET idle_in_transaction_session_timeout = 0;
SET client_encoding = 'UTF8';
SET standard_conforming_strings = on;
SET check_function_bodies = false;
SET client_min_messages = warning;
SET row_security = off;

DROP TABLE IF EXISTS TUserInfo CASCADE;
DROP TABLE IF EXISTS TFollow CASCADE;
DROP TABLE IF EXISTS TTweet CASCADE;
DROP TABLE IF EXISTS TLike CASCADE;
DROP TABLE IF EXISTS TMedia CASCADE;
DROP TABLE IF EXISTS TReport CASCADE;
DROP TABLE IF EXISTS TURL CASCADE;


CREATE TABLE TUserInfo (
    userId VARCHAR(20) PRIMARY KEY,
    userName VARCHAR(50) NOT NULL,
    realName VARCHAR(50) NOT NULL,
    status BOOLEAN NOT NULL, 
    otherProfileStuff VARCHAR(255),
    creationTime TIMESTAMP NOT NULL,
    suspendedTime TIMESTAMP,
    deletedTime TIMESTAMP
);

COPY TUserInfo(userId, userName, realName, status, otherProfileStuff, creationTime, suspendedTime, deletedTime)
FROM '/work/users.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE TFollow (
    userid VARCHAR(20) REFERENCES TUserInfo(userId) NOT NULL,
    followerId VARCHAR(20) REFERENCES TUserInfo(userId) NOT NULL,
    followedTime TIMESTAMP NOT NULL,
    unfollowedTime TIMESTAMP,
    PRIMARY KEY (userid, followerId) 
);

COPY TFollow(userid, followerId, followedTime, unfollowedTime)
FROM '/work/followers.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE TTweet (
    tweetId UUID PRIMARY KEY,
    userId VARCHAR(20) REFERENCES TUserInfo(userId) NOT NULL,
    repostTweetId UUID REFERENCES TTweet(tweetId),
    content TEXT NOT NULL,
    sentimentScore REAL NOT NULL DEFAULT 0.0,
    postTime TIMESTAMP NOT NULL,
    modifyTime TIMESTAMP,
    suspendedTime TIMESTAMP,
    deletedTime TIMESTAMP
);

COPY TTweet(tweetId, userId, repostTweetId, content, sentimentScore, postTime, modifyTime, suspendedTime, deletedTime)
FROM '/work/tweets.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE TLike (
    tweetId UUID REFERENCES TTweet(tweetId) NOT NULL,
    userId VARCHAR(20) REFERENCES TUserInfo(userId) NOT NULL,
    likeTime TIMESTAMP NOT NULL,
    unlikeTime TIMESTAMP,
    PRIMARY KEY (tweetId, userId) 
);

COPY TLike(tweetId, userId, likeTime, unlikeTime)
FROM '/work/likes.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE TMedia (
    mediaId UUID PRIMARY KEY,
    tweetId UUID REFERENCES TTweet(tweetId) NOT NULL,
    mimetype VARCHAR(50) NOT NULL,
    size INTEGER NOT NULL,
    content BYTEA NOT NULL,
    exif BYTEA,
    postTime TIMESTAMP NOT NULL,
    modifyTime TIMESTAMP,
    deletedTime TIMESTAMP NOT NULL
);

COPY TMedia(mediaId, tweetId, mimetype, size, content, exif, postTime, modifyTime, deletedTime)
FROM '/work/medias.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE TReport (
    tweetId UUID REFERENCES TTweet(tweetId),
    reporterId VARCHAR(20) REFERENCES TUserInfo(userId),
    reportTime TIMESTAMP NOT NULL,
    reason VARCHAR(255) NOT NULL,
    PRIMARY KEY (tweetId, reporterId) 
);

COPY TReport(tweetId, reporterId, reportTime, reason)
FROM '/work/reports.csv'
DELIMITER ','
CSV HEADER;


CREATE TABLE TURL (
    urlId BIGINT PRIMARY KEY,
    tweetId UUID REFERENCES TTweet(tweetId) NOT NULL,
    url VARCHAR(255) NOT NULL
);

COPY TURL(urlId, tweetId, url)
FROM '/work/urls.csv'
DELIMITER ','
CSV HEADER;


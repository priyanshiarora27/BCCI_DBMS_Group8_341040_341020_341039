-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema bcci
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema bcci
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `bcci` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci ;
USE `bcci` ;

-- -----------------------------------------------------
-- Table `bcci`.`team`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`team` (
  `team_id` INT NOT NULL,
  `team_name` VARCHAR(30) NOT NULL,
  `team_type` ENUM('men', 'women', 'ipl') NOT NULL,
  `homestate` VARCHAR(20) NULL,
  `founded_year` INT NULL,
  PRIMARY KEY (`team_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`coaches`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`coaches` (
  `coach_id` INT NOT NULL,
  `coach_name` VARCHAR(20) NOT NULL,
  `specialisation` ENUM('batting', 'bowling', 'fielding', 'head-coach') NOT NULL,
  `team_id` INT NULL DEFAULT NULL,
  `team_team_id` INT NOT NULL,
  PRIMARY KEY (`coach_id`),
  INDEX `fk_coaches_team1_idx` (`team_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_coaches_team1`
    FOREIGN KEY (`team_team_id`)
    REFERENCES `bcci`.`team` (`team_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`player`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`player` (
  `payer_id` INT NOT NULL,
  `player_name` VARCHAR(20) NOT NULL,
  `dob` DATE NULL DEFAULT NULL,
  `batting_style` VARCHAR(20) NULL DEFAULT NULL,
  `bowling_style` VARCHAR(45) NULL DEFAULT NULL,
  `role` ENUM('batsman', 'bowler', 'all-rounder', 'wicketkeeper') NULL DEFAULT NULL,
  `team_id` INT NOT NULL,
  `team_team_id` INT NOT NULL,
  PRIMARY KEY (`payer_id`),
  INDEX `fk_player_team_idx` (`team_team_id` ASC) VISIBLE,
  CONSTRAINT `fk_player_team`
    FOREIGN KEY (`team_team_id`)
    REFERENCES `bcci`.`team` (`team_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`contract`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`contract` (
  `contract_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `contract_type` ENUM('ipl', 'central') NOT NULL,
  `start_year` YEAR NOT NULL,
  `end_year` YEAR NOT NULL,
  `contract_value` DECIMAL(12,2) NULL DEFAULT NULL,
  `player_payer_id` INT NOT NULL,
  PRIMARY KEY (`contract_id`),
  INDEX `fk_contract_player1_idx` (`player_payer_id` ASC) VISIBLE,
  CONSTRAINT `fk_contract_player1`
    FOREIGN KEY (`player_payer_id`)
    REFERENCES `bcci`.`player` (`payer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`tournament`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`tournament` (
  `tournament_id` INT NOT NULL,
  `tournament_name` VARCHAR(30) NOT NULL,
  `format` ENUM('t20', 'test', 'odi') NOT NULL,
  `year` INT NOT NULL,
  PRIMARY KEY (`tournament_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`venue`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`venue` (
  `venue_id` INT NOT NULL,
  `venue_name` VARCHAR(40) NOT NULL,
  `city` VARCHAR(30) NULL DEFAULT NULL,
  `capacity` INT NULL DEFAULT NULL,
  PRIMARY KEY (`venue_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`match_details`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`match_details` (
  `match_id` INT NOT NULL,
  `match_date` DATE NOT NULL,
  `tournament_id` INT NULL DEFAULT NULL,
  `venue_id` INT NULL DEFAULT NULL,
  `team1_id` INT NULL DEFAULT NULL,
  `team2_id` INT NULL DEFAULT NULL,
  `winner_team_id` INT NULL DEFAULT NULL,
  `tournament_tournament_id` INT NOT NULL,
  `team_team_id` INT NOT NULL,
  `venue_venue_id` INT NOT NULL,
  PRIMARY KEY (`match_id`),
  INDEX `fk_match_details_tournament1_idx` (`tournament_tournament_id` ASC) VISIBLE,
  INDEX `fk_match_details_team1_idx` (`team_team_id` ASC) VISIBLE,
  INDEX `fk_match_details_venue1_idx` (`venue_venue_id` ASC) VISIBLE,
  CONSTRAINT `fk_match_details_team1`
    FOREIGN KEY (`team_team_id`)
    REFERENCES `bcci`.`team` (`team_id`),
  CONSTRAINT `fk_match_details_tournament1`
    FOREIGN KEY (`tournament_tournament_id`)
    REFERENCES `bcci`.`tournament` (`tournament_id`),
  CONSTRAINT `fk_match_details_venue1`
    FOREIGN KEY (`venue_venue_id`)
    REFERENCES `bcci`.`venue` (`venue_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`umpire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`umpire` (
  `umpire_id` INT NOT NULL,
  `umpire_name` VARCHAR(20) NOT NULL,
  `experience_years` TINYINT NULL DEFAULT NULL,
  PRIMARY KEY (`umpire_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`match_details_has_umpire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`match_details_has_umpire` (
  `match_details_match_id` INT NOT NULL,
  `umpire_umpire_id` INT NOT NULL,
  PRIMARY KEY (`match_details_match_id`, `umpire_umpire_id`),
  INDEX `fk_match_details_has_umpire_umpire1_idx` (`umpire_umpire_id` ASC) VISIBLE,
  INDEX `fk_match_details_has_umpire_match_details1_idx` (`match_details_match_id` ASC) VISIBLE,
  CONSTRAINT `fk_match_details_has_umpire_match_details1`
    FOREIGN KEY (`match_details_match_id`)
    REFERENCES `bcci`.`match_details` (`match_id`),
  CONSTRAINT `fk_match_details_has_umpire_umpire1`
    FOREIGN KEY (`umpire_umpire_id`)
    REFERENCES `bcci`.`umpire` (`umpire_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`player_match_performance`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`player_match_performance` (
  `performance_id` INT NOT NULL,
  `match_id` INT NOT NULL,
  `player_id` INT NOT NULL,
  `runs_scored` SMALLINT NOT NULL,
  `wickets_taken` TINYINT NULL DEFAULT NULL,
  `catches_taken` TINYINT NULL DEFAULT NULL,
  `match_details_match_id` INT NOT NULL,
  `player_payer_id` INT NOT NULL,
  `match_details_match_id1` INT NOT NULL,
  PRIMARY KEY (`performance_id`),
  INDEX `fk_player_match_performance_match_details1_idx` (`match_details_match_id` ASC) VISIBLE,
  INDEX `fk_player_match_performance_player1_idx` (`player_payer_id` ASC) VISIBLE,
  INDEX `fk_player_match_performance_match_details2_idx` (`match_details_match_id1` ASC) VISIBLE,
  CONSTRAINT `fk_player_match_performance_match_details1`
    FOREIGN KEY (`match_details_match_id`)
    REFERENCES `bcci`.`match_details` (`match_id`),
  CONSTRAINT `fk_player_match_performance_match_details2`
    FOREIGN KEY (`match_details_match_id1`)
    REFERENCES `bcci`.`match_details` (`match_id`),
  CONSTRAINT `fk_player_match_performance_player1`
    FOREIGN KEY (`player_payer_id`)
    REFERENCES `bcci`.`player` (`payer_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`tournament_has_umpire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`tournament_has_umpire` (
  `tournament_tournament_id` INT NOT NULL,
  `umpire_umpire_id` INT NOT NULL,
  PRIMARY KEY (`tournament_tournament_id`, `umpire_umpire_id`),
  INDEX `fk_tournament_has_umpire_umpire1_idx` (`umpire_umpire_id` ASC) VISIBLE,
  INDEX `fk_tournament_has_umpire_tournament1_idx` (`tournament_tournament_id` ASC) VISIBLE,
  CONSTRAINT `fk_tournament_has_umpire_tournament1`
    FOREIGN KEY (`tournament_tournament_id`)
    REFERENCES `bcci`.`tournament` (`tournament_id`),
  CONSTRAINT `fk_tournament_has_umpire_umpire1`
    FOREIGN KEY (`umpire_umpire_id`)
    REFERENCES `bcci`.`umpire` (`umpire_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `bcci`.`venue_has_umpire`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `bcci`.`venue_has_umpire` (
  `venue_venue_id` INT NOT NULL,
  `umpire_umpire_id` INT NOT NULL,
  PRIMARY KEY (`venue_venue_id`, `umpire_umpire_id`),
  INDEX `fk_venue_has_umpire_umpire1_idx` (`umpire_umpire_id` ASC) VISIBLE,
  INDEX `fk_venue_has_umpire_venue1_idx` (`venue_venue_id` ASC) VISIBLE,
  CONSTRAINT `fk_venue_has_umpire_umpire1`
    FOREIGN KEY (`umpire_umpire_id`)
    REFERENCES `bcci`.`umpire` (`umpire_id`),
  CONSTRAINT `fk_venue_has_umpire_venue1`
    FOREIGN KEY (`venue_venue_id`)
    REFERENCES `bcci`.`venue` (`venue_id`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;

ALTER TABLE team 
MODIFY team_name VARCHAR(50);

INSERT INTO team (team_id, team_name, team_type, homestate, founded_year) VALUES
(1, 'India Men', 'men', 'Delhi', 1932),
(2, 'India Women', 'women', 'Delhi', 1976),
(3, 'Mumbai Indians', 'ipl', 'Maharashtra', 2008),
(4, 'Chennai Super Kings', 'ipl', 'Tamil Nadu', 2008),
(5, 'Royal Challengers', 'ipl', 'Karnataka', 2008),
(6, 'Delhi Capitals', 'ipl', 'Delhi', 2008),
(7, 'Rajasthan Royals', 'ipl', 'Rajasthan', 2008),
(8, 'Sunrisers Hyderabad', 'ipl', 'Telangana', 2013),
(9, 'Punjab Kings', 'ipl', 'Punjab', 2008),
(10, 'Kolkata Knight Riders', 'ipl', 'West Bengal', 2008);
INSERT INTO coaches (coach_id, coach_name, specialisation, team_id, team_team_id) VALUES
(1, 'Rahul Dravid', 'head-coach', 1, 1),
(2, 'Amol Muzumdar', 'batting', 2, 2),
(3, 'Mark Boucher', 'head-coach', 3, 3),
(4, 'Stephen Fleming', 'head-coach', 4, 4),
(5, 'Sanjay Bangar', 'batting', 5, 5),
(6, 'Ricky Ponting', 'head-coach', 6, 6),
(7, 'Kumar Sangakkara', 'head-coach', 7, 7),
(8, 'Daniel Vettori', 'bowling', 8, 8),
(9, 'Trevor Bayliss', 'head-coach', 9, 9),
(10, 'Chandrakant Pandit', 'head-coach', 10, 10);
INSERT INTO player (payer_id, player_name, dob, batting_style, bowling_style, role, team_id, team_team_id) VALUES
(1, 'Virat Kohli', '1988-11-05', 'Right-hand', 'None', 'batsman', 1, 1),
(2, 'Rohit Sharma', '1987-04-30', 'Right-hand', 'None', 'batsman', 1, 1),
(3, 'Jasprit Bumrah', '1993-12-06', 'Right-hand', 'Right-arm fast', 'bowler', 1, 1),
(4, 'Smriti Mandhana', '1996-07-18', 'Left-hand', 'None', 'batsman', 2, 2),
(5, 'Harmanpreet Kaur', '1989-03-08', 'Right-hand', 'Off-spin', 'all-rounder', 2, 2),
(6, 'MS Dhoni', '1981-07-07', 'Right-hand', 'None', 'wicketkeeper', 4, 4),
(7, 'Hardik Pandya', '1993-10-11', 'Right-hand', 'Medium-fast', 'all-rounder', 3, 3),
(8, 'Ravindra Jadeja', '1988-12-06', 'Left-hand', 'Left-arm spin', 'all-rounder', 4, 4),
(9, 'KL Rahul', '1992-04-18', 'Right-hand', 'None', 'batsman', 6, 6),
(10, 'Shubman Gill', '1999-09-08', 'Right-hand', 'None', 'batsman', 10, 10),
(11, 'Rashid Khan', '1998-09-20', 'Right-hand', 'Leg-spin', 'bowler', 8, 8),
(12, 'Yuzvendra Chahal', '1990-07-23', 'Right-hand', 'Leg-spin', 'bowler', 5, 5);
INSERT INTO contract (contract_id, player_id, contract_type, start_year, end_year, contract_value, player_payer_id) VALUES
(1, 1, 'central', 2023, 2026, 70000000, 1),
(2, 2, 'central', 2023, 2026, 65000000, 2),
(3, 3, 'central', 2023, 2026, 50000000, 3),
(4, 4, 'central', 2023, 2025, 30000000, 4),
(5, 5, 'central', 2023, 2025, 32000000, 5),
(6, 6, 'ipl', 2022, 2024, 12000000, 6),
(7, 7, 'ipl', 2023, 2025, 15000000, 7),
(8, 8, 'ipl', 2022, 2024, 90000000, 8),
(9, 9, 'ipl', 2023, 2025, 80000000, 9),
(10, 10, 'ipl', 2023, 2026, 75000000, 10);
INSERT INTO tournament (tournament_id, tournament_name, format, year) VALUES
(1, 'IPL 2024', 't20', 2024),
(2, 'IPL 2023', 't20', 2023),
(3, 'ODI World Cup', 'odi', 2023),
(4, 'T20 World Cup', 't20', 2024),
(5, 'Border Gavaskar Trophy', 'test', 2023),
(6, 'Asia Cup', 'odi', 2023),
(7, 'WPL 2024', 't20', 2024),
(8, 'Ranji Trophy', 'test', 2024),
(9, 'Vijay Hazare Trophy', 'odi', 2024),
(10, 'Syed Mushtaq Ali Trophy', 't20', 2024);
INSERT INTO venue (venue_id, venue_name, city, capacity) VALUES
(1, 'Wankhede Stadium', 'Mumbai', 33000),
(2, 'MA Chidambaram Stadium', 'Chennai', 38000),
(3, 'Eden Gardens', 'Kolkata', 68000),
(4, 'Arun Jaitley Stadium', 'Delhi', 41000),
(5, 'M Chinnaswamy Stadium', 'Bengaluru', 40000),
(6, 'Narendra Modi Stadium', 'Ahmedabad', 132000),
(7, 'Rajiv Gandhi Stadium', 'Hyderabad', 55000),
(8, 'Sawai Mansingh Stadium', 'Jaipur', 30000),
(9, 'Punjab Cricket Stadium', 'Mohali', 26000),
(10, 'DY Patil Stadium', 'Navi Mumbai', 45000);
INSERT INTO match_details
(match_id, match_date, tournament_id, venue_id, team1_id, team2_id, winner_team_id,
 tournament_tournament_id, team_team_id, venue_venue_id)
VALUES
(1, '2024-03-22', 1, 1, 3, 4, 4, 1, 3, 1),
(2, '2024-03-24', 1, 3, 10, 6, 10, 1, 10, 3),
(3, '2023-10-10', 3, 6, 1, 10, 1, 3, 1, 6),
(4, '2023-10-15', 3, 5, 1, 5, 1, 3, 1, 5),
(5, '2024-04-02', 1, 2, 4, 8, 4, 1, 4, 2),
(6, '2024-04-05', 1, 4, 6, 9, 6, 1, 6, 4),
(7, '2024-04-07', 1, 7, 8, 3, 3, 1, 8, 7),
(8, '2024-04-10', 1, 8, 7, 9, 7, 1, 7, 8),
(9, '2024-04-12', 1, 9, 9, 5, 5, 1, 9, 9),
(10, '2024-04-15', 1, 10, 3, 10, 3, 1, 3, 10);
INSERT INTO umpire (umpire_id, umpire_name, experience_years) VALUES
(1, 'Nitin Menon', 12),
(2, 'Anil Chaudhary', 15),
(3, 'Kumar Dharmasena', 20),
(4, 'Marais Erasmus', 18),
(5, 'S Ravi', 25),
(6, 'Chris Gaffaney', 16),
(7, 'Rod Tucker', 22),
(8, 'Aleem Dar', 28),
(9, 'Paul Reiffel', 19),
(10, 'Bruce Oxenford', 21);
INSERT INTO match_details_has_umpire VALUES
(1,1),(1,2),
(2,3),(2,4),
(3,5),(3,6),
(4,7),(4,8),
(5,9),(5,10),
(6,1),(6,3),
(7,2),(7,4),
(8,5),(8,6),
(9,7),(9,8),
(10,9),(10,10);
INSERT INTO player_match_performance
(performance_id, match_id, player_id, runs_scored, wickets_taken, catches_taken,
 match_details_match_id, player_payer_id, match_details_match_id1)
VALUES
(1,1,6,58,0,2,1,6,1),
(2,1,7,42,2,1,1,7,1),
(3,2,10,67,0,1,2,10,2),
(4,3,1,85,0,0,3,1,3),
(5,3,3,5,3,0,3,3,3),
(6,4,2,90,0,1,4,2,4),
(7,5,8,55,2,1,5,8,5),
(8,6,9,72,0,0,6,9,6),
(9,7,11,10,4,0,7,11,7),
(10,8,7,48,1,1,8,7,8),
(11,9,12,15,3,0,9,12,9),
(12,10,6,64,0,2,10,6,10);
INSERT INTO tournament_has_umpire VALUES
(1,1),(1,2),(1,3),(1,4),
(3,5),(3,6),(3,7),
(4,8),(4,9),
(5,10);
INSERT INTO venue_has_umpire VALUES
(1,1),(1,2),
(2,3),(2,4),
(3,5),(3,6),
(4,7),(4,8),
(5,9),(5,10);


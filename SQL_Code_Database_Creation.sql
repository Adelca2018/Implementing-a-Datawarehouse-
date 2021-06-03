/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;



DROP DATABASE IF EXISTS `rossmann`;
CREATE DATABASE IF NOT EXISTS `rossmann` /*!40100 DEFAULT CHARACTER SET utf8 */;
USE `rossmann`;
DROP TABLE IF EXISTS `hub_day`;
CREATE TABLE IF NOT EXISTS `hub_day` (
  `DAY_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `LOAD_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  `DATE` datetime NOT NULL,
   UNIQUE KEY `DATE` (`DATE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `hub_store`;
CREATE TABLE IF NOT EXISTS `hub_store` (
  `STORE_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `LOAD_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  `STORE_ID` int(11) NOT NULL,
   UNIQUE KEY `STORE_ID` (`STORE_ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8  ;

-- Transaction each day

DROP TABLE IF EXISTS `link_day`;
CREATE TABLE IF NOT EXISTS `link_day` (
  `LINK_DAY_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `STORE_HSH` varchar(32) NOT NULL,
  `DAY_HSH` varchar(32) NOT NULL,
  `LOAD_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  KEY `FK_link_day_hub_store` (`STORE_HSH`),
  KEY `FK_link_day_hub_day` (`DAY_HSH`),
  FOREIGN KEY (`DAY_HSH`) REFERENCES `hub_day` (`DAY_HSH`),
  FOREIGN KEY (`STORE_HSH`) REFERENCES `hub_store` (`STORE_HSH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

-- information about competition
DROP TABLE IF EXISTS `sat_comp`;
CREATE TABLE IF NOT EXISTS `sat_comp` (
  `COMP_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `STORE_HSH` varchar(32) NOT NULL,
  `DIFF_HSH` varchar(32) NOT NULL,
  `LOAD_DATETIME` datetime NOT NULL,
  `LOAD_END_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  `COMP_DISTANCE` int(11) NOT NULL,
  `COMP_OPEN_MONTH` int(11) NOT NULL,
  `COMP_OPEN_YEAR` int(11) NOT NULL,
  KEY `FK_sat_comp_hub_store` (`STORE_HSH`),
  FOREIGN KEY (`STORE_HSH`) REFERENCES `hub_store` (`STORE_HSH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;


-- Satellite of hub_day
DROP TABLE IF EXISTS `sat_day`;
CREATE TABLE IF NOT EXISTS `sat_day` (
  `SAT_DAY_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `DAY_HSH` varchar(32) NOT NULL,
  `DIFF_HSH` varchar(32) NOT NULL,
  `LOAD_DATETIME` datetime NOT NULL,
  `LOAD_END_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  `DAY_OF_WEEK` int(11) NOT NULL,
  FOREIGN KEY (`DAY_HSH`) REFERENCES `hub_day` (`DAY_HSH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;


-- satellite of link_day

DROP TABLE IF EXISTS `sat_day_facts`;
CREATE TABLE IF NOT EXISTS `sat_day_facts` (
  `SAT_DAYF_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `LINK_DAY_HSH` varchar(32) NOT NULL,
  `DIFF_HSH` varchar(32) NOT NULL,
  `LOAD_DATETIME` datetime NOT NULL,
  `LOAD_END_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  `OPEN` BOOLEAN NOT NULL,
  `STATE_HOLIDAY` varchar(1) NOT NULL, 
  `SCHOOL_HOLIDAY` BOOLEAN NOT NULL,
  `PROMO` BOOLEAN NOT NULL,
  `CUSTOMERS` int(11) NOT NULL,
  `SALES` int(11) NOT NULL,
   FOREIGN KEY (`LINK_DAY_HSH`) REFERENCES `link_day` (`LINK_DAY_HSH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 ;

DROP TABLE IF EXISTS `sat_promo`;
CREATE TABLE IF NOT EXISTS `sat_promo` (
  `PROMO_HSH` varchar(32) NOT NULL  PRIMARY KEY ,
  `STORE_HSH` varchar(32) NOT NULL,
  `DIFF_HSH` varchar(32) NOT NULL,
  `LOAD_DATETIME` datetime NOT NULL,
  `LOAD_END_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  `PROMO2` BOOLEAN NOT NULL,
  `PROMO2_SINCE_WEEK` int(11) NOT NULL,
  `PROMO2_SINCE_YEAR` int(11) NOT NULL,
  `PROMO_INTERVAL` varchar(40) NOT NULL,
   KEY `FK_sat_promo_hub_store` (`STORE_HSH`),
  FOREIGN KEY (`STORE_HSH`) REFERENCES `hub_store` (`STORE_HSH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sat_store`;
CREATE TABLE IF NOT EXISTS `sat_store` (
  `SSTORE_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `STORE_HSH` varchar(32) NOT NULL,
  `DIFF_HSH` varchar(32) NOT NULL,
  `LOAD_DATETIME` datetime NOT NULL,
  `LOAD_END_DATETIME` datetime NOT NULL,
  `RECORD_SOURCE` int(11) NOT NULL,
  `STORE_TYPE` varchar(1) NOT NULL,
  `ASSORTMENT` varchar(1) NOT NULL,
   FOREIGN KEY (`STORE_HSH`) REFERENCES `hub_store` (`STORE_HSH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8  ;

DROP TABLE IF EXISTS `sat_store_biz`;
CREATE TABLE IF NOT EXISTS `sat_store_biz` (
  `STORE_HSH` varchar(32) NOT NULL PRIMARY KEY ,
  `LOAD_DATETIME` datetime NOT NULL,
  `LOAD_END_DATETIME` datetime NOT NULL,
  `SALES_RANK` int(11) NOT NULL,
  `SALES_AVG` int(11) NOT NULL,
  `CSTMR_AVG` int(11) NOT NULL,
  FOREIGN KEY (`STORE_HSH`) REFERENCES `hub_store` (`STORE_HSH`)
)  ENGINE=InnoDB DEFAULT CHARSET=utf8;

DROP TABLE IF EXISTS `sat_day_report`;
CREATE TABLE IF NOT EXISTS `sat_day_report` (
  `DAY_HSH` varchar(32) NOT NULL PRIMARY KEY,
  `SALES_COUNT` int(11) NOT NULL,
  `CUSTOMER_COUNT` int(11) NOT NULL,
   FOREIGN KEY (`DAY_HSH`) REFERENCES `hub_day` (`DAY_HSH`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


-- This tables saves the sources of information

DROP TABLE IF EXISTS `RECORD_SOURCE_REF`;
CREATE TABLE IF NOT EXISTS `RECORD_SOURCE_REF` (
  `RECORD_SOURCE` int(11)  NOT NULL PRIMARY KEY,
   `RECORD_PATH` varchar(200) NOT NULL    
) ENGINE=InnoDB DEFAULT CHARSET=utf8;


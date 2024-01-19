SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `milestone3`
--

DROP DATABASE if exists `milestone3`;
Create database `milestone3`;
use milestone3;

CREATE TABLE `BooksInfo` (
  `BookID` bigint(20) NOT NULL auto_increment,
  `BookBarcode` varchar(50) NOT NULL,
  `GenreName` varchar(100) NOT NULL,
  `Author` varchar(50) NOT NULL,
  `Description` text NOT NULL,
  `Press` varchar(100) NOT NULL,
  `DatePublication` date DEFAULT NULL,
  `Language` varchar(100) NOT NULL,
  `Edition` varchar(100) DEFAULT NULL,
  primary key(`BookID`)
);



-- INSERT INTO `BooksInfo` (`BookID`, `BookBarcode`, `GenreName`, `Author`, `Description`, `Press`, `DatePublication`, `Language`, `Edition`) VALUES
-- (1, '9787530216835', 'Fiction ', 'YuzeWang', 'A book description is a short summary of a book important information', '2', '2017-06-01', 'English', '2');

CREATE TABLE `BookStatistics` (
  `BBookID` bigint(20) NOT NULL,
  `NumOfLoans` INT(11) DEFAULT 0,
  `Surplus` INT(11) DEFAULT 0,
  `Total` INT(11) DEFAULT 0,
   FOREIGN KEY (`BBookID`) REFERENCES `BooksInfo`(`BookID`)
);

-- INSERT INTO `BookStatistics` (`BBookID`, `NumOfLoans`, `Surplus`, `Total`) VALUES
-- (20230001, 12, 2, 14);

CREATE TABLE `Operator` (
  `OperatorID` int(11) NOT NULL auto_increment,
  `Name` varchar(20) DEFAULT NULL,
  `Password` varchar(15) DEFAULT NULL,
   PRIMARY KEY (`OperatorID`)
); 

-- INSERT INTO `Operator` (`OperatorID`, `Name`, `Password`) VALUES
-- (20230001, 'YuzeWang', '111111');

-- --------------------------------------------------------
CREATE TABLE `Reader` (
  `ReaderID` int(11) NOT NULL PRIMARY KEY auto_increment,
  `ReaderName` varchar(20) NOT NULL,
  `ReaderPassword` varchar(20) NOT NULL DEFAULT '111111',
  `Gender` varchar(4) NOT NULL,
  `RegistrationDate` DATE NOT NULL
);


-- INSERT INTO `Reader` (`ReaderID`, `ReaderName`, `ReaderPassword`, `Gender`, `RegistrationDate`) VALUES
-- (1501014101, 'ShiyaXiao', '111111', 'F', '2017-09-02');
-- --------------------------------------------------------


CREATE TABLE `BorrowedBookInfo` (
  `BBookID` bigint(20) NOT NULL,
  `BookBarcode` VARCHAR(50) NOT NULL,
  `StartTime` DATETIME NOT NULL,
  `ExpiryTime` DATETIME NOT NULL,
  `RenewAllowance` Boolean DEFAULT False,
  `OperatorID` int(11) NOT NULL,
  `ReaderID` int(11) NOT NULL,
  FOREIGN KEY (`BBookID`) REFERENCES `BooksInfo`(`BookID`) on delete cascade,
  FOREIGN KEY (`OperatorID`) REFERENCES `Operator`(`OperatorID`) on delete cascade,
  FOREIGN KEY (`ReaderID`) REFERENCES `Reader`(`ReaderID`) on delete no action
) ENGINE=InnoDB;

-- INSERT INTO `BorrowedBookInfo` (`BBookID`, `BookBarcode`, `StartTime`, `ExpiryTime`, `RenewAllowance`, `Operator`) VALUES
-- (10000001, '9787530216835', '2017-09-02', '2023-09-02', True, 20230001);

-- --------------------------------------------------------

-- --------------------------------------------------------


-- --------------------------------------------------------

CREATE TABLE `BookStateTable` (
  `BBookID`  bigint(20) NOT NULL,
  `BookBarcode` varchar(50) NOT NULL,
  `BookState` varchar(50) DEFAULT "reserved",
  `OperatorID` INT(11) NOT NULL,
  `Renewable` boolean default false,
  FOREIGN KEY (`BBookID`) REFERENCES `BooksInfo`(`BookID`) on delete no action
);

-- INSERT INTO `BookStateTable` (`BBookID`, `BookBarcode`, `BookState`, `OperatorID`, `Renewable`) VALUES
-- (1, '9787530216835', 'reserved', '202300001', true);

CREATE TABLE `Author` (
  `Author` varchar(20) NOT NULL,
  `BBookID`  bigint(20) NOT NULL,
  FOREIGN KEY (`BBookID`) REFERENCES `BooksInfo`(`BookID`) on delete no action
);

-- COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;

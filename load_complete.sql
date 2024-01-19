USE `ywang349_1`;
SET FOREIGN_KEY_CHECKS = 0;
truncate table Author;
truncate table BookStatistics;
truncate table BorrowedBookInfo;
truncate table Reader;
truncate table Operator;
truncate table BooksInfo;
truncate table BookStateTable;
SET FOREIGN_KEY_CHECKS = 1;

LOAD DATA LOCAL INFILE '/Users/roywang/Schools/CSC 261/milestone3/dbcsv/Books.csv' INTO TABLE BooksInfo
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (BookID,BookBarcode,Press,Edition,GenreName,DatePublication,Language,Description
);

LOAD DATA LOCAL INFILE '/Users/roywang/Schools/CSC 261/milestone3/dbcsv/Operator.csv' INTO TABLE Operator
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (OperatorID,Name,Password);

LOAD DATA INFILE '/Users/roywang/Schools/CSC 261/milestone3/dbcsv/Author.csv' INTO TABLE Author
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (BBookID, Author);

LOAD DATA INFILE '/Users/roywang/Schools/CSC 261/milestone3/dbcsv/Book_State.csv' INTO TABLE BookStateTable
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (BBookID, BookState,Renewable
);

LOAD DATA INFILE '/Users/roywang/Schools/CSC 261/milestone3/dbcsv/Reader.csv' INTO TABLE Reader
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (ReaderID,ReaderName,ReaderPassword,Gender,RegistrationDate
);

LOAD DATA INFILE '/Users/roywang/Schools/CSC 261/milestone3/dbcsv/Borrowed_Book_Information.csv' INTO TABLE BorrowedBookInfo
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (BBookID,OperatorID,ReaderID,BookBarcode,StartTime,ExpiryTime,RenewAllowance
);
	
LOAD DATA INFILE '/Users/roywang/Schools/CSC 261/milestone3/dbcsv/Book_Statistic.csv' INTO TABLE BookStatistics
  FIELDS TERMINATED BY ',' 
  LINES TERMINATED BY '\r\n'
  IGNORE 1 LINES
  (BBookID,NumofLoans,Surplus,Total
);


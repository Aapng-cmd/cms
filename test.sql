DELIMITER //

CREATE FUNCTION DBEx(dbname CHAR(128))
RETURNS CHAR(50)
BEGIN
  DECLARE bit CHAR(50);
  
  SET bit = (SELECT SCHEMA_NAME FROM INFORMATION_SCHEMA.SCHEMATA WHERE SCHEMA_NAME = dbname);
  
  RETURN bit;
  
END; //
  
DELIMITER ;

DELIMITER //

CREATE FUNCTION TEx(tname CHAR(128))
RETURNS CHAR(50)
BEGIN
  DECLARE bit CHAR(50);
  
  SET bit = (SELECT tname FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE='BASE TABLE' AND TABLE_NAME=tname);
  
  RETURN bit;

END; //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE DIY(command TEXT)
BEGIN
  PREPARE stmt FROM command;
  EXECUTE stmt;
  DEALLOCATE PREPARE stmt;
END; //

DELIMITER ;

DELIMITER //

CREATE PROCEDURE Start(dbname CHAR(128))
BEGIN
  DECLARE bit INT;
  
  IF NOT STRCMP(DBEx(dbname), dbname)  THEN
    SET @q = CONCAT('DROP DATABASE ', dbname, ';');
    call DIY(@q);
  END IF;
  
  SET @q = CONCAT('CREATE DATABASE ', dbname, ';');
  call DIY(@q);
  
  IF STRCMP(TEx('cookies'), 'cookies') <=> NULL THEN
    SET @q = CONCAT('CREATE TABLE ', dbname, '.cookies (`email` varchar(255) NOT NULL, `cookie` varchar(255) NOT NULL, PRIMARY KEY (`email`));');
    call DIY(@q);
  END IF;
  
  IF STRCMP(TEx('user'), 'user') <=> NULL THEN
    SET @q = CONCAT('CREATE TABLE ', dbname, '.user (`id` int NOT NULL AUTO_INCREMENT, `name` varchar(255) NOT NULL, `password` varchar(255), `email` varchar(255) NOT NULL, PRIMARY KEY (`id`));');
    call DIY(@q);
  END IF;
  
  IF STRCMP(TEx('prom_ver'), 'prom_ver') <=> NULL THEN
    SET @q = CONCAT('CREATE TABLE ', dbname, '.prom_ver (`word` varchar(255) NOT NULL, `email` varchar(255) NOT NULL);');
    call DIY(@q);
  END IF;
  
  IF STRCMP(TEx('products'), 'products') <=> NULL THEN
    SET @q = CONCAT('CREATE TABLE ', dbname, ' .products (`alias` varchar(255) NOT NULL, `price` int NOT NULL, `count` int NOT NULL, `path` varchar(255), PRIMARY KEY (`alias`));');
    call DIY(@q);
  END IF;
  
  IF STRCMP(TEx('bought'), 'bought') <=> NULL THEN
    SET @q = CONCAT('CREATE TABLE ', dbname, ' .bought (`owner` varchar(255), `name` varchar(255), `count` int)');
    call DIY(@q);
  END IF;
    
END; //

DELIMITER ;

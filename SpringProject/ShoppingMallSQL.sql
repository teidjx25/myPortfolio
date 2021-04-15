CREATE DATABASE prodb2;

  GRANT ALL PRIVILEGES
  ON prodb2.* TO 'projectid'@'%'
  IDENTIFIED BY 'pro1234';

  GRANT ALL PRIVILEGES
  ON prodb2.* TO 'projectid'@'localhost'
  IDENTIFIED BY 'pro1234';

CREATE TABLE `prodb2`.`member` (
  `mId` VARCHAR(45) NOT NULL,
  `mPassword` VARCHAR(90) NULL,
  `mTel` VARCHAR(90) NULL,
  `mEmail` VARCHAR(120) NULL,
  `mName` VARCHAR(45) NULL,
  `mAddress` VARCHAR(300) NULL,
  `regdate` date NULL,
  `mClass` VARCHAR(90) NULL,
  `auth` int NULL,
  `mPoint` int NULL,
  PRIMARY KEY (`mId`));
  
CREATE TABLE `prodb2`.`order` (
  `idbuyProduct` INT NOT NULL AUTO_INCREMENT,
  `buyPN` INT NULL,
  `buyCheck` INT NULL,
  `buyNum` INT NULL,
  `totalPrice` INT NULL,
  `buyId` VARCHAR(90) NULL,
  `buyName`  VARCHAR(90) NULL,
  `buyAddress` VARCHAR(300) NULL,
  `buyTel`  VARCHAR(90) NULL,
  `buyCode` VARCHAR(150) NULL,
  `regDate` date NULL,
  PRIMARY KEY (`idbuyProduct`));  
  
  CREATE TABLE `prodb2`.`order_cart` (
  `idcart` INT NOT NULL AUTO_INCREMENT,
  `mId` VARCHAR(45) NULL,
  `pId` INT NULL,
  `cQTY` INT NULL,
  `oRegDate` date NULL,
  `pName` VARCHAR(90) NULL,
  `cTotalPrice` int(30) NULL,
  PRIMARY KEY (`idcart`));  
  
  
  CREATE TABLE `prodb2`.`product` (
  `pId` INT NOT NULL AUTO_INCREMENT,
  `bimg` longtext NULL,
  `pName` VARCHAR(90) NULL,
  `pPrice` INT NULL,
  `pReadcount` INT NULL,
  `pBuyCnt` INT NULL,
  `pQTY`  INT NULL,
  `maker` VARCHAR(90) NULL,
  `regdate`  DATE NULL,
  `productType` INT NULL,
  `promotion` INT NULL,
  `category` INT NULL, 
  `discount` INT NULL,
  `pContent` VARCHAR(6000) NULL,
  `recomendC` VARCHAR(3000) NULL,  
  PRIMARY KEY (`pId`));  
  
    CREATE TABLE `prodb2`.`request` (
  `qnum` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(45) NULL,
  `password` VARCHAR(45) NULL,
  `reRef` INT NULL,
  `reLev` INT NULL,
  `reSeq` INT NULL,
  `bnum`  INT NULL,
  `qRdate` date NULL,
  `requestImg`  longtext NULL,
  `title` varchar(90) NULL,
  `contents` varchar(5000) NULL,
  `category` varchar(100) NULL, 
  `state` INT NULL,
  PRIMARY KEY (`qnum`));  
  
CREATE TABLE `prodb2`.`review` (
  `cnum` INT NOT NULL AUTO_INCREMENT,
  `grade` int(11) NULL,
  `name` VARCHAR(90) NULL,
  `comment` varchar(500) NULL,
  `reRef` int(11) NULL,
  `reLev` int(11) NULL,
  `reSeq`  int(11) NULL,
  `bnum` int(11) NULL,
  `Rdate`  date NULL,
  `reviewImg` longtext NULL,

  PRIMARY KEY (`cnum`));  
  
  
  
  CREATE TABLE member (
      id        VARCHAR(20)  PRIMARY KEY, /* 기본키 */
	  passwd    VARCHAR(20)  NOT NULL,
	  name      VARCHAR(20)  NOT NULL,
      age		int,
      email		VARCHAR(30),
      address	VARCHAR(300),
      tel		VARCHAR(20),
      gm_lev	int,
      gm_area	VARCHAR(20),
	  regDate  DATETIME
  );

CREATE TABLE openboard (
	num       INT PRIMARY KEY,
	name      VARCHAR(20),
	passwd    VARCHAR(20),
	subject   VARCHAR(50),
	content   VARCHAR(2000),
	readcount INT,
	reg_date  DATETIME,
	ip        VARCHAR(20),
	filename  VARCHAR(50),
	re_ref    INT,  /* 글그룹 번호 */
	re_lev    INT,  /* 화면 들여쓰기 레벨 */
	re_seq    INT,   /* 글그룹 내에서 순번 */
    mgLev    INT,
    mgArea    VARCHAR(20)
);


CREATE TABLE noticeboard (
	num       INT PRIMARY KEY,
	name      VARCHAR(20),
	subject   VARCHAR(50),
	content   VARCHAR(2000),
	readcount INT,
	reg_date  DATETIME,
	filename  VARCHAR(50),
	re_ref    INT,  /* 글그룹 번호 */
	re_lev    INT,  /* 화면 들여쓰기 레벨 */
	re_seq    INT,   /* 글그룹 내에서 순번 */
	state	  INT
);


ALTER TABLE member convert to charset utf8;
ALTER TABLE openboard convert to charset utf8;
ALTER TABLE noticeboard convert to charset utf8;
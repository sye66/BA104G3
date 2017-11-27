--上傳照片
CREATE OR REPLACE  DIRECTORY MEDIA_DIR AS 'd:/images/'; 
CREATE OR REPLACE FUNCTION load_blob( myFileName VARCHAR) RETURN BLOB as result BLOB;  
  myBFILE      BFILE;
  myBLOB       BLOB;
BEGIN
    myBFILE := BFILENAME('MEDIA_DIR',myFileName);
    dbms_lob.createtemporary(myBLOB, TRUE);
    dbms_lob.fileopen(myBFILE,dbms_lob.file_readonly);
    dbms_lob.loadfromfile(myBLOB,myBFILE,dbms_lob.getlength(myBFILE) );
    dbms_lob.fileclose(myBFILE);
    RETURN myBLOB;
END load_blob;
/

--DROP指令--

--DROP SEQUENCE--
--小朱--
DROP SEQUENCE AD_SEQUENCE;				--廣告		自增主鍵		
DROP SEQUENCE ARTI_FORM_SEQUENCE;		--討論區	自增主鍵
DROP SEQUENCE ARTI_REPLY_SEQUENCE;		--回覆文章	自增主鍵
DROP SEQUENCE ARTI_REPORT_SEQUENCE;		--檢舉文章 	自增主鍵
--兆哥--
DROP SEQUENCE PRO_ORDER_SEQ;            --訂單 		自增主鍵
DROP SEQUENCE PRO_SEQ;                  --商品 		自增主鍵
DROP SEQUENCE PRO_CLASS_SEQ;            --商品分類 	自增主鍵
--柏炘--
DROP SEQUENCE SEQ_DIS_CASE_NO;			--爭議案件	自增主鍵
DROP SEQUENCE SEQ_SKILL_NO;				--技能 		自增主鍵
DROP SEQUENCE SEQ_SKILL_CATEGORY;		--技能分類	自增主鍵
--勝驊--
DROP SEQUENCE ACCUSE_SEQ;				--爭議案件	自增主鍵
DROP SEQUENCE IMAGE_SEQ;				--任務圖片	自增主鍵
DROP SEQUENCE MISSION_SEQ;				--任務 		自增主鍵
--家駿--
DROP SEQUENCE ACH_SEQ; 					--成就 		自增主鍵
DROP SEQUENCE AUTH_SEQ; 				--權限功能 	自增主鍵
DROP SEQUENCE EMP_SEQ; 					--員工 		自增主鍵
--阿群--
DROP SEQUENCE FAQ_NO;					--FAQ 		自增主鍵
DROP SEQUENCE STORED_NO;				--儲值紀錄 	自增主鍵
DROP SEQUENCE MEM_NO;					--會員 		自增主鍵
DROP SEQUENCE OFFICAL_NO;               --官方
--DROP TABLE--
--小朱--
DROP TABLE AD;							--廣告
DROP TABLE ARTI_REPLY;					--回覆文章
DROP TABLE ARTI_REPORT;					--檢舉文章
DROP TABLE ARTI_FORM;					--討論區
DROP TABLE ARTI_CLASS; 					--文章分類

--兆哥--
DROP TABLE PRO_ORD_LIST;                --訂單明細
DROP TABLE PRO_ORDER;             		--訂單
DROP TABLE PRO_TRACK;             	    --商品追蹤
DROP TABLE PRO;                         --商品
DROP TABLE PRO_CLASS;					--商品分類
--柏炘--
DROP TABLE CHAT_RECORD;					--聊天紀錄
DROP TABLE DISPUTE_CASE;				--爭議案件
DROP TABLE USER_SKILL;					--會員技能明細
DROP TABLE SKILL;						--技能
DROP TABLE SKILL_CATEGORY;				--技能分類
--勝驊--
DROP TABLE ACCUSE_CASE;					--檢舉案件
DROP TABLE CASE_CANDIDATE;				--接案候選人
DROP TABLE MISSION_IMAGES;				--任務圖片
DROP TABLE MISSION;						--任務
--家駿--
DROP TABLE RANK;						--排行榜
DROP TABLE ACH_DETAIL;					--成就明細
DROP TABLE ACHIEVE;						--成就項目
DROP TABLE COMP;						--員工權限
DROP TABLE AUTH;						--權限功能
DROP TABLE EMP; 						--員工
--阿群--
DROP TABLE FAQ;                         --FAQ
DROP TABLE RELATION;                    --關係
DROP TABLE FOLLOW_TOOL_MAN;             --關注的工具人
DROP TABLE STORED_HISTORY;              --儲值紀錄
-------------------------
DROP TABLE MEM;                         --會員  ***最後DROP掉***
-------------------------


--SQL指令--

--阿群--

--會員 MEM TABLE--
CREATE TABLE MEM(
MEM_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
MEM_PW VARCHAR2(30) NOT NULL,
MEM_NAME VARCHAR2(30) NOT NULL,
MEM_ID VARCHAR2(30) NOT NULL,
MEM_BDAY DATE NOT NULL,
MEM_TEL VARCHAR2(20) NOT NULL,
MEM_PHO VARCHAR2(20) NOT NULL,
MEM_GEND NUMBER(3) NOT NULL,
MEM_EMAIL VARCHAR2(30) NOT NULL,
MEM_PIC BLOB,
MEM_INTRO VARCHAR2(300) NOT NULL,
MEM_CODE NUMBER(30),
MEM_STATE NUMBER(1) NOT NULL,
MEM_GPS_LAT NUMBER(15,10) ,
MEM_GPS_LNG NUMBER(15,10) ,
MEM_IP VARCHAR2(50) ,
MEM_DATE TIMESTAMP WITH TIME ZONE NOT NULL,
MISSION_COUNT NUMBER(10),
MEM_ADDRESS VARCHAR2(100) NOT NULL,
MEM_SEARCH NUMBER(1) NOT NULL,
MEM_POINT NUMBER(20)
);
CREATE SEQUENCE MEM_NO START WITH 1  INCREMENT BY 1;
CREATE SEQUENCE OFFICAL_NO START WITH 1  INCREMENT BY 1;
COMMIT;


--儲值紀錄 STORED_HISTORY TABLE--

CREATE TABLE STORED_HISTORY(
STORED_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
MEM_NO VARCHAR2(20)  NOT NULL ,FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO),
STORED_DATE DATE NOT NULL,
STORED_TYPE NUMBER(3) NOT NULL,
STORED_COST NUMBER(20) NOT NULL
);

CREATE SEQUENCE STORED_NO START WITH 1 INCREMENT BY 1;
COMMIT;

--FAQ TABLE--

CREATE TABLE FAQ(
FAQ_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
FAQ_CONTENT VARCHAR2(600) NOT NULL,
FAQ_DATE DATE NOT NULL
);

CREATE SEQUENCE FAQ_NO START WITH 1 INCREMENT BY 1;

--關注的工具人 FOLLOW_TOOL_MAN TABLE--

CREATE TABLE FOLLOW_TOOL_MAN (
FOLLOWER_MEM_NO VARCHAR2(20) NOT NULL REFERENCES MEM(MEM_NO),
FOLLOWED_MEM_NO VARCHAR2(20) NOT NULL REFERENCES MEM(MEM_NO),
FOLLOW_STATUS NUMBER(5) NOT NULL,
CONSTRAINT FOLLOW_TOOL_MAN PRIMARY KEY(FOLLOWER_MEM_NO,FOLLOWED_MEM_NO)
);

COMMIT;

--關係 RELATION TABLE--

CREATE TABLE RELATION(
MEM_NO VARCHAR2(20) NOT NULL REFERENCES MEM(MEM_NO),
RELATED_MEM_NO VARCHAR2(20) NOT NULL REFERENCES MEM(MEM_NO),
RELATION_STATUS NUMBER(2) NOT NULL,
CONSTRAINT RELATION PRIMARY KEY(MEM_NO,RELATED_MEM_NO)
);
COMMIT;

--==================================================--

--家駿--

--員工 EMP TABLE--
CREATE TABLE EMP(
EMP_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
EMP_NAME VARCHAR2(10) NOT NULL,
EMP_PWD VARCHAR2(10) NOT NULL,
EMP_MAIL VARCHAR2(30) NOT NULL,
EMP_JOB VARCHAR2(10) NOT NULL,
EMP_PHONE VARCHAR2(10) NOT NULL,
EMP_STATE VARCHAR2(10) NOT NULL
);

CREATE SEQUENCE EMP_SEQ
START WITH 1
INCREMENT BY 1;

--權限功能 AUTH TABLE--
CREATE TABLE AUTH(
AUTH_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
AUTH_NAME VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE AUTH_SEQ
START WITH 1
INCREMENT BY 1;

--員工權限 COMP TABLE--
CREATE TABLE COMP(
EMP_NO VARCHAR2(20) NOT NULL,FOREIGN KEY (EMP_NO) REFERENCES EMP(EMP_NO),
AUTH_NO VARCHAR2(20),FOREIGN KEY (AUTH_NO) REFERENCES AUTH(AUTH_NO)
);

--成就 ACHIEVE TABLE--
CREATE TABLE ACHIEVE(
ACH_NO VARCHAR2 (20) PRIMARY KEY NOT NULL,
ACH_NAME VARCHAR2 (20) NOT NULL,
ACH_PICTURE BLOB, 
ACH_EXPLAIN VARCHAR2(50) NOT NULL
);

CREATE SEQUENCE ACH_SEQ
START WITH 1
INCREMENT BY 1;

--成就明細 ACHIEVE_DETAIL TABLE--

CREATE TABLE ACH_DETAIL(
MEM_NO VARCHAR2(20) NOT NULL,FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO),
ACH_NO VARCHAR2 (20) NOT NULL,FOREIGN KEY (ACH_NO) REFERENCES ACHIEVE(ACH_NO),
ACH_TIME DATE NOT NULL
);

--排行榜 RANK TABLE--
CREATE TABLE RANK(
MEM_NO VARCHAR2(20)  NOT NULL ,FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO),
DAY_NUMBER_RANK VARCHAR2(50) NOT NULL,
DAY_SCORE_RANK VARCHAR2(50) NOT NULL,
WEEK_NUMBER_RANK VARCHAR2(50) NOT NULL,
MONTH_NUMBER_RANK VARCHAR2(50) NOT NULL,
SEASON_NUMBER_RANK VARCHAR2(50) NOT NULL,
WEEK_SCORE_RANK VARCHAR2(50) NOT NULL,
MONTH_SCORE_RANK VARCHAR2(50) NOT NULL,
SEASON_SCORE_RANK VARCHAR2(50) NOT NULL
);

--==================================================--

--勝驊--

--任務 MISSION TABLE--
CREATE TABLE MISSION(
MISSION_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
MISSION_CATEGORY VARCHAR2(20) NOT NULL,
MISSION_NAME VARCHAR2(30) NOT NULL,
MISSION_DES CLOB,
ISSUER_MEM_NO VARCHAR2(20) NOT NULL ,FOREIGN KEY(ISSUER_MEM_NO)REFERENCES MEM(MEM_NO),
TAKECASE_MEM_NO VARCHAR2(20) ,FOREIGN KEY(TAKECASE_MEM_NO) REFERENCES MEM(MEM_NO),
MISSION_RELEASE_TIME DATE NOT NULL,
MISSION_DUE_TIME TIMESTAMP NOT NULL,
MISSION_START_TIME TIMESTAMP,
MISSION_END_TIME TIMESTAMP,
MISSION_STATE NUMBER(2) NOT NULL,
MISSION_PATTERN NUMBER(1) NOT NULL,
MISSION_PAY NUMBER(10,2),
MISSION_GPS_LAT NUMBER(15,10),
MISSION_GPS_LNG NUMBER(15,10)
);
CREATE SEQUENCE MISSION_SEQ START WITH 1 INCREMENT BY 1;
COMMIT;

--任務圖片 MISSION_IMAGES TABLE--
CREATE TABLE MISSION_IMAGES(
IMAGE_NO VARCHAR2(20) NOT NULL,
MISSION_NO VARCHAR2(20) NOT NULL,
FOREIGN KEY(MISSION_NO) REFERENCES MISSION(MISSION_NO),
ISSUER_MEM_NO VARCHAR2(20) NOT NULL,
FOREIGN KEY(ISSUER_MEM_NO) REFERENCES MEM(MEM_NO),
ISSUER_IMAGES BLOB
);

CREATE SEQUENCE IMAGE_SEQ START WITH 1 INCREMENT BY 1;
COMMIT;

--接案候選人 CASE_CANDIDATE TABLE--

CREATE TABLE CASE_CANDIDATE(
CANDIDATE_MEM_NO VARCHAR2(20) NOT NULL,
MISSION_NO VARCHAR2(20) NOT NULL,
ISSUER_INVITING NUMBER(1) NOT NULL,
PRIMARY KEY(CANDIDATE_MEM_NO,MISSION_NO),
CONSTRAINT CASE_CANDIDATE
FOREIGN KEY(CANDIDATE_MEM_NO) REFERENCES MEM(MEM_NO),
CONSTRAINT FK_MEM_MISSION
FOREIGN KEY(MISSION_NO) REFERENCES MISSION(MISSION_NO)
);
COMMIT;

--檢舉案件 ACCUSE_CASE--

CREATE TABLE ACCUSE_CASE(
ACCUSE_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
MISSION_NO VARCHAR2(20) ,FOREIGN KEY(MISSION_NO) REFERENCES MISSION(MISSION_NO),
ACCUSER_NO VARCHAR2(20), FOREIGN KEY(ACCUSER_NO) REFERENCES MEM(MEM_NO),
EMP_NO VARCHAR2(20),FOREIGN KEY(EMP_NO) REFERENCES EMP(EMP_NO),
ACCUSE_DATE TIMESTAMP NOT NULL,
CLOSE_CASE_DATE TIMESTAMP,
ACCUSE_DETAIL CLOB,
ACCUSE_STATE NUMBER(2) NOT NULL
);

CREATE SEQUENCE ACCUSE_SEQ START WITH 1 INCREMENT BY 1;
COMMIT;

--柏炘--

--技能分類 SKILL_CATEGORY TABLE--
CREATE TABLE SKILL_CATEGORY(
SKILL_CATE_NO VARCHAR2(20) NOT NULL PRIMARY KEY,
SKILL_CATE_NAME VARCHAR2(30) NOT NULL);
CREATE SEQUENCE SEQ_SKILL_CATEGORY START WITH 1 INCREMENT BY 1;
COMMIT;

--技能 SKILL TABLE--
CREATE TABLE SKILL(
SKILL_NO VARCHAR2(20) NOT NULL PRIMARY KEY,
SKILL_NAME VARCHAR2(30) NOT NULL,
SKILL_CATE_NO VARCHAR2(20) NOT NULL,
CONSTRAINT FK_SKILL_SKILL_CATEGORY FOREIGN KEY (SKILL_CATE_NO) REFERENCES SKILL_CATEGORY(SKILL_CATE_NO)
);
CREATE SEQUENCE SEQ_SKILL_NO START WITH 1 INCREMENT BY 1;
COMMIT;

--會員技能明細 USER_SKILL TABLE--
CREATE TABLE USER_SKILL(
MEM_NO VARCHAR2(20) NOT NULL,
SKILL_NO VARCHAR2(20) NOT NULL,
SKILL_DETAIL CLOB ,
SKILL_CERT BLOB,
CONSTRAINT FK_USER_SKILL_MEM FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO),
CONSTRAINT FK_USER_SKILL_SKILL FOREIGN KEY (SKILL_NO) REFERENCES SKILL(SKILL_NO),
CONSTRAINT PK_MEM_NO_SKILL_NO PRIMARY KEY (MEM_NO, SKILL_NO)
);
COMMIT;

--爭議案件 DISPUTE_CASE TABLE--
CREATE TABLE DISPUTE_CASE(
DISPUTE_CASE_NO VARCHAR2(20) NOT NULL PRIMARY KEY,
MISSION_NO VARCHAR2(20) NOT NULL,
DISPUTE_MEM_NO VARCHAR2(20) NOT NULL,
EMP_NO VARCHAR2(20),
ISSUE_DATETIME TIMESTAMP,
CLOSE_DATETIME TIMESTAMP,
DISPUTE_CASE_STATUS NUMBER(2),
DISPUTE_CONTENT CLOB,
DISPUTE_ATTACHMENT BLOB,
DISPUTE_REPLY CLOB,
CONSTRAINT FK_DEBATE_CASE_MISSION FOREIGN KEY (MISSION_NO) REFERENCES MISSION(MISSION_NO),
CONSTRAINT FK_DEBATE_CASE_MEM FOREIGN KEY (DISPUTE_MEM_NO) REFERENCES MEM(MEM_NO),
CONSTRAINT FK_DEBATE_CASE_EMP FOREIGN KEY (EMP_NO) REFERENCES EMP(EMP_NO)
);
CREATE SEQUENCE SEQ_DIS_CASE_NO START WITH 1 INCREMENT BY 1;
COMMIT;

--聊天記錄 CHAT_CONTEN TABLE--
CREATE TABLE CHAT_RECORD(
SENDER_MEM_NO VARCHAR2(20) NOT NULL,
RECEIVER_MEM_NO VARCHAR2(20) NOT NULL,
CHAT_DATETIME TIMESTAMP NOT NULL,
CHAT_CONTENT CLOB,
CONSTRAINT FK_CHAT_SENDER_MEM FOREIGN KEY (SENDER_MEM_NO) REFERENCES MEM(MEM_NO),
CONSTRAINT FK_CHAT_RECEIVER_MEM FOREIGN KEY (RECEIVER_MEM_NO) REFERENCES MEM(MEM_NO),
CONSTRAINT PK_SEND_REC_TIME PRIMARY KEY (SENDER_MEM_NO, RECEIVER_MEM_NO, CHAT_DATETIME)
);
COMMIT;

--兆哥--

--商品分類 PRO_CLASS TABLE--
CREATE TABLE PRO_CLASS (
PRO_CLASS_NO VARCHAR2(10) PRIMARY KEY NOT NULL,
PRO_CLASS_NAME VARCHAR2(30) NOT NULL
);
--商品分類 自增主鍵 PRO_CLASS_SEQ
CREATE SEQUENCE PRO_CLASS_SEQ
START WITH 1
INCREMENT BY 1;
COMMIT;


--商品 PRO TABLE--
CREATE TABLE PRO(
PRO_NO VARCHAR2(10) PRIMARY KEY NOT NULL,
PRO_PRICE NUMBER(10) NOT NULL,
PRO_CLASS_NO VARCHAR2(10) NOT NULL,
PRO_STATUS VARCHAR2(10) NOT NULL,
PRO_DISCOUNT NUMBER(3),
PRO_DIS_STARTDATE DATE,
PRO_DIS_ENDDATE DATE,
PRO_PIC BLOB,
PRO_NAME VARCHAR2(60) NOT NULL,
PRO_INFO CLOB NOT NULL,
FOREIGN KEY (PRO_CLASS_NO)REFERENCES PRO_CLASS(PRO_CLASS_NO)
);
--商品 自增主鍵 PRO_SEQ
CREATE SEQUENCE PRO_SEQ
START WITH 1
INCREMENT BY 1;
COMMIT;


--商品追蹤 PRO_TRACK TABLE--
CREATE TABLE PRO_TRACK (
MEM_NO VARCHAR2(20) NOT NULL REFERENCES MEM(MEM_NO),
PRO_NO VARCHAR2(10) NOT NULL REFERENCES PRO(PRO_NO),
CONSTRAINT PRO_TRACK PRIMARY KEY(MEM_NO,PRO_NO) 
);
COMMIT;

--訂單 PRO_ORDER TABLE--
CREATE TABLE PRO_ORDER(
ORD_NO VARCHAR2(20) PRIMARY KEY NOT NULL,
MEM_NO VARCHAR2(20) NOT NULL,
ORD_DATE DATE NOT NULL,
ORD_PRICE NUMBER(10) NOT NULL,
ORD_CONSIGNEE VARCHAR2(20) NOT NULL,
ORD_ADDRESS VARCHAR2(100) NOT NULL,
ORD_PHONE VARCHAR2(30) NOT NULL,
ORD_SHIPINFO VARCHAR2(10),
ORD_SHIP_DATE DATE,
FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO)
);
--訂單自增主鍵
CREATE SEQUENCE PRO_ORDER_SEQ
START WITH 1
INCREMENT BY 1;
COMMIT;

--訂單明細 PRO_ORD_LIST TABLE--
CREATE TABLE PRO_ORD_LIST(
ORD_NO VARCHAR2(20) NOT NULL REFERENCES PRO_ORDER(ORD_NO),
PRO_NO VARCHAR2(10) NOT NULL REFERENCES PRO(PRO_NO),
ORDPRO_COUNT NUMBER NOT NULL,
ORDPRO_PRICE NUMBER NOT NULL,
CONSTRAINT PRO_ORD_LIST PRIMARY KEY(ORD_NO,PRO_NO)
);
COMMIT;

--小朱--

--文章分類 ARTI_CLASS TABLE--
CREATE TABLE ARTI_CLASS (
ARTI_CLS_NO			NUMBER(10) NOT NULL,
ARTI_CLS_NAME		VARCHAR2(50) NOT NULL,
CONSTRAINT PK_ARTI_CLASS PRIMARY KEY (ARTI_CLS_NO));
COMMIT;
--討論區 ARTI_FORM TABLE--
CREATE TABLE ARTI_FORM (
ARTI_NO              VARCHAR2(10) NOT NULL,
MEM_NO               VARCHAR2(20) NOT NULL,FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO),
ARTI_TITLE           VARCHAR2(120) NOT NULL,
ARTI_LIKE            NUMBER(10) NOT NULL,
DESCRIBE             CLOB NOT NULL,
ARTI_TIME            TIMESTAMP WITH TIME ZONE NOT NULL,
ARTI_PIC             BLOB,
ARTI_CLS_NO           NUMBER(10) NOT NULL,FOREIGN KEY (ARTI_CLS_NO) REFERENCES ARTI_CLASS(ARTI_CLS_NO),
ARTI_STATUS          VARCHAR2(50) NOT NULL,
CONSTRAINT PK_ARTI_FORM PRIMARY KEY (ARTI_NO));

CREATE SEQUENCE ARTI_FORM_SEQUENCE
START WITH 1
INCREMENT BY 1;
COMMIT;

--回覆文章 ARTI_REPLY TABLE--
CREATE TABLE ARTI_REPLY (
REPLY_NO             VARCHAR2(10) NOT NULL,
MEM_NO               VARCHAR2(20) NOT NULL,FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO),
ARTI_NO              VARCHAR2(10) NOT NULL,FOREIGN KEY (ARTI_NO) REFERENCES ARTI_FORM(ARTI_NO),
REPLY_DESC           CLOB NOT NULL,
REPLY_TIME           TIMESTAMP WITH TIME ZONE NOT NULL,
ARTI_CLS_NO           NUMBER(10) NOT NULL,FOREIGN KEY (ARTI_CLS_NO) REFERENCES ARTI_CLASS(ARTI_CLS_NO),
CONSTRAINT PK_ARTI_REPLY PRIMARY KEY (REPLY_NO));
 
CREATE SEQUENCE ARTI_REPLY_SEQUENCE
START WITH 1
INCREMENT BY 1;
COMMIT;

--檢舉文章ARTI_REPORT TABLE--
CREATE TABLE ARTI_REPORT (
REPORT_NO           VARCHAR2(10) NOT NULL,
MEM_NO               VARCHAR2(20) NOT NULL,FOREIGN KEY (MEM_NO) REFERENCES MEM(MEM_NO),
ARTI_NO              VARCHAR2(10) NOT NULL,FOREIGN KEY (ARTI_NO ) REFERENCES ARTI_FORM(ARTI_NO),
REPORT_DESC           CLOB NOT NULL,
REPORT_TIME           TIMESTAMP WITH TIME ZONE NOT NULL,
REP_RE_DESC        VARCHAR2(20)NOT NULL,
REPORT_STATUS           VARCHAR2(10) NOT NULL,
CONSTRAINT PK_ARTI_REPORT PRIMARY KEY (REPORT_NO));
 
CREATE SEQUENCE ARTI_REPORT_SEQUENCE
START WITH 1
INCREMENT BY 1;
COMMIT;

--廣告 AD TABLE--
CREATE TABLE AD (
AD_NO           VARCHAR2(10) NOT NULL,
AD_PIC          BLOB,
AD_DESC         CLOB NOT NULL,
AD_START         TIMESTAMP WITH TIME ZONE NOT NULL,
AD_END          TIMESTAMP WITH TIME ZONE NOT NULL,
AD_FTY_NO       VARCHAR2(20) NOT NULL,
AD_FTY_NAME     VARCHAR2(50) NOT NULL,
CONSTRAINT PK_AD PRIMARY KEY (AD_NO));

CREATE SEQUENCE AD_SEQUENCE
START WITH 1
INCREMENT BY 1;
COMMIT;

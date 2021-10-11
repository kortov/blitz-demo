CREATE TABLE USR_PRP (
  SBJ_ID      text CONSTRAINT USR_PRP_SBJ_ID_PK PRIMARY KEY,
  CRID        text NOT NULL,
  RQ_FTR      smallint,
  DUO_USR_ID  text,
  CAS         bigint NOT NULL
);

CREATE TABLE ACS_TKN (
  ID          text CONSTRAINT ACS_TKN_ID_PK PRIMARY KEY,
  TYP         text NOT NULL,
  TTL         integer NOT NULL,
  CLI_ID      text NOT NULL,
  SCP         text[] NOT NULL,
  SBJ_ID      text,
  INS_ID      text,
  CRID        text NOT NULL
);

/* clean up expired refresh tokens periodicaly in DB*/
CREATE TABLE RFR_TKN (
  ID          text CONSTRAINT RFR_TKN_ID_PK PRIMARY KEY,
  CLI_ID      text NOT NULL,
  SCP         text[] NOT NULL,
  SBJ_ID      text,
  CRID        text NOT NULL,
  EXP_ON      bigint NOT NULL  /* need idx */
);

CREATE TABLE USR_ATR (
	SBJ_ID     text CONSTRAINT USR_ATR_SBJ_ID_PK PRIMARY KEY,
	EMAIL      text,
	GROUPS     text[]
);

CREATE TABLE AUD(
  ID         text CONSTRAINT AUD_ID_PK PRIMARY key,
	TS         bigint NOT NULL,
	TYP        text,
	PRC_ID     text,
	SSN_ID     text,
	SBJ_ID     text,
	OBJ_ID     text,
	LP_ID      text,
	APP_ID     text,
	CLI_MTD    text,
	PRCL       text,
	IP         bigint,
	IPV6       text,
	IPV6L      bigint,
	IPV6H      bigint,
	UA         text
);

CREATE TABLE AUD_PRM(
  R_AUD      text REFERENCES AUD(ID) not null,
	ATR        text NOT NULL,
	V          text,
	TS         bigint NOT NULL
);

/*maybe it will be better TO CREATE PK(SBJ_ID, OBJ_ID, RGH)*/
CREATE TABLE RGH(
  SBJ_ID    text NOT null, /* need idx */
  OBJ_ID  	text NOT null, /* need idx */
  RGH       text NOT null, /* need idx */
  TGS			  text[] NOT null
);

CREATE TABLE FED_ACC(
  SID       text CONSTRAINT FED_ACC_SID_PK PRIMARY key,
  SBJ_ID    text NOT null, /* need idx */
  FP_KEY    text NOT null,
  HM_PG	    text
);

CREATE TABLE USR_DVC(
  FP        text NOT NULL, /* need idx */
	SBJ_ID    text NOT NULL, /* need idx */
	UA		    text,
	UPD		    bigint NOT NULL
);

CREATE TABLE USR_APP_CRD(
	SBJ_ID    text NOT NULL, /* need idx */
	APP_ID    text NOT NULL, /* need idx */
	LGN       text NOT NULL,
	PSW       text NOT NULL
);

CREATE TABLE USR_TTP(
	SBJ_ID    text NOT NULL,  	/* need idx */
	ID			  text NOT NULL, 	/* need idx */
	SEC			  text NOT NULL,
	DSP_NAM		text NOT null,
	SRL			  text,
	SLT			  text,
	LNG			  integer NOT null,
	HMC_ALG		text NOT null,
	TM_STP		integer NOT null
);

CREATE TABLE USR_HTP(
	SBJ_ID 		text NOT NULL,  	/* need idx */
	ID			  text NOT NULL, 	/* need idx */
	SEC			  text NOT NULL,
	DSP_NAM		text NOT NULL,
	SRL			  text,
	SLT			  text,
	LNG			  integer NOT NULL,
	CNT			  integer NOT NULL
);

CREATE TABLE USR_DUO(
  SBJ_ID 		  text NOT NULL,  	/* need idx */
	ACT_BAR_COD text NOT NULL,
	ACT_COD		  text NOT NULL,
	EXP_ON			    bigint NOT NULL,	/* need idx */
	DUO_USR_ID	text NOT NULL,
	USR_NAM		  text NOT NULL,
	STU			    text NOT NULL
);

CREATE TABLE ACS_LST (
  ID          text 	CONSTRAINT ACL_LST_ID_PK PRIMARY KEY,
  SBJ_ID		  text 	NOT NULL,	/* need idx */
  CLI_ID  	  text 	NOT NULL,
  SCP         text[] 	NOT NULL,
  UPD			    bigint 	NOT NULL
);

/* clean up expired device codes periodicaly in DB*/
CREATE TABLE DEV_COD (
  COD       text CONSTRAINT DEV_COD_COD_PK PRIMARY KEY,
  USR_COD		text NOT NULL,	/* need idx */
  CLI_ID  	text NOT NULL,
  SCP       text[] NOT NULL,
  EXP_ON		bigint NOT NULL,	/* need idx */
  DAT			  text
);

/* clean up expired action states periodicaly in DB*/
CREATE TABLE ACT_STE (
  ID        text CONSTRAINT	ACT_STE_ID_PK PRIMARY KEY,
  DAT			  text,
  EXP_ON	  bigint NOT NULL	/* need idx */
);

CREATE TABLE OAT_DEV (
	SRL       text CONSTRAINT OAT_DEV_SRL_PK PRIMARY key,
	MDL	      text NOT NULL,
	SBJ_ID    text,
	APP       text,
	LST_UPD   bigint NOT NULL
);

CREATE TABLE OAT_PRC (
  ID        text CONSTRAINT 	OAT_PRC_ID_PK PRIMARY key,
	FLN       text NOT NULL,
	CRT       bigint NOT NULL,
	LOD_SRL   text[],
	FAL_SRL   text[],
	PRC       integer NOT NULL,
	SCC       integer NOT NULL,
	FLD       integer NOT NULL,
	ERR       text[]
);

/* clean up expired rows periodicaly in DB*/
CREATE TABLE CFM_REQ (
  ID        text CONSTRAINT	CFM_REQ_ID_PK PRIMARY key,
	DAT       text NOT NULL,
	CRT       text NOT NULL,
	EXP_ON    bigint NOT NULL		/* need idx */
);

CREATE TABLE IAT (
  ID        text CONSTRAINT	IAT_ID_PK PRIMARY key,
	SFT_ID    text NOT NULL,		/* need idx */
	SFT_VER   text NOT NULL,
	CRT_ON    bigint NOT NULL
);

/* clean up expired rows periodicaly in DB*/
CREATE TABLE REG (
  ID        text CONSTRAINT 	REG_ID_PK PRIMARY key,
	ENR_PNT   text NOT NULL,
	APP_ID    text NOT NULL,
	RQR_ID    text NOT NULL,
	EXP_ON    bigint NOT NULL,	/* need idx */
	OGN       text,
	TRG       text,
	CRT_ON    bigint NOT NULL,
	SBJ_ID    text,
	INS_ID    text,
	REG_ON    bigint,
	ATR 	    text,
	SHK 	    integer,
	RGH 	    text
);

CREATE TABLE CLT (
  ID				      text CONSTRAINT CLT_ID_PK PRIMARY key,
	CLI_SEC 		    text,
	CLI_SEC_EXP_ON 	bigint,
	SBJ_ID			    text,			/* need idx */
	CLI_SEC_HSH		  text,
	CRT_ON		 	    bigint,
	RET_URI			    text[],
	TE_ATH_MTD		  text NOT NULL,
	GRN_TYP			    text[],
	RSP_TYP			    text[],
	CLI_NAM			    text,
	SCP				      text[],
	JWKS_URI		    text,
	JWKS			      text,
	SFT_ID			    text NOT NULL,
	SFT_VER			    text,
	DEV_TYP			    text
);

CREATE TABLE USR (
  ID              text CONSTRAINT USR_ID_PK PRIMARY key,
	PSWD_HSH        text,
	LST_UPD         bigint NOT NULL,
  SUB             TEXT,
  FAMILY_NAME     TEXT,
	GIVEN_NAME      TEXT,
  MIDDLE_NAME     TEXT,
	EMAIL           TEXT,
	PHONE_NUMBER    TEXT
);

CREATE TABLE CFM_REC (
  ID        text CONSTRAINT CFM_REC_ID_PK PRIMARY key,
	APP_ID    text NOT NULL,
	OGN	      text,
	STE       text NOT NULL
);

ALTER TABLE RGH ADD PRIMARY KEY(SBJ_ID, OBJ_ID, RGH);
CREATE INDEX IDX_RFR_TKN_EXP_ON ON RFR_TKN(EXP_ON);
CREATE INDEX IDX_FED_ACC_SBJ_ID ON RFR_TKN(SBJ_ID);
CREATE INDEX IDX_USR_DVC_SBJ_ID ON USR_DVC(SBJ_ID);
CREATE INDEX IDX_USR_SUB ON USR(SUB);
CREATE INDEX IDX_USR_EMAIL ON USR(EMAIL);
CREATE INDEX IDX_USR_PHONE_NUMBER ON USR(PHONE_NUMBER);
CREATE INDEX IDX_USR_DVC_FP ON USR_DVC(FP);
CREATE INDEX IDX_USR_APP_CRD_SBJ_ID ON USR_APP_CRD(SBJ_ID);
CREATE INDEX IDX_USR_APP_CRD_APP_ID ON USR_APP_CRD(APP_ID);
CREATE INDEX IDX_USR_TTP_SBJ_ID ON USR_TTP(SBJ_ID);
CREATE INDEX IDX_USR_TTP_ID ON USR_TTP(ID);
CREATE INDEX IDX_USR_HTP_SBJ_ID ON USR_HTP(SBJ_ID);
CREATE INDEX IDX_USR_HTP_ID ON USR_HTP(ID);
CREATE INDEX IDX_USR_DUO_SBJ_ID ON USR_DUO(SBJ_ID);
CREATE INDEX IDX_USR_DUO_EXP ON USR_DUO(EXP_ON);
CREATE INDEX IDX_ACS_LST_SBJ_ID ON ACS_LST(SBJ_ID);
CREATE INDEX IDX_DEV_COD_USR_COD ON DEV_COD(USR_COD);
CREATE INDEX IDX_DEV_COD_EXP_IN ON DEV_COD(EXP_ON);
CREATE INDEX IDX_ACT_STE_EXP_ON ON ACT_STE(EXP_ON);
CREATE INDEX IDX_CFM_REQ_EXP_ON ON CFM_REQ(EXP_ON);
CREATE INDEX IDX_IAT_SFT_ID ON IAT(SFT_ID);
CREATE INDEX IDX_REG_EXP_ON ON REG(EXP_ON);
CREATE INDEX IDX_CLT_SBJ_ID ON CLT(SBJ_ID);

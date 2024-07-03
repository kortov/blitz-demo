-- #2726

CREATE TABLE RAD_STE(
	ID text not null,
	CLT_ID text not null,
	INST_ID text not null,
	SBJ_ID text not null,
	SID text not null,
 	TRACK text[],
	CH_TYPE text not null,
	EXP_ON bigint NOT NULL,
	AUTHR_ID text null,
	ATMPS_LEFT bigint null,
	CODE text null,
	CLT_IP text null,
	TIME bigint NULL
);

INSERT INTO BLITZ_SCHEMA_VERSION (SCRIPT_NAME, DATE) VALUES ('020-5.20.0.sql', LOCALTIMESTAMP(2));

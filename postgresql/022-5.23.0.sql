-- #2958

CREATE TABLE FED_TKN (
    FP_KEY text NOT NULL,
    SID text NOT NULL,
    SBJ_ID text NOT NULL,
    ACS_TKN text NOT NULL,
    ACS_EXP bigint NULL,
    RFR_TKN text NULL,
    CRT_ON bigint NOT NULL,
    EXP_ON bigint NULL,
    CONSTRAINT fed_tkn_pkey PRIMARY KEY (FP_KEY, SID, SBJ_ID)
);

-- #2861
ALTER TABLE fed_acc
ADD COLUMN nam text;

-- #2889

drop table RAD_STE;

CREATE TABLE RAD_STE (
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
 CLT_PORT bigint null,
 REQ_ID bigint null,
 REQ_AUTH text null,
 PAS_ATRS text null,
 TIME bigint null,
 MSG text null,
 ANSW text null
);

INSERT INTO BLITZ_SCHEMA_VERSION (SCRIPT_NAME, DATE) VALUES ('022-5.23.0.sql', LOCALTIMESTAMP(2));

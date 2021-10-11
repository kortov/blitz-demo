-- IB-2048: add USR_AGT table, IB-2154: EXP_ON column
CREATE TABLE USR_AGT (
    ID          text    NOT NULL,
    TP          text    NOT NULL,
    BRO         text,
    DEV         text    NOT NULL,
    DEV_ID      text,
    DEV_TYP     text    NOT NULL,
    OS          text    NOT NULL,
    SBJ_ID      text    NOT NULL,
    LAST_USED   integer NOT NULL,
    LAST_IP     text    NOT NULL,
    TRU         bool    NOT NULL,
    CLI_ID      text,
    CLS         bool    NOT NULL,
    TTL         integer NOT NULL
);
ALTER TABLE USR_AGT ADD CONSTRAINT USR_AGT_ID_PK PRIMARY KEY (ID, SBJ_ID);

DROP TABLE CFM_REC;
CREATE TABLE CFM_REC (
    ID          text    CONSTRAINT CFM_REC_ID_PK PRIMARY key,
    APP_ID      text    NOT NULL,
    OGN         text,
    STE         text    NOT NULL,
    EXP_ON      bigint  NOT NULL /* need idx */
);

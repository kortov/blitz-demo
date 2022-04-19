-- IB-2338

create table WAK (
    KEY_ID  text constraint KEY_ID_PK PRIMARY key,
    NAM     text not null,
    SBJ_ID  text not null,
    USR_HDL text not null,
    PK      text not null,
    AAGUIDE text,
    IS_UV   bool not null,
    ATT_MOD text not null,
    CNT     bigint not null,
    ADDED   bigint not null,
    ADD_ON_UA   text,
    LU      bigint,
    LU_ON_IP    text,
    LU_ON_UA    text
);

CREATE INDEX IDX_WAK_SBJ_ID ON WAK(SBJ_ID);
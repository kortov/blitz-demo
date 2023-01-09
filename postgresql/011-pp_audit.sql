-- IB-2458: add pp_audit

CREATE TABLE PP_AUDIT (
    ID     text    constraint PP_AUDIT_ID_PK PRIMARY key,
    IDX    integer NOT NULL,
    TTL    integer NOT NULL
);
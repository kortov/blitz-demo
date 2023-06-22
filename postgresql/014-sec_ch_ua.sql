-- IB-2583: add columns for Sec-CH-UA

ALTER TABLE WAK
    ADD COLUMN add_on_ch_ua text NULL,
    ADD COLUMN add_on_ch_pl text NULL,
    ADD COLUMN add_on_ch_pl_ver text NULL,
    ADD COLUMN lu_on_ch_ua text NULL,
    ADD COLUMN lu_on_ch_pl text NULL,
    ADD COLUMN lu_on_ch_pl_ver text NULL;

ALTER TABLE AUD
    ADD COLUMN ch_ua text NULL,
    ADD COLUMN ch_pl text NULL,
    ADD COLUMN ch_pl_ver text NULL;

INSERT INTO BLITZ_SCHEMA_VERSION (SCRIPT_NAME, DATE) VALUES ('014-sec_ch_ua.sql', LOCALTIMESTAMP(2));

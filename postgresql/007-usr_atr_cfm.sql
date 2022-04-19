-- IB-2283

CREATE TABLE usr_atr_cfm (
	sbj_id varchar(1024) NOT NULL,
	atr varchar(1024) NOT NULL,
	cfm_on int8 NOT NULL,
	CONSTRAINT usr_atr_cfm_pk PRIMARY KEY (sbj_id, atr)
);
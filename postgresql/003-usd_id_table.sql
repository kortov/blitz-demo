-- IB-2089: user id store
CREATE TABLE usd_id (
	sbj_id varchar(1024) NOT NULL,
	exp_on int8 NOT NULL,
	CONSTRAINT usd_id_pk PRIMARY KEY (sbj_id)
);
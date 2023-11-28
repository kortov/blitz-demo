-- #2741

ALTER TABLE acs_tkn
ADD COLUMN iat int8,
ADD COLUMN exp_on int8;
UPDATE acs_tkn SET iat=extract(epoch from now() at time zone 'utc') WHERE exp_on IS NULL;
UPDATE acs_tkn SET exp_on=iat+ttl WHERE exp_on IS NULL;

ALTER TABLE acs_tkn
ALTER COLUMN iat SET NOT NULL,
ALTER COLUMN exp_on SET NOT NULL,
ALTER COLUMN ttl DROP NOT NULL;

CREATE OR REPLACE FUNCTION force_acs_tkn_defaults() RETURNS trigger AS $$
BEGIN

    IF (NEW.EXP_ON IS NOT NULL AND NEW.IAT IS NOT NULL AND NEW.TTL IS NULL)    THEN
        NEW.TTL = NEW.EXP_ON - NEW.IAT;
    ELSE
        IF(NEW.TTL IS NOT NULL AND NEW.EXP_ON IS NULL AND NEW.IAT IS NULL ) THEN
            NEW.IAT = extract(epoch from now() at time zone 'utc');
            NEW.EXP_ON = NEW.IAT + NEW.TTL;
        END IF;
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE 'plpgsql';

CREATE TRIGGER acs_tkn_exp_migration_trigger BEFORE INSERT ON acs_tkn FOR EACH ROW EXECUTE PROCEDURE force_acs_tkn_defaults();

ALTER TABLE rfr_tkn
ADD COLUMN iat int8 NOT NULL default extract(epoch from now() at time zone 'utc');

-- #2679

ALTER TABLE acs_tkn
ADD COLUMN act text,
ADD COLUMN aud text[];

INSERT INTO BLITZ_SCHEMA_VERSION (SCRIPT_NAME, DATE) VALUES ('019-5.18.0.sql', LOCALTIMESTAMP(2));


-- IB-2601: Add blitz schema versioning 																															

CREATE TABLE IF NOT EXISTS BLITZ_SCHEMA_VERSION (
   ID            SERIAL PRIMARY KEY,
   SCRIPT_NAME   VARCHAR,
   DATE          TIMESTAMP WITH TIME ZONE
);

-- Revert awesome:languages from pg

BEGIN;

DROP TABLE IF EXISTS api.languages;

COMMIT;

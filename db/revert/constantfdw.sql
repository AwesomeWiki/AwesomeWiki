-- Revert awesome:constantfdw from pg

BEGIN;

DROP FOREIGN TABLE IF EXISTS api.constant;

DROP SERVER IF EXISTS awesome_constant;

COMMIT;

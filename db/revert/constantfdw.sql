-- Revert awesome:constantfdw from pg

BEGIN;

DROP FOREIGN TABLE api.constant;

DROP SERVER awesome_constant;

COMMIT;

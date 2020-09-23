-- Revert awesome:python from pg

BEGIN;

DROP FOREIGN TABLE api.awesome_python;

DROP SERVER awesome_list;

COMMIT;

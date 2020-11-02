-- Revert awesome:python from pg

BEGIN;

DROP FOREIGN TABLE IF EXISTS api.awesome_python_categories;
DROP FOREIGN TABLE IF EXISTS api.awesome_python;
DROP FOREIGN TABLE IF EXISTS api.python_package;

DROP SERVER IF EXISTS python_package;

COMMIT;

-- Revert awesome:javascript from pg

BEGIN;

DROP FOREIGN TABLE IF EXISTS api.awesome_javascript_categories;
DROP FOREIGN TABLE IF EXISTS api.awesome_javascript;
DROP FOREIGN TABLE IF EXISTS api.javascript_package;

DROP SERVER IF EXISTS javascript_package;

COMMIT;

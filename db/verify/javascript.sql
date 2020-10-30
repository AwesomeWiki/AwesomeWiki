-- Verify awesome:javascript on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.awesome_javascript', 'select');

ROLLBACK;

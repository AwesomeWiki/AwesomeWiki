-- Verify awesome:python on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.awesome_python', 'select');

ROLLBACK;

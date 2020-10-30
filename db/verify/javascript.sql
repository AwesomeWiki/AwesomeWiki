-- Verify awesome:languages on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.languages', 'select');

ROLLBACK;

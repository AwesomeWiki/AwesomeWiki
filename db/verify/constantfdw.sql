-- Verify awesome:constantfdw on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.constant', 'select');

ROLLBACK;

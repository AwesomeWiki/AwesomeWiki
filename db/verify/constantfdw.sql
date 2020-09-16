-- Verify awesome:constantfdw on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege('api.constant', 'usage');

ROLLBACK;

-- Verify awesome:python on pg

BEGIN;

SELECT pg_catalog.has_schema_privilege('api.awesome_python', 'usage');

ROLLBACK;

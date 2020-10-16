-- Verify awesome:articles on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.articles', 'select');

ROLLBACK;

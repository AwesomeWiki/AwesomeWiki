-- Verify awesome:awesome on pg

BEGIN;

SELECT pg_catalog.has_server_privilege('awesome_list', 'usage');
SELECT pg_catalog.has_server_privilege('awesome_list_categories', 'usage');

ROLLBACK;

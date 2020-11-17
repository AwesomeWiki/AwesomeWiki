-- Verify awesome:languages on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.languages', 'select');


SELECT slug from api.languages;

SELECT name from api.languages;


DO $$
DECLARE
    n varchar;
    s varchar;
BEGIN
   n := (SELECT name FROM api.languages WHERE slug = 'javascript');
   ASSERT n = 'JavaScript';
   s := (SELECT slug FROM api.languages WHERE name = 'Python');
   ASSERT s = 'python';
END $$;


ROLLBACK;

-- Verify awesome:python on pg

-- BEGIN;

SELECT pg_catalog.has_table_privilege('api.awesome_python', 'select');

SELECT pg_catalog.has_table_privilege('api.awesome_python_categories', 'select');

SELECT category_slug from api.awesome_python;

SELECT name from api.awesome_python;

SELECT url from api.awesome_python;

SELECT name from api.awesome_python_categories;

SELECT slug from api.awesome_python_categories;


DO $$
DECLARE
    n varchar;
    u varchar;
    category varchar;
    num int;
BEGIN
   n := (SELECT name FROM api.awesome_python WHERE url = 'https://github.com/ajenti/ajenti');
   ASSERT n = 'ajenti';
   u := (SELECT url FROM api.awesome_python WHERE name = 'trio');
   ASSERT u = 'https://github.com/python-trio/trio';
   category := (SELECT category_slug FROM api.awesome_python WHERE url = 'https://github.com/lepture/authlib');
   ASSERT category = 'authentication';
   n := (SELECT name FROM api.awesome_python WHERE category_slug  = 'cms' AND url = 'https://github.com/feincms/feincms');
   ASSERT n = 'feincms';
   u := (SELECT url FROM api.awesome_python WHERE name = 'django-cache-machine' AND category_slug = 'caching');
   ASSERT u = 'https://github.com/django-cache-machine/django-cache-machine';
   category := (SELECT category_slug FROM api.awesome_python WHERE name = 'pylint' AND url = 'https://www.pylint.org/');
   ASSERT category = 'code-analysis';
   num := (SELECT COUNT(*) FROM api.awesome_python WHERE category_slug = 'code-analysis');
   ASSERT num = 18;
END $$;


DO $$
DECLARE
    n varchar;
    s varchar;
BEGIN
   n := (SELECT name FROM api.awesome_python_categories WHERE slug = 'admin-panels');
   ASSERT n = 'Admin Panels';
   s := (SELECT slug FROM api.awesome_python_categories WHERE name = 'Built-in Classes Enhancement');
   ASSERT s = 'built-in-classes-enhancement';
END $$;

-- ROLLBACK;

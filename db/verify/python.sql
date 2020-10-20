-- Verify awesome:python on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.awesome_python', 'select');

SELECT category_slug from api.awesome_python;

SELECT name from api.awesome_python;

SELECT fqn from api.awesome_python;

SELECT url from api.awesome_python;


DO $$
DECLARE
    n varchar;
    u varchar;
    f varchar;
    category varchar;
    num int;
BEGIN
   n := (SELECT name FROM api.awesome_python WHERE url = 'https://github.com/ajenti/ajenti');
   ASSERT n = 'ajenti';
   u := (SELECT url FROM api.awesome_python WHERE name = 'trio');
   ASSERT u = 'https://github.com/python-trio/trio';
   category := (SELECT category_slug FROM api.awesome_python WHERE url = 'https://github.com/lepture/authlib');
   ASSERT category = 'authentication';
   f := (SELECT fqn FROM api.awesome_python WHERE url = 'https://github.com/prabhupant/python-ds');
   ASSERT f = 'python-ds';
   n := (SELECT name FROM api.awesome_python WHERE category_slug  = 'cms' AND url = 'https://github.com/feincms/feincms');
   ASSERT n = 'feincms';
   u := (SELECT url FROM api.awesome_python WHERE name = 'django-cache-machine' AND category_slug = 'caching');
   ASSERT u = 'https://github.com/django-cache-machine/django-cache-machine';
   f := (SELECT fqn FROM api.awesome_python WHERE name = 'eyeD3' AND category_slug = 'audio');
   ASSERT f = 'eyed3';
   category := (SELECT category_slug FROM api.awesome_python WHERE name = 'pylint' AND url = 'https://www.pylint.org/');
   ASSERT category = 'code-analysis';
   num := (SELECT COUNT(*) FROM api.awesome_python WHERE category_slug = 'code-analysis');
   ASSERT num = 18;
END $$;


SELECT pg_catalog.has_table_privilege('api.awesome_python_categories', 'select');

SELECT name from api.awesome_python_categories;

SELECT slug from api.awesome_python_categories;

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



SELECT pg_catalog.has_table_privilege('api.python_package', 'select');


DO $$
DECLARE
    n varchar;
    u varchar;
    s varchar;
    author varchar;
    author_email varchar;
BEGIN
   n := (SELECT name from api.python_package where fqn = 'ajenti');
   ASSERT n = 'ajenti';
   u := (SELECT url FROM api.python_package WHERE fqn = 'trio');
   ASSERT u = 'https://github.com/python-trio/trio';
   s := (SELECT category_slug FROM api.python_package WHERE fqn = 'authlib');
   ASSERT s = 'authentication';
   n := (SELECT name FROM api.python_package WHERE fqn  = 'feincms' AND url = 'https://github.com/feincms/feincms');
   ASSERT n = 'feincms';
   u := (SELECT url FROM api.python_package WHERE fqn = 'django-cache-machine' AND category_slug = 'caching');
   ASSERT u = 'https://github.com/django-cache-machine/django-cache-machine';
   author := (SELECT metadata -> 'info' ->> 'author' AS author  from api.python_package where fqn = 'pylint');
   ASSERT author = 'Python Code Quality Authority';
   author_email := (SELECT metadata  -> 'info' ->> 'author_email' AS email  from api.python_package where fqn = 'pylint');
   ASSERT author_email = 'code-quality@python.org';
   -- Testing Gray's code
   author := (SELECT metadata -> 'info' ->> 'author' AS author  from api.python_package where fqn = 'nude-py');
   ASSERT author = 'Hideo Hattori';
   author_email := (SELECT metadata  -> 'info' ->> 'author_email' AS email  from api.python_package where fqn = 'vcr-py');
   ASSERT author_email = 'me@kevinmccarthy.org';


END $$;

ROLLBACK;

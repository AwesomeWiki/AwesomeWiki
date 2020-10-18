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


SELECT pg_catalog.has_table_privilege('api.awesome_python', 'select');

SELECT pg_catalog.has_table_privilege('api.awesome_python', 'select');

SELECT category_slug from api.awesome_python;

SELECT name from api.awesome_python;

SELECT fqn from api.awesome_python;

SELECT url from api.awesome_python;


DO $$
DECLARE
    n varchar;
    u varchar;
    s varchar;
    i varchar;
    author varchar;
    author_email varchar;
BEGIN
   n := (SELECT name from api.python_package where fqn = 'ajenti');
   ASSERT n = 'ajenti';
   u := (SELECT url FROM api.python_package WHERE fqn = 'trio');
   ASSERT u = 'https://github.com/python-trio/trio';
   s := (SELECT category_slug FROM api.python_package WHERE fqn = 'authlib');
   ASSERT s = 'authentication';
    i := (SELECT info ->> 'info' AS info  from api.python_package where fqn = 'ajenti');
    ASSERT i = '{"author": "Eugeny Pankov", "author_email": "e@ajenti.org", "bugtrack_url": null, "classifiers": [], "description": "", "description_content_type": null, "docs_url": null, "download_url": "", "downloads": {"last_day": -1, "last_month": -1, "last_week": -1}, "home_page": "http://ajenti.org/", "keywords": "", "license": "", "maintainer": "", "maintainer_email": "", "name": "ajenti", "package_url": "https://pypi.org/project/ajenti/", "platform": "", "project_url": "https://pypi.org/project/ajenti/", "project_urls": {"Homepage": "http://ajenti.org/"}, "release_url": "https://pypi.org/project/ajenti/1.2.23.13/", "requires_dist": null, "requires_python": "", "summary": "The server administration panel", "version": "1.2.23.13", "yanked": false, "yanked_reason": null}';
   n := (SELECT name FROM api.python_package WHERE fqn  = 'feincms' AND url = 'https://github.com/feincms/feincms');
   ASSERT n = 'feincms';
   u := (SELECT url FROM api.python_package WHERE fqn = 'django-cache-machine' AND category_slug = 'caching');
   ASSERT u = 'https://github.com/django-cache-machine/django-cache-machine';
   i := (SELECT info ->> 'info' AS info  from api.python_package where fqn = 'ajenti' and name = 'ajenti');
   ASSERT  i = '{"author": "Eugeny Pankov", "author_email": "e@ajenti.org", "bugtrack_url": null, "classifiers": [], "description": "", "description_content_type": null, "docs_url": null, "download_url": "", "downloads": {"last_day": -1, "last_month": -1, "last_week": -1}, "home_page": "http://ajenti.org/", "keywords": "", "license": "", "maintainer": "", "maintainer_email": "", "name": "ajenti", "package_url": "https://pypi.org/project/ajenti/", "platform": "", "project_url": "https://pypi.org/project/ajenti/", "project_urls": {"Homepage": "http://ajenti.org/"}, "release_url": "https://pypi.org/project/ajenti/1.2.23.13/", "requires_dist": null, "requires_python": "", "summary": "The server administration panel", "version": "1.2.23.13", "yanked": false, "yanked_reason": null}';
   author := (SELECT info -> 'info' ->> 'author' AS author  from api.python_package where fqn = 'pylint');
   ASSERT author = 'Python Code Quality Authority';
   author_email := (SELECT info -> 'info' ->> 'author_email' AS author  from api.python_package where fqn = 'pylint');
   ASSERT author = 'code-quality@python.org';
END $$;

ROLLBACK;

-- Verify awesome:javascript on pg

BEGIN;

SELECT pg_catalog.has_table_privilege('api.awesome_javascript', 'select');

SELECT category_slug from api.awesome_javascript;

SELECT name from api.awesome_javascript;

SELECT fqn from api.awesome_javascript;

SELECT url from api.awesome_javascript;


DO $$
DECLARE
    n varchar;
    u varchar;
    f varchar;
    category varchar;
    num int;
BEGIN
   n := (SELECT name FROM api.awesome_javascript WHERE url = 'https://github.com/jquery/qunit');
   ASSERT n = 'qunit';
   u := (SELECT url FROM api.awesome_javascript WHERE name = 'mocha');
   ASSERT u = 'https://github.com/mochajs/mocha';
   category := (SELECT category_slug FROM api.awesome_javascript WHERE url = 'https://github.com/avajs/ava');
   ASSERT category = 'frameworks';
   f := (SELECT fqn FROM api.awesome_javascript WHERE url = 'https://github.com/DevExpress/testcafe');
   ASSERT f = 'testcafe';
   n := (SELECT name FROM api.awesome_javascript WHERE category_slug  = 'assertion' AND url = 'https://github.com/thlorenz/proxyquire');
   ASSERT n = 'proxyquire';
   u := (SELECT url FROM api.awesome_javascript WHERE name = 'DalekJS' AND category_slug = 'frameworks');
   ASSERT u = 'https://github.com/dalekjs/dalek';
   f := (SELECT fqn FROM api.awesome_javascript WHERE name = 'yolpo' AND category_slug = 'runner');
   ASSERT f = 'yolpo';
   category := (SELECT category_slug FROM api.awesome_javascript WHERE name = 'webdriverio' AND url = 'https://github.com/webdriverio/webdriverio');
   ASSERT category = 'runner';
   num := (SELECT COUNT(*) FROM api.awesome_javascript WHERE category_slug = 'qa-tools');
   ASSERT num = 10;
END $$;


SELECT pg_catalog.has_table_privilege('api.awesome_javascript_categories', 'select');

SELECT name from api.awesome_javascript_categories;

SELECT slug from api.awesome_javascript_categories;

DO $$
DECLARE
    n varchar;
    s varchar;
BEGIN
   n := (SELECT name FROM api.awesome_javascript_categories WHERE slug = 'benchmark');
   ASSERT n = 'Benchmark';
   s := (SELECT slug FROM api.awesome_javascript_categories WHERE name = 'Files');
   ASSERT s = 'files';
END $$;



SELECT pg_catalog.has_table_privilege('api.javascript_package', 'select');


DO $$
DECLARE
    n varchar;
    u varchar;
    s varchar;
    d varchar;
BEGIN
   n := (SELECT name from api.javascript_package where fqn = 'bower');
   ASSERT n = 'Bower';
   u := (SELECT url FROM api.javascript_package WHERE fqn = 'seajs');
   ASSERT u = 'https://github.com/seajs/seajs';
   s := (SELECT category_slug FROM api.javascript_package WHERE fqn = 'modulejs');
   ASSERT s = 'loaders';
   n := (SELECT name FROM api.javascript_package WHERE fqn  = 'headjs' AND url = 'https://github.com/headjs/headjs');
   ASSERT n = 'HeadJS';
   u := (SELECT url FROM api.javascript_package WHERE fqn = 'bit' AND category_slug = 'component-managment');
   ASSERT u = 'https://github.com/teambit/bit';
--    d := (select metadata -> 'collected' -> 'metadata' ->> 'description' AS de  from api.javascript_package where fqn = 'npm');
--    ASSERT d = 'a package manager for JavaScript';
   -- Testing Gray's code
--    author := (select metadata -> 'collected' -> 'metadata' ->> 'description' AS description  from api.javascript_package where fqn = 'npm';);
--    ASSERT author = 'Hideo Hattori';
--    author_email := (SELECT metadata  -> 'info' ->> 'author_email' AS email  from api.javascript_package where fqn = 'vcr-py');
--    ASSERT author_email = 'me@kevinmccarthy.org';
END $$;

ROLLBACK;

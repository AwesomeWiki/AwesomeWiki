-- Revert awesome:articles from pg

BEGIN;

DROP FOREIGN TABLE IF EXISTS api.articles;

DROP SERVER IF EXISTS articles_hn;

COMMIT;

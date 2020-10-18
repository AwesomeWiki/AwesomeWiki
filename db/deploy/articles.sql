-- Deploy awesome:articles to pg

BEGIN;

CREATE SERVER IF NOT EXISTS articles_hn FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.articles.HackerNews'
);

CREATE FOREIGN TABLE IF NOT EXISTS api.articles (
    "language" CHARACTER VARYING,
    "fqn" CHARACTER VARYING,
    "title" CHARACTER VARYING,
    "url" CHARACTER VARYING
) SERVER articles_hn;

GRANT SELECT ON api.articles TO web_anon;

COMMIT;

-- Deploy awesome:javascript to pg

BEGIN;

-- CREATE SERVER IF NOT EXISTS awesome_list FOREIGN DATA WRAPPER multicorn OPTIONS (
--     wrapper 'awesome.alist.ForeignDataWrapper'
-- );

-- CREATE SERVER IF NOT EXISTS awesome_list_categories FOREIGN DATA WRAPPER multicorn OPTIONS (
--     wrapper 'awesome.alist.Categories'
-- );

CREATE SERVER IF NOT EXISTS javascript_package FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.javascript.Package'
);

CREATE FOREIGN TABLE IF NOT EXISTS api.awesome_javascript (
    "category_slug" CHARACTER VARYING,
    "name" CHARACTER VARYING,
    "fqn" CHARACTER VARYING,
    "url" CHARACTER VARYING,
    "description" CHARACTER VARYING
) SERVER awesome_list OPTIONS (
    repo 'sorrycc/awesome-javascript'
);

CREATE FOREIGN TABLE IF NOT EXISTS api.awesome_javascript_categories (
    "name" CHARACTER VARYING,
    "slug" CHARACTER VARYING
) SERVER awesome_list_categories OPTIONS (
    repo 'sorrycc/awesome-javascript'
);

CREATE FOREIGN TABLE IF NOT EXISTS api.javascript_package (
    "category_slug" CHARACTER VARYING,
    "name" CHARACTER VARYING,
    "fqn" CHARACTER VARYING,
    "url" CHARACTER VARYING,
    "metadata" JSON 
) SERVER javascriptgit _package OPTIONS (
    repo 'sorrycc/awesome-javascript'
);

GRANT SELECT ON api.awesome_javascript TO web_anon;
GRANT SELECT ON api.awesome_javascript_categories TO web_anon;
GRANT SELECT ON api.javascript_package TO web_anon;

COMMIT;
-- Deploy awesome:python to pg

BEGIN;

CREATE SERVER IF NOT EXISTS awesome_list FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.alist.ForeignDataWrapper'
);

CREATE SERVER IF NOT EXISTS awesome_list_categories FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.alist.Categories'
);

CREATE SERVER IF NOT EXISTS python_package FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.python.Package'
);

CREATE FOREIGN TABLE IF NOT EXISTS api.awesome_python (
    "category_slug" CHARACTER VARYING,
    "name" CHARACTER VARYING,
    "fqn" CHARACTER VARYING,
    "url" CHARACTER VARYING,
    "description" CHARACTER VARYING
) SERVER awesome_list OPTIONS (
    repo 'vinta/awesome-python'
);

CREATE FOREIGN TABLE IF NOT EXISTS api.awesome_python_categories (
    "name" CHARACTER VARYING,
    "slug" CHARACTER VARYING
) SERVER awesome_list_categories OPTIONS (
    repo 'vinta/awesome-python'
);

CREATE FOREIGN TABLE IF NOT EXISTS api.python_package (
    "category_slug" CHARACTER VARYING,
    "name" CHARACTER VARYING,
    "fqn" CHARACTER VARYING,
    "url" CHARACTER VARYING,
    "metadata" JSON 
) SERVER python_package OPTIONS (
    repo 'vinta/awesome-python'
);

GRANT SELECT ON api.awesome_python TO web_anon;
GRANT SELECT ON api.awesome_python_categories TO web_anon;
GRANT SELECT ON api.python_package TO web_anon;

COMMIT;

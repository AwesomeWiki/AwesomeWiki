-- Deploy awesome:python to pg

BEGIN;

CREATE SERVER awesome_list FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.alist.ForeignDataWrapper'
);

CREATE SERVER awesome_list_categories FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.alist.Categories'
);

CREATE FOREIGN TABLE api.awesome_python (
    "category_slug" CHARACTER VARYING,
    "name" CHARACTER VARYING,
    "fqn" CHARACTER VARYING,
    "url" CHARACTER VARYING
) SERVER awesome_list OPTIONS (
    repo 'vinta/awesome-python'
);

CREATE FOREIGN TABLE api.awesome_python_categories (
    "name" CHARACTER VARYING,
    "slug" CHARACTER VARYING
) SERVER awesome_list_categories OPTIONS (
    repo 'vinta/awesome-python'
);

GRANT SELECT ON api.awesome_python TO web_anon;
GRANT SELECT ON api.awesome_python_categories TO web_anon;

COMMIT;

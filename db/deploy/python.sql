-- Deploy awesome:python to pg

BEGIN;

CREATE SERVER awesome_list FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.list.ForeignDataWrapper'
);

CREATE FOREIGN TABLE api.awesome_python (
    "category_name" CHARACTER VARYING,
    "name" CHARACTER VARYING,
    "url" CHARACTER VARYING
) SERVER awesome_list OPTIONS (
    repo 'vinta/awesome-python'
);

GRANT SELECT ON api.awesome_python TO web_anon;

COMMIT;

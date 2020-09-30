-- Deploy awesome:constantfdw to pg

BEGIN;

CREATE SERVER awesome_constant FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.constant.ForeignDataWrapper'
);

CREATE FOREIGN TABLE api.constant (
    test CHARACTER VARYING,
    test2 CHARACTER VARYING
) SERVER awesome_constant;

GRANT SELECT ON api.constant TO web_anon;

COMMIT;

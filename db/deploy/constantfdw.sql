-- Deploy awesome:constantfdw to pg

BEGIN;

CREATE SERVER awesome_constant FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.ConstantForeignDataWrapper'
);

CREATE FOREIGN TABLE api.constant (
    test CHARACTER VARYING,
    test2 CHARACTER VARYING
) SERVER awesome_constant;

COMMIT;

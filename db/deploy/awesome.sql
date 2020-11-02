-- Deploy awesome:awesome to pg

BEGIN;

CREATE SERVER IF NOT EXISTS awesome_list FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.alist.ForeignDataWrapper'
);

CREATE SERVER IF NOT EXISTS awesome_list_categories FOREIGN DATA WRAPPER multicorn OPTIONS (
    wrapper 'awesome.alist.Categories'
);

COMMIT;

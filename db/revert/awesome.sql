-- Revert awesome:awesome from pg

BEGIN;

DROP SERVER IF EXISTS awesome_list_categories;
DROP SERVER IF EXISTS awesome_list;

COMMIT;

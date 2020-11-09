-- Deploy awesome:languages to pg

BEGIN;

CREATE TABLE IF NOT EXISTS api.languages (
    slug CHARACTER VARYING,
    name CHARACTER VARYING,
    PRIMARY KEY (slug)
);

INSERT INTO api.languages (slug, name) VALUES ('python', 'Python') ON CONFLICT DO NOTHING;
INSERT INTO api.languages (slug, name) VALUES ('javascript', 'JavaScript') ON CONFLICT DO NOTHING;
GRANT SELECT ON api.languages TO web_anon;

COMMIT;

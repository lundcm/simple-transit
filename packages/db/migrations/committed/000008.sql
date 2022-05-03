--! Previous: sha1:c6f659c41bb8b32dd6f3a45dbd1bc12b6b58e8b0
--! Hash: sha1:6d9f8b3c38d864435f9d7aa2d3b65ebc3c1cccde

BEGIN;

ALTER TABLE tl_route_headways DROP CONSTRAINT fk_rails_078ffc5894;
ALTER TABLE tl_route_headways DROP COLUMN service_id;

COMMIT;

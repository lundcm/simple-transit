--! Previous: sha1:8ca5ec7000e7a9cbc536ed088d7ee1d236ac4e8c
--! Hash: sha1:bdb68b7a14e49e27aaf35688a29e499636b87111

BEGIN;

alter table feed_version_gtfs_imports add column schedule_removed bool not null default false;

COMMIT;

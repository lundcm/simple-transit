--! Previous: sha1:f1e7445e29bbb33cca55c1d1c86b3d402c090e7a
--! Hash: sha1:703d3eff60b5a2903b4c3e24220c8dea024ab603

-- Updating the metro transit feed so it's not ftp
update app_public.location_feed
set gtfs_static = 'https://resources.gisdata.mn.gov/pub/gdrs/data/pub/us_mn_state_metc/trans_transit_schedule_google_fd/csv_trans_transit_schedule_google_fd.zip'
where name = 'Metro Transit';

/* @name AddLocationFeedDownload */
insert into app_public.location_feed_download (location_feed_id,
                                               download_date,
                                               rows_read,
                                               failure)
values (:location_feed_id,
        :download_date,
        :rows_read,
        :failure);
/* @name UpdateLocationFeedDownload */
update app_public.location_feed_download
set rows_read = coalesce(rows_read, jsonb_build_object()) || jsonb_build_object(:table::text, :count::int),
    status    = coalesce(status, jsonb_build_object()) || jsonb_build_object(:table::text, :status::text)
where location_feed_id = :location_feed_id
  and download_date = :download_date;

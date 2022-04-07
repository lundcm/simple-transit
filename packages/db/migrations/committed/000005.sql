--! Previous: sha1:d75bb87303328c210a96f0b312e794f3ab2ef928
--! Hash: sha1:08d0466ddfb813fc74e59c0a60037b3457cb532d

drop table if exists app_public.location_feed_download;

create table app_public.location_feed_download
(
    id               uuid                     default gen_random_uuid() not null
        constraint location_feed_download_pkey primary key,
    location_feed_id uuid
        constraint fk_location_feed_id references app_public.location_feed on delete cascade,
    download_date    timestamp with time zone default now()             not null,
    rows_read        jsonb,
    rows_in_table    jsonb,
    status           jsonb,
    failure          jsonb,
    created_at       timestamp with time zone default now()             not null,
    updated_at       timestamp with time zone default now()             not null
);

alter table app_public.location_feed_download
    enable row level security;
create policy select_all on app_public.location_feed_download for select using (true);
grant select on app_public.location_feed_download to :DATABASE_VISITOR;

create index idx_location_feed_download_location_feed_id on app_public.location_feed_download (location_feed_id);

create trigger _100_timestamps
    before insert or update
    on app_public.location_feed_download
    for each row
execute procedure app_private.tg__timestamps();

-- Add audit functions
create or replace function app_hidden.audit_agency(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) || jsonb_build_object('agency', (select count(1)
                                                                                                   from app_hidden.agency
                                                                                                   where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

create or replace function app_hidden.audit_calendar(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) || jsonb_build_object('calendar', (select count(1)
                                                                                                     from app_hidden.calendar
                                                                                                     where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

create or replace function app_hidden.audit_calendar_dates(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) ||
                    jsonb_build_object('calendar_dates', (select count(1)
                                                          from app_hidden.calendar_dates
                                                          where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

create or replace function app_hidden.audit_routes(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) ||
                    jsonb_build_object('routes', (select count(1)
                                                  from app_hidden.routes
                                                  where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

create or replace function app_hidden.audit_shapes(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) ||
                    jsonb_build_object('shapes', (select count(1)
                                                  from app_hidden.shapes
                                                  where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

create or replace function app_hidden.audit_stop_times(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) ||
                    jsonb_build_object('stop_times', (select count(1)
                                                      from app_hidden.stop_times
                                                      where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

create or replace function app_hidden.audit_stops(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) ||
                    jsonb_build_object('stops', (select count(1)
                                                 from app_hidden.stops
                                                 where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

create or replace function app_hidden.audit_trips(location uuid, download timestamp with time zone) returns void
as
$$
update app_public.location_feed_download
set rows_in_table = coalesce(rows_in_table, jsonb_build_object()) ||
                    jsonb_build_object('trips', (select count(1)
                                                 from app_hidden.trips
                                                 where location_feed_id = location))
where location_feed_id = location
  and download_date = download;
$$ language sql;

-- Add RLS to the app_hidden tables
alter table app_hidden.agency
    enable row level security;
drop policy if exists select_all on app_hidden.agency;
create policy select_all on app_hidden.agency for select using (true);

alter table app_hidden.calendar
    enable row level security;
drop policy if exists select_all on app_hidden.calendar;
create policy select_all on app_hidden.calendar for select using (true);

alter table app_hidden.calendar_dates
    enable row level security;
drop policy if exists select_all on app_hidden.calendar_dates;
create policy select_all on app_hidden.calendar_dates for select using (true);

alter table app_hidden.routes
    enable row level security;
drop policy if exists select_all on app_hidden.routes;
create policy select_all on app_hidden.routes for select using (true);

alter table app_hidden.shapes
    enable row level security;
drop policy if exists select_all on app_hidden.shapes;
create policy select_all on app_hidden.shapes for select using (true);

alter table app_hidden.stop_times
    enable row level security;
drop policy if exists select_all on app_hidden.stop_times;
create policy select_all on app_hidden.stop_times for select using (true);

alter table app_hidden.stops
    enable row level security;
drop policy if exists select_all on app_hidden.stops;
create policy select_all on app_hidden.stops for select using (true);

alter table app_hidden.trips
    enable row level security;
drop policy if exists select_all on app_hidden.trips;
create policy select_all on app_hidden.trips for select using (true);

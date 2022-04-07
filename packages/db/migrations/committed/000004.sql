--! Previous: sha1:703d3eff60b5a2903b4c3e24220c8dea024ab603
--! Hash: sha1:d75bb87303328c210a96f0b312e794f3ab2ef928

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='agency' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.agency rename column feed_region_id to location_feed_id;
        END IF;
    END $$;

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='calendar' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.calendar rename column feed_region_id to location_feed_id;
        END IF;
    END $$;

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='calendar_dates' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.calendar_dates rename column feed_region_id to location_feed_id;
        END IF;
    END $$;

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='routes' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.routes rename column feed_region_id to location_feed_id;
        END IF;
    END $$;

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='shapes' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.shapes rename column feed_region_id to location_feed_id;
        END IF;
    END $$;

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='stop_times' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.stop_times rename column feed_region_id to location_feed_id;
        END IF;
    END $$;

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='stops' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.stops rename column feed_region_id to location_feed_id;
        END IF;
    END $$;

DO $$
    BEGIN
        IF EXISTS(
                select *
                from information_schema.columns
                where table_schema='app_hidden' and table_name='trips' and column_name='feed_region_id'
            )
        THEN
            alter table app_hidden.trips rename column feed_region_id to location_feed_id;
        END IF;
    END $$;


alter table app_hidden.agency alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.agency drop constraint if exists agency_pkey;
create unique index if not exists idx_agency_location_feed_agency_id on app_hidden.agency(location_feed_id, agency_id);
alter table app_hidden.agency add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.agency add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.agency drop column if exists created_at;

alter table app_hidden.calendar alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.calendar drop constraint if exists calendar_pkey;
create unique index if not exists idx_calendar_location_feed_service_id on app_hidden.calendar(location_feed_id, service_id);
alter table app_hidden.calendar add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.calendar add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.calendar drop column if exists created_at;

alter table app_hidden.calendar_dates alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.calendar_dates drop constraint if exists calendar_dates_pkey;
create unique index if not exists idx_calendar_dates_location_feed_service_id_date on app_hidden.calendar_dates(location_feed_id, service_id, date);
alter table app_hidden.calendar_dates add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.calendar_dates add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.calendar_dates drop column if exists created_at;

alter table app_hidden.routes alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.routes drop constraint if exists routes_pkey;
create unique index if not exists idx_routes_location_feed_route_id_agency_id on app_hidden.routes(location_feed_id, route_id, agency_id);
alter table app_hidden.routes add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.routes add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.routes drop column if exists created_at;

alter table app_hidden.shapes alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.shapes drop constraint if exists shapes_pkey;
create unique index if not exists idx_shapes_location_feed_shape_id_shape_pt_sequence on app_hidden.shapes(location_feed_id, shape_id, shape_pt_sequence);
alter table app_hidden.shapes add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.shapes add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.shapes drop column if exists created_at;

alter table app_hidden.stop_times alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.stop_times drop constraint if exists stop_times_pkey;
create unique index if not exists idx_stop_times_location_feed_trip_id_stop_id_stop_sequence on app_hidden.stop_times(location_feed_id, trip_id, stop_id, stop_sequence);
alter table app_hidden.stop_times add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.stop_times add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.stop_times drop column if exists created_at;

alter table app_hidden.stops alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.stops drop constraint if exists stops_pkey;
create unique index if not exists idx_stops_location_feed_stop_id on app_hidden.stops(location_feed_id, stop_id);
alter table app_hidden.stops add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.stops add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.stops drop column if exists created_at;

alter table app_hidden.trips alter column location_feed_id type uuid using gen_random_uuid()::uuid;
alter table app_hidden.trips drop constraint if exists trips_pkey;
create unique index if not exists idx_trips_location_feed_trip_id on app_hidden.trips(location_feed_id, trip_id);
alter table app_hidden.trips add column if not exists id uuid primary key default gen_random_uuid();
alter table app_hidden.trips add column if not exists download_date timestamptz default current_timestamp;
alter table app_hidden.trips drop column if exists created_at;

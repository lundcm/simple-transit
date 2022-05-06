--! Previous: sha1:4f2b1f1c40fd2245fa13f9d2e2aeabf38240ec0a
--! Hash: sha1:c6f659c41bb8b32dd6f3a45dbd1bc12b6b58e8b0

CREATE TABLE feed_fetches (
    id bigserial primary key,
    feed_id bigint NOT NULL REFERENCES current_feeds(id),
    url_type text not null,
    url text not null,
    success bool NOT NULL,
    fetched_at timestamp without time zone,
    fetch_error text,
    response_size integer,
    response_code integer,
    response_sha1 text,
    feed_version_id bigint REFERENCES feed_versions(id),
    created_at timestamp without time zone DEFAULT NOW() NOT NULL,
    updated_at timestamp without time zone DEFAULT NOW() NOT NULL
);

CREATE INDEX ON feed_fetches(feed_id);
CREATE INDEX ON feed_fetches(feed_version_id);
CREATE INDEX ON feed_fetches(fetched_at);
CREATE INDEX ON feed_fetches(success);

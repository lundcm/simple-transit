import { sql } from '@pgtyped/query';
import csv from 'csv-parser';
import { Task } from 'graphile-worker';
import request from 'request';
import stream from 'stream';
import unzipper from 'unzipper';
import util from 'util';

import { IGetCurrentTimestampQuery } from '../_generated/transit_download_gtfs.queries';
import {
  addLocationFeedDownload,
  updateLocationFeedDownload,
} from '../sql/transit_download_gtfs.queries';

const getCurrentTimestamp = sql<IGetCurrentTimestampQuery>`select current_timestamp as download_date;`;

const task: Task = async (inPayload: any, { logger, query, addJob }) => {
  logger.info(
    `!!! starting transit data update for ${inPayload.name} !!!\nlocation: ${inPayload.gtfs_static}`
  );
  if (!inPayload.gtfs_static.startsWith('http')) {
    logger.error(
      "static url isn't http(s) which isn't supported at this point, skipping..."
    );
    throw new Error(
      "static url isn't http(s) which isn't supported at this point, skipping..."
    );
  }

  const pipeline = util.promisify(stream.pipeline);
  let directory: unzipper.CentralDirectory | undefined;

  directory = await unzipper.Open.url(
    request as unknown as any,
    inPayload.gtfs_static
  );
  if (!directory) {
    logger.error('error reading zip file');
    throw new Error('error reading zip file');
  }

  const downloadDate = (await getCurrentTimestamp.run(undefined, { query }))[0]
    .download_date;

  const read_agency = async (file: unzipper.File) => {
    const agency_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => agency_rows.push(data))
    );
    return agency_rows;
  };
  const read_calendar = async (file: unzipper.File) => {
    const calendar_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => calendar_rows.push(data))
    );
    return calendar_rows;
  };
  const read_calendar_dates = async (file: unzipper.File) => {
    const calendar_dates_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => calendar_dates_rows.push(data))
    );
    return calendar_dates_rows;
  };
  const read_routes = async (file: unzipper.File) => {
    const routes_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => routes_rows.push(data))
    );
    return routes_rows;
  };
  const read_shapes = async (file: unzipper.File) => {
    const shapes_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => shapes_rows.push(data))
    );
    return shapes_rows;
  };
  const read_stops = async (file: unzipper.File) => {
    const stops_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => stops_rows.push(data))
    );
    return stops_rows;
  };
  const read_stop_times = async (file: unzipper.File) => {
    const stop_times_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => stop_times_rows.push(data))
    );
    return stop_times_rows;
  };
  const read_trips = async (file: unzipper.File) => {
    const trips_rows: any[] = [];
    await pipeline(
      file.stream(),
      csv().on('data', (data) => trips_rows.push(data))
    );
    return trips_rows;
  };

  await addLocationFeedDownload.run(
    {
      location_feed_id: inPayload.id,
      download_date: downloadDate,
      rows_read: null,
      failure: null,
    },
    { query }
  );

  directory.files.forEach(async (file) => {
    switch (file.path) {
      case 'agency.txt':
        let agency_rows = await read_agency(file);
        logger.info(`agency read: ${agency_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'agency',
            count: agency_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_agency', {
          agency_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      case 'calendar.txt':
        let calendar_rows = await read_calendar(file);
        logger.info(`calendar read: ${calendar_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'calendar',
            count: calendar_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_calendar', {
          calendar_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      case 'calendar_dates.txt':
        let calendar_dates_rows = await read_calendar_dates(file);
        logger.info(`calendar_dates read: ${calendar_dates_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'calendar_dates',
            count: calendar_dates_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_calendar_dates', {
          calendar_dates_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      case 'routes.txt':
        let routes_rows = await read_routes(file);
        logger.info(`routes read: ${routes_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'routes',
            count: routes_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_routes', {
          routes_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      case 'shapes.txt':
        let shapes_rows = await read_shapes(file);
        logger.info(`shapes read: ${shapes_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'shapes',
            count: shapes_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_shapes', {
          shapes_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      case 'stop_times.txt':
        let stop_times_rows = await read_stop_times(file);
        logger.info(`stop_times read: ${stop_times_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'stop_times',
            count: stop_times_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_stop_times', {
          stop_times_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      case 'stops.txt':
        let stops_rows = await read_stops(file);
        logger.info(`stops read: ${stops_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'stops',
            count: stops_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_stops', {
          stops_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      case 'trips.txt':
        let trips_rows = await read_trips(file);
        logger.info(`trips read: ${trips_rows.length}`);
        await updateLocationFeedDownload.run(
          {
            table: 'trips',
            count: trips_rows.length,
            location_feed_id: inPayload.id,
            download_date: downloadDate,
            status: 'Started',
          },
          { query }
        );
        await addJob('transit_upsert_trips', {
          trips_rows,
          downloadDate,
          locationFeedId: inPayload.id,
        });
        break;
      default:
        break;
    }
  });
};

export default task;

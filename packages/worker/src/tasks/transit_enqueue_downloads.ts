import { sql } from '@pgtyped/query';
import { Task } from 'graphile-worker';

import { IGetLocationFeedsQuery } from '../_generated/transit_enqueue_downloads.queries';

const getLocationFeeds = sql<IGetLocationFeedsQuery>`select * from app_public.location_feed;`;

const task: Task = async (_, { logger, query, addJob }) => {
  const feeds = await getLocationFeeds.run(undefined, { query });
  if (!feeds) {
    logger.error('No feeds found; aborting');
    return;
  }

  feeds.map(async (feed) => {
    // enqueue the download for each feed we care about
    console.log(feed.name, feed.gtfs_static);
    await addJob('transit_download_gtfs', feed);
  });
};

export default task;

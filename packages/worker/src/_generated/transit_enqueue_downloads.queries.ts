/** Types generated for queries found in "src/tasks/transit_enqueue_downloads.ts" */

/** 'GetLocationFeeds' parameters type */
export type IGetLocationFeedsParams = void;

/** 'GetLocationFeeds' return type */
export interface IGetLocationFeedsResult {
  created_at: Date;
  gtfs_alert: string | null;
  gtfs_alert_info: string | null;
  gtfs_static: string | null;
  gtfs_static_info: string | null;
  gtfs_trip_update: string | null;
  gtfs_trip_update_info: string | null;
  gtfs_vehicle_position: string | null;
  gtfs_vehicle_position_info: string | null;
  id: string;
  location_id: string | null;
  name: string;
  transit_feed_static_id: string | null;
  updated_at: Date;
}

/** 'GetLocationFeeds' query type */
export interface IGetLocationFeedsQuery {
  params: IGetLocationFeedsParams;
  result: IGetLocationFeedsResult;
}

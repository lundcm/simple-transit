/** Types generated for queries found in "src/sql/transit_download_gtfs.sql" */
import { PreparedQuery } from '@pgtyped/query';

export type Json = null | boolean | number | string | Json[] | { [key: string]: Json };

/** 'AddLocationFeedDownload' parameters type */
export interface IAddLocationFeedDownloadParams {
  download_date: Date | null | void;
  failure: Json | null | void;
  location_feed_id: string | null | void;
  rows_read: Json | null | void;
}

/** 'AddLocationFeedDownload' return type */
export type IAddLocationFeedDownloadResult = void;

/** 'AddLocationFeedDownload' query type */
export interface IAddLocationFeedDownloadQuery {
  params: IAddLocationFeedDownloadParams;
  result: IAddLocationFeedDownloadResult;
}

const addLocationFeedDownloadIR: any = {"name":"AddLocationFeedDownload","params":[{"name":"location_feed_id","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":286,"b":301,"line":6,"col":9}]}},{"name":"download_date","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":313,"b":325,"line":7,"col":9}]}},{"name":"rows_read","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":337,"b":345,"line":8,"col":9}]}},{"name":"failure","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":357,"b":363,"line":9,"col":9}]}}],"usedParamSet":{"location_feed_id":true,"download_date":true,"rows_read":true,"failure":true},"statement":{"body":"insert into app_public.location_feed_download (location_feed_id,\n                                               download_date,\n                                               rows_read,\n                                               failure)\nvalues (:location_feed_id,\n        :download_date,\n        :rows_read,\n        :failure)","loc":{"a":36,"b":364,"line":2,"col":0}}};

/**
 * Query generated from SQL:
 * ```
 * insert into app_public.location_feed_download (location_feed_id,
 *                                                download_date,
 *                                                rows_read,
 *                                                failure)
 * values (:location_feed_id,
 *         :download_date,
 *         :rows_read,
 *         :failure)
 * ```
 */
export const addLocationFeedDownload = new PreparedQuery<IAddLocationFeedDownloadParams,IAddLocationFeedDownloadResult>(addLocationFeedDownloadIR);


/** 'UpdateLocationFeedDownload' parameters type */
export interface IUpdateLocationFeedDownloadParams {
  count: number | null | void;
  download_date: Date | null | void;
  location_feed_id: string | null | void;
  status: string | null | void;
  table: string | null | void;
}

/** 'UpdateLocationFeedDownload' return type */
export type IUpdateLocationFeedDownloadResult = void;

/** 'UpdateLocationFeedDownload' query type */
export interface IUpdateLocationFeedDownloadQuery {
  params: IUpdateLocationFeedDownloadParams;
  result: IUpdateLocationFeedDownloadResult;
}

const updateLocationFeedDownloadIR: any = {"name":"UpdateLocationFeedDownload","params":[{"name":"table","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":528,"b":532,"line":12,"col":81},{"a":633,"b":637,"line":13,"col":78}]}},{"name":"count","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":542,"b":546,"line":12,"col":95}]}},{"name":"status","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":647,"b":652,"line":13,"col":92}]}},{"name":"location_feed_id","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":687,"b":702,"line":14,"col":26}]}},{"name":"download_date","required":false,"transform":{"type":"scalar"},"codeRefs":{"used":[{"a":727,"b":739,"line":15,"col":23}]}}],"usedParamSet":{"table":true,"count":true,"status":true,"location_feed_id":true,"download_date":true},"statement":{"body":"update app_public.location_feed_download\nset rows_read = coalesce(rows_read, jsonb_build_object()) || jsonb_build_object(:table::text, :count::int),\n    status    = coalesce(status, jsonb_build_object()) || jsonb_build_object(:table::text, :status::text)\nwhere location_feed_id = :location_feed_id\n  and download_date = :download_date","loc":{"a":406,"b":739,"line":11,"col":0}}};

/**
 * Query generated from SQL:
 * ```
 * update app_public.location_feed_download
 * set rows_read = coalesce(rows_read, jsonb_build_object()) || jsonb_build_object(:table::text, :count::int),
 *     status    = coalesce(status, jsonb_build_object()) || jsonb_build_object(:table::text, :status::text)
 * where location_feed_id = :location_feed_id
 *   and download_date = :download_date
 * ```
 */
export const updateLocationFeedDownload = new PreparedQuery<IUpdateLocationFeedDownloadParams,IUpdateLocationFeedDownloadResult>(updateLocationFeedDownloadIR);



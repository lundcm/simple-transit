/** Types generated for queries found in "src/tasks/transit_download_gtfs.ts" */

/** 'GetCurrentTimestamp' parameters type */
export type IGetCurrentTimestampParams = void;

/** 'GetCurrentTimestamp' return type */
export interface IGetCurrentTimestampResult {
  download_date: Date | null;
}

/** 'GetCurrentTimestamp' query type */
export interface IGetCurrentTimestampQuery {
  params: IGetCurrentTimestampParams;
  result: IGetCurrentTimestampResult;
}


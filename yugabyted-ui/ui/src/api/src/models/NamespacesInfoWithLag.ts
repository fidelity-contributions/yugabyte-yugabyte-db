// tslint:disable
/**
 * Yugabyte Cloud
 * YugabyteDB as a Service
 *
 * The version of the OpenAPI document: v1
 * Contact: support@yugabyte.com
 *
 * NOTE: This class is auto generated by OpenAPI Generator (https://openapi-generator.tech).
 * https://openapi-generator.tech
 * Do not edit the class manually.
 */


// eslint-disable-next-line no-duplicate-imports
import type { XClusterTableInfoWithLag } from './XClusterTableInfoWithLag';


/**
 * A single namespace and its corresponding tables participating in the replication
 * @export
 * @interface NamespacesInfoWithLag
 */
export interface NamespacesInfoWithLag  {
  /**
   * Name of the namespace in the replication
   * @type {string}
   * @memberof NamespacesInfoWithLag
   */
  namespace: string;
  /**
   * 
   * @type {XClusterTableInfoWithLag[]}
   * @memberof NamespacesInfoWithLag
   */
  table_info_list: XClusterTableInfoWithLag[];
}




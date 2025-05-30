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
import type { XClusterInboundGroup } from './XClusterInboundGroup';
// eslint-disable-next-line no-duplicate-imports
import type { XClusterOutboundGroup } from './XClusterOutboundGroup';


/**
 * 
 * @export
 * @interface XClusterReplicationGroups
 */
export interface XClusterReplicationGroups  {
  /**
   * 
   * @type {XClusterInboundGroup[]}
   * @memberof XClusterReplicationGroups
   */
  inbound_replication_groups?: XClusterInboundGroup[];
  /**
   * 
   * @type {XClusterOutboundGroup[]}
   * @memberof XClusterReplicationGroups
   */
  outbound_replication_groups?: XClusterOutboundGroup[];
}




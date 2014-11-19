# Class: voltdb::params
#
# This class defines default parameters used by the main module class voltdb
# Operating Systems differences in names and paths are addressed here
#
# == Variables
#
# Refer to voltdb class for the variables defined here.
#
# == Usage
#
# This class is not intended to be used directly.
# It may be imported or inherited by other classes
#
class voltdb::params {

  ### Module specific parameters
  $data_dir = '/var/lib/voltdb'
  $license = ''
  $version =  '4.8'
  $cluster_hostcount = '3'
  $cluster_sitesperhost = '2'
  $cluster_kfactor = '1'
  $commandlog_enabled = 'true'
  $commandlog_synchronous = 'false'
  $frequency_time = '300'
  $frequency_transactions = '1000'
  $snapshot_enabled = 'true'
  $snapshot_frequency = '30m'
  $snapshot_prefix = 'voltdb'
  $snapshot_retain = '3'
  $security_enabled = 'false'
  $voltdb_path = '/var/lib/voltdb/voltdb'
  $snapshots_path = '/var/lib/voltdb/snapshots'
  $users = {}
  $httpd_port = '8080'
  $jsonapi_enabled = 'false'

}

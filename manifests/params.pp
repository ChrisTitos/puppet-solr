# == Class: solr::params
# This class sets up some required parameters
#
# === Actions
# - Specifies solr home directory
# - Specifies the solr version
#
class solr::params {

  $solr_home = '/opt/solr'
  $solr_version = '4.5.0'

}

# == Class: solr::service
# This class sets up solr service
#
# === Actions
# - Sets up jetty service
#
class solr::service {

  service { 'jetty':
    ensure      => running,
    hasrestart  => true,
    hasstatus   => true,
  }

}
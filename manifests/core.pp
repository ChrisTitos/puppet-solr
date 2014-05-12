# == Definition: solr::core
# This definition sets up solr config and data directories for each core
#
# === Parameters
# - The $core to create
#
# === Actions
# - Creates a directory for the core
# - Puts core.properties in the core by a template
# - Creates the data directory for the core
#
define solr::core(
  $core_name = $title,
  $core_path = "example/solr/${title}"
) {
  include solr::params
  $solr_home  = $solr::params::solr_home

  file { "${solr_home}/${core_path}":
    ensure  => directory,
    owner   => 'solr',
    group   => 'solr',
    require   =>  Exec['create-user'],
  }

  file { "${solr_home}/${core_path}/core.properties":
    ensure  => file,
    owner   => 'solr',
    group   => 'solr',
    content => template('solr/core.properties.erb'),
    require => File["${solr_home}/${core_path}"],
  }

  file { "${solr_home}/${core_path}/data":
    ensure  => directory,
    owner   => 'solr',
    group   => 'solr',
    require => File["${solr_home}/${core_path}"],
  }
}

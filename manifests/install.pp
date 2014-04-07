# == Class: solr::install
# This class installs the required packages for jetty
#
# === Actions
# - Installs default jdk
# - Installs jetty and extra libs
#
class solr::install {

  package { 'java-1.7.0-openjdk':
    ensure  => present,
  }

  package { 'jetty-eclipse':
    ensure  => present,
    require => Package['java-1.7.0-openjdk'],
  }

  #package { 'libjetty-extra':
  #  ensure  => present,
  # require => Package['jetty-eclipse'],
  #}
  
  if defined( Package['wget'] ) {
    debug("wget already installed")
  } else {
    package { 'wget': ensure => present }
  }
    
  if defined( Package['curl'] ) {
    debug("curls already installed")
  } else {
    package { 'curl': ensure => present }
  }
}


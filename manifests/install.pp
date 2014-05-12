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

  file { '/etc/yum.repos.d/jpackage50.repo':
    ensure  => file,
    source  => 'puppet:///modules/solr/jpackage50.repo',
  }

  package { 'jetty5':
    ensure  => present,
    require => Package['java-1.7.0-openjdk'],
  }

  package { 'jetty5-extra':
    ensure  => present,
    require => Package['jetty5'],
  }

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

# == Class: solr::config
# This class sets up solr install
#
# === Actions
# - Creates solr user
# - Create solr home and log directories
# - Downloads solr and extracts it to the target
# - Creates solr config file
# - Creates solr service file
# - Initiates all cores specified by the user
#
class solr::config(
  $cores = 'UNSET',
) {
  include solr::params

  $solr_home      = $::solr::params::solr_home
  $solr_version   = $::solr::params::solr_version
  $file_name      = "solr-${solr_version}.tgz"
  $download_site  = 'https://archive.apache.org/dist/lucene/solr'

  exec { 'create-user':
    path      =>  ['/usr/bin', '/usr/sbin', '/bin'],
    command   =>  "useradd -d ${solr_home} -s /bin/bash solr",
  }

  file { '/var/log/solr':
    ensure    =>  directory,
    owner     =>  'solr',
    group     =>  'solr',
    require   =>  Exec['create-user'],
  }

  exec { 'solr-download':
    command   =>  "wget ${download_site}/${solr_version}/${file_name}",
    cwd       =>  '/tmp',
    creates   =>  "/tmp/${file_name}",
    onlyif    =>  "test ! -d ${solr_home}/dist && test ! -f /tmp/${file_name}",
    timeout   =>  0,
    require   =>  File['/var/log/solr'],
  }

  exec { 'extract-solr':
    path      =>  ['/usr/bin', '/usr/sbin', '/bin'],
    command   =>  "tar xzvf ${file_name}",
    cwd       =>  '/tmp',
    onlyif    =>  "test -f /tmp/${file_name} && test ! -d /tmp/solr-${solr_version}",
    require   =>  Exec['solr-download'],
  }

  exec { 'copy-solr':
    path      =>  ['/usr/bin', '/usr/sbin', '/bin'],
    command   =>  "mv /tmp/solr-${solr_version} ${solr_home}",
    cwd       =>  $solr_home,
    onlyif    =>  "test -d /tmp/solr-${solr_version} test ! -d ${solr_home}/dist",
    require   =>  Exec['extract-solr'],
  }

  file { '/etc/default/jetty':
    ensure    =>  file,
    source    =>  'puppet:///modules/solr/jettydefault',
    require   =>  Exec['copy-solr'],
  }

  file { '/etc/init.d/jetty':
    ensure    =>  file,
    source    =>  'puppet:///modules/solr/jetty',
    mode      =>  '0777',
    require   =>  File['/etc/default/jetty'],
  }

  solr::core { $cores:
    require   =>   File['/etc/init.d/jetty'],
  }
}

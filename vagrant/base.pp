# the default path for puppet to look for executables
Exec { path => [ '/bin/', '/sbin/' , '/usr/bin/', '/usr/sbin/' ] }

stage { 'first': }

stage { 'last': }

Stage['first'] -> Stage['main'] -> Stage['last']

# default use case:
include solr

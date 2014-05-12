require 'rake'
require 'puppet-lint/tasks/puppet-lint'
PuppetLint.configuration.ignore_paths = ["pkg/**/*.pp",
                                         "templates/**/*.*",
                                         "files/**/*.*",
                                         "spec/**/*.*",
                                         "vendor/**/*.*",
                                         "vagrant/**/*.pp"]

task :default => ["lint"]

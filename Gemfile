source 'https://rubygems.org'

if puppetversion = ENV['PUPPET_GEM_VERSION']
    gem 'puppet', puppetversion, :require => false
else
    gem 'puppet', :require => false
end

group :development, :test do
  gem 'rake',                    :require => false
  gem 'puppet-lint',             :require => false
end


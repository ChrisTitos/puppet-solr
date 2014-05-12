require 'spec_helper'

describe 'solr::install' do
  it { should contain_file('/etc/yum.repos.d/jpackage.repo').with({
    'ensure'    =>    'file',
    'source'    =>    'puppet:///modules/solr/jpackage.repo'})
  }
  it { should contain_package('java-1.7.0-openjdk').with_ensure('present') }
  it { should contain_package('jetty6-core').with_ensure('present') }
  it { should contain_package('wget').with_ensure('present') }
  it { should contain_package('curl').with_ensure('present') }

end

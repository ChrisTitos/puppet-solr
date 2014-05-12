require 'spec_helper'

describe 'solr::install' do
  it { should contain_file('/etc/yum.repos.d/jpackage50.repo').with({
    'ensure'    =>    'file',
    'source'    =>    'puppet:///modules/solr/jpackage50.repo'})
  }
  it { should contain_package('java-1.7.0-openjdk').with_ensure('present') }
  it { should contain_package('jetty5').with_ensure('present') }
  it { should contain_package('jetty5-extra').with_ensure('present') }
  it { should contain_package('wget').with_ensure('present') }
  it { should contain_package('curl').with_ensure('present') }

end

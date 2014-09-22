# Encoding: utf-8

require_relative '../spec_helper'

describe 'kitchen_jenkins::default on Ubuntu 12.04' do
  let(:chef_run) do
    ChefSpec::Runner.new(
      :platform => 'ubuntu',
      :version => '12.04'
      ) do |node|
      node.set[:kitchen_jenkins][:packages] = 'user'
    end.converge('kitchen_jenkins::default')
  end

  before do
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep foodcritic').and_return(false)
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep berkshelf').and_return(false)
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep test-kitchen').and_return(false)
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep chefspec').and_return(false)
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep kitchen-vagrant').and_return(false)
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep rubocop').and_return(false)
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep chef').and_return(false)
    stub_command('/var/lib/jenkins/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep chef-zero').and_return(false)
    stub_command('git --version >/dev/null').and_return(true)
    stub_command('/usr/sbin/apache2 -t').and_return(true)
    stub_command('/etc/init.d/vboxdrv status | grep 4.3').and_return(false)
    stub_command('VBoxManage list extpacks | grep 4.3.12').and_return(false)
    stub_command('which php').and_return(true)
  end

  it 'include recipe build-essential' do
    expect(chef_run).to include_recipe('build-essential::default')
  end

  it 'include recipe apt default' do
    expect(chef_run).to include_recipe('apt::default')
  end

  it 'include recipe jenkins master' do
    expect(chef_run).to include_recipe('jenkins::master')
  end

  it 'include recipe java default' do
    expect(chef_run).to include_recipe('java::default')
  end

  it 'include recipe virtualbox default' do
    expect(chef_run).to include_recipe('virtualbox::default')
    expect(chef_run).to include_recipe('virtualbox::webportal')
  end

  it 'include recipe vagrant default' do
    expect(chef_run).to include_recipe('vagrant::default')
  end

  it 'not include recipe docker default' do
    expect(chef_run).to_not include_recipe('docker::default')
  end

  it 'include recipe ruby default' do
    expect(chef_run).to include_recipe('ruby_build::default')
  end

  it 'install packages for ruby gems build' do
    expect(chef_run).to install_package('libxml2-dev')
    expect(chef_run).to install_package('libxslt1-dev')
  end

  it 'install ruby gems' do
    expect(chef_run).to run_execute('install_foodcritic')
    expect(chef_run).to run_execute('install_berkshelf')
    expect(chef_run).to run_execute('install_chefspec')
    expect(chef_run).to run_execute('install_test-kitchen')
    expect(chef_run).to run_execute('install_kitchen-vagrant')
    expect(chef_run).to run_execute('install_rubocop')
    expect(chef_run).to run_execute('install_chef')
    expect(chef_run).to run_execute('install_chef-zero')
  end

  it 'install jenkins plugins' do
    expect(chef_run).to install_jenkins_plugin('git')
    expect(chef_run).to install_jenkins_plugin('jquery')
    expect(chef_run).to install_jenkins_plugin('simple-theme-plugin')
    expect(chef_run).to install_jenkins_plugin('gravatar')
    expect(chef_run).to install_jenkins_plugin('greenballs')
    expect(chef_run).to install_jenkins_plugin('envinject')
    expect(chef_run).to install_jenkins_plugin('config-file-provider')
    expect(chef_run).to install_jenkins_plugin('ansicolor')
  end

  it 'template config theme jenkins' do
    expect(chef_run).to create_template('/var/lib/jenkins/org.codefirst.SimpleThemeDecorator.xml')
  end

  it 'restart jenkins to apply plugins' do
    expect(chef_run).to execute_jenkins_command('safe-restart')
  end

end

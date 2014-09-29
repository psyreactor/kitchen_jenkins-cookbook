# Encoding: utf-8
#
# Cookbook Name:: kitchen_jenkins
# Recipe:: default
#
# Copyright 2014, Mariani Lucas
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'kitchen_jenkins::_config'
include_recipe 'build-essential::default'
include_recipe 'yum-epel::default' if platform_family?('rhel', 'fedora')
include_recipe 'yum-repoforge::default' if platform_family?('rhel', 'fedora')
include_recipe 'apt::default' if platform_family?('debian')
include_recipe 'java::default'
include_recipe 'jenkins::master'
include_recipe 'sysctl::apply'
include_recipe 'ruby_build::default'

case node[:kitchen_jenkins][:kitchen][:driver]
when 'vagrant' then
  include_recipe 'virtualbox::default'
  include_recipe 'virtualbox::webportal'
  include_recipe 'vagrant::default'
when 'docker' then
  include_recipe 'docker::default'
end

sysctl_param 'net.ipv4.ip_forward' do
  value 1
  only_if { node[:kitchen_jenkins][:kitchen][:driver] == 'docker' }
end

sudo node[:jenkins][:master][:user] do
  user node[:jenkins][:master][:user]
  nopasswd true
  only_if { node[:kitchen_jenkins][:kitchen][:driver] == 'docker' }
end

node[:kitchen_jenkins][:packeges].each do | pkg |
  package pkg do
    action :install
  end
end

node[:kitchen_jenkins][:plugins].each do | plg |
  jenkins_plugin plg
end

%w(org.codefirst.SimpleThemeDecorator hudson.tasks.Mailer).each do |file|
  template "#{node[:jenkins][:master][:home]}/#{file}.xml" do
    source '#{file}.xml.erb'
    user node[:jenkins][:master][:user]
    group node[:jenkins][:master][:group]
    mode '0644'
  end
end

jenkins_command 'safe-restart'

ruby_build_ruby '1.9.3-p547' do
  prefix_path "#{node[:jenkins][:master][:home]}/.rubies/ruby-1.9.3-p547"
  user node[:jenkins][:master][:user]
  group node[:jenkins][:master][:group]
end

node[:kitchen_jenkins][:gems].each do |gems|
  execute "install_#{gems}" do
    command "#{node[:jenkins][:master][:home]}/.rubies/ruby-1.9.3-p547/bin/gem install #{gems} --no-ri --no-rdoc"
    timeout 8_000
    user node[:jenkins][:master][:user]
    group node[:jenkins][:master][:group]
    action :run
    not_if "#{node[:jenkins][:master][:home]}/.rubies/ruby-1.9.3-p547/bin/gem list --local | grep #{gems}"
  end
end

service 'docker' do
  action :restart
  only_if { node[:kitchen_jenkins][:kitchen][:driver] == 'docker' }
end

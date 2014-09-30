# Encoding: utf-8
#
# Cookbook Name:: kitchen_jenkins
# Recipe:: _config
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

# Vagrant attributes 
node.default[:vagrant][:plugins] = ['vagrant-berkshelf']

# Jenkins attributes
node.default[:jenkins][:master][:jvm_options] = "-DhttpProxyHost=#{node[:kitchen_jenkins][:proxy][:host]} -DhttpProxyPort=#{node[:kitchen_jenkins][:proxy][:port]} -DhttpsProxyHost=#{node[:kitchen_jenkins][:proxy][:host]} -DhttpsProxyPort=#{node[:kitchen_jenkins][:proxy][:port]}" unless node[:kitchen_jenkins][:proxy][:host].nil?

# Docker attributes
node.default[:docker][:group_members] = %W( #{node[:jenkins][:master][:user]} root )

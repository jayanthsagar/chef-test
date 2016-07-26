#
# Author:: Seth Chisamore (<schisamo@chef.io>)
# Cookbook Name:: iis
# Recipe:: default
#
# Copyright 2011, Chef Software, Inc.
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

# Always add this, so that we don't require this to be added if we want to add other components
default = Opscode::IIS::Helper.older_than_windows2008r2? ? 'Web-Server' : 'IIS-WebServerRole'

(node['iis']['components'] + [default]).each do |feature|
  windows_feature feature do
    action :install
    all !Opscode::IIS::Helper.older_than_windows2012?
    source node['iis']['source'] unless node['iis']['source'].nil?
  end
end

service 'iis' do
  service_name 'W3SVC'
  action [:enable, :start]
end

directory "#{node['iis']['docroot']}/myfirstsite/app1" do
	action :create
end

 iis_site "Default Web Site" do
 	action :delete
 end

 iis_site "myfirstsite" do
 	protocol :http
	port 80
 	path "#{node['iis']['docroot']}/myfirstsite"
 	action [:add,:start]
 end

iis_pool 'myFirstPool' do
  runtime_version "4.5"
  pipeline_mode :Classic
  action :add
end

 iis_app "myfirstsite" do
   path "/app1"
   application_pool "myFirstPool"
   physical_path "#{node['iis']['docroot']}/myfirstsite/app1"
   enabled_protocols "http, net.pipe"
   action :add
  end

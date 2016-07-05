#
# Cookbook Name:: iis
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
# install iis
powershell_script "Install IIS" do
  code 'Add-WindowsFeature Web-Server'
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-Server).Installed"
end

service "w3svc" do
  action [:start, :enable]
end

template "c:\inetpub\wwwroot\Default.html" do
	source "Default.html.erb"
end

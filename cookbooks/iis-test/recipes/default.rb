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
  code 'Add-WindowsFeature Web-Server '
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-Server).Installed"
end
powershell_script "Install App development Feature" do
  code 'Add-WindowsFeature Web-App-Dev'
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-App-Dev).Installed"
end
powershell_script "Install web management tools" do
  code "Add-WindowsFeature Web-Mgmt-Tools"
  guard_interpreter :powershell_script
  not_if "(Get-WindowsFeature -Name Web-Mgmt-Tools).Installed"
end
powershell_script "Install ASP .Net 4.5" do
	code "Add-WindowsFeature Web-Asp-Net45"
	guard_interpreter :powershell_script
	not_if "(Get-WindowsFeature -Name Web-Asp-Net45).Installed"
end
service "w3svc" do
  action [:start, :enable]
end

template 'c:\inetpub\wwwroot\Default.htm' do
	source "Default.html.erb"
end

#
# Cookbook Name:: httpd
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "httpd"  do
	action :install
end

file "/var/www/html/index.html" do
	content '<html>
	<body><h1>hello world!</h1>
	</body>
	</html>'
end

service "httpd" do
	action [:start, :enable]
	supports :restart => :true
end
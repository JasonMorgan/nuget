#
# Cookbook Name:: nugetServer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
include_recipe 'nuget::web_loader'

dsc_resource 'Web-Server' do
  resource :WindowsFeature
  property :Name, 'Web-Server'
  property :Ensure, 'Present'
end

dsc_resource 'Web-Asp-Net45' do
  resource :WindowsFeature
  property :Name, 'Web-Asp-Net45'
  property :Ensure, 'Present'
end

service 'W3SVC' do
  supports :status => true, :restart => true, :reload => true
  action [:enable, :start]
end

node['nugetServer']['website'].each do |site|
  dsc_resource site['packageSource'] do
    resource :File
    property :Ensure, 'Present'
    module_name 'PSDesiredStateConfiguration'
    property :DestinationPath, site['packageSource']
    property :Type, 'Directory'
  end

dsc_resource site['directory'] do
  resource :File
  property :Ensure, 'Present'
  module_name 'PSDesiredStateConfiguration'
  property :DestinationPath, site['directory']
  property :Type, 'Directory'
end

	cookbook_file "#{ENV['SYSTEMDRIVE']}/Archives/nuget.zip" do
    	source 'nuget.zip'
	end

	dsc_resource "nuget archive - #{site['directory']}" do
		resource :Archive
		module_name 'PSDesiredStateConfiguration'
		property :Destination, "#{site['directory']}"
		property :Path, "#{ENV['SYSTEMDRIVE']}/Archives/nuget.zip"
		notifies :restart, 'service[W3SVC]'
	end

	template "#{site['directory']}\\web.config" do
	  source 'web.config.erb'
	  variables({
	  	  :requireApiKey => site['requireApiKey'],
	  	  :apiKey => site['apiKey'],
	  	  :packagesPath => site['packageSource'],
	  	  :allowOverrideExistingPackageOnPush => site['allowPackageOverwrite']
	  	})
	  notifies :restart, 'service[W3SVC]'
	end

	powershell_script "make #{site['name']}" do
		code "New-Website -Name #{site['name']} -PhysicalPath #{site['directory']} -Port #{site['port']}"
		not_if "if (get-website -name #{site['name']}) {$true} else {$false}"
		notifies :restart, 'service[W3SVC]'
	end

end
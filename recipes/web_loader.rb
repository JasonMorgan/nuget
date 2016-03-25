#
# Cookbook Name:: nugetServer
# Recipe:: webLoader
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
["Archives","Sources"].each do |folder|
	dsc_resource folder do
		resource :File
		module_name 'PSDesiredStateConfiguration'
		property :Ensure, 'Present'
		property :DestinationPath, "#{ENV['SYSTEMDRIVE']}\\#{folder}"
		property :Type, 'Directory'
	end
end
target_path = "#{ENV['SYSTEMDRIVE']}/Program Files"
node.nugetServer.dscResources.each do |archive|
	remote_file "#{ENV['SYSTEMDRIVE']}/Archives/#{archive}" do
	  	source "#{node['serverBase']['webServerUrl']}/#{archive}"
	end
	dsc_resource archive do
		resource :Archive
		module_name 'PSDesiredStateConfiguration'
		property :Destination, "#{target_path}/WindowsPowershell/modules/"
		property :Path, "#{ENV['SYSTEMDRIVE']}/Archives/#{archive}"
	end
end
node['nugetServer']['archives'].each do |archive|
	remote_file "#{ENV['SYSTEMDRIVE']}/Archives/#{archive}" do
    	source "#{node['serverBase']['webServerUrl']}/#{archive}"
	end
	dsc_resource archive do
		resource :Archive
		module_name 'PSDesiredStateConfiguration'
		property :Destination, "#{ENV['SYSTEMDRIVE']}/Sources"
		property :Path, "#{ENV['SYSTEMDRIVE']}/Archives/#{archive}"
	end
end
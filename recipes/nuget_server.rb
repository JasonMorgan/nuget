#
# Cookbook Name::nuget
# Recipe:: nuget_server
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node['nuget']['website'].each do |site|
  dsc_resource site['name'] do
    resource :cNuget
    property :PackageSource, site['packageSource']
    property :Name, site['name']
    property :Port, site['port']
    property :APIKey, site['apiKey']
    property :AllowNugetPackagePush, site['allowPackagePush']
    property :AllowPackageOverwrite, site['allowPackageOverwrite']
  end
end

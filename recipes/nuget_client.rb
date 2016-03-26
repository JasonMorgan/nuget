#
# Cookbook Name:: .
# Recipe:: nuget_client
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

node['nuget']['repo'].each do |repo|
  case repo['type']
  when 'PowerShellGet'
    dsc_resource repo['name'] do
      resource :cPSRepo
      module_name 'cNuGet'
      property :Ensure, 'Present'
      property :Name, repo['name']
      property :Port, repo['port']
      property :APIKey, repo['apikey']
      property :PublishUri, repo['publishUri']
      property :SourceUri, repo['sourceUri']
      property :InstallPolicy, repo['policy']
    end
  else
    dsc_resource repo['name'] do
      resource :cPackageRepo
      module_name 'cNuget'
      property :Ensure, 'Present'
      property :Name, repo['name']
      property :Port, repo['port']
      property :SourceUri, repo['sourceUri']
      property :ProviderName, repo['type']
      property :InstallPolicy, repo['policy']
    end
  end
end

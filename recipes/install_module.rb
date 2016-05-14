#
# Cookbook Name:: .
# Recipe:: install_module
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
cred = ps_credential(node['nuget_dsc']['account']['name'], node['nuget_dsc']['account']['password'])
nuget_dsc_module 'ISESteroids' do
  name 'ISESteroids'
  version '2.3.0.64'
  credential cred
  pkg_provider 'PSGallery'
  action :install
end

nuget_dsc_package_repo 'chocolatey' do
  credential cred
end

nuget_dsc_repo 'test' do
  package_source 'c:\\test'
  port 88
  api_key 'myapikey'
end

nuget_dsc_package 'git' do
  name 'git'
  pkg_provider 'chocolatey'
  version '2.8.0'
  credential cred
  action :install
end

nuget_dsc_module_repo 'test' do
  credential cred
  source_uri 'http://localhost:88/nuget'
  publish_uri 'http://localhost:88/'
end

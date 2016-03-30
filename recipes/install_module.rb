#
# Cookbook Name:: .
# Recipe:: install_module
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
cred = ps_credential('vagrant', 'vagrant')
nuget_module 'ISESteroids' do
  name 'ISESteroids'
  version '2.3.0.64'
  credential cred
  provider 'PSGallery'
  action :install
end

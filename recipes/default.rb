#
# Cookbook Name:: nugetServer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#


dsc_resource 'Web-Server' do
  resource :WindowsFeature
  property :Name, 'Web-Server'
  property :Ensure, 'Present'
end

#
# Cookbook Name:: nugetServer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'chef_handler'

chef_handler 'Chef::Handler::ErrorReport' do
  source 'chef/handler/error_report'
  action :enable
end

node.default['powershell']['installation_reboot_mode'] = 'immediate_reboot'

recipes = [
  'powershell::powershell5',
  'nuget_dsc::bootstrap_module'
]

recipes.each do |recipe|
  include_recipe recipe
end

#
# Cookbook Name:: nugetServer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
recipes = [
  'nuget::bootstrap_module',
  'nuget::nuget_server',
  'nuget::nuget_client'
]
recipes.each do |recipe|
  include_recipe recipe
end

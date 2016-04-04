#
# Cookbook Name:: nugetServer
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
recipes = [
  'nuget_dsc::bootstrap_module'
]

recipes.each do |recipe|
  include_recipe recipe
end

#
# Cookbook Name::nuget
# Recipe:: load_module
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

dsc_resource 'bootstrap' do
  resource :script
  module_name 'PSDesiredStateConfiguration'
  property :GetScript, '@{}'
  property :SetScript, <<-CODE
    Set-PackageSource -Name #{node['nuget']['module']['source']} -Trusted -ForceBootstrap
    Install-Module -Name #{node['nuget']['module']['name']} -RequiredVersion #{node['nuget']['module']['version']} -Force -Repository #{node['nuget']['module']['source']}
  CODE
  property :TestScript, <<-CODE
    $mod = Get-Module -Name #{node['nuget']['module']['name']} -ListAvailable -ErrorAction SilentlyContinue
    if ( ($mod -ne $null) -and ($mod.Version -ge [version](#{node['nuget']['module']['version']})) ) {
      return $true
    }
    return $false
  CODE
  property :PSDscRunAsCredential, ps_credential(
    node['nuget']['account']['name'],
    node['nuget']['account']['password']
  )
end


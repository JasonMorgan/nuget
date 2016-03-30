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
    Set-PackageSource -Name #{node['nuget']['modules'][0]['source']} -Trusted -ForceBootstrap
    Install-Module -Name #{node['nuget']['modules'][0]['name']} -RequiredVersion #{node['nuget']['modules'][0]['version']} -Force -Repository #{node['nuget']['modules'][0]['source']}
  CODE
  property :TestScript, <<-CODE
    $mod = Get-Module -Name #{node['nuget']['modules'][0]['name']} -ListAvailable -ErrorAction SilentlyContinue
    if ( ($mod -ne $null) -and ($mod.Version -ge [version](#{node['nuget']['modules'][0]['version']})) ) {
      return $true
    }
    return $false
  CODE
  property :PSDscRunAsCredential, ps_credential(
    node['nuget']['account']['name'],
    node['nuget']['account']['password']
  )
end


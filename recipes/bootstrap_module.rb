#
# Cookbook Name::nuget_dsc
# Recipe:: load_module
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

dsc_resource 'bootstrap' do
  resource :script
  module_name 'PSDesiredStateConfiguration'
  property :GetScript, '@{}'
  property :SetScript, <<-CODE
    Set-PackageSource -Name #{node['nuget_dsc']['module']['source']} -Trusted -ForceBootstrap
    Install-Module -Name #{node['nuget_dsc']['module']['name']} -RequiredVersion #{node['nuget_dsc']['module']['version']} -Force -Repository #{node['nuget_dsc']['module']['source']}
  CODE
  property :TestScript, <<-CODE
    $mod = Get-Module -Name #{node['nuget_dsc']['module']['name']} -ListAvailable -ErrorAction SilentlyContinue
    if ( ($mod -ne $null) -and ($mod.Version -ge [version](#{node['nuget_dsc']['module']['version']})) ) {
      return $true
    }
    return $false
  CODE
  property :PSDscRunAsCredential, ps_credential(
    node['nuget_dsc']['account']['name'],
    node['nuget_dsc']['account']['password']
  )
end


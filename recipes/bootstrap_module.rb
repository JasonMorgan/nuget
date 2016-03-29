#
# Cookbook Name::nuget
# Recipe:: load_module
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

powershell_script 'Get cNuget' do
  code <<-EOH
  Set-PackageSource -Name #{node['nuget']['modules'][0]['source']} -Trusted -ForceBootstrap
  Install-Module -Name cNuget -RequiredVersion #{node['nuget']['modules'][0]['version']} -Force -Repository #{node['nuget']['modules'][0]['source']}
  EOH
  not_if <<-CODE
  $mod = Get-Module -Name cNuget -ListAvailable"
  if ( ($mod -ne $null) -and ($mod.Version -ge [version](#{node['nuget']['modules'][0]['version']})) ) {
    return $true
  }
  return $false
  CODE
end

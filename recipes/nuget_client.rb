#
# Cookbook Name:: nuget_server
# Recipe:: nuget_client
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
node['nugetServer']['repos'].each do |repo|
	case repo['type']
	when 'NuGet'
		powershell_script "nuget #{repo['name']}" do
			code "Register-PackageSource -Name #{repo['name']} -Location #{repo['url']}/nuget -ProviderName #{repo['type']} -ForceBootstrap -Trusted -Force"
			not_if "if (Get-PackageSource -Name #{repo['name']}) {return $true}; $false"
		end
	when 'PSModule'
		powershell_script "PS #{repo['name']}" do
			code "Register-PSRepository -Name #{repo['name']} -SourceLocation #{repo['url']}/nuget -InstallationPolicy Trusted"
			not_if "if (Get-PackageSource -Name #{repo['name']}) {return $true}; $false"
		end
	when 'chocolatey'
		powershell_script "nuget #{repo['name']}" do
			code <<-SCRIPT
			Register-PackageSource -Name #{repo['name']} -Location #{repo['url']}/nuget -ProviderName NuGet -ForceBootstrap -Trusted -Force
			Unregister-PackageSource -Name #{repo['name']}
			Register-PackageSource -Name #{repo['name']} -Location #{repo['url']}/nuget -ProviderName #{repo['type']} -ForceBootstrap -Trusted
			SCRIPT
			not_if "if (Get-PackageSource -Name #{repo['name']}) {return $true}; $false"
		end
	end
end

resource_name :nuget_package_repo

default_action :install

provides :nuget_package_repo, platform: 'windows'

property :name, String, name_property: true
property :pkg_provider, String, default: 'Chocolatey'
property :credential, Chef::Util::Powershell::PSCredential, required: true
property :source_uri, String, default: 'http://chocolatey.org/api/v2/'
property :install_policy, String, default: 'Trusted'

action :install do
  dsc_resource new_resource.name do
    resource :PackageRepo
    property :Ensure, 'Present'
    property :Name, new_resource.name
    property :ProviderName, new_resource.pkg_provider
    property :SourceUri, new_resource.source_uri
    property :installPolicy, new_resource.install_policy
    property :PSDscRunAsCredential, new_resource.credential
  end
end

action :uninstall do
  dsc_resource new_resource.name do
    resource :PackageRepo
    property :Ensure, 'Absent'
    property :Name, new_resource.name
    property :ProviderName, new_resource.pkg_provider
    property :SourceUri, new_resource.source_uri
    property :installPolicy, new_resource.install_policy
    property :PSDscRunAsCredential, new_resource.credential
  end
end

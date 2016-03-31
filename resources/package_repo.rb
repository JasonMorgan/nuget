resource_name :nuget_package_repo

provides :nuget_package_repo, platform: 'windows'

property :name, String, name_property: true
property :pkg_provider, String, default: 'Chocolatey'
property :credential, Chef::Util::Powershell::PSCredential, required: true
property :source_uri, String, default: 'http://chocolatey.org/api/v2/'
property :install_policy, String, default: 'Trusted'

action :install do
  dsc_resource name do
    resource :PackageRepo
    property :Ensure, 'Present'
    property :Name, name
    property :ProviderName, pkg_provider
    property :SourceUri, source_uri
    property :installPolicy, install_policy
    property :PSDscRunAsCredential, credential
  end
end

action :uninstall do
  dsc_resource name do
    resource :PackageRepo
    property :Ensure, 'Absent'
    property :Name, name
    property :ProviderName, pkg_provider
    property :SourceUri, source_uri
    property :installPolicy, install_policy
    property :PSDscRunAsCredential, credential
  end
end

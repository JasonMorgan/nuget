resource_name :nuget_package

provides :nuget_package, platform: 'windows'

property :name, String, name_property: true
property :pkg_provider, String, default: 'Chocolatey'
property :version, String, required: true
property :credential, Chef::Util::Powershell::PSCredential, required: true

action :install do
  dsc_resource name do
    resource :Nuget_package
    property :Ensure, 'Present'
    property :Name, name
    property :ProviderName, pkg_provider
    property :Version, version
    property :PSDscRunAsCredential, credential
  end
end

action :uninstall do
  dsc_resource name do
    resource :Nuget_package
    property :Ensure, 'Absent'
    property :Name, name
    property :ProviderName, pkg_provider
    property :Version, version
    property :PSDscRunAsCredential, credential
  end
end

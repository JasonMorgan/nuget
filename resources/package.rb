resource_name :nuget_dsc_package

default_action :install

provides :nuget_dsc_package, platform: 'windows'

property :name, String, name_property: true
property :pkg_provider, String, default: 'nuget'
property :version, String
property :credential, Chef::Util::Powershell::PSCredential

action :install do
  dsc_resource new_resource.name do
    resource :Nuget_package
    property :Ensure, 'Present'
    property :Name, new_resource.name
    property :ProviderName, new_resource.pkg_provider
    property :Version, new_resource.version if new_resource.version
    property :PSDscRunAsCredential, new_resource.credential if new_resource.credential
  end
end

action :uninstall do
  dsc_resource new_resource.name do
    resource :Nuget_package
    property :Ensure, 'Absent'
    property :Name, new_resource.name
    property :ProviderName, new_resource.pkg_provider
    property :Version, new_resource.version if new_resource.version
    property :PSDscRunAsCredential, new_resource.credential if new_resource.credential
  end
end

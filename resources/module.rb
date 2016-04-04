
resource_name :nuget_dsc_module

default_action :install

provides :nuget_dsc_module, platform: 'windows'

property :name, String, name_property: true
property :pkg_provider, String, default: 'PSGallery'
property :version, String, required: true
property :credential, Chef::Util::Powershell::PSCredential, required: true

action :install do
  dsc_resource new_resource.name do
    resource :Nuget_Module
    property :Ensure, 'Present'
    property :Name, new_resource.name
    property :ProviderName, new_resource.pkg_provider
    property :Version, new_resource.version
    property :PSDscRunAsCredential, new_resource.credential
  end
end

action :uninstall do
  dsc_resource new_resource.name do
    resource :Nuget_Module
    property :Ensure, 'Absent'
    property :Name, new_resource.name
    property :ProviderName, new_resource.pkg_provider
    property :Version, new_resource.version
    property :PSDscRunAsCredential, new_resource.credential
  end
end

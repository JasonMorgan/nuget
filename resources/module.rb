#import_recipe 'nuget::default'

resource_name :nuget_module

provides :nuget_module, platform: 'windows'

property :name, String, name_property: true
property :pkg_provider, String, default: 'PSGallery'
property :version, String, required: true
property :credential, Chef::Util::Powershell::PSCredential, required: true

load_current_value do
  #
end

action :install do
  dsc_resource name do
    resource :Nuget_Module
    property :Ensure, 'Present'
    property :Name, name
    property :ProviderName, pkg_provider
    property :Version, version
    property :PSDscRunAsCredential, credential
  end
end

action :uninstall do
  dsc_resource name do
    resource :Nuget_Module
    property :Ensure, 'Absent'
    property :Name, name
    property :ProviderName, pkg_provider
    property :Version, version
    property :PSDscRunAsCredential, credential
  end
end

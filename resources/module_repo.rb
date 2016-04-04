resource_name :nuget_module_repo

default_action :install

provides :nuget_module_repo, platform: 'windows'

property :name, String, name_property: true
property :credential, Chef::Util::Powershell::PSCredential, required: true
property :source_uri, String, required: true
property :publish_uri, String, required: true
property :install_policy, String, default: 'Trusted'

action :install do
  dsc_resource new_resource.name do
    resource :PSRepo
    property :Ensure, 'Present'
    property :Name, new_resource.name
    property :SourceUri, new_resource.source_uri
    property :PublishUri, new_resource.publish_uri
    property :installPolicy, new_resource.install_policy
    property :PSDscRunAsCredential, new_resource.credential
  end
end

action :uninstall do
  dsc_resource new_resource.name do
    resource :PSRepo
    property :Ensure, 'Absent'
    property :Name, new_resource.name
    property :SourceUri, new_resource.source_uri
    property :PublishUri, new_resource.publish_uri
    property :installPolicy, new_resource.install_policy
    property :PSDscRunAsCredential, new_resource.credential
  end
end

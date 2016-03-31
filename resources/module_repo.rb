resource_name :nuget_module_repo

provides :nuget_module_repo, platform: 'windows'

property :name, String, name_property: true
property :credential, Chef::Util::Powershell::PSCredential, required: true
property :source_uri, String, required: true
property :publish_uri, String, required: true
property :install_policy, String, default: 'Trusted'

action :install do
  dsc_resource name do
    resource :PSRepo
    property :Ensure, 'Present'
    property :Name, name
    property :SourceUri, source_uri
    property :PublishUri, publish_uri
    property :installPolicy, install_policy
    property :PSDscRunAsCredential, credential
  end
end

action :uninstall do
  dsc_resource name do
    resource :PSRepo
    property :Ensure, 'Absent'
    property :Name, name
    property :SourceUri, source_uri
    property :PublishUri, publish_uri
    property :installPolicy, install_policy
    property :PSDscRunAsCredential, credential
  end
end

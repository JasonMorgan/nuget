resource_name :nuget_repo

default_action :install

provides :nuget_repo, platform: 'windows'

property :name, String, name_property: true
property :package_source, String, required: true
property :port, Integer, required: true
property :api_key, String, required: true
property :allow_package_push, [TrueClass, FalseClass], default: true
property :allow_package_overwrite, [TrueClass, FalseClass], default: true

action :install do
  dsc_resource new_resource.name do
    resource :Nuget
    property :Name, new_resource.name
    property :PackageSource, new_resource.package_source
    property :Port, new_resource.port
    property :APIKey, new_resource.api_key
    property :AllowNugetPackagePush, new_resource.allow_package_push
    property :AllowPackageOverwrite, new_resource.allow_package_overwrite
  end
end

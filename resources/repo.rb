resource_name :nuget_repo

provides :nuget_repo, platform: 'windows'

property :name, String, name_property: true
property :package_source, String, required: true
property :port, Integer, required: true
property :api_key, String, required: true
property :allow_package_push, [TrueClass, FalseClass], default: true
property :allow_package_overwrite, [TrueClass, FalseClass], default: true

action :install do
  dsc_resource name do
    resource :Nuget
    property :Name, name
    property :PackageSource, package_source
    property :Port, port
    property :APIKey, api_key
    property :AllowNugetPackagePush, allow_package_push
    property :AllowPackageOverwrite, allow_package_overwrite
  end
end

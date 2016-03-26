resource_name :nuget_module

property :name, String, desired_state: true
property :provider, String, desired_state: false, default: 'PSGallery'
property :version, String, desired_state: true

load_current_value do
  powershell_script 'get' do
    code <<-EOH
    Get-Module -ListAvailable -Name #{name} | select Name,Version
    EOH
  end
end

default_action :install

action :install do
  powershell_script 'install' do
    code <<-EOH
    $params = @{
      Name = "#{name}"
      ProviderName = "#{provider}"
    }
    if (#{version})
    {
      $params.add('RequiredVersion',"#{version}")
    }
    Install-Module @params -Force
    EOH
  end
end

action :uninstall do
  powershell_script 'uninstall' do
    code <<-EOH
    Uninstall-Module -Name #{name} -Force
    EOH
  end
end

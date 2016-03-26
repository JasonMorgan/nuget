resource_name :nuget_package

property :name, String
property :provider, String
property :version, String

load_current_value do
  powershell_script 'get' do
    code <<-EOH
    Get-Package -Name #{name}
    EOH
  end
end

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
    Install-Package @params -Force
    EOH
  end
end

action :uninstall do
  powershell_script 'uninstall' do
    code <<-EOH
    Uninstall-Package -Name #{name} -Force
    EOH
  end
end

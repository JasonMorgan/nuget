default['nuget']['modules'] = ['cNuget' => '1.2.5']
default['nuget']['allowPackagePush'] = true
default['nuget']['allowPackageOverwrite'] = true
default['nuget']['website'] = [{
  'name' => 'NuGet',
  'port' => 81,
  'directory' => "#{ENV['SYSTEMDRIVE']}\\inetpub\\nuget",
  'apiKey' => 'c4a94e44-0fff-4bb7-aed3-80b05329fe9b',
  'packageSource' => "#{ENV['SYSTEMDRIVE']}\\Packages",
  'allowPackagePush' => true,
  'allowPackageOverwrite' => true
}]
default['nuget']['repo'] = [{
  'name' => 'Napm',
  'publishUri' => 'http://localhost:81/nuget',
  'sourceUri' => 'http://localhost:81',
  'apiKey' => 'c4a94e44-0fff-4bb7-aed3-80b05329fe9b',
  'type' => 'NuGet',
  'policy' => 'Trusted'
}]

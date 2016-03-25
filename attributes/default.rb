default['nugetServer']['dscResources'] = ['cNuget.zip']
default['nugetServer']['archives'] = []
default['nugetServer']['allowPackagePush'] = true
default['nugetServer']['allowPackageOverwrite'] = true
default['nugetServer']['website'] = [{
  'name' => 'NuGet',
  'port' => 81,
  'directory' => "#{ENV['SYSTEMDRIVE']}\\inetpub\\nuget",
  'apiKey' => 'c4a94e44-0fff-4bb7-aed3-80b05329fe9b',
  'packageSource' => "#{ENV['SYSTEMDRIVE']}\\Packages",
  'allowPackagePush' => true,
  'allowPackageOverwrite' => true
}]
default['nugetServer']['repos'] = [{
  'name' => 'Napm',
  'url' => 'http://192.168.50.11:81',
  'apiKey' => 'c4a94e44-0fff-4bb7-aed3-80b05329fe9b',
  'type' => 'NuGet'
}]

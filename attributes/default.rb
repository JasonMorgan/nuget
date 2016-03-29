default['nuget']['modules'] = [{
  'name' => 'cNuget',
  'version' => '1.3.0',
  'source' => 'PSGallery'
}]

default['nuget']['website'] = [
  {
    'name' => 'Packages',
    'port' => 81,
    'apiKey' => 'c4a94e44-0fff-4bb7-aed3-80b05329fe9b',
    'packageSource' => "#{ENV['SYSTEMDRIVE']}\\Packages",
    'allowPackagePush' => true,
    'allowPackageOverwrite' => true
  },
  {
    'name' => 'Modules',
    'port' => 81,
    'apiKey' => 'c4a94e44-0fff-4bb7-aed3-80b05329fe9b',
    'packageSource' => "#{ENV['SYSTEMDRIVE']}\\Modules",
    'allowPackagePush' => true,
    'allowPackageOverwrite' => true
  }
]
default['nuget']['repo'] = [
  {
    'name' => 'PSGallery',
    'publishUri' => 'https://www.powershellgallery.com/api/v2/package/',
    'sourceUri' => 'https://www.powershellgallery.com/api/v2/',
    'type' => 'PowershellGet',
    'policy' => 'Trusted'
  },
  {
    'name' => 'Chocolatey',
    'sourceUri' => 'http://chocolatey.org/api/v2/',
    'type' => 'Chocolatey',
    'policy' => 'Trusted'
  }
]

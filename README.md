nuget Cookbook
====================
Cookbook to create a nuget server and to configure the windows package manager.

Requirements
------------
Only runs on Windows Server.
#### packages
none

Attributes
----------

e.g.
#### nugetServer::default
<table>
  <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><tt>['nuget']['module']['name']</tt></td>
    <td>string</td>
    <td>Name of the module to install</td>
    <td><tt>Nuget</tt></td>
  </tr>
  <tr>
    <td><tt>['nuget']['module']['version']</tt></td>
    <td>string</td>
    <td>The module </td>
    <td><tt>1.3.1</tt></td>
  </tr>
  <tr>
    <td><tt>['nuget']['module']['source']</tt></td>
    <td>string</td>
    <td>Name of the package source</td>
    <td><tt>PSGallery</tt></td>
  </tr>
  <tr>
    <td><tt>['nuget']['account']['name']</tt></td>
    <td>string</td>
    <td>The name of the account that will install the Nuget Module</td>
    <td><tt>vagrant</tt></td>
  </tr>
  <tr>
    <td><tt>['nuget']['account']['password']</tt></td>
    <td>string</td>
    <td>The password of the account that will install the Nuget Module</td>
    <td><tt>vagrant</tt></td>
  </tr>
</table>

Usage
-----
#### nuget::default
Bootstraps the Nuget DSC Resource module.  This module is necessary for all the resouces this cookbook provides.

e.g.
Just include `nuget` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nuget]"
  ]
}
```

Resources
---------
###***nuget_module***
installs a module from a designated repository.

####properties:
  * ***name:*** String - name of the module to be managed - name property
  * ***pkg_provider:*** String - name of the nuget provider - defaults to 'PSGallery' - optional
  * ***version:*** String - version of the module to be managed - required
  * ***credential:*** Chef::Util::Powershell::PSCredential - credential used to install the module - required

####actions:
  * install - default
  * uninstall 
  
```
nuget_module 'name' do
  version '0.1.0'
  credential ps_credential('vagrant', 'vagrant')
end
```

###***nuget_package_repo***
registers/unregisters a package repository

####properties:
  * ***name:*** String - name of the module to be managed - name property
  * ***pkg_provider:*** String - name of the nuget provider - defaults to 'Chocolatey' - optional
  * ***source_uri:*** String - package source uri - defaults to http://chocolatey.org/api/v2/
  * ***credential:*** Chef::Util::Powershell::PSCredential - credential used to install the module - required
  * ***install_policy:*** String - trusted or untrusted - defaults to Trusted

####actions:
  * install - default
  * uninstall 
  
```
nuget_package_repo 'name' do
  credential ps_credential('vagrant', 'vagrant')
end
```

###***nuget_module_repo***
registers/unregisters a module repository

####properties:
  * ***name:*** String - name of the module to be managed - name property
  * ***pkg_provider:*** String - name of the nuget provider - defaults to 'Chocolatey' - optional
  * ***source_uri:*** String - module source uri - required
  * ***publish_uri:*** String - package publish uri - required
  * ***credential:*** Chef::Util::Powershell::PSCredential - credential used to install the module - required
  * ***install_policy:*** String - trusted or untrusted - defaults to Trusted

####actions:
  * install - default
  * uninstall 
  
```
nuget_module_repo 'name' do
  credential ps_credential('vagrant', 'vagrant')
  source_uri 'http://somehost/nuget/'
  publish_uri 'http://somehost/'
end
```

###nuget_package
installs/uninstalls a nuget package

####properties:
  * ***name:*** String - name of the module to be managed - name property
  * ***pkg_provider:*** String - name of the nuget provider - defaults to 'Nuget' - optional
  * ***version:*** String - version of the module to be managed - required
  * ***credential:*** Chef::Util::Powershell::PSCredential - credential used to install the module - required

####actions:
  * install - default
  * uninstall 

```
nuget_package 'name' do
  version '0.1.0'
  credential ps_credential('vagrant', 'vagrant')
end
```

###nuget_repo
Creates a nuget website

####properties:
  * ***name:*** String - name of nuget site - name property
  * ***package_source:*** String - Path to the packages folder - required
  * ***port:*** Integer - port number for use by the site - required
  * ***api_key:*** String - API Key - required
  * ***allow_package_push:*** Boolean - Set if the site should accept package pushes - defaults to true
  * ***allow_package_overwrite:*** Boolean - Set if the site should allow package overrides - defaults to true

####actions:
  * install - default
  * uninstall 
```
nuget_repo 'name' do
  package_source 'c:\pathtofolder'
  port 81
  api_key 'myapikey'
end
```

License and Authors
-------------------
Authors: Jason Morgan, Verizon ISD Tools

nugetServer Cookbook
====================
Cookbook to create a nuget server and to configure the windows package manager.

Requirements
------------
Only runs on Windows Server.  Requires the MME_Configs serverBase cookbook.
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
    <td><tt>['nugetServer']['dscResources']</tt></td>
    <td>string[]</td>
    <td>array of DSC Resources to include</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['nugetServer']['archives']</tt></td>
    <td>string[]</td>
    <td>array of archives to include</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['nugetServer']['packageSource']</tt></td>
    <td>string</td>
    <td>Path to the packages folder</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['nugetServer']['apiKey']</tt></td>
    <td>string</td>
    <td>The API key for use with the nuget Server</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['nugetServer']['allowPackagePush']</tt></td>
    <td>Boolean</td>
    <td>Specify whether the nuget server will allow package pushes</td>
    <td><tt>true</tt></td>
  </tr>
  <tr>
    <td><tt>['nugetServer']['allowPackageOverwrite']</tt></td>
    <td>Boolean</td>
    <td>Specify if package overwrites will be allowed</td>
    <td><tt>true</tt></td>
  </tr>
</table>

Usage
-----
#### nugetServer::default
Calling the default recipe will configure a nuget server on the node.

e.g.
Just include `nugetServer` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[nugetServer]"
  ]
}
```

License and Authors
-------------------
Authors: Jason Morgan, Verizon ISD Tools

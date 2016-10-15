class site {
  #Properties
  [string]$Name
  [int]$Port
  [string]$Path
  #Constructors
  site () {}

  site ([string]$name,[int]$port,[string]$path) {
    $this.Name = $name
    $this.Port = $port
    $this.Path = $path
  }
}
$sites = [site]::new('test',88,'c:\test')

describe "Testing the default configuration of NuGet" {
  context "Nuget website | Sources | W3SVC" {
    it "ensures IIS installed" {
        (get-windowsfeature -name web-server).installed | should be $true
    }
    foreach ($site in $sites) {
      it "checks for Modules website" {
        get-website -name $site.Name | should not be $null
      }
      it "ensures $($site.path) directory exists" {
        test-path $site.Path -type container | should be true
      }
      it "tests for contents" {
        (invoke-webrequest -uri "http://localhost:$($site.Port)" -usebasicparsing).StatusCode | should be 200
      }
    }

    it "ensures w3svc is running" {
        (get-service -name w3svc).status | should match 'running'
    }
  }
}

Describe "Looking for installed packages" {
  Context " Git | Steroids | Nuget Module " {
    it "checks for git install" {
      $return = Get-Package -Name 'git'
      $return | Should not be $null
    }
    it "checks for ISESteroids" {
      $return = Get-Module -ListAvailable -Name ISESteroids
      $return | Should not be $null
    }
    it "checks for Nuget" {
      $return = Get-Module -ListAvailable -Name Nuget
      $return | Should not be $null
    }
  }
}
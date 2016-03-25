describe 'Pester tests for nuget server' {
    context 'Checking the website' {
        it 'exists' {
            {Get-Website -Name Nuget -ErrorAction stop} | should not throw
        }
        it 'is running' {
            (Get-Website -Name Nuget).State | should match 'started'
        }
        it 'responds to http' {
            (wget -usebasicparsing http://localhost:81).statusCode | should be 200
        }
    }
    context 'Uses PowerShell to grab the client' {
        $Client = Get-PackageSource -Name napm
        it 'exists' {
            {Get-PackageSource -Name napm -ErrorAction stop} | should not throw
        }
        it 'is Napm' {
            $client.Name | should match 'Napm'
        }
        it 'is Nuget Type' {
            $client.ProviderName | should match 'NuGet'
        }
    }
}
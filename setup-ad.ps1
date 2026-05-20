# Install fitur AD DS
Install-WindowsFeature -Name AD-Domain-Services -IncludeManagementTools

# Promosikan server menjadi Domain Controller (forest baru)
Import-Module ADDSDeployment
Install-ADDSForest `
-DomainName 'farhan.local' `
-DomainNetbiosName 'CORP' `
-ForestMode 'WinThreshold' `
-DomainMode 'WinThreshold' `
-InstallDns `
-SafeModeAdministratorPassword (ConvertTo-SecureString 'P@ssw0rd4123' -AsPlainText -Force) `
-Force
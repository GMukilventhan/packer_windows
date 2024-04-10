$IPAddress = "10.75.1.100"
$SubnetMask = "255.255.248.0"
$DefaultGateway = "10.75.0.1"
$DNS1 = "8.8.8.8"
$DNS2 = "8.8.4.4"
$NetworkInterface = Get-NetAdapter -Physical
New-NetIPAddress -InterfaceIndex $NetworkInterface.InterfaceIndex -IPAddress $IPAddress -PrefixLength 21 -DefaultGateway $DefaultGateway
Set-DnsClientServerAddress -InterfaceIndex $NetworkInterface.InterfaceIndex -ServerAddresses $DNS1, $DNS2
Get-NetIPAddress
Get-DnsClientServerAddress

#$ProgressPreference = "SilentlyContinue"
#$webclient = New-Object System.Net.WebClient
#$version_url = "https://packages.vmware.com/tools/releases/latest/windows/x64/"
#$raw_package = $webclient.DownloadString($version_url)
#$raw_package -match "VMware-tools[\w-\d\.]*\.exe"
#$package = $Matches.0
#$url = "https://packages.vmware.com/tools/releases/latest/windows/x64/$package"
#$exe = "$Env:TEMP\$package"
#Write-Output "***** Downloading VMware Tools"
#$webclient.DownloadFile($url, $exe)
#$parameters = '/S /v "/qn REBOOT=R ADDLOCAL=ALL"'
#Write-Output "***** Installing VMware Tools"
#Start-Process $exe $parameters -Wait
#Write-Output "***** Deleting $exe"
#Remove-Item $exe



#Install PS Windows Update Module

#Get-PackageProvider -name nuget -force
#Get-WindowsUpdate -MicrosoftUpdate -install -IgnoreUserInput -acceptall -AutoReboot
#Install-WindowsUpdate -IgnoreUserInput -AcceptAll -AutoReboot

#WinRM Configure
#winrm quickconfig -quiet
#winrm set winrm/config/service '@{AllowUnencrypted="true"}'
#winrm set winrm/config/service/auth '@{Basic="true"}'

#Stop-Computer -Force
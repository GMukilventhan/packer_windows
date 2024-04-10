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

$ProgressPreference = "SilentlyContinue"
$webclient = New-Object System.Net.WebClient
$version_url = "https://packages.vmware.com/tools/releases/latest/windows/x64/"
$raw_package = $webclient.DownloadString($version_url)
$raw_package -match "VMware-tools[\w-\d\.]*\.exe"
$package = $Matches.0
$url = "https://packages.vmware.com/tools/releases/latest/windows/x64/$package"
$exe = "$Env:TEMP\$package"
Write-Output "***** Downloading VMware Tools"
$webclient.DownloadFile($url, $exe)
$parameters = '/S /v "/qn REBOOT=R ADDLOCAL=ALL"'
Write-Output "***** Installing VMware Tools"
Start-Process $exe $parameters -Wait
Write-Output "***** Deleting $exe"
Remove-Item $exe



netsh advfirewall firewall add rule name="Open Port 3389" dir=in action=allow protocol=TCP localport=3389
reg add "HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Terminal Server" /v fDenyTSConnections /t REG_DWORD /d 0 /f


Stop-Computer -Force
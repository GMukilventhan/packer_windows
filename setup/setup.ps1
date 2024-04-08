
$IPAddress = "110.75.1.100"
$SubnetMask = "255.255.248.0"
$DefaultGateway = "10.75.7.255"
$DNS1 = "8.8.8.8"
$DNS2 = "8.8.4.4"


$NetworkInterface = Get-NetAdapter -Physical


New-NetIPAddress -InterfaceIndex $NetworkInterface.InterfaceIndex -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $DefaultGateway


Set-DnsClientServerAddress -InterfaceIndex $NetworkInterface.InterfaceIndex -ServerAddresses $DNS1, $DNS2

Get-NetIPAddress
Get-DnsClientServerAddress
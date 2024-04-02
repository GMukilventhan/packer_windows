#$ErrorActionPreference = "Stop"

# Switch network connection to private mode
# Required for WinRM firewall rules
#$profile = Get-NetConnectionProfile
#Set-NetConnectionProfile -Name $profile.Name -NetworkCategory Private

# Copy BGINFO and custom INI file
#net use x: \\vserv01\packerbuild /persistent:no
#xcopy /E X:\BGinfo "c:\program files (x86)\bginfo\"
#xcopy X:\startup\bginfo.bat "C:\programdata\microsoft\windows\start menu\programs\startup"
#"C:\programdata\microsoft\windows\start menu\programs\startup\bginfo.bat"

#Install PS Windows Update Module

#Get-PackageProvider -name nuget -force
#Install-Module PSWindowsUpdate -confirm:$false -force
#Get-WindowsUpdate -MicrosoftUpdate -install -IgnoreUserInput -acceptall -AutoReboot | Out-File -filepath 'c:\windowsupdate.log' -append

#WinRM Configure
#winrm quickconfig -quiet
#winrm set winrm/config/service '@{AllowUnencrypted="true"}'
#winrm set winrm/config/service/auth '@{Basic="true"}'

# Reset auto logon count
# https://docs.microsoft.com/en-us/windows-hardware/customize/desktop/unattend/microsoft-windows-shell-setup-autologon-logoncount#logoncount-known-issue
#Set-ItemProperty -Path 'HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Winlogon' -Name AutoLogonCount -Value 0

# Définition des paramètres de l'adresse IP statique
$IPAddress = "192.168.1.100"
$SubnetMask = "255.255.255.0"
$DefaultGateway = "192.168.1.1"
$DNS1 = "8.8.8.8"
$DNS2 = "8.8.4.4"

# Obtenir l'interface réseau
$NetworkInterface = Get-NetAdapter -Physical

# Configuration de l'adresse IP statique
New-NetIPAddress -InterfaceIndex $NetworkInterface.InterfaceIndex -IPAddress $IPAddress -PrefixLength 24 -DefaultGateway $DefaultGateway

# Configuration du DNS
Set-DnsClientServerAddress -InterfaceIndex $NetworkInterface.InterfaceIndex -ServerAddresses $DNS1, $DNS2

# Afficher les informations de configuration
Get-NetIPAddress
Get-DnsClientServerAddress
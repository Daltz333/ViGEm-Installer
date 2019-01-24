echo "Checking powershell version"

$PSversion = ($PSversion = $PSVersionTable.PSVersion.Major)

if ($PSVersion -ge 5){
	echo "Your powershell version is compatible for ViGEm"
	
} else {
	echo "Your powershell version is too old, you need powershell 5 or greater for installing ViGEm"
}

$checkInstall = (Get-ViGEmBusDevice) 

if($?){
	echo "ViGEm is already installed"
	return
	
} else {
	echo "Installing ViGEm"
	
}

((Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force).Status) | Out-String


. ({ Register-PSRepository -Name nuget.vigem.org -SourceLocation "https://nuget.vigem.org/" -InstallationPolicy Trusted },{ "Repository already registered, nothing to do =)" })[(Get-PSRepository -Name nuget.vigem.org -ErrorAction Ignore).Registered -eq $true]


(Install-Module ViGEmManagementModule -Repository nuget.vigem.org)
(Add-ViGEmBusDevice)

(Install-ViGEmBusDeviceDriver)
echo "Please reboot your system and re-run this script to confirm installation"
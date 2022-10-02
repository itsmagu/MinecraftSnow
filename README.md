# **Minecraft Snow**
## Becuase the world needs more Modpacks...
##### but i made a installer

### Windows:
* ##### This is the only part you need to install the modpack
>Powershell:
```
Invoke-WebRequest -Uri "https://github.com/itsmagu/MinecraftSnow/releases/download/Main/install-1.ps1" -OutFile (".\install-packages.ps1") -UseBasicParsing
.\install-1.ps1
```

* ##### Your done...

##### Update by running install-3.ps1 again inside of the instance folder


# All the code in the installer
> Powershell:
```
function Test-Administrator  
{
    $user = [Security.Principal.WindowsIdentity]::GetCurrent();
    (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)  
}
if (Test-Administrator) {
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
Get-ExecutionPolicy

echo 'starting install-2'
Invoke-WebRequest -Uri "https://github.com/itsmagu/MinecraftSnow/releases/download/Main/install-2.ps1" -OutFile 'install-2.ps1' -UseBasicParsing
Start-Process -Wait powershell {.\install-2.ps1}

} else {
    echo 'Run as Administrator and try again'
}
```

```
Clear-Host
Write-Output "Installation will start"
try
{
    git | Out-Null
   "Git is installed"
}
catch [System.Management.Automation.CommandNotFoundException]
{
   "No git"
   $git_url = "https://github.com/git-for-windows/git/releases/download/v2.37.3.windows.1/Git-2.37.3-64-bit.exe"
   if (!(Test-Path -Path '.\git.exe' -PathType Leaf)){
       Invoke-WebRequest -Uri $git_url -OutFile 'git.exe' -UseBasicParsing
   }
   Start-Process .\git.exe -Wait
   Remove-Item -Force .\git.exe
}
try
{
    java | Out-Null
   "Java is installed"
}
catch [System.Management.Automation.CommandNotFoundException]
{
   "Java is not installed"
   $java_url = "https://javadl.oracle.com/webapps/download/AutoDL?BundleId=246808_424b9da4b48848379167015dcc250d8d"
   if (!(Test-Path -Path '.\javainit.exe' -PathType Leaf)){
       Invoke-WebRequest -Uri $java_url -OutFile 'javainit.exe' -UseBasicParsing
   }
   Start-Process .\javainit.exe -Wait
   Remove-Item -Force .\javainit.exe
}
if (!(Test-Path -Path '.\mmc.zip' -PathType Leaf)){
    Write-Output "Downloading MultiMC"
    Invoke-WebRequest -Uri 'https://files.multimc.org/downloads/mmc-stable-win32.zip' -OutFile 'mmc.zip' -UseBasicParsing
}
if (!(Test-Path -Path 'C:\MultiMC')){
    Write-Output "Installing MultiMC"
    if ((Test-Path -Path 'C:\MultiMC\instances\1.16.5')){
        Write-Output "MultiMC is installed but not clean?"
        Write-Output "Deleting MultiMC and reinstalling"
        Remove-Item -Force -Recurse 'C:\MultiMC'
    }
    Expand-Archive .\mmc.zip -DestinationPath C:\
    Remove-Item -Force .\mmc.zip
}
if (!(Test-Path -Path 'C:\MultiMC\instances')){
    mkdir 'C:\MultiMC\instances'
}
if (!(Test-Path -Path 'C:\MultiMC\instances\1.16.5')){
    mkdir 'C:\MultiMC\instances\1.16.5'
} else { 
    echo 'instance found, this is wrong.'
    echo 'To fix this the installer is made to delete all overlaping'
    echo 'instances and installing them from scratch'
    Remove-Item -Recurse -Force 'C:\MultiMC\instances\1.16.5'
    mkdir 'C:\MultiMC\instances\1.16.5'
}
Write-Output "Cleaned"

Write-Output "Added shortcut to start menu"
Set-Location 'C:\MultiMC\instances\1.16.5\'
Invoke-WebRequest -Uri "https://github.com/itsmagu/MinecraftSnow/releases/download/Main/install-3.ps1" -OutFile 'install-3.ps1' -UseBasicParsing
Start-Process -Wait powershell {.\install-3.ps1}
Write-Output "Fully Done"
& 'C:\MultiMC\MultiMC.exe'
Write-Output "Safe to Close"
$WshShell = New-Object -comObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("C:\ProgramData\Microsoft\Windows\Start Menu\Programs\MinecraftSnow.lnk")
$Shortcut.TargetPath = "C:\MultiMC\MultiMC.exe -l 1.16.5"
$Shortcut.Save()
Write-Host -Object ('press any key... ' -f [System.Console]::ReadKey().Key.ToString());
```

```
Clear-Host
Write-Output "Starting:"
if (Test-Path -Path .\.git) {
  Write-Output "Cleaning for git"
  git stash
  Write-Output "Updating..."
  git pull
} else {
  Write-Output "Downloading all files"
  git clone https://github.com/itsmagu/MinecraftSnow
  Move-Item .\MinecraftSnow\.git .\
  Move-Item .\MinecraftSnow\* .\
  Remove-Item .\MinecraftSnow
  mkdir .\.minecraft\mods
}
if (Test-Path -Path ".\.minecraft\mods") {
    Remove-Item ".\.minecraft\mods\**" -Recurse -Force
}
Write-Output ("reading " + $file_data.Count/2 + " installorders...")
$file_data = Get-Content ./installorders
Write-Output "installing..."
for ($index = 0; $index -lt $file_data.Count; $index+=2) {
  if (!(Test-Path -Path (".\.minecraft\mods\" + $file_data[$index]) -PathType Leaf)) {
    Invoke-WebRequest -Uri $file_data[$index+1] -OutFile (".\.minecraft\mods\"+$file_data[$index]) -UseBasicParsing
    Write-Output ($file_data[$index]+" installed...")
  }
}
Write-Output "Done."
```
Clear-Host
Write-Output "Starting:"
if (Test-Path -Path '.\.git') {
  git config --global --add safe.directory C:/MultiMC/instances/1.16.5
  Write-Output "Cleaning for git"
  git stash
  Write-Output "Updating..."
  git pull
} else {
  Write-Output "Downloading all files"
  git clone https://github.com/itsmagu/MinecraftSnow
  Move-Item '.\MinecraftSnow\.git' '.\'
  Move-Item '.\MinecraftSnow\*' '.\'
  Remove-Item '.\MinecraftSnow'
  if (!(Test-Path -Path ".\.minecraft\mods")) {
    mkdir '.\.minecraft\mods'
  } else {
    Remove-Item ".\.minecraft\mods\**" -Recurse -Force
  }
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
# **Minecraft Snow**
## Becuase the world needs more Modpacks...
##### but i made a installer

### Windows:
* ##### install git if you don't have that
>Powershell:
```
winget install 'git.git'
```
* ##### download the installer
>Powershell:
```
mkdir .\1.16.5
Invoke-WebRequest -Uri "https://github.com/itsmagu/MinecraftSnow/releases/download/Main/install.ps1" -OutFile (".\1.16.5\install.ps1") -UseBasicParsing
cd "1.16.5"
.\install.ps1

```
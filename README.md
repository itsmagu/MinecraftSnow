# **Minecraft Snow**
## Becuase the world needs more Modpacks...
##### but i made a installer

### Windows:
* ##### One command install :
>Powershell:
```
Invoke-WebRequest -Uri "https://github.com/itsmagu/MinecraftSnow/releases/download/Main/install-2.ps1" -OutFile (".\install-2.ps1") -UseBasicParsing
Start-Process powershell -verb runas -ArgumentList "-file .\install-2.ps1"
```

* ##### Your done...

##### Update by running install-3.ps1 again inside of the instance folder
##### You might need to run this in Powershell as Administrator:
```
Set-ExecutionPolicy -ExecutionPolicy Unrestricted -Scope LocalMachine
```
##### if the installer wont start
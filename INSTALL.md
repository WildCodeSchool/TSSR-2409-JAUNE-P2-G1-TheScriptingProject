
# Guide d'installation :

## Besoins initiaux : besoins du projet

Pour ce projet, nous prendrons les adresses IP suivantes : 

| **Machines**   | **Adresses IP** |
|----------------|-----------------|
| Win Sever 2022 | 172.16.10.5     |
| Debian 12      | 176.16.10.10    |
| Win 10         | 172.16.10.20    |
| Ubuntu 22.04   | 172.16.10.30    |
| DG             | 172.16.10.254   |
| Masque sous Res| 255.255.255.0   |
| DNS            |  8.8.8.8        |



Nous utiliserons ici des VM sur Proxmox

## Prérequis VM

# Prérequis technique Windows Serveur et Client

## Windows Serveur
- OS : **Windows Server 2022 21H2**
- Hostname : **SRVWIN01**
- @IP : **172.16.10.5**
- Firewall : **Off**
- Compte actif : **Administrator**
- Logiciels installés : **PowerShell Core** 
- Services activés: **WinRM**
- Script Execution Policy : **Unrestricted**

## Windows Client
- OS : **Windows 10 Pro 22H2**
- Hostname : **CLIWIN01**
- @IP : **172.16.10.20**
- Firewall : **Off**
- Compte actif : **wilder** et **Administrateur**
- Logiciels installés : **PowerShell Core** 
- Services activés: **WinRM**
- Script Execution Policy : **Unrestricted** 

## Renommer les machines : 

Pour ce projet, nous allons donner les noms suivants aux machines : 
- Debian : SRVLX01  
- Ubuntu : CLILIN01 
- Windows Server : SRVWIN01 
- Windows 10: CLIWIN01

**Pour les machines Windows :**

Nous allons chercher *nom* dans le menu démarrer.   
Nous cliquons sur **Afficher le nom de votre PC** et nous le modifions.   
Nous redémarrons la machine.   

Nous allons aussi modifier le fichier hosts qui est sous C:\Windows\System32\drivers\etc : 

- Pour le serveur, ajouter (avec le compte Administrator) :  
```

172.16.10.10 SRVLX01
172.16.10.20 CLIWIN01
172.16.10.30 CLILIN01
```
  
- Pour le client, ajouter (avec le compte Administrateur) :  
```

172.16.10.10 SRVLX01 
172.16.10.5 SRVWIN01
172.16.10.30 CLILIN01
```

**Pour les machines Linux :**

Nous allons éditer le ficher /etc/hostname et changer le nom du PC : 
```Bash
nano /etc/hostname
```

Nous allons aussi modifier le fichier /etc/hosts : 

- Pour le serveur, ajouter (en root) :
```

172.16.10.5 SRVWIN01 
172.16.10.20 CLIWIN01
172.16.10.30 CLILIN01

```

  
- Pour le client, ajouter (en éditant avec un sudo) :
```

172.16.10.10 SRVLX01
172.16.10.5 SRVWIN01
172.16.10.20 CLIWIN01
```


L'ensemble de nos noms de machines est maintenant modifié.   

## Installation et configuration du ssh sur le client Ubuntu

- Installer Openssh  
`sudo apt update`    
`sudo apt install openssh-server `   

- Pour activer et démarrer le service SSH. \
`sudo systemctl enable sshd`   
`sudo systemctl start sshd` 
- Pour vérifier si SSH est activé \
`sudo systemctl status sshd`\
Si le service est actif, vous verrez une ligne indiquant que le service "Active: active (running)"

## Configuration de WinRM sur le serveur SRVWIN01

- Assurez-vous que le service WinRM (Windows Remote Management) est activé et en
cours d'exécution :
Si nécessaire, ouvrez PowerShell en tant qu'administrateur
Exécutez la commande suivante pour démarrer le service WinRM :\
``Start-Service -Name WinRM``    
- Configurez WinRM pour permettre l'accès à distance:\
Exécutez la commande suivante pour configurer WinRM pour les accès à distance  
``Enable-PSRemoting -Force ``   
- Ajouter le PC client à la liste des hôte de confiance avec la commande :   
``Set-Item WSMan:\localhost\Client\TrustedHosts -Value "172.16.10.20" -Force ``   

## Configuration de WinRM sur le client CLIWIN01  

- Assurez-vous que le service WinRM est activé et en cours d'exécution :
Si nécessaire, ouvrez PowerShell en tant qu'administrateur :   
- Exécutez la commande suivante pour démarrer le service WinRM  
``Set-Service -Name winrm -StartupType Automatic``   
- Pour démarrer le service immédiatement, utilise   
``Start-Service -Name WinRM``   
- Configurez les paramètres de l'hôte distant pour permettre la connexion à distance :   
Exécutez la commande suivante pour configurer les paramètres de l'hôte distant :     
`Set-Item WSMan:\localhost\Client\TrustedHosts -Value SRVWIN01 -Force`   

## Activation de l'exécution de script le serveur et le client Windows
- Afin de pouvoir exécuter les scripts sans soucis, il faut sur le client et le serveur, effectuer la commande suivante :
```PowerShell
Set-ExecutionPolicy -Scope LocalMachine -ExecutionPolicy Unrestricted
```
> *La commande sur le client peut être effectuées en remote lors de la première connexion PowerShell distante.*



## Divers 

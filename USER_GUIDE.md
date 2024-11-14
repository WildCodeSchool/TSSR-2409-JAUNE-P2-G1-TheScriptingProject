# Documentiation utilisateur

# Utilisation 

Pour utiliser le script,  il vous suffit de suivre le menu déroulant en tappant le chiffre correpsondant à votre choix.

Par exemple si vous souhaiter obtenir la version de l'os sur le script bash :

1. tapper 2 pour rentrer dans le menu prdinateur
2. tapper 2 pour récuprérer ue information
3. tapepr 1 pour avoir une information sur la machine
4. tapper 1 pour avoir la version de l'os


- le fichier `info_utilisateur_date.txt` enregistre les actions faites. Il se trouve au chemin suivant **/home/Documents** pour linux et pour windows**C:\users\administrateur\Documents**

- Le fichier `log_evt.log` qui enrengistre les activité ce trouve dans **C:\Windows\System32\LogFiles**.


# Utilisation du script PowerShell (solution de contournement)

## Préparation de son environnement de travail

Le script devant s'exécuter sur le poste client pour le moment, il est nécessaire de préparer son environnement afin d'avoir une utilisation sans accroc du script.

Avant de lancer le script, un explorateur de fichier depuis le serveur et saisissez dans l'URL de l'explorateur ce qui suit afin d'établir une connexion **UNC** :
`\\"IPduServeur"\C$\Users\Administrateur\Documents`

Vous êtes alors invité à vous connecter avec le compte `Administrateur` présent sur le client.
Un fois connecté sur le client avec le compte `Administrateur`, vous allez pouvoir y déposer le script PowerShell depuis le serveur. (Attention importer aussi le fichier de module `.psm1` avec le script)

**(Optionnel)** :
Vous pouvez aussi créer un raccourci afin d'accéder au fichier log plus facilement. Pour cela créer un nouveau raccourci et saisissez le chemin qui suit :
`\\"IPdServeur"\C$\Windows\System32\LogFiles\log_evt.log`

>*Il faut avoir lancé la console au moins une fois avant de pouvoir créer ce raccourci, autrement cela vous dira que le fichier n'existe pas. Ce qui est normal comme le fichier n'a pas encore été créé.*


## Lancement du script en Remote avec PowerShell 7

Sur le serveur lancer **PowerShell 7** en tant qu'**Administrateur**. Une fois dans la console saisissez ce qui suit afin d'établir une connexion entre le serveur et le client :
```PowerShell
Enter-PSSession -ComputerName "NomDuServeur" -Credential Administrateur -ConfigurationName "PowerShell.7`
```

Saisissez le mot de passe de la session **Administrateur** présente sur le client
vous devriez maintenant être connecter. Afin de vous assurez que vous utilisé la bonne version de PowerShell sur le client vous pouvez vérifier la version de PowerShell en tapant la commande suivante : 
```PowerShell
$PSVersionTable
```

L'attribut `PSVersion` devant indiquer 7.4.5 ou 7.4.6.

Désormais, vous n'avez plus qu'à vous déplacer la ou vous avez déposé le script, puis l'exécuter.
Les informations que vous récupérerez seront enregistré au format texte dans le dossier `C:\Users\Administrateur\Documents` au format `info_"YYYYMMJJ"_"Cible".txt`

Une fois terminé vous pouvez sortir du Remote avec la commande :
```PowerShell
exit
```


## Astuce

Dans le cas ou à chaque exécution du script il vous demande si vous faites confiance au fichier et que vous devez valider. Vous pouvez ajouter le script au script de confiance avec la commande suivante : 
```PowerShell
Unblock-File -Path "CheminDuScript"\"Script.ps1","CheminDuScript"\"ModuileScript.psm1"
```

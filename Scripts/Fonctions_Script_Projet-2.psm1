# ---------------------------------------------------------------------------------------------------------------------------------
#                                                 FONCTION LOGS

# Fonction pour redirection vers fichier de log
function custom_log {
    param (
        [string]$message
    )
    Write-Output "$(Get-Date -UFormat "%Y/%m/%d - %H:%M:%S") - $($ENV:USERNAME) - $message" >> "C:\Windows\System32\LogFiles\log_evt.log"
}

# ---------------------------------------------------------------------------------------------------------------------------------
#                                                 FONCTION ACTIONS SUR COMPTE ET GROUPE

# Fonction -> Création de compte utilisateur local
function Création_De_Compte_Utilisateur_Local {   
    # Demander le nom d'utilisateur
    $username = Read-Host "Entrez le nom de l'utilisateur à créer"

    # Vérifier si l'utilisateur existe déjà
    if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
        Write-Host "L'utilisateur '$username' existe déjà !"
    exit
    }

    # Demander le mot de passe de l'utilisateur
    $password = Read-Host "Entrez le mot de passe pour l'utilisateur '$username'" -AsSecureString

    # Créer un nouvel utilisateur local
    try {
        New-LocalUser -Name $username -Password $password -FullName $username -Description "Compte utilisateur local créé via script" -PasswordNeverExpires
        Write-Host "L'utilisateur '$username' a été créé avec succès."
    }
    catch {
        Write-Host "Erreur lors de la création de l'utilisateur : $_"
    exit
    }
}

# Fonction -> Changement de mot de passe
function Changement_De_Mot_De_Passe {

    # Demander le nom de l'utilisateur pour lequel changer le mot de passe
    $utilisateur = Read-Host -Prompt "Entrez le nom de l'utilisateur"

        # Vérifier si l'utilisateur existe
    if (Get-LocalUser -Name $utilisateur -ErrorAction SilentlyContinue) {
        # Demander le nouveau mot de passe
        $nouveauMDP = Read-Host -Prompt "Entrez le nouveau mot de passe pour $utilisateur" -AsSecureString

        # Modifier le mot de passe de l'utilisateur
        Set-LocalUser -Name $utilisateur -Password $nouveauMDP

        # Vérifier si la commande a réussi
        if ($?) {
        Write-Host "Le mot de passe a été changé avec succès pour $utilisateur."
        } 
        else {
            Write-Host "Erreur lors du changement du mot de passe."
        }
    } 
    else {
        Write-Host "L'utilisateur $utilisateur n'existe pas."
        exit 1
    }
}
# Fonction -> Suppression de compte utilisateur local
# Fonction -> Désactivation de compte utilisateur local

# Fonction -> Ajout à un groupe d'administration
function add_user_group_admin {
    $userName = Read-Host -prompt "Saisir le nom du compte à ajouter au groupe Administrateur"
    if ([string]::IsNullOrEmpty($userName)) { 
        Write-Output "Pas de nom d'utilisateur saisi"
    }
    else{
        try {
            Add-LocalGroupMember -Group "Administrateurs" -Member "$userName"
            Write-Output "Ajout de $userName au groupe d'administration"
        }
        catch {
            Write-Output "Erreur : impossible d'ajouter l'utilisateur $userName au groupe Administrateur."
        }
    }
}

# Fonction -> Ajout à un groupe local
function add_user_group_local {    
    $userName = Read-Host -prompt "Saisir le nom du compte à ajouter à un groupe"
    Clear-Host
    if ([string]::IsNullOrEmpty($userName)) { 
        Write-Output "Pas de nom d'utilisateur saisi"
    }
    else{
        $groupName = Read-Host -prompt "Saisir le nom du groupe"
        Clear-Host
        if ([string]::IsNullOrEmpty($groupName)) {
            Write-Output "Pas de nom de groupe saisi"
        }
        else{
            try {
                Add-LocalGroupMember -Group  "$groupName" -Member "$userName" 
                Write-Output "Ajout de $userName au groupe $groupName"
            }
            catch {
                Write-Output "Erreur : impossible d'ajouter l'utilisateur $userName au groupe $groupName."
            }
        }   
    }
}

# Fonction -> Sortie d’un groupe local
function del_user_group_local {
    $userName = Read-Host -prompt "Saisir le nom du compte à retirer du groupe"
    Clear-Host
    if ([string]::IsNullOrEmpty($userName)) { 
        Write-Output "Pas de nom d'utilisateur saisi"
    }
    else{
        $groupName = Read-Host -prompt "Saisir le nom du groupe"
        Clear-Host
        if ([string]::IsNullOrEmpty($groupName)) {
                Write-Output "Pas de nom de groupe saisi"
        }
            try {
                Remove-LocalGroupMember -Group "$groupName" -Member "$userName"
                Write-Output "Suppression de $userName du groupe $groupName"
            }
            catch {
                Write-Output "Erreur : impossible de retirer l'utilisateur $userName au groupe $groupName."
            }
        }  
}

# ---------------------------------------------------------------------------------------------------------------------------------
#                                              FONCTIONS INFORMATIONS SUR COMPTE ET GROUPE
# Fonction -> Date de dernière connexion d’un utilisateur
function user_last_logon {
    $userName = Read-Host -prompt "Saisir le nom du compte" 

    if ([string]::IsNullOrEmpty($userName)) { 
        Write-Host "Aucun nom d'utilisateur saisi" -ForegroundColor Yellow
        return
    }

    $localUser = Get-LocalUser "$userName" -ErrorAction SilentlyContinue

    if ( -not $localUser ) {
        Write-Host "Aucun utilisateur de ce nom" -ForegroundColor Yellow
    }
    else{
        Write-Output "Dernière connexion le $($localUser.lastlogon)" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        Write-Host "Information envoyé dans "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt""
    }
}

# Fonction -> Date de dernière modification du mot de passe
# Fonction -> Liste des sessions ouvertes par l'utilisateur
# Fonction -> Groupe d’appartenance d’un utilisateur
# Fonction -> Historique des commandes exécutées par l'utilisateur
# Fonction -> Droits/permissions de l’utilisateur sur un dossier
# Fonction -> Droits/permissions de l’utilisateur sur un fichier

# ---------------------------------------------------------------------------------------------------------------------------------
#                                              FONCTIONS ACTIONS SUR HOTE DISTANT
# Fonction -> Arrêt
function Arrêt_De_La_Machine{

    Write-Output "Arrêt de la machine en cours..."
    Stop-Computer
    }

# Fonction -> Redémarrage
function  Redémarrage_De_La_Machine { 

    Write-Output "Redémarrage de la machine en cours..."
    Restart-Computer
} 

# Fonction -> Verrouillage
function  Verrouillage_De_La_Machine {

    Write-Output "Verrouillage de la machine..."
    RUNDLL32.EXE user32.dll,LockWorkStation
}

# Fonction -> Mise-à-jour du système
function  Mise_A_Jour_Du_Système {

    Write-Output "Mise à jour de la machine en cours..."

    # Activer le module Windows Update s'il n'est pas déjà installé
    #Install-Module PSWindowsUpdate -Force -Scope CurrentUser
    # Définir la politique d'exécution
    #Set-ExecutionPolicy RemoteSigned -Scope "Process ou CurrentUser ou LocalMachine"
    # Importer le module
    #Import-Module PSWindowsUpdate

    # Rechercher les mises à jour disponibles
    Write-Output "Recherche des mises à jour disponibles..."
    $updates = Get-WindowsUpdate

    # Installer les mises à jour
    if ($updates) {
        Write-Output "Installation des mises à jour..."
        Install-WindowsUpdate -AcceptAll -AutoReboot
    } else {
        Write-Output "Aucune mise à jour disponible."
    }

    Write-Output "Mises à jour terminées."
}

# Fonction -> PMAD
# Fonction -> Création de répertoire
# Fonction -> Modification de répertoire
# Fonction -> Suppression de répertoire
# Fonction -> Activation du pare-feu
# Fonction -> Désactivation du pare-feu
# Fonction -> Installation de logiciel
function install_soft {
    install-package
}

# Fonction -> Désinstallation de logiciel
function uninstall-soft {
    uninstall-package
}

# Fonction -> Exécution de script sur la machine distante
function execution_script {
    invoke-command
}

# ---------------------------------------------------------------------------------------------------------------------------------
#                                              FONCTIONS INFORMATIONS SUR HOTE DISTANT
# Fonction -> Version de l'OS
function version_os {
    Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version
}

# Fonction -> Mémoire RAM totale
function ram_totale {
    Get-CimInstance win32_physicalmemory | Format-Table Capacity
}

# Fonction -> Utilisation de la RAM
function ram_utilisation {
    Get-ComputerInfo | Select-Object TotalPhysicalMemory, OsTotalVisibleMemory, OsFreePhysicalMemory
}

# Fonction -> Liste des utilisateurs locaux
function liste_utilisateurs {
    Get-LocalUser
}

# Fonction -> Nombre de disque
function nombre_Disque {
    Get-Disk
}

# Fonction -> Partition (nombre, nom, FS, taille) par disque
function partition {
    Get-Partition
}

# Fonction -> Espace disque restant par partition/volume
function espace_Restant {
    Get-Volume
}

# Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
function nom_espace_dossier {

}


# Fonction -> Liste des lecteurs monté (disque, CD, etc.)
function liste_lecteur {
    Get-psdrive
}

# Fonction -> Liste des applications/paquets installées
function liste_Appli {
    Get-Appxpackage
}

# Fonction -> Liste des services en cours d'execution
function service_runing {
    Get-service
}

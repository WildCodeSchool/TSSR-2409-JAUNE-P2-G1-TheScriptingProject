
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
#                                                 FONCTION TEST UTILISATEUR

# Fonction afin de tester si un utilisateur existe ou si rien n'a été saisi
function test_user {

    $global:userName = Read-Host -prompt "Saisir le nom du compte" 
    Clear-Host

    if ([string]::IsNullOrEmpty($userName)) { 
        
        Write-Host "Aucun utilisateur saisi" -ForegroundColor Yellow
        return
    }

    $localUser = Get-LocalUser "$userName" -ErrorAction SilentlyContinue

    if ( -not $localUser ) {
        Write-Host "Aucun utilisateur nommé `"$userName`"" -ForegroundColor Yellow
        return
    }
}


# ---------------------------------------------------------------------------------------------------------------------------------
#                                                 FONCTION ACTIONS SUR COMPTE ET GROUPE

# Fonction -> Création de compte utilisateur local
function Création_De_Compte_Utilisateur_Local {   
    # Demander le nom d'utilisateur
    $username = Read-Host "Entrez le nom de l'utilisateur à créer"
    Clear-Host

    # Vérifier si l'utilisateur existe déjà
    if (Get-LocalUser -Name $username -ErrorAction SilentlyContinue) {
        Write-Host "L'utilisateur '$username' existe déjà !"
        return
    }

    # Demander le mot de passe de l'utilisateur
    $password = Read-Host "Entrez le mot de passe pour l'utilisateur '$username'" -AsSecureString
    Clear-Host

    # Créer un nouvel utilisateur local
    try {
        New-LocalUser -Name $username -Password $password -FullName $username -Description "Compte utilisateur local créé via script" -PasswordNeverExpires
        Write-Host "L'utilisateur '$username' a été créé avec succès."
        custom_log "ACTION - L'utilisateur '$username' a été créé avec succès."
    }
    catch {
        Write-Host "Erreur lors de la création de l'utilisateur : $userName"
        custom_log "ACTION - Erreur lors de la création de l'utilisateur : $userName"
        return
    }
}

# Fonction -> Changement de mot de passe
function Changement_De_Mot_De_Passe {

    # Demander le nom de l'utilisateur pour lequel changer le mot de passe
    
    $utilisateur = Read-Host -Prompt "Entrez le nom de l'utilisateur"
    Clear-Host

        # Vérifier si l'utilisateur existe
    if (Get-LocalUser -Name $utilisateur -ErrorAction SilentlyContinue) {
        # Demander le nouveau mot de passe
        $nouveauMDP = Read-Host -Prompt "Entrez le nouveau mot de passe pour $utilisateur" -AsSecureString
        Clear-Host

        # Modifier le mot de passe de l'utilisateur
        Set-LocalUser -Name $utilisateur -Password $nouveauMDP

        # Vérifier si la commande a réussi
        if ($?) {
            Write-Host "Le mot de passe a été changé avec succès pour $utilisateur."
            custom_log "ACTION - Le mot de passe a été changé avec succès pour $utilisateur."
        } 
        else {
            Write-Host "Erreur lors du changement du mot de passe pour $utilisateur."
            custom_log "ACTION - Erreur lors du changement du mot de passe pour $utilisateur."
        }
    } 
    else {
        Write-Host "L'utilisateur $utilisateur n'existe pas."
        return
    }
}

# Fonction -> Suppression de compte utilisateur local
function Suppression_du_compte_utilisateur 
{
# Demander le nom d'utilisateur à supprimer
$userName = Read-Host "Quel utilisateur doit être supprimé du compte local ?"
Clear-Host

# Tester si l'utilisateur à supprimer existe
if (Get-LocalUser -Name $userName -ErrorAction SilentlyContinue) 
{
    Write-Host "L'utilisateur '$userName' existe !"
}
else {
    Write-Host "Utilisateur $userName inconnu"
    return
}
$validation = Read-Host "Confirmation de la suppression de l'utilisateur $userName [o/n]"
Clear-Host
switch ($validation) {
    "o"{
        custom_log "ACTION - Validation de la suppression du compte $UserName"
        # suppression de l'utilisateur
    if (Remove-LocalUser -Name $userName)
    {
        Write-Host "Echec de la suppression de l'utilisateur $userName"
        custom_log "ACTION - Echec de la suppression de l'utilisateur $userName"
    }
    else {
        Write-Host "Utilisateur $userName supprimé avec succès"
        custom_log "ACTION - Utilisateur $userName supprimé avec succès"
    }
    }
    "n" {
        # pas de suppression
        Write-Host "Suppression du compte $userName annulé"
        custom_log "ACTION - Suppression du compte $userName annulé"

    }
    Default {
        Write-Host "Erreur de saisie"
    }
}
}

# Fonction -> Désactivation de compte utilisateur local


# Fonction -> Ajout à un groupe d'administration
function add_user_group_admin {
    
    test_user    
    
    try {
        Add-LocalGroupMember -Group "Administrateurs" -Member "$userName" -ErrorAction Stop
        Write-Host "Ajout de $userName au groupe Administrateurs" -ForegroundColor Cyan
        custom_log "ACTION - Ajout de $userName au groupe Administrateurs"
    }
    catch {
        Write-Host "Erreur : impossible d'ajouter l'utilisateur $userName au groupe Administrateurs." -ForegroundColor Red
        Write-Host "Vérifiez que l'utilisateur n'est pas déjà membre du groupe Administrateurs et que le script soit bien lancé en tant qu'administrateur" -ForegroundColor Yellow
        custom_log "ACTION - Erreur : impossible d'ajouter l'utilisateur $userName au groupe Administrateurs."
    }
    
    
}


# Fonction -> Ajout à un groupe local
function add_user_group_local {    

    test_user
    
    $groupName = Read-Host -prompt "Saisir le nom du groupe"
    Clear-Host
    if ([string]::IsNullOrEmpty($groupName)) {
        Write-Output "Pas de nom de groupe saisi"
    }

    $localGroup = Get-LocalGroup "$groupName" -ErrorAction SilentlyContinue

    if ( -not $localGroup ) {
        Write-Host "Aucun groupe nommé `"$groupName`"" -ForegroundColor Yellow
        return
    }

    
        try {
            Add-LocalGroupMember -Group  "$groupName" -Member "$userName" -ErrorAction Stop 
            Write-Output "Ajout de $userName au groupe $groupName"
            custom_log "ACTION - Ajout de $userName au groupe $groupName"
        }
        catch {
            Write-Host "Erreur : impossible d'ajouter l'utilisateur $userName au groupe $groupName." -ForegroundColor Red
            Write-Host "Vérifiez que l'utilisateur n'est pas déjà membre du groupe $groupName et que le script soit bien lancé en tant qu'administrateur" -ForegroundColor Yellow
            custom_log "ACTION - Erreur : impossible d'ajouter l'utilisateur $userName au groupe $groupName."
        }
}   



# Fonction -> Sortie d’un groupe local
function del_user_group_local {

    test_user

    
    $groupName = Read-Host -prompt "Saisir le nom du groupe"
    Clear-Host
    if ([string]::IsNullOrEmpty($groupName)) {
            Write-Output "Pas de nom de groupe saisi"
    }

    $localGroup = Get-LocalGroup "$groupName" -ErrorAction SilentlyContinue

    if ( -not $localGroup ) {
        Write-Host "Aucun groupe nommé `"$groupName`"" -ForegroundColor Yellow
        return
    }
        try {
            Remove-LocalGroupMember -Group "$groupName" -Member "$userName" -ErrorAction Stop
            Write-Output "Suppression de $userName du groupe $groupName"
            custom_log "ACTION - Suppression de $userName du groupe $groupName"
        }
        catch {
            Write-Host "Erreur : impossible de retirer l'utilisateur $userName du groupe $groupName." -ForegroundColor Red
            Write-Host "Vérifiez que l'utilisateur soit membre du groupe $groupName et que le script soit bien lancé en tant qu'administrateur" -ForegroundColor Yellow
            custom_log "ACTION - Erreur : impossible de retirer l'utilisateur $userName du groupe $groupName."
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
        Write-Host "Dernière connexion le $($localUser.lastlogon)`n" -ForegroundColor Cyan
        Write-Output "Dernière connexion de l'utilisateur $UserName le $($localUser.lastlogon)" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        Write-Host "-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
}

# Fonction -> Date de dernière modification du mot de passe
function user_last_password_change {
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
        Write-Host "Dernière changement de mot de passe pour le compte $userName, le $($localUser.PasswordLastSet)`n" -ForegroundColor Cyan
        Write-Output "Dernière changement de mot de passe pour le compte $userName, le $($localUser.PasswordLastSet)" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        Write-Host "-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
}

# Fonction -> Liste des sessions ouvertes par l'utilisateur
function current_user_session {

    test_user

    $localUserSession = Get-WmiObject -Class Win32_LoggedOnUser | Select-Object Antecedent  | Where-Object { $_.Antecedent -match $userName }

    if ($localUserSession.Count -le 1 ) {
        Write-Host "l'utilisateur a $($localUserSession.Count) session en cours" -ForegroundColor Cyan
        custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
    elseif ($localUserSession.Count -le 0) {
        Write-Host "l'utilisateur n'a aucune session en cours" -ForegroundColor Cyan
        custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    } 
    else {
        Write-Host "l'utilisateur a $($localUserSession.Count) sessions en cours" -ForegroundColor Cyan
        custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
}




# Fonction -> Groupe d’appartenance d’un utilisateur
function local_group_info {    
    
    test_user

    Write-host "l'utilisateur $userName est membre des groupes :" -ForegroundColor Cyan
    Write-Output "l'utilisateur $userName est membre des groupes :" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    
    Get-LocalGroup | ForEach-Object { 
        if ((Get-LocalGroupMember -Group $_.Name).Name -contains "$(hostname)\$userName") { 
            Write-host $_.Name -ForegroundColor Cyan
            Write-Output $_.Name >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            
        }
    }

    Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    
}

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
    
    Write-Host "Quel dossier souhaitez vous atteindre (Saisir le chemin absolu du dossier)?"

    $destinationDir = read-host
    Clear-Host 

    Write-Host "Sous quel format souhaitez vous afficher la taille du dossier ?"
    Write-Host "G) Giga-Octets"
    Write-Host "M) Mega-Octets"
    Write-Host "K) Kilo-Octets"
    Write-Host "O) Octets"
    $sizeType = Read-Host
    
    Clear-Host

    switch ($sizeType){
        "G" {
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum / 1Gb,2)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Go`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Go" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }

        "M" {
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum / 1Mb,2)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Mo`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Mo" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }

        "K" {
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum / 1Kb,2)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Ko`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Ko" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }

        "O" {
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Octets`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Octets" >> "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            custom_log "INFORMATION - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }
        Default {
            Write-host "Erreur de saisie !"
        }
    } 
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

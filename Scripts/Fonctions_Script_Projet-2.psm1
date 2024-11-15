
# ---------------------------------------------------------------------------------------------------------------------------------
#                                                 FONCTION LOGS

# Fonction pour redirection vers fichier de log
function custom_log {
    param (
        [string]$message
    )
    try {
        # Formate le log avec date et nom d'utilisateur exécutant le script et récupère l'attribut. 
        # Envoie et ajoute au fichier log avec encodage UTF8 afin d'éviter les problème d'affichage à cause de l'encodage windows
        Write-Output "$(Get-Date -UFormat "%Y/%m/%d - %H:%M:%S") - $($ENV:USERNAME) - $message"  | Out-File -LiteralPath "C:\Windows\System32\LogFiles\log_evt.log" -Encoding utf8 -Append 
    }
    catch {
        # Message d'erreur indiquant qu l'user n'est pas connecté en tant qu'admin
        Write-Host "Erreur : Ecriture des logs impossible, les actions effectuées ne seront pas consignées.`nVérifiez que le script soit lancé en tant qu'administrateur" -ForegroundColor Yellow
        return
    }
}


# ---------------------------------------------------------------------------------------------------------------------------------
#                                                 FONCTION TEST UTILISATEUR

# Fonction afin de tester si un utilisateur existe ou si rien n'a été saisi
function test_user {

    # Initialise la variable userName en tant que variable globale
    $global:userName = Read-Host -prompt "Saisir le nom du compte" 
    Clear-Host

    # Test afin de savoir si la saisie est vide ou nul
    if ([string]::IsNullOrEmpty($userName)) { 
        
        Write-Host "Aucun utilisateur saisi" -ForegroundColor Yellow
        return
    }

    # Récupère le compte de l'utilisateur et ignore le message d'erreur si inexistant afin d'afficher message d'erreur custom
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
function Suppression_du_compte_utilisateur {
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
function Désactivation_du_compte_utilisateur {

    test_user
    
    $validation = Read-Host "Confirmation de la désactivation de l'utilisateur $userName [o/n]"
    Clear-Host

    switch ($validation) {
        "o"{
            # Désactivation de l'utilisateur
            custom_log "ACTION - Validation de la désactivation du compte $UserName"

            try {
                Disable-LocalUser -Name $userName -ErrorAction Stop
                Write-Host "Utilisateur $userName désactivé avec succès"
                custom_log "ACTION - Utilisateur $userName désactivé avec succès"
            }
            catch {
                # Affiche le message d'erreur correspondant sur l'impossibilté de désactivation du compte
                Write-Host "Erreur : impossible de désactiver le compte $userName : $($_.Exception.Message)" -ForegroundColor Red
                Write-Host "Vérifiez que le script soit lancé en tant qu'administrateur" -ForegroundColor Yellow
                custom_log "ACTION - Erreur : impossible de désactiver le compte $userName."
            }
        }
        "n" {
            # Pas de désactivation
            Write-Host "Désactivation du compte $userName annulée."
            custom_log "ACTION - Erreur : Désactivation du compte $userName annulée."
        }
        Default {
            Write-Host "Erreur de saisie"
        }
    }
}


# Fonction -> Ajout à un groupe d'administration
function add_user_group_admin {
    
    test_user    
    
    try {
        # Essaye d'ajouter au groupe, dans le cas d'une erreur, stop. Obligatoire comme la cmdlet ne stop pas nativement
        Add-LocalGroupMember -Group "Administrateurs" -Member "$userName" -ErrorAction Stop
        Write-Host "Ajout de $userName au groupe Administrateurs" -ForegroundColor Cyan
        custom_log "ACTION - Ajout de $userName au groupe Administrateurs"
    }
    catch {
        # Affiche un message d'erreur en cas d'jout impossible
        Write-Host "Erreur : impossible d'ajouter l'utilisateur $userName au groupe Administrateurs." -ForegroundColor Red
        Write-Host "Vérifiez que l'utilisateur n'est pas déjà membre du groupe Administrateurs et que le script soit lancé en tant qu'administrateur" -ForegroundColor Yellow
        custom_log "ACTION - Erreur : impossible d'ajouter l'utilisateur $userName au groupe Administrateurs."
    }
    
    
}


# Fonction -> Ajout à un groupe local
function add_user_group_local {    

    test_user

    # test le groupe fonctionne comme la fonction test_user
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
            Write-Host "Vérifiez que l'utilisateur n'est pas déjà membre du groupe $groupName et que le script soit lancé en tant qu'administrateur" -ForegroundColor Yellow
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
            Write-Host "Vérifiez que l'utilisateur soit membre du groupe $groupName et que le script soit lancé en tant qu'administrateur" -ForegroundColor Yellow
            custom_log "ACTION - Erreur : impossible de retirer l'utilisateur $userName du groupe $groupName."
        }
        
}

# ---------------------------------------------------------------------------------------------------------------------------------
#                                              FONCTIONS INFORMATIONS SUR COMPTE ET GROUPE

# Fonction -> Date de dernière connexion d’un utilisateur
function user_last_logon {
    test_user
    
    try{
        Write-Host "Dernière connexion le $($localUser.lastlogon)`n" -ForegroundColor Cyan
        Write-Host "-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        # Envoie l'information demandé vers le fichier d'information situé dans le profil de l'user exécutant le script et formate le nom du fichier. l'envoie avec encodage UTF 8 et ajoute en fin de fichier
        Write-Output "Dernière connexion de l'utilisateur $UserName le $($localUser.lastlogon)" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
        custom_log "INFORMATION - Date de dernière connexion d’un utilisateur - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
    Catch{
        Write-Host "Erreur sur la récupération de la dernière connexion de l'utilisateur $userName`n" -ForegroundColor Red
        custom_log "INFORMATION - Erreur sur la récupération de la dernière connexion de l'utilisateur $userName"
    }
}

# Fonction -> Date de dernière modification du mot de passe
function user_last_password_change {
    test_user
    
    try{
        Write-Host "Dernièr changement de mot de passe pour le compte $userName, le $($localUser.PasswordLastSet)`n" -ForegroundColor Cyan
        Write-Host "-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        Write-Output "Dernièr changement de mot de passe pour le compte $userName, le $($localUser.PasswordLastSet)" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
        custom_log "INFORMATION - Date de dernière modification du mot de passe - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
    catch{
        Write-Host "Erreur sur la récupération de la date du dernier changement du mot de passe du compte $userName" -ForegroundColor Red
        custom_log "INFORMATION - Erreur sur la récupération de la date du dernier changement du mot de passe du compte $userName"
    }
}

# Fonction -> Liste des sessions ouvertes par l'utilisateur
function current_user_session {

    test_user

    $localUserSession = Get-WmiObject -Class Win32_LoggedOnUser | Select-Object Antecedent  | Where-Object { $_.Antecedent -match $userName }

    if ($localUserSession.Count -le 1 ) {
        Write-Host "l'utilisateur $userName a $($localUserSession.Count) session en cours" -ForegroundColor Cyan
        Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        Write-Output "l'utilisateur $userName a $($localUserSession.Count) session en cours" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
        custom_log "INFORMATION - Liste des sessions ouvertes par l'utilisateur - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
    elseif ($localUserSession.Count -le 0) {
        Write-Host "l'utilisateur $userName n'a aucune session en cours" -ForegroundColor Cyan
        Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        Write-Output "l'utilisateur $userName n'a aucune session en cours" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
        custom_log "INFORMATION - Liste des sessions ouvertes par l'utilisateur - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    } 
    else {
        Write-Host "l'utilisateur $userName a $($localUserSession.Count) sessions en cours" -ForegroundColor Cyan
        Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        Write-Output "l'utilisateur $userName a $($localUserSession.Count) sessions en cours" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
        custom_log "INFORMATION - Liste des sessions ouvertes par l'utilisateur - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
}




# Fonction -> Groupe d’appartenance d’un utilisateur
function local_group_info {    
    
    test_user

    Write-host "l'utilisateur $userName est membre des groupes :" -ForegroundColor Cyan
    Write-Output "l'utilisateur $userName est membre des groupes :" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
    
    Get-LocalGroup | ForEach-Object { 
        if ((Get-LocalGroupMember -Group $_.Name).Name -contains "$(hostname)\$userName") { 
            Write-host $_.Name -ForegroundColor Cyan
            Write-Output $_.Name | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
            
        }
    }

    Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    custom_log "INFORMATION - Liste des sessions ouvertes par l'utilisateur - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    
}

# Fonction -> Historique des commandes exécutées par l'utilisateur
function user_shell_history {

    test_user

    try {
        # Récupère les logs personne de l'user ciblé dans %AppData%\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.tx
        Copy-Item -Path "C:\Users\$($userName)\AppData\Roaming\Microsoft\Windows\PowerShell\PSReadline\ConsoleHost_history.txt" -Destination "$([Environment]::GetFolderPath("MyDocuments"))\Export_Get-History_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -ErrorAction Stop
        Write-Host "L'historique de commande de l'utilisateur $userName a été envoyé vers $([Environment]::GetFolderPath("MyDocuments"))\Export_Get-History_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -ForegroundColor Cyan
        Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        custom_log "INFORMATION - Historique des commandes exécutées par l'utilisateur - Envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    }
    catch {
        Write-Host "Erreur lors de l'export de l'historique" -ForegroundColor Red
        write-host "Possible si l'utilisateur n'a jamais saisi de commande" -ForegroundColor Yellow
        Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        custom_log "INFORMATION - Erreur lors de l'export de l'historique"
    }
}




# Fonction -> Droits/permissions de l’utilisateur sur un dossier
# Fonction -> Droits/permissions de l’utilisateur sur un fichier

function acl_file_and_directory {
    $dirPath =  (Read-Host "Sur quel dossier ou fichier souhaitez vous voir les permissions ? (Par défaut dossier courant)`n") -replace "^$","."
    Clear-Host

    # Récupère les droits ACL pour un fichier, il faut ensuite voir manuellement si l'utilisateur apparait dans un des groupes 
    try{
        if (($accessType = Get-Acl -path "$dirPath" -ErrorAction Stop | ForEach-Object { $_.Access } )) {
    
            Write-Host "Vérifier si l'utilisateur $userName ou un de ses groupes apparait dans la liste ci dessous :" -ForegroundColor Cyan
            $accessType | ForEach-Object { "$($_.IdentityReference) - $($_.AccessControlType) - $($_.FileSystemRights)" } 
            Write-Host "`n-> Information envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
    
            Write-Output "`nVérifier si l'utilisateur $userName ou un de ses groupes apparait dans la liste ci dessous :" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
            Write-Output $accessType | ForEach-Object { "$($_.IdentityReference) - $($_.AccessControlType) - $($_.FileSystemRights)" } | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
           
            custom_log "INFORMATION - Permissions de l'utilisateur '$userName' sur le dossier/fichier $dirPath - Envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }
    }
    Catch {
        Write-Host "Erreur sur le chemin : $dirPath`n$($_.Exception.Message)" -ForegroundColor Yellow
        custom_log "INFORMATION - Erreur sur le chemin : $dirPath`n$($_.Exception.Message)"
    }
}



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
    Write-host "Installation du module nécessaire"
    Install-Module -Name PSWindowsUpdate
    # Rechercher les mises à jour disponibles
    Write-Output "Recherche des mises à jour disponibles..."
    $updates = Get-WindowsUpdate

    # Installer les mises à jour
    if ($updates) {
        Write-Output "Installation des mises à jour..."
        Install-WindowsUpdate -AcceptAll -AutoReboot
        custom_log "ACTION - Mise à jour effectuées"
    } else {
        Write-Output "Aucune mise à jour disponible."
        custom_log "ACTION - Aucune mise à jour disponible"
    }

    Write-Output "Mises à jour terminées."
}
# Fonction -> PMAD
# Fonction -> Création de répertoire
function create_directory {

    # Demander à l'utilisateur de fournir un nom de répertoire
    Clear-Host
    $repertoire = Read-Host -prompt "Veuillez indiquer le nom du répertoire"
    # Chemin complet du répertoire dans le dossier personnel
    
    $chemin_complet = "C:\Users\$($ENV:USERNAME)\$($repertoire)"
    
    # Vérifier si le répertoire existe avant de le créer
    if ($chemin_complet) { 
        try { 
            New-Item -Path "$chemin_complet" -ItemType Directory -ErrorAction Stop
            Write-host "Le répertoire '$chemin_complet' a été créé."
            custom_log "ACTION - Création du répertoire $chemin_complet"
        }
        catch {
            Write-host "Le répertoire '$chemin_complet' existe déjà."
            custom_log "ACTION - Le répertoire '$chemin_complet' existe déjà."
        }
    }
}
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
            # L'opérateur MATH suivi de ::Round permet d'arrondir la valeur récupérée, Gb, Mb, Kb et bit, et arrondi ensuite à deux chiffre après la virgule.
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum / 1Gb,2)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Go`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Go" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
            custom_log "INFORMATION - Nom et espace disque d'un dossier - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }

        "M" {
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum / 1Mb,2)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Mo`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Mo" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
            custom_log "INFORMATION - Nom et espace disque d'un dossier - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }

        "K" {
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum / 1Kb,2)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Ko`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Ko" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
            custom_log "INFORMATION - Nom et espace disque d'un dossier - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
        }

        "O" {
            $destinationSize = [math]::Round((Get-ChildItem "$destinationDir" -recurse | Measure-Object -Property Length -Sum).Sum)
            Write-Host "le volume du dossier $destinationDir est de : $destinationSize Octets`n" -ForegroundColor Cyan
            Write-Host "-> Information envoyé dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
            Write-Output "le volume du dossier $destinationDir est de : $destinationSize Octets" | Out-File -LiteralPath "$([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt" -Encoding utf8 -Append 
            custom_log "INFORMATION - Nom et espace disque d'un dossier - Envoyée dans $([Environment]::GetFolderPath("MyDocuments"))\info_$(Get-Date -UFormat %Y%m%d)_$($userName).txt"
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

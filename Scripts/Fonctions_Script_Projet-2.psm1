
# ---------------------------------------------------------------------------------------------------------------------------------
#                                                 FONCTION ACTIONS SUR COMPTE ET GROUPE

# Fonction -> Création de compte utilisateur local
# Fonction -> Changement de mot de passe
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
# Fonction -> Date de dernière modification du mot de passe
# Fonction -> Liste des sessions ouvertes par l'utilisateur
# Fonction -> Groupe d’appartenance d’un utilisateur
# Fonction -> Historique des commandes exécutées par l'utilisateur
# Fonction -> Droits/permissions de l’utilisateur sur un dossier
# Fonction -> Droits/permissions de l’utilisateur sur un fichier

# ---------------------------------------------------------------------------------------------------------------------------------
#                                              FONCTIONS ACTIONS SUR HOTE DISTANT
# Fonction -> Arrêt
# Fonction -> Redémarrage
# Fonction -> Verrouillage
# Fonction -> Mise-à-jour du système
# Fonction -> PMAD
# Fonction -> Création de répertoire
# Fonction -> Modification de répertoire
# Fonction -> Suppression de répertoire
# Fonction -> Activation du pare-feu
# Fonction -> Désactivation du pare-feu
# Fonction -> Installation de logiciel
# Fonction -> Désinstallation de logiciel
# Fonction -> Exécution de script sur la machine distante

# ---------------------------------------------------------------------------------------------------------------------------------
#                                              FONCTIONS INFORMATIONS SUR HOTE DISTANT
# Fonction -> Version de l'OS
# Fonction -> Mémoire RAM totale
# Fonction -> Utilisation de la RAM
# Fonction -> Liste des utilisateurs locaux
# Fonction -> Nombre de disque
# Fonction -> Partition (nombre, nom, FS, taille) par disque
# Fonction -> Espace disque restant par partition/volume
# Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
# Fonction -> Liste des lecteurs monté (disque, CD, etc.)
# Fonction -> Liste des applications/paquets installées
# Fonction -> Liste des services en cours d'execution

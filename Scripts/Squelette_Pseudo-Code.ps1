Import-Module -Force .\Fonctions_Script_Projet-2.psm1

$targetType=$null
$actionOrInfoType=$null
$userManagement=$null
$userInfo=$null
$computerInfo=$null
$computerManagement=$null

custom_log "********StartScript********"

Clear-Host

do {
    $targetType = Read-Host -Prompt "Quel cible souhaitez vous atteindre ?`n1) Utilisateur`n2) Ordinateur`nx) Quitter`n"
    Clear-Host
    switch ($targetType) {
    "1" {
        custom_log "Déplacement vers Utilisateur"
        do {
            Remove-Variable userManagement,infoType -ErrorAction SilentlyContinue
            $actionOrInfoType = Read-Host -Prompt "Que voulez vous faire ?`n1) Effectuer une action`n2) Récupérer une information`n0) Retour`nx) Quitter`n"
            Clear-Host
            switch ($actionOrInfoType) {
                "1" {
                    custom_log "Déplacement vers Actions Utilisateur"
                    Write-Host "Quelles type d'actions effectuer sur les comptes utilisateurs ?"
                    Write-Host "1) Création de compte utilisateur local"
                    Write-Host "2) Changement de mot de passe d'un utilisateur local"
                    Write-Host "3) Suppression de compte utilisateur local"
                    Write-Host "4) Désactivation de compte utilisateur local"
                    Write-Host "5) Ajout d'un utilisateur au groupe Administrateurs"
                    Write-Host "6) Ajout d'un utilisateur à un groupe local"
                    Write-Host "7) Retrait d'un utilisateur d'un groupe local"
                    Write-Host "0) Retour"
                    Write-Host "x) Quitter"
                    $userManagement = Read-Host 
                    Clear-Host
                        switch ($userManagement) {
                        "1" {
                            # Fonction -> Création de compte utilisateur local
                            custom_log "ACTION - Création de compte utilisateur local"
                            Création_De_Compte_Utilisateur_Local
                        }
                        "2" {
                            # Fonction -> Changement de mot de passe
                            custom_log "ACTION - Changement de mot de passe"
                            Changement_De_Mot_De_Passe
                        }
                        "3" {
                            # Fonction -> Suppression de compte utilisateur local
                            custom_log "ACTION - Suppression de compte utilisateur local"
                            Suppression_du_compte_utilisateur
                        }
                        "4" {
                            # Fonction -> Désactivation de compte utilisateur local
                            custom_log "ACTION - Désactivation de compte utilisateur local"
                            Désactivation_du_compte_utilisateur
                        }
                        "5" {
                            # Fonction -> add_user_group_admin
                            custom_log "ACTION - Ajout à un groupe d'administration"
                            add_user_group_admin
                        }
                        "6"{
                            # Fonction -> add_user_group_local
                            custom_log "ACTION - Ajout à un groupe local"
                            add_user_group_local
                        }
                        "7" {
                            # Fonction -> del_user_group_local
                            custom_log "ACTION - Retrait d'un groupe local"
                            del_user_group_local
                        }
                        "0" { 
                            $userManagement="0"
                            $userInfo="0"
                            custom_log "Retour vers Utilisateur"
                            }
                        "x" {
                            Write-Host "Au revoir !"
                            $targetType="x"
                            custom_log "*********EndScript*********"
                        }
                        Default { 
                            Write-Host "Erreur de saisie !" -ForegroundColor Yellow
                            custom_log "Erreur de saisie"
                        }
                    }
                }
                
                "2" { 
                    custom_log "Déplacement vers Informations Utilisateur"
                    Write-Host "Quelles informations souhaitez vous récupérer ?"
                    Write-Host "1) Dernière date de connexion d'un utilisateur"
                    Write-Host "2) Dernière modification de mot de passe"
                    Write-Host "3) Liste des sessions ouvertes par l'utilisateur"
                    Write-Host "4) Groupe d’appartenance d’un utilisateur"
                    Write-Host "0) Retour"
                    Write-Host "x) Quitter"
                    $userInfo = Read-Host 
                    Clear-Host 
                    switch ($userInfo) {
                        "1" {
                            # Fonction -> Date de dernière connexion d’un utilisateur
                            custom_log "INFORMATION - Date de dernière connexion d’un utilisateur"
                            user_last_logon
                        }
                        "2" {
                            # Fonction -> Date de dernière modification du mot de passe
                            custom_log "InINFORMATIONfo - Date de dernière modification du mot de passe"
                            user_last_password_change
                        }
                        "3" {
                            # Fonction -> Liste des sessions ouvertes par l'utilisateur
                            custom_log "INFORMATION - Liste des sessions ouvertes par l'utilisateur"
                            current_user_session
                        }
                        "4" {
                            # Fonction -> Groupe d’appartenance d’un utilisateur
                            custom_log "INFORMATION - Groupe d’appartenance d’un utilisateur"
                            local_group_info
                        }
                        "5" {
                            # Fonction -> Historique des commandes exécutées par l'utilisateur
                            custom_log "INFORMATION - Historique des commandes exécutées par l'utilisateur"
                            user_shell_history
                        }
                        "6" {
                            # Fonction -> Droits/permissions de l’utilisateur sur un dossier
                            custom_log "INFORMATION - Droits/permissions de l’utilisateur sur un dossier"
                        }
                        "7" {
                            # Fonction -> Droits/permissions de l’utilisateur sur un fichier
                            custom_log "INFORMATION - Droits/permissions de l’utilisateur sur un fichier"
                        }
                        "0" { 
                            Write-Host "retour"
                            $userManagement="0"
                            $userInfo="0"
                            custom_log "Retour vers Utilisateur"
                            }
                        "x" {
                            Write-Host "Au revoir !"
                            $targetType="x"
                            custom_log "*********EndScript*********"
                        }
                        Default { 
                            Write-Host "Erreur de saisie !" -ForegroundColor Yellow
                            custom_log "Erreur de saisie"
                        }
                    }
                }
                "0" { custom_log "Retour vers Choix de la cible" }
                "x" {
                    Write-Host "Au revoir !"
                    $targetType="x"
                    custom_log "*********EndScript*********"
                }
                Default { 
                    Write-Host "Erreur de saisie !" -ForegroundColor Yellow
                    custom_log "Erreur de saisie"
                }
            }
        } while (($userManagement -eq "0") -and ($userInfo -eq "0")) 
        
    }    
    "2" {
        custom_log "Déplacement vers Ordinateurs"
        do {
            Remove-Variable computerManagement,computerInfo -ErrorAction SilentlyContinue 
            $actionOrInfoType = Read-Host -Prompt "Que voulez vous faire ?`n1) Effectuer une action`n2) Récupérer une information`n0) Retour`nx) Quitter`n"
            Clear-Host
            switch ($actionOrInfoType) {
                "1" { 
                    custom_log "Déplacement vers Actions Ordinateur"
                    Write-Host "Quelles type d'actions effectuer sur l'hôte distant' ?"
                    Write-Host "1) Arrêt"
                    Write-Host "2) Redémarrage"
                    Write-Host "3) Verrouillage de la session"
                    Write-Host "4) Mise à jour du système"
                    Write-Host "5) Prise en main à distance (CLI)"
                    Write-Host "6) Création de répertoire"
                    Write-Host "7) Modification de répertoire"
                    Write-Host "8) Suppression de répertoire"
                    Write-Host "9) Activation du parefeu"
                    Write-Host "10) Désactivation du parfeu"
                    Write-Host "11) Installation de logiciel"
                    Write-Host "12) Désinstallation de logiciel"
                    Write-Host "13) Exécution de script"
                    Write-Host "0) Retour"
                    Write-Host "x) Quitter"
                    $computerManagement = Read-Host 
                    Clear-Host
                    switch ($computerManagement) {
                        "1" { 
                            # Fonction -> Arrêt
                            custom_log "ACTION - Arret machine" 
                        }
                        "2"{
                            # Fonction -> Redémarrage
                            custom_log "ACTION -  Redémarrage de la machine"
                        }
                        "3" {
                            # Fonction -> Verrouillage
                            custom_log "ACTION - Verrouillage de la machine"
                        }
                        "4" {
                            # Fonction -> Mise-à-jour du système
                            custom_log "ACTION - Mise à jour de la machine"
                        }
                        "5" {
                            # Fonction -> PMAD
                            custom_log "ACTION - PMAD"
                        }
                        "6"{
                            # Fonction -> Création de répertoire
                            custom_log "ACTION - Création de répertoire"
                        }
                        "7"{
                            # Fonction -> Modification de répertoire
                            custom_log "ACTION - Modification de répertoire"
                        }
                        "8"{
                            # Fonction -> Suppression de répertoire
                            custom_log "ACTION - Suppression de répertoire"
                        }
                        "9"{
                            # Fonction -> Activation du pare-feu
                            custom_log "ACTION - Activation du parefeu"
                        }
                        "10"{
                            # Fonction -> Désactivation du pare-feu
                            custom_log "ACTION - Désactivation du parefeu"
                        }
                        "11"{
                            # Fonction -> Installation de logiciel
                            custom_log "ACTION - Installation de logiciel"
                        }
                        "12"{
                            # Fonction -> Désinstallation de logiciel
                            custom_log "ACTION - Désinstallationde logiciel"
                        }
                        "13" {
                            # Fonction -> Exécution de script sur la machine distante
                            custom_log "ACTION - Exécution de script sur la machine distante"
                        }
                        "0" { 
                            $computerManagement="0"
                            $computerInfo="0"
                            custom_log "Retour vers Ordinateur"
                            }
                        "x" {
                            Write-Host "Au revoir !"
                            $targetType="x"
                            custom_log "*********EndScript*********"
                        }
                        Default { 
                            Write-Host "Erreur de saisie !" -ForegroundColor Yellow
                            custom_log "Erreur de saisie"
                        }
                    } 
                }
                "2" { 
                    custom_log "Déplacement vers Informations Ordinateur"
                    Write-Host "Quelles informations de l'hôte distant souhaitez vous récupérer ?"
                    Write-Host "1) Version de l'OS"
                    Write-Host "2) Mémoire RAM total"
                    Write-Host "3) Utilisation de la RAM"
                    Write-Host "4) Liste des utlisateur locaux"
                    Write-Host "5) Nombre de disque"
                    Write-Host "6) Partitions (nombre, nom, FS, taille) par disque"
                    Write-Host "7) Espace disque restant par partition/volume"
                    Write-Host "8) Nom et espace disque d'un dossier"
                    Write-Host "9) Liste des lecteurs monté"
                    Write-Host "10) Liste des applications installées"
                    Write-Host "11) Liste des services en cours d'execution"
                    Write-Host "0) Retour"
                    Write-Host "x) Quitter"
                    $computerInfo = Read-Host
                    Clear-Host
                    switch ($computerInfo) {
                        "1" { 
                            # Fonction -> Version de l'OS
                            custom_log "INFORMATION - Version de l'OS"
                        }
                        "2"{
                            # Fonction -> Mémoire RAM totale
                            custom_log "INFORMATION - Mémoire RAM total"
                        }
                        "3"{
                            # Fonction -> Utilisation de la RAM
                            custom_log "INFORMATION - Utilisation de la RAM"
                        }
                        "4"{
                            # Fonction -> Liste des utilisateurs locaux
                            custom_log "INFORMATION - Liste des utilisateurs locaux"
                        }
                        "5"{
                            # Fonction -> Nombre de disque
                            custom_log "INFORMATION - Nombre de disque"
                        }
                        "6"{
                            # Fonction -> Partition (nombre, nom, FS, taille) par disque
                            custom_log "INFORMATION - Partition (nombre, nom, FS, taille) par disque"
                        }
                        "7"{
                            # Fonction -> Espace disque restant par partition/volume
                            custom_log "INFORMATION - Espace disque restant par partition/volume"
                        }
                        "8"{
                            # Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
                            custom_log "INFORMATION - Nom et espace disque d'un dossier (nom de dossier demandé)"
                            nom_espace_dossier
                        }
                        "9"{
                            # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
                            custom_log "INFORMATION - Liste des lecteurs monté (disque, CD, etc.)"
                        }
                        "10"{
                            # Fonction -> Liste des applications/paquets installées
                            custom_log "INFORMATION - Liste des applications/paquets installées"
                        }
                        "11"{
                            # Fonction -> Liste des services en cours d'execution
                            custom_log "INFORMATION - Liste des services en cours d'execution"
                        }
                        "0" { 
                            $computerManagement="0"
                            $computerInfo="0"
                            custom_log "Retour vers Ordinateur"
                        }
                        "x" {
                            Write-Host "Au revoir !"
                            $targetType="x"
                            custom_log "*********EndScript*********"
                        }
                        Default { 
                            Write-Host "Erreur de saisie !" -ForegroundColor Yellow
                        }
                    }
                }
                "0" { custom_log "Retour vers Choix de la cible" }
                "x" { 
                    Write-Host "Au revoir !"
                    $targetType="x"
                    custom_log "*********EndScript*********"
                }
                Default { 
                    Write-Host "Erreur de saisie !" -ForegroundColor Yellow
                    custom_log "Erreur de saisie"
                }
            }
        } while (($computerManagement -eq "0") -and ($computerInfo -eq "0"))
    }
    "x" { 
    Write-Host "Au revoir !"
    $targetType="x"
    custom_log "*********EndScript*********"
    }
    Default { 
        Write-Host "Erreur de saisie !" -ForegroundColor Yellow
        custom_log "Erreur de saisie"
    }
    }
} while ($targetType -ne "x")

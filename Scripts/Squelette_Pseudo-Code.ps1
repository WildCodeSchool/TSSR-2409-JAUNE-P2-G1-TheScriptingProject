#----------------------------------------------------------------------------------------------------
#                                   Logiciels

function install_soft {
    # Fonction -> Installation de logiciel
install-package
}

function désinstall-soft {
    # Fonction -> Désinstallation de logiciel
uninstall-package
}

function exécution_script {
    # Fonction -> Exécution de script sur la machine distante
invoke-command
}
#---------------------------------------------------------------------------------------------------------                         
#                                   info machine récupérer

function version_os {

    #Fonction -> Version de l'OS
Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version
}
function ram_totale {
    # Fonction -> Mémoire RAM totale
Get-CimInstance win32_physicalmemory | Format-Table Capacity
}
function ram_utilisation {
    # Fonction -> Utilisation de la RAM
Get-ComputerInfo | Select-Object TotalPhysicalMemory, OsTotalVisibleMemory, OsFreePhysicalMemory
}
function liste_utilisateurs {
    # Fonction -> Liste des utilisateurs locaux
Get-localuser
}
#-------------------------------------------------------------------------------------------------------------
#                                   Disque
function nombre_Disque {
    # Fonction -> Nombre de disque
Get-Disk
}

function partition {
    # Fonction -> Partition (nombre, nom, FS, taille) par disque
get-partition
}

function espace_Restant {
    # Fonction -> Espace disque restant par partition/volume
get-volume
}

function nom_espace_dossier {
    # Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
   
}

function liste_lecteur {
    # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
Get-psdrive
}
# --------------------------------------------------------------------------------------

 # DEBUT CAS demande quel type d'info récupérer sur les logiciels

function liste_Appli {
    # Fonction -> Liste des applications/paquets installées
Get-Appxpackage
}

function service_runing {
    # Fonction -> Liste des services en cours d'execution
Get-service
}

Clear-Host
# DEBUT BOUCLE while 
$targetType = Read-Host -Prompt "Quel cible souhaitez vous atteindre ?`n1) Utilisateur`n2) Ordinateur`n"
Clear-Host
# DEBUT CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur
# dans le cas 1 utilisteur
switch ($targetType) {
"1" {
    # DEBUT CAS demande si on doit récupérer une information ou effectuer une action
    # dans le cas 1 action sur les groupes ou user
    $infoactionType = Read-Host -Prompt "Que voulez vous faire ?`n1) Effectuer une action`n2) Récupérer une information`n"
    Clear-Host

        switch ($infoactionType) {
        "1" {
            # DEBUT CAS demande quelles actions effectuer
            # dans le cas 1 gestion des comptes
            $actionType = Read-Host -Prompt "Quelles type d'action souhaitez vous effectuer ? `n1) Actions sur les comptes`n2) Actions sur les groupes`n" 
            Clear-Host
            
            switch ($actionType) { 

                "1" { 
                    # DEBUT CAS Demande quel action exécuter sur les comptes    
                    # dans le cas 1 - Création de compte utilisateur local
                    $userManagement = Read-Host -Prompt "Quelles type d'actions effectuer sur les comptes utilisateurs ?`n1) Création de compte utilisateur local`n2) Changement de mot de passe`n3) Suppression de compte utilisateur local`n4) Désactivation de compte utilisateur local`n"
                    Clear-Host            
                    
                    switch ($userManagement) {
                    
                        "1" {
                            # Fonction -> Création de compte utilisateur local
                            Write-Output "Création de compte utilisateur local"
                        }
                        # dans le cas 2 - Changement de mot de passe
                        "2" {
                            # Fonction -> Changement de mot de passe
                            Write-Output "Changement de mot de passe"
                        }
                        # dans le cas 3 - Suppression de compte utilisateur local 
                        "3" {
                            # Fonction -> Suppression de compte utilisateur local
                            Write-Output  "Suppression de compte utilisateur local"
                        }
                        # dans le cas 4 - Désactivation de compte utilisateur local
                        "4" {
                            # Fonction -> Désactivation de compte utilisateur local
                            Write-Output "Désactivation de compte utilisateur local"
                        }
                        Default { 
                            Write-Output "Erreur de saisie" 
                        }
                    # FIN CAS Demande quel action exécuter sur les comptes  
                    }
                }
            
                # dans le cas 2 gestion des groupe
                "2" {
# Demande quel action exécuter sur les groupes  
                    $groupManagement = Read-Host -Prompt "Quelles type d'actions effectuer sur les groupes ?`n1) Ajout à un groupe d'administration`n2) Ajout à un groupe local`n3) Sortie d’un groupe local`n"
                    Clear-Host
            
                    switch ($groupManagement) {
                    # dans le cas 1 - Ajout à un groupe d'administration
                    "1" {
                        # Fonction -> Ajout à un groupe d'administration
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
                    # dans le cas 2 - Ajout à un groupe local
                    "2" {   
                        # Fonction -> Ajout à un groupe local
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
                    # dans le cas 3 - Sortie d’un groupe local
                    "3" {    
                        # Fonction -> Sortie d’un groupe local
                        # Fonction -> Ajout à un groupe local
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
                    
                    Default { 
                            Write-Output "Erreur de saisie" 
                        }
                    # FIN CAS Demande quel action exécuter sur les groupes 
                    }
                }

            Default {
                Write-Output "Erreur de saisie" 
    }
        # FIN CAS demande quelles actions effectuer
    
            
"2" {
        # dans le cas 2 information

            # demande quelle information récupérer
            $infoType = Read-Host "Quelles type d'action souhaitez vous effectuer ?`n1) Actions sur l'information lié à la session `n2) Actions sur l'information lié au compte`n"
            Clear-Host
            # dans le cas 1 information lié à la session
            switch ($infoType) {
            "1" {
                # demande quelles info lié à la session récupérer
                $infoUser = Read-Host "Quelles type d'action souhaitez vous effectuer ?`n1) Date de dernière connexion d’un utilisateur `n2) Date de dernière modification du mot de passe `n3) Liste des sessions ouvertes par l'utilisateur`n"
                Clear-Host
                # dans le cas 1 - Date de dernière connexion d’un utilisateur
                switch ($infoUser) {
                "1" {
                    # Fonction -> Date de dernière connexion d’un utilisateur
                    Write-Host "Date de dernière connexion d’un utilisateur"
                }
                # dans le cas 2 - Date de dernière modification du mot de passe
                "2" {
                    # Fonction -> Date de dernière modification du mot de passe
                    Write-Host "Date de dernière modification du mot de passe"
                }
                # dans le cas 3 - Liste des sessions ouvertes par l'utilisateur
                "3" {
                    # Fonction -> Liste des sessions ouvertes par l'utilisateur
                    Write-Host "Liste des sessions ouvertes par l'utilisateur"
                }
                # FIN CAS demande quelles info lié à la session récupérer
                }
            }
            # dans le cas 2 information lié au compte
            "2" {
                # demande quelles info lié au compte récupérer
                $actiontype= Read-Host "Quelles type d'action souhaitez vous effectuer ?`n1) Groupe d’appartenance d’un utilisateur `n2) Historique des commandes exécutées par l'utilisateur `n3) Droits/permissions de l’utilisateur sur un dossier `n4) Droits/permissions de l’utilisateur sur un fichier`n"
                Clear-Host
                switch ($actiontype) {
                # dans le cas 1 - Groupe d’appartenance d’un utilisateur
                "1" {
                    # Fonction -> Groupe d’appartenance d’un utilisateur
                    Write-Host "Groupe d’appartenance d’un utilisateur"
                }
                # dans le cas 2 - Historique des commandes exécutées par l'utilisateur
                "2" {
                    # Fonction -> Historique des commandes exécutées par l'utilisateur
                    Write-Host "Historique des commandes exécutées par l'utilisateur"
                }
                # dans le cas 3 - Droits/permissions de l’utilisateur sur un dossier
                "3" {
                    # Fonction -> Droits/permissions de l’utilisateur sur un dossier
                    Write-Host "Droits/permissions de l’utilisateur sur un dossier"
                }
                # dans le cas 4 - Droits/permissions de l’utilisateur sur un fichier
                "4" {
                    # Fonction -> Droits/permissions de l’utilisateur sur un fichier
                    Write-Host "Droits/permissions de l’utilisateur sur un fichier"
                }
                # FIN CAS demande quelles info lié au compte récupérer
                }
            # FIN CAS demande quelle information récupérer
            }
            }
        # FIN CAS demande si on doit récupérer une information ou effectuer une action

    # dans le cas 2 ordinateur
"2" {
    
    # DEBUT CAS demande demande si on doit récupérer une information ou effectuer une action
    # dans le cas 1 action
    $infoactionType = Read-Host -Prompt "Que voulez vous faire ?`n1) Effectuer une action`n2) Récupérer une information`n"
    Clear-Host

    switch ($infoactionType) {
    "1" {
        # DEBUT CAS demande quelle action effectuer
        Write-Output "Quel type d'action souhaitez-vous effectuer ? `n1) Actions sur la machine `n2) Actions sur les fichiers `n3) Actions sur le pare-feu `n4) Actions sur les logiciels"
            $dowhatType = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
            Clear-Host
        # dans le cas 1 gestion de la machine
        switch ($dowhatType) { 
            # DEBUT CAS demande quelles action effectuer sur la machine
            1 {
                Write-Output "Quelle action sur la machine ? `n1) Arrêt de la machine `n2) Redémarrage de la machine `n3) Verrouillage de la machine `n4) Mise à jour de la machine `n5) Assistance à distance (PMAD)"
                $actionHost = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
                Clear-Host
                switch ($actionHost) {
                # dans le cas 1 - Arrêt
                1 { 
                    # Fonction -> Arrêt
                    Write-Output "Arrêt de la machine en cours..."
                        } 
                # dans le cas 2 - Redémarrage
                2 {  
                    # Fonction -> Redémarrage
                    Write-Output "Redémarrage de la machine en cours..."
                } 
                # dans le cas 3 - Verrouillage
                3 {
                    # Fonction -> Verrouillage
                    Write-Output "Verrouillage de la machine..."
                 }   
                # dans le cas 4 - Mise-à-jour du système
                4 { 
                    # Fonction -> Mise-à-jour du système
                    Write-Output "Mise à jour de la machine en cours..."

                # dans le cas 5 - PMAD
                5 { 
                    # Fonction -> PMAD
                    Write-Output "PMAD en cours..."
                }
                # FIN CAS demande quelles action effectuer sur la machine
                Default { Write-Output "Action non valide pour la machine" }
            }
            # dans la cas 2 gestion des fichiers 
            2 {
                Write-Output "Quelle action sur les fichiers ? `n1) Création de répertoire `n2) Modification de répertoire `n3) Suppression de répertoire"
                $actionFile = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
                Clear-Host
                # DEBUT CAS demande quelles actions effectuer sur les fichiers
                switch ($actionFile) {
                # dans le cas 1 - Création de répertoire
                1 { création 
                    # Fonction -> Création de répertoire
                    Write-Output "Création de répertoire en cours..."
                }
                # dans le cas 2 - Modification de répertoire
                2 { Modification 
                    # Fonction -> Modification de répertoire
                    Write-Output "Modification de répertoire en cours..."
                }
                # dans le cas 3 - Suppression de répertoire
                3 { suppression
                    # Fonction -> Suppression de répertoire
                    Write-Output "Suppression de répertoire en cours..."
                }
                # FIN CAS demande quelles actions effectuer sur les fichiers
                 Default { Write-Output "Erreur de saisie pour les fichiers"
                }
            }   

            # dans le cas 3 gestion du parefeu
            3 {
                Write-Output "Quelle action sur le pare-feu ? `n1) Activation du pare-feu `n2) Désactivation du pare-feu"
                $actionFirewall = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
                Clear-Host
                # DEBUT CAS demande quelles action à effectuer sur le parefeu
                switch ($actionFirewall) {
                # dans le cas 1 - Activation du pare-feu
                1 {
                    # Fonction -> Activation du pare-feu
                    Write-Output "Activation des pares feu..."
                }
                # dans le cas 2 - Désactivation du pare-feu
                2 {
                    # Fonction -> Désactivation du pare-feu
                    Write-Output "Désactivation des pares feu..."
                }
                # FIN CAS demande quelles action à effectuer sur le parefeu
                Default { Write-Output "Erreur de saisie pour le pare-feu" 
                }
            }  
            # dans le cas 4 gestion des logiciels
            4 {
                Write-Output "Quelle action sur les logiciels ? `n1) Installation d'un logiciel `n2) Désinstallation d'un logiciel `n3) Exécution d'un logiciel"
                $actionSoftware = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
                Clear-Host
                # DEBUT CAS demande quelles actions à effectuer sur les logiciel
                switch ($actionSoftware) {
                # dans le cas 1 - Installation de logiciel
                1 {
                    # Fonction -> Installation de logiciel
                    Write-Output "Installation de logiciel..."
                }
                # dans le cas 2 - Désinstallation de logiciel
                2 {
                    # Fonction -> Désinstallation de logiciel
                    Write-Output "Désinstallationde logiciel..."
                }
                # dans le cas 3 - Exécution de script sur la machine distante
                3 {
                    # Fonction -> Exécution de script sur la machine distante
                    Write-Output "Exécution de script sur la machine distante..."
                }
                # FIN CAS demande quelles actions à effectuer sur les logiciel
                Default { Write-Output "Erreur de saisie pour les logiciels" 
                }
            }
            # FIN CAS demande quelle action effectuer
            
        }   

        # dans le cas 2 information
    "2" {
             write-host " Quelle info sur la machine?`n[1] info_machine  `n [2]info_disque  `n [3]info_logiciel "
            # DEBUT CAS demande quelles informations récupérer
            $choix=read-host -Prompt "entrer l'action souhaitée"
            switch($choix)
        
            # dans le cas 1 information sur la machine
                {
                # DEBUT CAS demande quel type d'info machine récupérer
            1 {
                write-host " quelle information?`n[1] Version os  `n[2] Ram totale  `n[3] Utilisation RAM  `n[4] Liste utiliqateur locaux `n[5] Sortie "
                $choix_2=read-host -Prompt  "que voulez-vous faire?"
                switch($choix_2)
                    {
                    # dans le cas 1 - Version de l'OS
                    # Fonction -> Version de l'OS
                    1{Get-WmiObject Win32_OperatingSystem | Select-Object Caption, Version}

                # dans le cas 2 - Mémoire RAM totale
                    # Fonction -> Mémoire RAM totale
                    2{Get-CimInstance win32_physicalmemory | Format-Table Capacity}
                # dans le cas 3 - Utilisation de la RAM
                    # Fonction -> Utilisation de la RAM
                     3 {Get-ComputerInfo | Select-Object TotalPhysicalMemory, OsTotalVisibleMemory, OsFreePhysicalMemory}
                # dans le cas 4 - Liste des utilisateurs locaux
                    # Fonction -> Liste des utilisateurs locaux
                    4 {Get-localuser}
                # FIN CAS demande quel type d'info machine récupérer
                    }
                }
            # dans le cas 3 information sur les disques

            2 {
                write-host " quelle information ?`n[1] Nombre de disque  `n[2] Partition  `n[3] Espace disque restant  `n[4] Nom et espacedisque d'un dossier `n[5] Liste des lecteurs montés`n[6] Sortie"
                $choix_3=read-host -Prompt "que voulez-vous faire?"
                switch($choix_3)
                    {
                # DEBUT CAS demande quel type d'info récuperer sur les disques
                # dans le cas 1 - Nombre de disque
                    # Fonction -> Nombre de disque
                    1 {Get-Disk}
                # dans le cas 2 - Partition (nombre, nom, FS, taille) par disque
                    # Fonction -> Partition (nombre, nom, FS, taille) par disque
                    2 {Get-Partition}
                # dans le cas 3 - Espace disque restant par partition/volume
                    # Fonction -> Espace disque restant par partition/volume
                    3 {Get-Volume}
                # dans le cas 4 - Nom et espace disque d'un dossier (nom de dossier demandé)
                    # Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
                    4 {get-content}
                # dans le cas 5 - Liste des lecteurs monté (disque, CD, etc.)
                    # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
                    5 { Get-psdrive }
                # FIN CAS demande quel type d'info récuperer sur les disques
                    }
                }

            3 {
                write-host "[1] Liste des applications/paquets `n[2] Liste des services en cours d'éxécution`n[3] Sortie"
                $choix_4=read-host -Prompt "que voulez-vous faire?"
                switch($choix_4)
                {
            # dans le cas 4 information sur les logiciels

                # DEBUT CAS demande quel type d'info récupérer sur les logiciels
                # dans le cas 1 - Liste des applications/paquets installées
                    # Fonction -> Liste des applications/paquets installées
                    1 {Get-AppxPackage}
                # dans le cas 2 - Liste des services en cours d'execution
                    # Fonction -> Liste des services en cours d'execution
                    2 {Get-service}
                }
                # FIN CAS demande quel type d'info récupérer sur les logiciels
                }
            }
            # FIN CAS demande quelles informations récupérer
            
            # FIN CAS demande quelles informations récupérer
        }
        # FIN CAS demande si on doit récupérer une information ou effectuer une action
    }
    # FIN CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur   
            }

        }

    }
}

# demande si on doit continuer la boucle ou sortir
# FIN BOUCLE while

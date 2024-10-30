# Fonctions ()
# Fonctions ()
# Fonctions ()
# ...

# DEBUT BOUCLE while 

    # DEBUT CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur
    # dans le cas 1 utilisteur
    
        # DEBUT CAS demande si on doit récupérer une information ou effectuer une action
        # dans le cas 1 action sur les groupes ou user

            # DEBUT CAS demande quelles actions effectuer
            # dans le cas 1 gestion des comptes
            
                # DEBUT CAS Demande quel action exécuter sur les comptes    
                # dans le cas 1 - Création de compte utilisateur local
                
                    # Fonction -> Création de compte utilisateur local
                
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
                        
                # dans le cas 2 - Changement de mot de passe
                    # Fonction -> Changement de mot de passe

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

                # dans le cas 3 - Suppression de compte utilisateur local 
                    # Fonction -> Suppression de compte utilisateur local 

                # dans le cas 4 - Désactivation de compte utilisateur local
                    # Fonction -> Désactivation de compte utilisateur local
                
                # FIN CAS Demande quel action exécuter sur les comptes  


            # dans le cas 2 gestion des groupe

                # Demande quel action exécuter sur les groupes  
                # dans le cas 1 - Ajout à un groupe d'administration
                    # Fonction -> Ajout à un groupe d'administration

                # dans le cas 2 - Ajout à un groupe local
                    # Fonction -> Ajout à un groupe local

                # dans le cas 3 - Sortie d’un groupe local
                    # Fonction -> Sortie d’un groupe local

                # FIN CAS Demande quel action exécuter sur les groupes  
            
            # FIN CAS demande quelles actions effectuer


        # dans le cas 2 information

            # demande quelle information récupérer
            # dans le cas 1 information lié à la session

                # demande quelles info lié à la session récupérer 
                # dans le cas 1 - Date de dernière connexion d’un utilisateur
                    # Fonction -> Date de dernière connexion d’un utilisateur

                # dans le cas 2 - Date de dernière modification du mot de passe
                    # Fonction -> Date de dernière modification du mot de passe

                # dans le cas 3 - Liste des sessions ouvertes par l'utilisateur
                    # Fonction -> Liste des sessions ouvertes par l'utilisateur

                # FIN CAS demande quelles info lié à la session récupérer

            # dans le cas 2 information lié au compte

                # demande quelles info lié au compte récupérer
                # dans le cas 1 - Groupe d’appartenance d’un utilisateur
                    # Fonction -> Groupe d’appartenance d’un utilisateur

                # dans le cas 2 - Historique des commandes exécutées par l'utilisateur
                    # Fonction -> Historique des commandes exécutées par l'utilisateur

                # dans le cas 3 - Droits/permissions de l’utilisateur sur un dossier
                    # Fonction -> Droits/permissions de l’utilisateur sur un dossier

                # dans le cas 4 - Droits/permissions de l’utilisateur sur un fichier
                    # Fonction -> Droits/permissions de l’utilisateur sur un fichier
                
                # FIN CAS demande quelles info lié au compte récupérer
            
            # FIN CAS demande quelle information récupérer

        # FIN CAS demande si on doit récupérer une information ou effectuer une action


    # dans le cas 2 ordinateur

         # DEBUT CAS demande demande si on doit récupérer une information ou effectuer une action
        
        Clear-Host

        # dans le cas 1 action
        
            # DEBUT CAS demande demande si on doit récupérer une information ou effectuer une action
        
        Clear-Host

        # dans le cas 1 action
        
            # DEBUT CAS demande quelle action effectuer
            Write-Output "Quel type d'action souhaitez-vous effectuer ? `n1) Actions sur la machine `n2) Actions sur les fichiers `n3) Actions sur le pare-feu `n4) Actions sur les logiciels"
            $actionType = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
            Clear-Host

            # dans le cas 1 gestion de la machine
            switch ($actionType) {    

                
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
                            Stop-Computer
                        } 
                        # dans le cas 2 - Redémarrage
                        2 {     
                        # Fonction -> Redémarrage
                            Write-Output "Redémarrage de la machine en cours..."
                            Restart-Computer 
                        }
                        # dans le cas 3 - Verrouillage
                        3 {
                        # Fonction -> Verrouillage
                            Write-Output "Verrouillage de la machine..."
                            RUNDLL32.EXE user32.dll,LockWorkStation
                        }
                        # dans le cas 4 - Mise-à-jour du système
                        4 { 
                        # Fonction -> Mise-à-jour du système
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
                        # dans le cas 5 - PMAD
                        5 {  
                        # Fonction -> PMAD


                        }

                        # FIN CAS demande quelles action effectuer sur la machine
                        Default { Write-Output "Action non valide pour la machine" }
                    }
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
                    }
                    
                        # Fonction -> Création de répertoire
                    
                    # dans le cas 2 - Modification de répertoire
                    2 { Modification 
                    }
                        # Fonction -> Modification de répertoire

                    # dans le cas 3 - Suppression de répertoire
                    3 { suppression
                    }
                        # Fonction -> Suppression de répertoire
                    Default { Write-Output "Erreur de saisie pour les fichiers" }
                    }
                }
                     # FIN CAS demande quelles actions effectuer sur les fichiers

                # dans le cas 3 gestion du parefeu
                3 {
                    Write-Output "Quelle action sur le pare-feu ? `n1) Activation du pare-feu `n2) Désactivation du pare-feu"
                    $actionFirewall = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
                    Clear-Host
                # DEBUT CAS demande quelles action à effectuer sur le parefeu
                    switch ($actionFirewall) {

                    # dans le cas 1 - Activation du pare-feu
                    1 { agentactivationruntimestarter.exe
                    }
                        # Fonction -> Activation du pare-feu

                    # dans le cas 2 - Désactivation du pare-feu
                    2 {  Désactivation
                    }
                        # Fonction -> Désactivation du pare-feu
                    Default { Write-Output "Erreur de saisie pour le pare-feu" }
                    }
                }
                # FIN CAS demande quelles action à effectuer sur le parefeu

                # dans le cas 4 gestion des logiciels
                4 {
                    Write-Output "Quelle action sur les logiciels ? `n1) Installation d'un logiciel `n2) Désinstallation d'un logiciel `n3) Exécution d'un logiciel"
                    $actionSoftware = Read-Host "Veuillez entrer le numéro de l'action souhaitée"
                    Clear-Host
                    # DEBUT CAS demande quelles actions à effectuer sur les logiciel 
                    switch ($actionSoftware) {
                    # dans le cas 1 - Installation de logiciel
                    1 { Installation
                    }
                        # Fonction -> Installation de logiciel

                    # dans le cas 2 - Désinstallation de logiciel
                    2 { Désinstallation
                    }
                        # Fonction -> Désinstallation de logiciel

                    # dans le cas 3 - Exécution de script sur la machine distante
                    3 { Exécution  
                    }
                        # Fonction -> Exécution de script sur la machine distante
                    Default { Write-Output "Erreur de saisie pour les logiciels" }
                    }
                }
                    # FIN CAS demande quelles actions à effectuer sur les logiciel
            
            # FIN CAS demande quelle action effectuer
            Default { Write-Output "Erreur de saisie sur les actions" }
            }


            

            # dans le cas 2 information
            
            
            write-host "
                [1]info_machine  `r
                [2]info_disque  `r
                [3]info_logiciel  `r
                "
            # DEBUT CAS demande quelles informations récupérer
            [int]$choix=read-host "entrer l'action souhaitée"
            switch($choix)
            
            
            # dans le cas 1 information sur la machine
            {
            # DEBUT CAS demande quel type d'info machine récupérer
                1 {
                write-host "
                [1]Version os  `r
                [2]Ram totale  `r
                [3]Utilisation RAM  `r
                [4]Liste utiliqateur locaux `r
                [5]Sortie   `r
                "
                [int]$choix_2=read-host "que voulez-vous faire?"
                switch($choix2)
                    {# Fonctions ()
# Fonctions ()
# Fonctions ()
# ...

# DEBUT BOUCLE while 

    # DEBUT CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur
    # dans le cas 1 utilisteur
    
        # DEBUT CAS demande si on doit récupérer une information ou effectuer une action
        # dans le cas 1 action sur les groupes ou user

            # DEBUT CAS demande quelles actions effectuer
            # dans le cas 1 gestion des comptes
            
                # DEBUT CAS Demande quel action exécuter sur les comptes    
                # dans le cas 1 - Création de compte utilisateur local
                
                    # Fonction -> Création de compte utilisateur local
                    
                # dans le cas 2 - Changement de mot de passe
                    # Fonction -> Changement de mot de passe

                # dans le cas 3 - Suppression de compte utilisateur local 
                    # Fonction -> Suppression de compte utilisateur local 

                # dans le cas 4 - Désactivation de compte utilisateur local
                    # Fonction -> Désactivation de compte utilisateur local
                
                # FIN CAS Demande quel action exécuter sur les comptes  


            # dans le cas 2 gestion des groupe

                # Demande quel action exécuter sur les groupes  
                # dans le cas 1 - Ajout à un groupe d'administration
                    # Fonction -> Ajout à un groupe d'administration

                # dans le cas 2 - Ajout à un groupe local
                    # Fonction -> Ajout à un groupe local

                # dans le cas 3 - Sortie d’un groupe local
                    # Fonction -> Sortie d’un groupe local

                # FIN CAS Demande quel action exécuter sur les groupes  
            
            # FIN CAS demande quelles actions effectuer


        # dans le cas 2 information

            # demande quelle information récupérer
            # dans le cas 1 information lié à la session

                # demande quelles info lié à la session récupérer 
                # dans le cas 1 - Date de dernière connexion d’un utilisateur
                    # Fonction -> Date de dernière connexion d’un utilisateur

                # dans le cas 2 - Date de dernière modification du mot de passe
                    # Fonction -> Date de dernière modification du mot de passe

                # dans le cas 3 - Liste des sessions ouvertes par l'utilisateur
                    # Fonction -> Liste des sessions ouvertes par l'utilisateur

                # FIN CAS demande quelles info lié à la session récupérer

            # dans le cas 2 information lié au compte

                # demande quelles info lié au compte récupérer
                # dans le cas 1 - Groupe d’appartenance d’un utilisateur
                    # Fonction -> Groupe d’appartenance d’un utilisateur

                # dans le cas 2 - Historique des commandes exécutées par l'utilisateur
                    # Fonction -> Historique des commandes exécutées par l'utilisateur

                # dans le cas 3 - Droits/permissions de l’utilisateur sur un dossier
                    # Fonction -> Droits/permissions de l’utilisateur sur un dossier

                # dans le cas 4 - Droits/permissions de l’utilisateur sur un fichier
                    # Fonction -> Droits/permissions de l’utilisateur sur un fichier
                
                # FIN CAS demande quelles info lié au compte récupérer
            
            # FIN CAS demande quelle information récupérer

        # FIN CAS demande si on doit récupérer une information ou effectuer une action


    # dans le cas 2 ordinateur

        # DEBUT CAS demande demande si on doit récupérer une information ou effectuer une action
        # dans le cas 1 action
            # DEBUT CAS demande quelle action effectuer
            # dans le cas 1 gestion de la machine

                # DEBUT CAS demande quelles action effectuer sur la machine
                # dans le cas 1 - Arrêt
                    # Fonction -> Arrêt
                # dans le cas 2 - Redémarrage
                    # Fonction -> Redémarrage

                # dans le cas 3 - Verrouillage
                    # Fonction -> Verrouillage

                # dans le cas 4 - Mise-à-jour du système
                    # Fonction -> Mise-à-jour du système

                # dans le cas 5 - PMAD
                    # Fonction -> PMAD

                # FIN CAS demande quelles action effectuer sur la machine

            # dans la cas 2 gestion des fichiers 

                # DEBUT CAS demande quelles actions effectuer sur les fichiers
                # dans le cas 1 - Création de répertoire
                    # Fonction -> Création de répertoire

                # dans le cas 2 - Modification de répertoire
                    # Fonction -> Modification de répertoire

                # dans le cas 3 - Suppression de répertoire
                    # Fonction -> Suppression de répertoire
                
                # FIN CAS demande quelles actions effectuer sur les fichiers

            # dans le cas 3 gestion du parefeu

                # DEBUT CAS demande quelles action à effectuer sur le parefeu
                # dans le cas 1 - Activation du pare-feu
                    # Fonction -> Activation du pare-feu

                # dans le cas 2 - Désactivation du pare-feu
                    # Fonction -> Désactivation du pare-feu
                
                # FIN CAS demande quelles action à effectuer sur le parefeu

            # dans le cas 4 gestion des logiciels

                # DEBUT CAS demande quelles actions à effectuer sur les logiciel 
                # dans le cas 1 - Installation de logiciel
                    # Fonction -> Installation de logiciel

                # dans le cas 2 - Désinstallation de logiciel
                    # Fonction -> Désinstallation de logiciel

                # dans le cas 3 - Exécution de script sur la machine distante
                    # Fonction -> Exécution de script sur la machine distante

                # FIN CAS demande quelles actions à effectuer sur les logiciel
            
            # FIN CAS demande quelle action effectuer
            


        # dans le cas 2 information

            # DEBUT CAS demande quelles informations récupérer
            # dans le cas 1 information sur la machine

                # DEBUT CAS demande quel type d'info machine récupérer
                # dans le cas 1 - Version de l'OS
                    # Fonction -> Version de l'OS

                # dans le cas 2 - Mémoire RAM totale
                    # Fonction -> Mémoire RAM totale

                # dans le cas 3 - Utilisation de la RAM
                    # Fonction -> Utilisation de la RAM
                
                # dans le cas 4 - Liste des utilisateurs locaux
                    # Fonction -> Liste des utilisateurs locaux
                
                # FIN CAS demande quel type d'info machine récupérer
                

            # dans le cas 3 information sur les disques

                # DEBUT CAS demande quel type d'info récuperer sur les disques
                # dans le cas 1 - Nombre de disque
                    # Fonction -> Nombre de disque

                # dans le cas 2 - Partition (nombre, nom, FS, taille) par disque
                    # Fonction -> Partition (nombre, nom, FS, taille) par disque

                # dans le cas 3 - Espace disque restant par partition/volume
                    # Fonction -> Espace disque restant par partition/volume
                
                # dans le cas 4 - Nom et espace disque d'un dossier (nom de dossier demandé)
                    # Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)

                # dans le cas 5 - Liste des lecteurs monté (disque, CD, etc.)
                    # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
                
                # FIN CAS demande quel type d'info récuperer sur les disques


            # dans le cas 4 information sur les logiciels

                # DEBUT CAS demande quel type d'info récupérer sur les logiciels
                # dans le cas 1 - Liste des applications/paquets installées
                    # Fonction -> Liste des applications/paquets installées

                # dans le cas 2 - Liste des services en cours d'execution
                    # Fonction -> Liste des services en cours d'execution

                # FIN CAS demande quel type d'info récupérer sur les logiciels
            
            # FIN CAS demande quelles informations récupérer

        # FIN CAS demande si on doit récupérer une information ou effectuer une action

    # FIN CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur   


# demande si on doit continuer la boucle ou sortir
# FIN BOUCLE while

                    # dans le cas 1 - Version de l'OS
                    # Fonction -> Version de l'OS
                  
                # dans le cas 2 - Mémoire RAM totale
                    # Fonction -> Mémoire RAM totale
                   
                # dans le cas 3 - Utilisation de la RAM
                    # Fonction -> Utilisation de la RAM
                    
                # dans le cas 4 - Liste des utilisateurs locaux
                    # Fonction -> Liste des utilisateurs locaux
                    
                # FIN CAS demande quel type d'info machine récupérer
                  
               

            # dans le cas 3 information sur les disques
           
                # DEBUT CAS demande quel type d'info récuperer sur les disques
                # dans le cas 1 - Nombre de disque
                    # Fonction -> Nombre de disque

                # dans le cas 2 - Partition (nombre, nom, FS, taille) par disque
                    # Fonction -> Partition (nombre, nom, FS, taille) par disque

                # dans le cas 3 - Espace disque restant par partition/volume
                    # Fonction -> Espace disque restant par partition/volume
                
                # dans le cas 4 - Nom et espace disque d'un dossier (nom de dossier demandé)
                    # Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)

                # dans le cas 5 - Liste des lecteurs monté (disque, CD, etc.)
                    # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
                
                # FIN CAS demande quel type d'info récuperer sur les disques

            
            # dans le cas 4 information sur les logiciels

                # DEBUT CAS demande quel type d'info récupérer sur les logiciels
                # dans le cas 1 - Liste des applications/paquets installées
                    # Fonction -> Liste des applications/paquets installées

                # dans le cas 2 - Liste des services en cours d'execution
                    # Fonction -> Liste des services en cours d'execution

                # FIN CAS demande quel type d'info récupérer sur les logiciels
            
            # FIN CAS demande quelles informations récupérer

        # FIN CAS demande si on doit récupérer une information ou effectuer une action

    # FIN CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur   


# demande si on doit continuer la boucle ou sortir
# FIN BOUCLE while

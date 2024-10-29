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
                        1 { Arrêt
                        } 
                        # Fonction -> Arrêt
                        # dans le cas 2 - Redémarrage
                        2 { Redémarrage
                        }
                        # Fonction -> Redémarrage

                        # dans le cas 3 - Verrouillage
                        3 { Verrouillage
                        }   
                        # Fonction -> Verrouillage

                        # dans le cas 4 - Mise-à-jour du système
                        4 { Mise à jour
                        }   
                        # Fonction -> Mise-à-jour du système

                        # dans le cas 5 - PMAD
                        5 { PMAD
                        }    
                        # Fonction -> PMAD

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

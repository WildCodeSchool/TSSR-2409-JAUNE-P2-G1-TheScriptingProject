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
                    {
                    # dans le cas 1 - Version de l'OS
                    # Fonction -> Version de l'OS
                    1 {Get-computerinfo}
                # dans le cas 2 - Mémoire RAM totale
                    # Fonction -> Mémoire RAM totale
                    2 {Get-ciminstance}
                # dans le cas 3 - Utilisation de la RAM
                    # Fonction -> Utilisation de la RAM
                    3 {Get-computerinfo}
                # dans le cas 4 - Liste des utilisateurs locaux
                    # Fonction -> Liste des utilisateurs locaux
                    4 {Get-localuser}
                # FIN CAS demande quel type d'info machine récupérer
                    }
                }

            # dans le cas 3 information sur les disques
            2 {
                write-host "
                [1]Nombre de disque  `r
                [2]Partition  `r
                [3]Espace disque restant  `r
                [4]Nom et espacedisque d'un dossier `r
                [5]Liste des lecteurs montés    `r
                [6]Sortie   `r
                "
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

            3 {
                write-host "
                [1]Liste des applications/paquets `r
                [2]Liste des services en cours d'éxécution  `r
                [3]Sortie   `r
                "
            # dans le cas 4 information sur les logiciels

                # DEBUT CAS demande quel type d'info récupérer sur les logiciels
                # dans le cas 1 - Liste des applications/paquets installées
                    # Fonction -> Liste des applications/paquets installées

                # dans le cas 2 - Liste des services en cours d'execution
                    # Fonction -> Liste des services en cours d'execution

                # FIN CAS demande quel type d'info récupérer sur les logiciels
            }
            # FIN CAS demande quelles informations récupérer

        # FIN CAS demande si on doit récupérer une information ou effectuer une action

    # FIN CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur   


# demande si on doit continuer la boucle ou sortir
# FIN BOUCLE while

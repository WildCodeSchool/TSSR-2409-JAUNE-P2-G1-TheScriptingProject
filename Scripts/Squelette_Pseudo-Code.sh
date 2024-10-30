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
                    clear
                    # Demande le nom d'utilisateur
                    read -p "Entrez le nom d'utilisateur à créer: " username
                    clear 
                    # Vérifie si l'utilisateur existe déjà
                    if id "$username" &>/dev/null; then
                        echo "L'utilisateur '$username' existe déjà!"
                        exit 1
                    fi
                    clear
                    # Demande le mot de passe
                    read -s -p "Entrez le mot de passe pour l'utilisateur '$username': " password
                    echo
                    clear 
                    # Définit le mot de passe de l'utilisateur
                    echo "$username:$password" | chpasswd
                    # Création de l'utilisateur avec un répertoire personnel
                    sudo useradd -m -s /bin/bash "$username"

                    # Affiche un message de confirmation
                    echo "L'utilisateur '$username' a été créé avec succès."
                    exit 0
                    clear
                # dans le cas 2 - Changement de mot de passe

                    # Fonction -> Changement de mot de passe
                    # Demander le nom de l'utilisateur pour lequel changer le mot de passe
                    read -p "Entrez le nom de l'utilisateur : " utilisateur

                    # Vérifier si l'utilisateur existe
                    if id "$utilisateur" &>/dev/null; then
                    # Demander le nouveau mot de passe
                        echo "Entrez le nouveau mot de passe pour $utilisateur : "
                        sudo passwd "$utilisateur"
                    else
                        echo "L'utilisateur $utilisateur n'existe pas."
                        exit 1
                    fi
                    
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
            clear 
            # DEBUT CAS demande quelle action effectuer
            echo -e "Quelles type d'action souhaitez vous effectuer ? \n1) Actions sur la machine \n2) Actions sur les fichiers \n3) Actions sur le parefeu  \n4) Action sur les logiciels"
            read actionType
            clear 
            case $actionType in
            # dans le cas 1 gestion de la machine
            1)
               
                echo -e "Quelle action sur la machine ? \n1) Arret de la machine  \n2) Redemarrage de la machine \n3) Verrouillage de la machine \n4) Mise à jour de la machine \n5) Pmad"
                read actionhost
                clear 

                # DEBUT CAS demande quelles action effectuer sur la machine
                case $actionhost in

                    # dans le cas 1 - Arrêt
                    1) arret ;;
                    # Fonction -> Arrêt
                
                    # dans le cas 2 - Redémarrage
                    2) redemarrage ;;
                        # Fonction -> Redémarrage

                    # dans le cas 3 - Verrouillage
                    3) verrouillage ;;
                        # Fonction -> Verrouillage

                    # dans le cas 4 - Mise-à-jour du système
                    4) mise_a_jour ;;
                        # Fonction -> Mise-à-jour du système
                    
                    # dans le cas 5 - PMAD
                    5) pmad ;;
                        # Fonction -> PMAD
                    *) echo "Action non valide pour la machine" ;;
                    # FIN CAS demande quelles action effectuer sur la machine
                esac
                ;;
            # dans la cas 2 gestion des fichiers 
            2) 
                echo -e "Quelle action sur les fichiers ? \n1) Creation repertoire \n2) Modification repertoire \n3) Suppression repertoire"
                read actionFile
                clear 
                # DEBUT CAS demande quelles actions effectuer sur les fichiers
                
                case $actionFile in
                # dans le cas 1 - Création de répertoire
                1) creation_repertoire ;;
                    # Fonction -> Création de répertoire

                # dans le cas 2 - Modification de répertoire
                2) modification_repertoire ;;
                    # Fonction -> Modification de répertoire

                # dans le cas 3 - Suppression de répertoire
                3) suppression_repertoire ;;
                    # Fonction -> Suppression de répertoire
                *) echo "Erreur de saisie pour les fichiers" ;;
                esac
                ;;
                # FIN CAS demande quelles actions effectuer sur les fichiers
            
            # dans le cas 3 gestion du parefeu
            3)
                echo -e "Quelle action sur le pare-feu ? \n1) Activation du pare feu \n2) Désactivation du pare feu"
                read actionFirewall
                clear
                # DEBUT CAS demande quelles action à effectuer sur le parefeu
                case $actionFirewall in
                # dans le cas 1 - Activation du pare-feu
                1) activation_pare_feu ;;
                    # Fonction -> Activation du pare-feu

                # dans le cas 2 - Désactivation du pare-feu
                2) desactivation_pare_feu ;;
                    # Fonction -> Désactivation du pare-feu

                *) echo "Erreur de saisie pour le pare-feu" ;;
                esac
                ;;
                # FIN CAS demande quelles action à effectuer sur le parefeu

            
            # dans le cas 4 gestion des logiciels
            4)
                echo -e "Quelle action sur les logiciels ? \n1) Installation du logiciel  \n2) Désinstallation du logiciel  \n3) Exécution du logiciel"
                read actionSoftware
                clear
                # DEBUT CAS demande quelles actions à effectuer sur les logiciel 
                case $actionSoftware in
                # dans le cas 1 - Installation de logiciel
                1) installation_logiciel ;;
                    # Fonction -> Installation de logiciel
                
                # dans le cas 2 - Désinstallation de logiciel
                2) desinstallation_logiciel ;;
                    # Fonction -> Désinstallation de logiciel

                # dans le cas 3 - Exécution de script sur la machine distante
                3) Exécution_du_logiciel ;;
                    # Fonction -> Exécution de script sur la machine distante

                *) echo "Erreur de saisie pour les logiciels" ;;
                esac
                ;;
             *) echo "Erreur de saisie sur les actions"
                # FIN CAS demande quelles actions à effectuer sur les logiciel
            esac
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


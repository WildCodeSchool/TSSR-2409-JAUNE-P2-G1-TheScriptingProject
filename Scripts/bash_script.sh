#!/bin/bash
# Fonctions ()
# Fonctions ()
# Fonctions ()

# début de la boucle while 

    # accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur
    # dans le cas 1 utilistaeur

        # demande un type d'action
        # dans le cas 1 action sur les groupes ou user

            # demande quelles actions effectuer
            # dans le cas 1 gestion des comptes

                # Demande quel action exécuter sur les comptes    
                # dans le cas 1
                    # Fonction -> Création de compte utilisateur local

                # dans le cas 2
                    # Fonction -> Changement de mot de passe

                # dans le cas 3
                    # Fonction -> Suppression de compte utilisateur local 

                # dans le cas 4 
                    # Fonction -> Désactivation de compte utilisateur local
                
                # FIN CAS Demande quel action exécuter sur les comptes  


            # dans le cas 2 gestion des goupe

                # Demande quel action exécuter sur les groupes  
                # dans le cas 1
                    # Fonction -> Ajout à un groupe d'administration

                # dans le cas 2
                    # Fonction -> Ajout à un groupe local

                # dans le cas 3
                    # Fonction -> Sortie d’un groupe local

                # FIN CAS Demande quel action exécuter sur les groupes  
            
            # FIN CAS demande quelles actions effectuer


        # dans le cas 2 information

            # demande quelle information récupérer
            # dans le cas 1 information lié à la session

                # demande quelles info lié à la session récupérer 
                # dans le cas 1
                    # Fonction -> Date de dernière connexion d’un utilisateur

                # dans le cas 2
                    # Fonction -> Date de dernière modification du mot de passe

                # dans le cas 3
                    # Fonction -> Liste des sessions ouvertes par l'utilisateur

                # FIN CAS demande quelles info lié à la session récupérer

            # dans le cas 2 information lié au compte

                # demande quelles info lié au compte récupérer
                # dans le cas 1 
                    # Fonction -> Groupe d’appartenance d’un utilisateur

                # dans le cas 2
                    # Fonction -> Historique des commandes exécutées par l'utilisateur

                # dans le cas 3
                    # Fonction -> Droits/permissions de l’utilisateur sur un dossier

                # dans le cas 4
                    # Fonction -> Droits/permissions de l’utilisateur sur un fichier
                
                # FIN CAS demande quelles info lié au compte récupérer
            
            # FIN CAS demande quelle information récupérer

        # FIN CAS demande un type d'action


    # dans le cas 2 ordinateur

        # demande un type d'action
        # dans le cas 1 action
            # demande quelle action effectuer
            # dans le cas 1 gestion de la machine

                # demande quelles action effectuer sur la machine
                # dans le cas 1
                    # Fonction -> Arrêt
                # dans le cas 2
                    # Fonction -> Redémarrage

                # dans le cas 3
                    # Fonction -> Verrouillage

                # dans le cas 4
                    # Fonction -> Mise-à-jour du système

                # dans le ca5
                    # Fonction -> PMAD

                # FIN CAS demande quelles action effectuer sur la machine

            # dans la cas 2 gestion des fichiers 

                # demande quelles actions effectuer sur les fichiers
                # dans le cas 1
                    # Fonction -> Création de répertoire

                # dans le cas 2
                    # Fonction -> Modification de répertoire

                # dans le cas 3
                    # Fonction -> Suppression de répertoire
                
                # FIN CAS demande quelles actions effectuer sur les fichiers

            # dans le cas 3 gestion du parefeu

                # demande quelles action à effectuer sur le parefeu
                # dans le cas 1
                    # Fonction -> Activation du pare-feu

                # dans le cas 2
                    # Fonction -> Désactivation du pare-feu
                
                # FIN CAS demande quelles action à effectuer sur le parefeu

            # dans le cas 4 gestion des logiciels

                # demande quelles actions à effectuer sur les logiciel
                # dans le cas 1
                    # Fonction -> Installation de logiciel

                # dans le cas 2 
                    # Fonction -> Désinstallation de logiciel

                # dans le cas 3
                    # Fonction -> Exécution de script sur la machine distante

                # FIN CAS demande quelles actions à effectuer sur les logiciel
            
            # FIN CAS demande quelle action effectuer
            


       # dans le cas 2 information

            # DEBUT CAS demande quelles informations récupérer
            echo -e "Quelles choix de menu?\n1) information machine \n2) information disques \n3) Information logiciel"
            read choix_menu
            clear
                case $choix_menu in
            # dans le cas 1 information sur la machine
                1)
                # DEBUT CAS demande quel type d'info machine récupérer
                echo -e "Que faire?\n1) version de l'os \n2) Mémoire RAM totale \n3) Utilisation de la RAM \n4) Utilisateurs locaux \n0) Sortie"
                read actionMachine
                clear

                    case $actionMachine in
                        # dans le cas 1 - Version de l'OS
                            # Fonction -> Version de l'OS
                        1) uname -r ;;
                        # dans le cas 2 - Mémoire RAM totale
                            # Fonction -> Mémoire RAM totale
                        2) free -h ;;
                        # dans le cas 3 - Utilisation de la RAM
                            # Fonction -> Utilisation de la RAM
                        3) free -h | awk '{print $2 "----- "}' ;;
                        # dans le cas 4 - Liste des utilisateurs locaux
                            # Fonction -> Liste des utilisateurs locaux
                        4) cat /etc/passwd ;;
                        # FIN CAS demande quel type d'info machine récupérer
                        0) echo "Sortie"
                            exit ;;
                        *) echo "Erreur de saisie" ;;
                        esac ;;

            # dans le cas 3 information sur les disques
                2)
               
                # DEBUT CAS demande quel type d'info récuperer sur les disques
                 echo -e "\n1) Nombre de disque \n2) Détail partition \n3) Espace restant \n4) Détails dossier \n5) Liste lecteur \n0) Sortie"
                read actionHost
                clear
                case $actionHost in
                # dans le cas 1 - Nombre de disque
                    # Fonction -> Nombre de disque
                    1) sudo lshw -class disk ;;
                # dans le cas 2 - Partition (nombre, nom, FS, taille) par disque
                    # Fonction -> Partition (nombre, nom, FS, taille) par disque
                    2) df -h ;;
                # dans le cas 3 - Espace disque restant par partition/volume
                    # Fonction -> Espace disque restant par partition/volume
                    3) df -h | awk '{print $1"-------"$4}' ;;
                # dans le cas 4 - Nom et espace disque d'un dossier (nom de dossier demandé)
                    # Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
                    4) read -p "quel nom de dossier?" choix_1
                            if [ -d "$choix_1" ]
                            then
                                find . -type d -name $choix_1 | du -hs
                            else 
                                echo "Le nom de dossier n'existe pas"
                            exit 1
                            fi ;;
                # dans le cas 5 - Liste des lecteurs monté (disque, CD, etc.)
                    # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
                    5) lsblk ;;
                # FIN CAS demande quel type d'info récuperer sur les disques
                    0) echo "Sortie" 
                        exit ;;
                    *) echo "Erreur de saisie";;
                    esac ;;

            # dans le cas 4 information sur les logiciels
                3)
                # DEBUT CAS demande quel type d'info récupérer sur les logiciels
                echo -e "Quells informations à récupérer? \n1) Liste des applications/paquets \n2) Liste des services en cours d'écéxution \0) sortie"
                read infoHost
                clear
                    case $infoHost in
                # dans le cas 1 - Liste des applications/paquets installées
                    # Fonction -> Liste des applications/paquets installées
                        1) dpkg --list ;;
                # dans le cas 2 - Liste des services en cours d'execution
                    # Fonction -> Liste des services en cours d'execution
                        2) service --status-all;;
                        0) echo "Sortie"
                            exit ;;
                        *) Erreur de saisie ;;
                # FIN CAS demande quel type d'info récupérer sur les logiciels
                        esac
            # FIN CAS demande quelles informations récupérer
        esac
        # FIN CAS demande si on doit récupérer une information ou effectuer une action

    # FIN CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur   


# demande si on doit continuer la boucle ou sortir

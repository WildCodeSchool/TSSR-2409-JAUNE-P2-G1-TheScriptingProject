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
        echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Actions sur les comptes \n2) Actions sur les groupes"
        read actionType
        clear
        
        case $actionType in
        1)
            # DEBUT CAS Demande quel action exécuter sur les comptes
            echo -e "Quelles type d'actions effectuer sur les comptes utilisateurs ? \n1) Création de compte utilisateur local \n2) Changement de mot de passe \n3) Suppression de compte utilisateur local  \n4) Désactivation de compte utilisateur local "               
            read userManagement
            clear
                case $userManagement in              
                # dans le cas 1 - Création de compte utilisateur local
                1)
                    # Fonction -> Création de compte utilisateur local
                    echo "Création de compte utilisateur local"
                    ;;
                # dans le cas 2 - Changement de mot de passe
                2) 
                    # Fonction -> Changement de mot de passe
                    echo "Changement de mot de passe"
                    ;;
                # dans le cas 3 - Suppression de compte utilisateur local 
                3)
                    # Fonction -> Suppression de compte utilisateur local 
                    echo "Suppression de compte utilisateur local "
                    ;;
                # dans le cas 4 - Désactivation de compte utilisateur local
                4)    
                    # Fonction -> Désactivation de compte utilisateur local
                    echo "Désactivation de compte utilisateur local"
                    ;;

                0)
                    echo "retour au menu précédent"
                    ;;
                *)
                    echo "Erreur de saisie" 
                    ;;
                # FIN CAS Demande quel action exécuter sur les comptes  
                esac 
                ;;
        
        # dans le cas 2 gestion des groupe
        2)
            # Demande quel action exécuter sur les groupes 
            echo -e "Quelles type d'actions effectuer sur les groupes ?\n1) Ajout à un groupe d'administration \n2) Ajout à un groupe local \n3) Sortie d’un groupe local "
            read groupManagement
            clear
                case $groupManagement in
                # dans le cas 1 - Ajout à un groupe d'administration
                1)
                    # Fonction -> Ajout à un groupe d'administration
                    echo "Ajout à un groupe d'administration"
                    ;;

                # dans le cas 2 - Ajout à un groupe local
                2)
                    # Fonction -> Ajout à un groupe local
                    echo "Ajout à un groupe local"
                    ;;

                # dans le cas 3 - Sortie d’un groupe local
                3)
                    # Fonction -> Sortie d’un groupe local
                    echo "Sortie d’un groupe local"
                    ;;

                *)
                    echo "Erreur de saisie" 
                    ;;
                # FIN CAS Demande quel action exécuter sur les groupes  
                esac 
                ;;
        # FIN CAS demande quelles actions effectuer
        esac 



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
# FIN BOUCLE while

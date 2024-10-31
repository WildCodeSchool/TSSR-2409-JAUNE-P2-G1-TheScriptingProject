#!/bin/bash

# Fonctions ()
# Fonctions ()
# Fonctions ()
# ...
clear
# DEBUT BOUCLE while 

# DEBUT CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur
# dans le cas 1 utilisteur
echo -e "Que souhaitez vous atteindre?\n1) Utilisateur\n2) Ordinateur\n"
read targetType
clear
case $targetType in
1)
    # DEBUT CAS demande si on doit récupérer une information ou effectuer une action
    # dans le cas 1 action
    echo -e "Que souhaitez vous faire ?\n1) Effectuer une action\n2) Récupérer une Information"
    read dowhatType
    clear
    case $dowhatType in
    1)
        # DEBUT CAS demande quelles actions effectuer
        # dans le cas 1 gestion des comptes
        echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Actions sur les comptes \n2) Actions sur les groupes"
        read actionType
        clear
        
        case $actionType in
        1)
            echo -e "Quelles type d'actions effectuer sur les comptes utilisateurs ? \n1) Création de compte utilisateur local \n2) Changement de mot de passe \n3) Suppression de compte utilisateur local  \n4) Désactivation de compte utilisateur local "               
            read userManagement
            clear
            
            case $userManagement in
                # Demande le nom d'utilisateur
                1 )# Fonction -> Création de compte utilisateur local
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
                    clear 
                    # Définit le mot de passe de l'utilisateur
                    echo "$username:$password" | chpasswd
                    # Création de l'utilisateur avec un répertoire personnel
                    sudo useradd -m -s /bin/bash "$username"

                    # Affiche un message de confirmation
                    echo "L'utilisateur '$username' a été créé avec succès."
                    exit 0
                    clear
                    ;;
                
                2)  # dans le cas 2 - Changement de mot de passe
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
                    ;;
                esac
                
        2)
            # DEBUT CAS Demande quel action exécuter sur les comptes
            echo -e "Quelles type d'actions effectuer sur les comptes utilisateurs ? \n1) Création de compte utilisateur local \n2) Changement de mot de passe \n3) Suppression de compte utilisateur local  \n4) Désactivation de compte utilisateur local "               
            read userManagement
            clear
            
            case $groupManagement in
                # dans le cas 1 - Ajout à un groupe d'administration
                1)
                    # Fonction -> Ajout à un groupe d'administration
                    echo -e "Merci d'indiquer l'utilisateur à ajouter au groupe sudo"
                    read userName
                    clear

                    if [ -z "$userName" ]
                    then
                        echo "Aucun compte saisi"
                        exit 1
                    else
                        sudo usermod -aG sudo "$userName" && echo ""$userName" ajouté au groupe sudo" 
                    fi
                    ;;

                # dans le cas 2 - Ajout à un groupe local
                2)
                    # Fonction -> Ajout à un groupe local
                    echo -e "Merci d'indiquer l'utilisateur à ajouter"
                    read userName
                    clear

                    if [ -z "$userName" ] 
                    then
                        echo "Aucun compte saisi"
                        exit 1
                    fi

                    echo -e "Merci d'indiquer le nom du groupes auquel l'utilisateur doit être ajouté. "
                    read groupName

                    if [ -z "$groupName" ] 
                    then
                        echo "Aucun groupe saisi"
                        exit 1
                    fi
                    sudo usermod -aG "$groupName" "$userName" && ""$userName" ajouté au groupe "$groupName""
                    ;;

                # dans le cas 3 - Sortie d’un groupe local
                3)
                    # Fonction -> Sortie d’un groupe local
                    echo -e "Merci d'indiquer l'utilisateur à retirer"
                    read userName
                    clear

                    if [ -z "$userName"] 
                    then
                        echo "Aucun compte saisi"
                        exit 1
                    fi

                    echo -e "Merci d'indiquer le nom du groupe auquel l'utilisateur doit être retiré. "
                    read groupName
                    clear
                    
                    if [ -z "$groupName"] 
                    then
                        echo "Aucun groupe saisi"
                        exit 1
                    fi
                    sudo userdel "$groupName" "$userName" && ""$userName" a été retiré du groupe "$groupName"" && echo "Sortie d’un groupe local"
                    ;;

                *)
                    echo "Erreur de saisie"
                    exit 1
                    ;;
                # FIN CAS Demande quel action exécuter sur les groupes  
                esac 
                ;;
        # FIN CAS demande quelles actions effectuer
        esac 
        ;;
    2)
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
                3)
            # dans le cas 2 information lié au compte
                echo -e "Quel information souhaitez-vous?\n1) Groupe d'appartenance d'un utilisateur\n2) Historique des commandes exécutées par l'utilisateur\n3) Droits/permissions de l'utilisateur sur un dossier\n4) Droits/permission de l'utilisateur sur un fichier\n0) Sortie "
                read info_perso
                clear
                case $info_perso in
                    # Fonction -> Groupe d’appartenance d’un utilisateur
                1) read -p "Quel utilisateur ?" utilisateur_cible
                    cat /etc/group | grep $utilisateur_cible ;;
                # dans le cas 2
                    # Fonction -> Historique des commandes exécutées par l'utilisateur
                2) shopt -s histappend
                    source ~/.bashrc
                    history;;
                # dans le cas 3
                    # Fonction -> Droits/permissions de l’utilisateur sur un dossier
                3) read -p "quelle nom de dossier? " nom_dossier
                    if [ -d "$nom_dossier" ]
                    then
                        whereis $nom_dossier | ls -l
                    else 
                        echo "Le nom de dossier n'existe pas"
                        exit 1
                    fi ;;
                
                # dans le cas 4
                    # Fonction -> Droits/permissions de l’utilisateur sur un fichier
                4) read -p "quelle nom de fichier? " nom_fichier
                    if [ -f "$nom_fichier" ]
                    then
                        whereis $nom_fichier | ls -l
                    else 
                        echo "Le nom de fichier n'existe pas"
                        exit 1
                    fi ;;
                # FIN CAS demande quelles info lié au compte récupérer
                0) exit 0 ;;
            # FIN CAS demande quelle information récupérer
                esac 
        # FIN CAS demande un type d'action
            

        # FIN CAS demande si on doit récupérer une information ou effectuer une action
    ;;
    esac
;;

    # dans le cas 2 ordinateur



2)    
    # DEBUT CAS demande demande si on doit récupérer une information ou effectuer une action
    # dans le cas 1 action
    echo -e "Que souhaitez vous faire ?\n1) Effectuer une action\n2) Récupérer une Information"
    read dowhatType
    clear
    case $dowhatType in
    1)

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
                    1) 
                    
                    # Fonction -> Arrêt
                        echo "Arrêt de la machine en cours..."
                        sudo shutdown now 
                        ;;
                    

                    # dans le cas 2 - Redémarrage
                    2)  
                        # Fonction -> Redémarrage
                        echo "Redémarrage de la machine en cours..."
                        sudo reboot
                        ;;

                    # dans le cas 3 - Verrouillage
                    3) 
                        # Fonction -> Verrouillage
                        echo "Verrouillage de la machine..."
                        gnome-screensaver-command -l || xdg-screensaver lock || echo "Commande de verrouillage indisponible"
                        ;;

                    # dans le cas 4 - Mise-à-jour du système
                    4)
                        # Fonction -> Mise-à-jour du système
                        echo "Mise à jour de la machine en cours..."
                        sudo apt update && sudo apt upgrade -y
                        ;;
                    # dans le cas 5 - PMAD
                    5) 
                        # Fonction -> PMAD
                        echo "Action PMAD en cours..."
                        echo -e "Saisir le nom de l'hote à atteindre\n"
                        read hostName
                        clear 

                        if [ -z $hostName ]
                        then 
                            echo "Aucun nom d'hôte saisi, arrêt du script"
                            exit 1
                        else
                            echo -e "Saisir le nom d'utilisateur avec lequel se connecter à $hostName\n"
                            read userName
                            clear
                        fi

                        if [ -z $userName ]
                        then
                            echo -e "Aucun nom d'utilisateur saisi, arrêt du script\n"
                            exit 1
                        else
                            echo -e "Êtes vous sur de vouloir vous connecter à $userName@$hostName ? o/n\n"
                            read validation
                            clear
                        fi

                        case $validation in
                            o) ssh "$userName"@"$hostName" ;;

                            *) echo "Validation refusé, arrêt du script" ;;
                        esac

                        ;;

                    *) 
                        echo "Action non valide pour la machine" 
                        ;;
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


                echo -e "Que voulez-vous faire ?\n1) Instalaltion de logiciel\n2) Désinstaller un logiciel\n3) Exécuter un script sur la machine\n0) Sortie"
                read action_logiciel
                clear
                case $action_logiciel in
                # dans le cas 1
                    # Fonction -> Installation de logiciel
                1) read -p "Quel est le nom du logiciel? " nom_logiciel_install
                    apt install $nom_logiciel_install ;;
                # dans le cas 2 
                    # Fonction -> Désinstallation de logiciel
                2) read -p "Quel est le nom du logiciel? " nom_logiciel_uninstall
                    apt remove $nom_logiciel_uninstall;;
                # dans le cas 3
                    # Fonction -> Exécution de script sur la machine distante
                3) read -p "Inserez une adresse ip" ip_valeur
                    systemctl enable sshd
                    ssh user@$ip_valeur
                    
                    ;;
                # FIN CAS demande quelles actions à effectuer sur les logiciel
                0) exit ;;
                esac 

            # FIN CAS demande quelle action effectuer
            
    ;;

        # dans le cas 2 information
    2)
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
        ;;
        esac
        # FIN CAS demande si on doit récupérer une information ou effectuer une actionn
    ;;
    esac
        
;;
esac
    # FIN CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur   



# demande si on doit continuer la boucle ou sortir
# FIN BOUCLE while

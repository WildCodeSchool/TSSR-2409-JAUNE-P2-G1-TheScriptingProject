#! /bin/bash


#----------------------------------------------------------------------------------------------------
#                                   Logiciels
# Fonction -> Installation de logiciel
function install_soft() {
    read -p "Quel est le nom du logiciel? " nom_logiciel_install
apt install $nom_logiciel_install ;
}

function désinstall-soft() {
    # Fonction -> Désinstallation de logiciel
read -p "Quel est le nom du logiciel? " nom_logiciel_uninstall
apt remove $nom_logiciel_uninstall
}

function exécution_script() {
    # Fonction -> Exécution de script sur la machine distante
read -p "Inserez une adresse ip" ip_valeur
systemctl enable sshd
ssh user@$ip_valeur
}

function historique() {
    #Historique
read -p "Inserez une adresse ip" ip_valeur
systemctl enable sshd
ssh user@$ip_valeur
}
                    
#---------------------------------------------------------------------------------------------------------                         
#                                   info machine récupérer

function version_os() {
    #Fonction -> Version de l'OS
uname -r
}
function ram_totale() {
    # Fonction -> Mémoire RAM totale
free -h
}
function ram_utilisation() {
    # Fonction -> Utilisation de la RAM
free -h | awk '{print $2 "----- "}'
}
function liste_utilisateurs() {
    # Fonction -> Liste des utilisateurs locaux
cat /etc/passwd
}
#-------------------------------------------------------------------------------------------------------------
#                                   Disque
function nombre_disque() {
    # Fonction -> Nombre de disque
sudo lshw -class disk
}

function partition() {
    # Fonction -> Partition (nombre, nom, FS, taille) par disque
df -h
}

function disque_restant() {
    # Fonction -> Espace disque restant par partition/volume
df -h | awk '{print $1"-------"$4}'
}

function espace_dossier() {
    # Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
read -p "quel nom de dossier?" choix_1
    if [ -d "$choix_1" ]
    then
        find . -type d -name $choix_1 | du -hs
    else 
        echo "Le nom de dossier n'existe pas"
        exit 1
    fi
}
function liste_lecteur() {
    # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
lsblk
}
# --------------------------------------------------------------------------------------
#                                    Appli/service
 # DEBUT CAS demande quel type d'info récupérer sur les logiciels

function liste_appli() {
    # Fonction -> Liste des applications/paquets installées
dpkg --list
}

function service_runing() {
    # Fonction -> Liste des services en cours d'execution
service --status-all
}
#-----------------------------------------------------------------------------------------------
#                                   GROUPE    
function ajout_grp_admin() {
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
}

function add_grp_local() {
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
}

function sortie_groupe() {
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
}
      
#---------------------------------------------------------------------------------------------


# DEBUT BOUCLE while 

# DEBUT CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur
# dans le cas 1 utilisteur
echo -e "Que souhaitez vous atteindre?\n1) Utilisateur\n2) Ordinateur\n"
read choix_1
clear
case $choix_1 in

1)
#cas utilisateur
    # DEBUT CAS demande si on doit récupérer une information ou effectuer une action
    
    echo -e "Que souhaitez vous faire ?\n1) Effectuer une action\n2) Récupérer une Information"
    read dowhatType
    clear
    case $dowhatType in  
        1)   
        #Effectuer une action

        
            # dans le cas 1 gestion des comptes
            echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Actions sur les comptes \n2) Actions sur les groupes"
            read actionType
            clear
            case $actionType in
        
            1) 
            # action exécuter sur les comptes
                echo -e "Quelles type d'actions effectuer sur les comptes utilisateurs ? \n1) Création de compte utilisateur local \n2) Changement de mot de passe \n3) Suppression de compte utilisateur local  \n4) Désactivation de compte utilisateur local "               
                read userManagement
                clear
                case $usermanagement in
    
                    1) ;; # Fonction création de compte
                    2) ;; # Fonction changement de mot de passe
                    3) ;; # Fonction suppression de compte
                    4) ;; # Fonction désactivation de compte
                    *) echo "Option invalide!" ;;
                
                    esac ;;

            2)
            # action sur les groupe
                echo "Quelle action souhaitez-vous effectuer sur les groupes ?\n1) Ajouter un utilisateur au groupe d'aministration\n2) Ajouter un utilisateur à un groupe local\n3) Retirer un utilisateur d'un groupe local"
                read group_action
                clear
                case $groupe_action in 
                    1) ajout_grp_admin ;;   #Ajouter un utilisateur au groupe d'aministration
                    2) add_grp_local ;;   #Ajouter un utilisateur à un groupe local 
                    3) sortie_groupe ;;   #Retirer un utilisateur d'un groupe local"
                    *) echo "erreur de saisie"

                    esac ;;
        
        2)
            # dans le cas 2 information
            echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Actions sur l'information lié à la session \n2) Actions sur l'information lié au compte"
            read info_1
            clear
            case $info_1 in 
            
                1)
                #cas 1 information lié à la session
                echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Date de dernière connexion d’un utilisateur \n2) Date de dernière modification du mot de passe \n3) Liste des sessions ouvertes par l'utilisateur"
                read info_2
                clear
                case $info_2 in

              
                    1) ;; # Fonction -> Date de dernière connexion d’un utilisateur
            
                    2) ;; # Fonction -> Date de dernière modification du mot de passe
           
                    3) ;; # Fonction -> Liste des sessions ouvertes par l'utilisateur
              
                # FIN CAS demande quelles info lié à la session récupérer
                esac ;;
            # dans le cas 2 information lié au compte
   
                2)
                # demande quelles info lié au compte récupérer
                echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Groupe d’appartenance d’un utilisateur \n2) Historique des commandes exécutées par l'utilisateur \n3) Droits/permissions de l’utilisateur sur un dossier \n4) Droits/permissions de l’utilisateur sur un fichier"
                read info_3 
                clear

                case $info_3 in 

          
                    1) ;;  # Fonction -> Groupe d’appartenance d’un utilisateur
                    2) ;; # Fonction -> Historique des commandes exécutées par l'utilisateur
                    3) ;; # Fonction -> Droits/permissions de l’utilisateur sur un dossier
                    4) ;; # Fonction -> Droits/permissions de l’utilisateur sur un fichier
                    *) echo "erreur de saisie"
                esac ;;
                # FIN CAS demande quelles info lié au compte récupérer
        
            # FIN CAS demande quelle information récupérer
            esac ;;
        # FIN CAS demande si on doit récupérer une information ou effectuer une action
        esac ;;
    esac ;; 
        2)  
        #cas ordinateur
    
            # DEBUT CAS demande demande si on doit récupérer une information ou effectuer une action
            echo -e "Que souhaitez vous faire ?\n1) Effectuer une action\n2) Récupérer une Information"
            read choix_2
            clear
            case $choix_2 in 
    
            1)    
                echo -e "Que souhaitez-vous faire?\n1) Gestion de la machine\n2) Gestion des fichiers\n3) Gestion du pare-feu\n4) Gestion des logiciels"
                read choix_gestion
                clear
                case $choix_gestion in
                
                    1)      
                    # Gestion de la machine
                    echo -e "Quelle action sur la machine ?\n1) Arrêt de la machine\n2) Redémarrage de la machine\n3) Verrouillage de la machine\n4) Mise à jour de la machine\n5) PMAD"
                    read choix_machine
                    clear
                    case $choix_machine in
                        1) ;;            # Fonction -> Arrêt de la machine
                        2) ;;          # Fonction -> Redémarrage de la machine
                        3) ;;             # Fonction -> Verrouillage de la machine
                        4) ;;           # Fonction -> Mise à jour du système
                        5) ;;        # Fonction -> PMAD
                        *) echo "Option invalide!" ;;
                    esac ;;
    
            2)  
            # Gestion des fichiers
                echo -e "Quelle action sur les fichiers ?\n1) Création de répertoire\n2) Modification de répertoire\n3) Suppression de répertoire"
                read actionFile
                clear

                case $actionFile in
                    1) ;;       # Fonction -> Création de répertoire
                    2) ;;       # Fonction -> Modification de répertoire
                    3) ;;       # Fonction -> Suppression de répertoire
                    *) echo "Option invalide!" ;;
                esac ;;
    
            3)  
            # Gestion du pare-feu
                echo -e "Quelle action sur le pare-feu ?\n1) Activation du pare-feu\n2) Désactivation du pare-feu"
                read actionFirewall
                clear

                case $actionFirewall in
                    1) ;;         # Fonction -> Activation du pare-feu
                    2) ;;         # Fonction -> Désactivation du pare-feu
                    *) echo "Option invalide!" ;;
                esac ;;
    
            4)  
            # Gestion des logiciels
                echo -e "Que voulez-vous faire ?\n1) Installation de logiciel\n2) Désinstallation de logiciel\n3) Exécuter un script\n0) Sortie"
                read action_logiciel
                clear

                case $action_logiciel in
                    1) install_software ;;      # Fonction -> Installation de logiciel
                    2) uninstall_software ;;    # Fonction -> Désinstallation de logiciel
                    3) ;;           # Fonction -> Exécution de script sur la machine
                    0) echo "Sortie..." ;;
                    *) echo "Option invalide!" ;;
                esac ;;
    

    
    
    2)   
    # dans le cas 2 information

echo -e "Quel choix de menu?\n1) Informations sur la machine \n2) Informations sur les disques \n3) Informations sur les logiciels"
read choix_menu
clear

    case $choix_menu in
        1)
            # Sous-menu pour les informations machine
            echo -e "Que souhaitez-vous faire?\n1) Version de l'OS \n2) Mémoire RAM totale \n3) Utilisation de la RAM \n4) Utilisateurs locaux \n0) Sortie"
            read info_machine
            clear
        
            case $info_machine in
                1) version_os ;;               # Appel de la fonction pour la version de l'OS
                2) ram_totale ;;               # Appel de la fonction pour la RAM totale
                3) ram_utilisation ;;          # Appel de la fonction pour l'utilisation de la RAM
                4) liste_utilisateur ;;        # Appel de la fonction pour la liste des utilisateurs locaux
                0) echo "Sortie" ;;

            esac ;;
        

        2)
            # sous menu pour les disques
            echo -e "\n1) Nombre de disque \n2) Détail partition \n3) Espace restant \n4) Détails dossier \n5) Liste lecteur \n0) Sortie"
            read info_dique
            clear
            case $info_disque in

                1) nombre_disque ;;   # Fonction nombre de disque
                2) partition ;;   # Fonction partition
                3) disque_restant ;;  #Fonction Espace disque restant par partition/volume
                4) espace_dossier ;;  # Fonction Nom et espace disque d'un dossier
                5) liste_lecteur ;;  # Fonction Liste des lecteurs monté
                0) echo "Sortie" ;;    

            esac ;;
        

        3)    
            #sous menu information sur les logiciels
            echo -e "Quells informations à récupérer? \n1) Liste des applications/paquets \n2) Liste des services en cours d'écéxution \0) sortie"
            read infoHost
            clear
            case $infoHost in

                1) liste_appli ;;     # Fonction liste des applications/paquets installées
                2) service_runing ;;     # Fonction liste des services en cours d'execution
                3) echo "Sortie" ;;
                # FIN CAS demande quel type d'info récupérer sur les logiciels
            esac ;;
            # FIN CAS demande quelles informations récupérer

        esac ;;
        # FIN CAS demande si on doit récupérer une information ou effectuer une action
    
    esac ;;
    # FIN CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur   

esac ;;
esac

# demande si on doit continuer la boucle ou sortir
# FIN BOUCLE while

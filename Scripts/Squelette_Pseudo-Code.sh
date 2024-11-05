#! /bin/bash

cible=whoami
horodate=$(date '+%Y%m%d')

function connexion_ssh() { 
# Demander à l'utilisateur son nom d'utilisateur
read -p "À quel utilisateur voulez-vous être connecté ? " User

# Demander l'adresse IP de connexion
read -p "Indiquez l'IP de connexion : " Ip_Valeur

# Vérifier si les valeurs saisies sont non vides
if [ -z "$User" ] || [ -z "$Ip_Valeur" ]; then
    echo "Erreur : Vous devez fournir à la fois un utilisateur et une adresse IP."
    exit 1
fi

# Établir la connexion SSH
ssh "$User@$Ip_Valeur"

}

#-------------------------------------------------------------------------------------------
#                                  Action Utilisateur

#Fonction Création compte utilisateur
function Création_de_compte_Utilisateur_local()
{
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
} 

#Fonction chagement de mot de passe
function Changement_MDP()
{
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
}

#Fonction Suppression de compte utilisateur local
function Suppression_du_compte_utilisateur ()
{
        read -p "Quel utilisateur doit être supprimé du compte local ? : " userName
        # Tester si l'utilisateur à supprimer existe
        if cat /etc/passwd | grep $userName > /dev/null
        then
            read -p "Confirmation de la suppression de l'utilisateur $userName [o/n] : " validation
            case $validation in
            o)
                # suppression de l'utilisisateur
                sudo userdel $userName
                if cat /etc/passwd | grep -wq "$userName"
                then
                    echo "Echec de la suppression de l'utilisateur $userName"
                else
                    echo "Utilisateur $userName supprimé avec succès"
                fi
                ;;
            n)
                # pas de suppression
                echo "Suppression du compte $userName annulé"
                ;;
            *)
                echo "Erreur de saisie"
                ;;
            esac
        else
            echo "Utilisateur $userName inconnu"
        fi
}


#Fonction Désactivation de compte utilisateur local



#Fonction -> Ajout à un groupe d'administration
function ajout_grp_admin() {  
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

#Fonction -> Ajout à un groupe local
function add_grp_local() { 
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

#Fonction -> Sortie d’un groupe local
function sortie_groupe() {   
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
#                                  action Ordinateur

#Fonction arrêt système
function Arrêt_machine()
{ 
    echo "Arrêt de la machine en cours..."
    sudo shutdown now 
}

#Fonction redémmarage système
function Redémarrage_machine()
{ 
    echo "Redémarrage de la machine en cours..."
    sudo reboot
}
  
#Fonction verrouillage système
function  Verrouillage_machine()
{
    echo "Verrouillage de la machine..."
    gnome-screensaver-command -l || xdg-screensaver lock || echo "Commande de verrouillage indisponible"   
}

#Fonction mise a jour du système
function Mise-à-jour_système()
{
    echo "Mise à jour de la machine en cours..."
    sudo apt update && sudo apt upgrade -y
} 

#Fonction Création de répertoire
#Fonction Modification de répertoire
#Fonction Suppression de répertoire


#fonction PMAD
function PMAD()

{
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
}

#fonction activer pare feu
function activer_pare_feu() 
{
    sudo -S ufw enable
    echo "Activation du pare-feu réussie." 
}
 
#Fonction désactiver pare feu
function desactiver_pare_feu() 
{
sudo -S ufw disable
echo "Désactivation du pare-feu réussie."
}

# Fonction -> Installation de logiciel
function install_soft() {
    read -p "Quel est le nom du logiciel? " nom_logiciel_install
apt install $nom_logiciel_install ;
}

# Fonction -> Désinstallation de logiciel
function désinstall-soft() {
read -p "Quel est le nom du logiciel? " nom_logiciel_uninstall
apt remove $nom_logiciel_uninstall
}

#Fonction Exécution de script sur la machine distante

#----------------------------------------------------------------------------------------------
#                                   Info Utilisateur

#Fonction Date de dernière connexion d’un utilisateur
function date_dernière_connexion()
{  
utilisateur="userName"  # Remplacer "userName" par le nom d'utilisateur
derniere_connexion=$(last -n 1 "$utilisateur" | awk '{print $4, $5, $6, $7}')
echo "Dernière connexion de $utilisateur : $derniere_connexion"
}

#Fonction Date de dernière modification du mot de passe
function date_dernière_modification_mot_de_passe()
{
  # Remplacer "userName" par le nom d'utilisateur
chage -l "userName" | grep "Dernier changement de mot de passe" | awk '{print $5, $6, $7}'
}

#Fonction Liste des sessions ouvertes par l'utilisateur
function liste_sessions_utilisateur() {
    local utilisateur=$1

    # Vérification que le nom d'utilisateur est fourni
    if [ -z "$utilisateur" ]; then
        echo "Veuillez spécifier un nom d'utilisateur."
        return 1
    fi

    # Affiche les sessions en cours pour l'utilisateur spécifié
    echo "Sessions ouvertes pour l'utilisateur : $utilisateur"
    who | grep "^$utilisateur" || echo "Aucune session ouverte trouvée pour $utilisateur."
}

#Fonction Groupe d’appartenance d’un utilisateur
function utilisateur_1() {
 read -p "Quel utilisateur ?" utilisateur_cible
cat /etc/group | grep $utilisateur_cible
}

#Fonction Historique des commandes exécutées par l'utilisateur
function utilisateur_2() {
shopt -s histappend
source ~/.bashrc
history
}

#Fonction Droits/permissions de l’utilisateur sur un dossier
function utilisateur_3() {
read -p "quelle nom de dossier? " nom_dossier
 if [ -d "$nom_dossier" ]
then
    whereis $nom_dossier | ls -l
else 
    echo "Le nom de dossier n'existe pas"
exit 1
fi
}

#Fonction Droits/permissions de l’utilisateur sur un fichier
function utilisateur_4() {
read -p "quelle nom de fichier? " nom_fichier
if [ -f "$nom_fichier" ]
then
    whereis $nom_fichier | ls -l
else 
    echo "Le nom de fichier n'existe pas"
exit 1
fi
#---------------------------------------------------------------------------------------------------------------------------
#                                               info ordinateur
#Fonction -> Version de l'OS
function version_os() {   
uname -r
}

# Fonction -> Nombre de disque
function nombre_disque() {   
sudo lshw -class disk
}

# Fonction -> Partition (nombre, nom, FS, taille) par disque
function partition() {  
df -h
}

# Fonction -> Espace disque restant par partition/volume
function disque_restant() {   
df -h | awk '{print $1"-------"$4}'
}

# Fonction -> Nom et espace disque d'un dossier (nom de dossier demandé)
function espace_dossier() {
read -p "quel nom de dossier?" choix_1
    if [ -d "$choix_1" ]
    then
        find . -type d -name $choix_1 | du -hs
    else 
        echo "Le nom de dossier n'existe pas"
        exit 1
    fi
}

# Fonction -> Liste des lecteurs monté (disque, CD, etc.)
function liste_lecteur() {  
lsblk
}

 # Fonction -> Liste des applications/paquets installées
function liste_appli() {
dpkg --list
}

# Fonction -> Liste des services en cours d'execution
function service_runing() { 
service --status-all
}

# Fonction -> Liste des utilisateurs locaux
function liste_utilisateurs() {   
cat /etc/passwd
}

# Fonction -> Mémoire RAM totale
function ram_totale() {
   free -h
}

# Fonction -> Utilisation de la RAM
function ram_utilisation() {
    
free -h | awk '{print $2 "----- "}'
}

        
#--------------------------------------------------------------------------------------------------
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
    
                    1) Création_de_compte_utilisateur_local ;; # Fonction création de compte
                    2) Changement_de_mot_de_passe ;; # Fonction changement de mot de passe
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

              
                    1) date_dernière_connexion >> info_${horodate}_${cible}.txt ;; # Fonction -> Date de dernière connexion d’un utilisateur
            
                    2) date_dernière_modification_mot_de_passe >> info_${horodate}_${cible}.txt ;; # Fonction -> Date de dernière modification du mot de passe
           
                    3) liste_sessions_utilisateur >> info_${horodate}_${cible}.txt ;; # Fonction -> Liste des sessions ouvertes par l'utilisateur
                    *) echo "erreur de saisie"
                # FIN CAS demande quelles info lié à la session récupérer
                esac ;;
            # dans le cas 2 information lié au compte
   
                2)
                # demande quelles info lié au compte récupérer
                echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Groupe d’appartenance d’un utilisateur \n2) Historique des commandes exécutées par l'utilisateur \n3) Droits/permissions de l’utilisateur sur un dossier \n4) Droits/permissions de l’utilisateur sur un fichier"
                read info_3 
                clear

                case $info_3 in 

          
                    1) utilisateur_1 >> info_${horodate}_${cible}.txt ;;  # Fonction -> Groupe d’appartenance d’un utilisateur
                    2) utilisateur_2 >> info_${horodate}_${cible}.txt ;; # Fonction -> Historique des commandes exécutées par l'utilisateur
                    3) utilisateur_3 >> info_${horodate}_${cible}.txt ;; # Fonction -> Droits/permissions de l’utilisateur sur un dossier
                    4) utilisateur_4 >> info_${horodate}_${cible}.txt ;; # Fonction -> Droits/permissions de l’utilisateur sur un fichier
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
                        1)  Arrêt_machine ;;            # Fonction -> Arrêt de la machine
                        2) Redémarrage_machine ;;          # Fonction -> Redémarrage de la machine
                        3) Verrouillage_machine ;;             # Fonction -> Verrouillage de la machine
                        4) Mise-à-jour_système ;;           # Fonction -> Mise à jour du système
                        5) PMAD ;;        # Fonction -> PMAD
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
                    1) activer_pare_feu ;;         # Fonction -> Activation du pare-feu
                    2) desactiver_pare_feu ;;         # Fonction -> Désactivation du pare-feu
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
                    3) ssh CLILIN01 bash < ./nomscript.sh ;;          # Fonction -> Exécution de script sur la machine
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
                1) version_os >> info_${horodate}_${cible}.txt ;;               # Appel de la fonction pour la version de l'OS
                2) ram_totale >> info_${horodate}_${cible}.txt ;;               # Appel de la fonction pour la RAM totale
                3) ram_utilisation >> info_${horodate}_${cible}.txt ;;          # Appel de la fonction pour l'utilisation de la RAM
                4) liste_utilisateur >> info_${horodate}_${cible}.txt ;;        # Appel de la fonction pour la liste des utilisateurs locaux
                0) echo "Sortie" ;;

            esac ;;
        

        2)
            # sous menu pour les disques
            echo -e "\n1) Nombre de disque \n2) Détail partition \n3) Espace restant \n4) Détails dossier \n5) Liste lecteur \n0) Sortie"
            read info_disque
            clear
            case $info_disque in

                1) nombre_disque >> info_${horodate}_${cible}.txt ;;   # Fonction nombre de disque
                2) partition >> info_${horodate}_${cible}.txt ;;   # Fonction partition
                3) disque_restant >> info_${horodate}_${cible}.txt ;;  #Fonction Espace disque restant par partition/volume
                4) espace_dossier >> info_${horodate}_${cible}.txt ;;  # Fonction Nom et espace disque d'un dossier
                5) liste_lecteur >> info_${horodate}_${cible}.txt ;;  # Fonction Liste des lecteurs monté
                0) echo "Sortie" ;;    

            esac ;;
        

        3)    
            #sous menu information sur les logiciels
            echo -e "Quells informations à récupérer? \n1) Liste des applications/paquets \n2) Liste des services en cours d'écéxution \0) sortie"
            read infoHost
            clear
            case $infoHost in

                1) liste_appli >> info_${horodate}_${cible}.txt ;;     # Fonction liste des applications/paquets installées
                2) service_runing >> info_${horodate}_${cible}.txt ;;     # Fonction liste des services en cours d'execution
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

#! /bin/bash

cible=$(whoami)
fichier_horo=$HOME/Documents/"Info_${cible}_$(date +'%Y%m%d').txt"

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
function Creation_de_compte_Utilisateur_local() {
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
function Changement_MDP() {
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
function Suppression_du_compte_utilisateur() {
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
function desactivation_utilisateur() {
echo -e "quel nom d'utilisateur?" choix_9
read choix_9
sudo usermod -L $choix_9
}



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
function Arret_machine() { 
    echo "Arrêt de la machine en cours..."
    sudo shutdown now 
}

#Fonction redemmarage système
function Redemarrage_machine() { 
    echo "Redémarrage de la machine en cours..."
    sudo systemctl reboot
}
  
#Fonction verrouillage système
function  Verrouillage_machine() {
    echo "Verrouillage de la machine..."
    gnome-screensaver-command -l || xdg-screensaver lock || echo "Commande de verrouillage indisponible"   
}

#Fonction mise a jour du système
function Mise_a_jour_systeme() {
    echo "Mise à jour de la machine en cours..."
    sudo apt update && sudo apt upgrade -y
} 

#Fonction Création de répertoire
function create_directory ()
{
    # Demander à l'utilisateur de fournir un nom de répertoire
    read -p "Veuillez indiquer le nom du répertoire: " repertoire

    # Chemin complet du répertoire dans le dossier personnel
    chemin_complet="$HOME/$repertoire"

    # Vérifier si le répertoire existe avant de le créer
    if [ ! -d "$chemin_complet" ]; then
    mkdir "$chemin_complet"
    echo "Le répertoire '$chemin_complet' a été créé."
    else
    echo "Le répertoire '$chemin_complet' existe déjà."
    fi
}

#Fonction Modification de répertoire
function modify_directory()
{
read -p "Voulez-vous déplacer ou renommer un répertoire ?  ('1'pour Renommer / '2'pour Déplacer) : " action

if [ "$action" == "1" ]; then
    read -p "Entrez le chemin actuel du répertoire : " ancien_nom
    read -p "Entrez le nouveau nom du répertoire : " nouveau_nom
    mv "$ancien_nom" "$nouveau_nom"
    echo "Le répertoire a été renommé en $nouveau_nom."

elif [ "$action" == "2" ]; then
    read -p "Entrez le chemin actuel du répertoire : " repertoire
    read -p "Entrez le nouveau chemin de destination : " destination
    mv "$repertoire" "$destination"
    echo "Le répertoire a été déplacé vers $destination."

else
    echo "Action non reconnue. Veuillez entrer '1' ou '2'."
fi
}

#Fonction Suppression de répertoire
function delete_directory()
{ 
    # Demander chemin du répertoire à supprimer
read -p "Entrez le chemin actuel du répertoire : "   repertoire_a_supprimer


    # Vérifier si le répertoire existe
if [ -d "$repertoire_a_supprimer" ]; then
    # Demander une confirmation
    read -p "Êtes-vous sûr de vouloir supprimer le répertoire '$repertoire_a_supprimer' ? [o/n] " confirmation
    if [ "$confirmation" = "o" ]; then
    # Si l'utilisateur confirme avec "o"
    rm -rf "$repertoire_a_supprimer"
    echo "Le répertoire '$repertoire_a_supprimer' a été supprimé."
    elif [ "$confirmation" = "n" ]; then
    # Si l'utilisateur annule avec "n"
    echo "Suppression annulée."

    else
    echo "Suppression annulée."
    fi
else
  echo "Erreur : Le répertoire '$repertoire_a_supprimer' n'existe pas."
  exit 1
fi
}

#fonction PMAD
function PMAD() {
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
function activer_pare_feu() {
    sudo -S ufw enable
    echo "Activation du pare-feu réussie." 
}
 
#Fonction désactiver pare feu
function desactiver_pare_feu() {
sudo -S ufw disable
echo "Désactivation du pare-feu réussie."
}

# Fonction -> Installation de logiciel
function install_soft() {
    read -p "Quel est le nom du logiciel? " nom_logiciel_install
sudo apt install $nom_logiciel_install ;
}

# Fonction -> Désinstallation de logiciel
function desinstall_soft() {
read -p "Quel est le nom du logiciel? " nom_logiciel_uninstall
sudo apt remove $nom_logiciel_uninstall
}

#Fonction Exécution de script sur la machine distante

#----------------------------------------------------------------------------------------------
#                                   Info Utilisateur

#Fonction Date de dernière connexion d’un utilisateur
function date_derniere_connexion() {  
last | head -n1
}

#Fonction Date de dernière modification du mot de passe
function date_derniere_modification_mot_de_passe() {
  sudo passwd -S $cible | awk '{print $3}'

}

#Fonction Liste des sessions ouvertes par l'utilisateur
function liste_sessions_utilisateur() {
   w
}

#Fonction Groupe d’appartenance d’un utilisateur
function utilisateur_1() {
 read -p "Quel utilisateur ?" utilisateur_cible
cat /etc/group | grep $utilisateur_cible
}

#Fonction Historique des commandes exécutées par lutilisateur
function utilisateur_2() {
#shopt -s histappend
#source ~/.bashrc
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
}

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
function liste_utilisateur() {   
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

max_execution=5
execution_count=0

while [ $execution_count -lt $max_execution ]; do
    ((execution_count++)) 

# Affichage du menu de sélection de la cible (ordinateur ou utilisateur)
echo -e "Que souhaitez-vous atteindre?\n1) Utilisateur\n2) Ordinateur\nX) Sortir du script"
read choix_1
clear

# Gestion de la cible choisie
case $choix_1 in
1)
    # Cible: Utilisateur
    echo -e "Que souhaitez-vous faire ?\n1) Effectuer une action\n2) Récupérer une Information"
    read dowhatType
    clear
    
    case $dowhatType in
    1)
        # Effectuer une action
        echo -e "Quel type d'action souhaitez-vous effectuer ?\n1) Actions sur les comptes\n2) Actions sur les groupes"
        read actionType
        clear
        
        case $actionType in
        1)
            # Actions sur les comptes
            echo -e "Quel type d'action sur les comptes utilisateurs ?\n1) Création de compte utilisateur local\n2) Changement de mot de passe\n3) Suppression de compte utilisateur local\n4) Désactivation de compte utilisateur local"
            read userManagement
            clear
            
            case $userManagement in
                1) Creation_de_compte_Utilisateur_local ;; # Fonction de création de compte
                2) Changement_MDP ;;           # Fonction de changement de mot de passe
                3) Suppression_du_compte_utilisateur ;;    # Fonction de suppression de compte
                4) desactivation_utilisateur ;;  # Fonction de désactivation de compte
                *) echo "Option invalide!" ;;
            esac ;;
        
        2)
            # Actions sur les groupes
            echo -e "Quelle action souhaitez-vous effectuer sur les groupes ?\n1) Ajouter un utilisateur au groupe d'administration\n2) Ajouter un utilisateur à un groupe local\n3) Retirer un utilisateur d'un groupe local"
            read group_action
            clear
            
            case $group_action in
                1) ajout_grp_admin ;;    # Ajouter un utilisateur au groupe d'administration
                2) add_grp_local ;;      # Ajouter un utilisateur à un groupe local
                3) sortie_groupe ;;      # Retirer un utilisateur d'un groupe local
                *) echo "Erreur de saisie" ;;
            esac ;;
        esac ;;
    
    2)
        # Récupérer une information
        echo -e "Quel type d'information souhaitez-vous obtenir ?\n1) Information liée à la session\n2) Information liée au compte"
        read info_1
        clear
        
        case $info_1 in
        1)
            # Information liée à la session
            echo -e "Quel type d'information ?\n1) Date de dernière connexion\n2) Date de dernière modification du mot de passe\n3) Liste des sessions ouvertes"
            read info_2
            clear
            
            case $info_2 in
                1) date_derniere_connexion >> $fichier_horo;; # Date de dernière connexion
                
                2) date_derniere_modification_mot_de_passe >> $fichier_horo ;; # Date de dernière modification du mot de passe
                
                3) liste_sessions_utilisateur >> $fichier_horo ;; # Liste des sessions ouvertes
                *) echo "Erreur de saisie" ;;
            esac ;;
        
        2)
            # Information liée au compte
            echo -e "Quel type d'information ?\n1) Groupe d’appartenance\n2) Historique des commandes\n3) Droits sur un dossier\n4) Droits sur un fichier"
            read info_3
            clear
            
            case $info_3 in
                1) utilisateur_1 >> info_${horodate}_${cible}.txt ;; # Groupe dappartenance
                2) utilisateur_2 >> info_${horodate}_${cible}.txt ;; # Historique des commandes
                3) utilisateur_3 >> info_${horodate}_${cible}.txt ;; # Droits sur un dossier
                4) utilisateur_4 >> info_${horodate}_${cible}.txt ;; # Droits sur un fichier
                *) echo "Erreur de saisie" ;;
            esac ;;
        esac ;;
    esac  ;;
    
2)
    # Cible: Ordinateur
    echo -e "Que souhaitez-vous faire ?\n1) Effectuer une action\n2) Récupérer une information"
    read choix_2
    clear
    
    case $choix_2 in
    1)
        # Effectuer une action
        echo -e "Que souhaitez-vous gérer ?\n1) Gestion de la machine\n2) Gestion des fichiers\n3) Gestion du pare-feu\n4) Gestion des logiciels"
        read choix_gestion
        clear
        
        case $choix_gestion in
        1)
            # Gestion de la machine
            echo -e "Quelle action ?\n1) Arrêt\n2) Redémarrage\n3) Verrouillage\n4) Mise à jour\n5) PMAD"
            read choix_machine
            clear
            
            case $choix_machine in
                1) Arret_machine ;; # Arrêt
                2) Redemarrage_machine ;; # Redémarrage
                3) Verrouillage_machine ;; # Verrouillage
                4) Mise_a_jour_systeme ;; # Mise à jour
                5) PMAD ;; # PMAD
                *) echo "erreur saisie!" ;;
            esac
            ;;
        
        2)
            # Gestion des fichiers
            echo -e "Quelle action sur les fichiers ?\n1) Création de répertoire\n2) Modification de répertoire\n3) Suppression de répertoire"
            read actionFile
            clear
            
            case $actionFile in
                1) create_directory ;; # Création de répertoire
                2) modify_directory ;; # Modification de répertoire
                3) delete_directory ;; # Suppression de répertoire
                *) echo "erreur saisie!" ;;
            esac ;;
        
        3)
            # Gestion du pare-feu
            echo -e "Quelle action sur le pare-feu ?\n1) Activation\n2) Désactivation"
            read actionFirewall
            clear
            
            case $actionFirewall in
                1) activer_pare_feu ;; # Activation du pare-feu
                2) desactiver_pare_feu ;; # Désactivation du pare-feu
                *) echo "erreur saisie!" ;;
            esac ;;
        
        4)
            # Gestion des logiciels
            echo -e "Que voulez-vous faire ?\n1) Installation\n2) Désinstallation\n3) Exécuter un script\n0) Sortie"
            read action_logiciel
            clear
            
            case $action_logiciel in
                1) install_soft ;; # Installation de logiciel
                2) uninstall_soft ;; # Désinstallation de logiciel
                3) ssh CLILIN01 bash < ./nomscript.sh ;; # Exécution d'un script
                0) echo "Sortie..." ;;
                *) echo "erreur saisie!" ;;
            esac ;;
        esac ;;
    
    2)
        # Récupérer une information
        echo -e "Quel choix de menu ?\n1) Informations sur la machine\n2) Informations sur les disques\n3) Informations sur les logiciels"
        read choix_menu
        clear
        
        case $choix_menu in
        1)
            # Informations sur la machine
            echo -e "Que souhaitez-vous obtenir ?\n1) Version de l'OS\n2) Mémoire RAM totale\n3) Utilisation de la RAM\n4) Utilisateurs locaux\n0) Sortie"
            read info_machine
            clear
            
            case $info_machine in
                1) version_os >> $fichier_horo ;; # Version OS
                2) ram_totale >> $fichier_horo;; # RAM totale
                3) ram_utilisation >> $fichier_horo ;; # Utilisation RAM
                4) liste_utilisateur >> $fichier_horo ;; # Utilisateurs locaux
                0) echo "Sortie" ;;
                *) echo "erreur saisie!" ;;
            esac ;;
        
        2)
            # Informations sur les disques
            echo -e "\n1) Nombre de disques\n2) Détail partition\n3) Espace restant\n4) Détails dossier\n5) Liste des lecteurs\n0) Sortie"
            read info_disque
            clear
            
            case $info_disque in
                1) nombre_disque >> $fichier_horo ;; # Nombre de disques
                2) partition >> $fichier_horo ;; # Détail partition
                3) disque_restant >> $fichier_horo ;; # Espace restant
                4) espace_dossier >> $fichier_horo ;; # Détails dossier
                5) liste_lecteur >> $fichier_horo;; # Liste lecteurs
                0) echo "Sortie" ;;
                *) echo "erreur saisie!" ;;
            esac ;;
        
        3)
            # Informations sur les logiciels
            echo -e "Quelles informations ?\n1) Liste des applications/paquets\n2) Liste des services en cours\n0) Sortie"
            read infoHost
            clear
            
            case $infoHost in
                1) liste_appli >> $fichier_horo ;; # Liste des applications
                2) service_runing >> $fichier_horo ;; # Liste des services en cours
                0) echo "Sortie" ;;
                *) echo "erreur saisie!" ;;
            esac ;;
        esac ;;
    esac ;;
    
x)
    
    if [ $x ="0" ] ;then
        echo "vous êtes Sorti du script"
        exit 2
    fi 
esac
done
echo "Nombre maximal de tentatives atteint. Le script s'arrête."

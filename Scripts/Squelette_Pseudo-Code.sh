#!/bin/bash

#!/bin/bash
#----------------------------------------------------------------------------------------------------
#                                   Logiciels

fonction install_soft ()
{
    # Fonction -> Installation de logiciel
read -p "Quel est le nom du logiciel? " nom_logiciel_install
apt install $nom_logiciel_install
}
fonction désinstall-soft ()
{
    # Fonction -> Désinstallation de logiciel
read -p "Quel est le nom du logiciel? " nom_logiciel_uninstall
apt remove $nom_logiciel_uninstall
}
fonctions exécution_script()
{
    # Fonction -> Exécution de script sur la machine distante
read -p "Inserez une adresse ip" ip_valeur
systemctl enable sshd
ssh user@$ip_valeur
}

fonction historique ()
{
    #Historique
read -p "Inserez une adresse ip" ip_valeur
systemctl enable sshd
ssh user@$ip_valeur
}
                    
#---------------------------------------------------------------------------------------------------------                         
#                                   info machine récupérer

fonction version_os()
{
    #Fonction -> Version de l'OS
uname -r
}
fonction ram_totale()
{
    # Fonction -> Mémoire RAM totale
free -h
}
fonction ram_utilisation ()
{
    # Fonction -> Utilisation de la RAM
free -h | awk '{print $2 "----- "}'
}
fonction liste_utilisateurs ()
    # Fonction -> Liste des utilisateurs locaux
cat /etc/passwd
}
#-------------------------------------------------------------------------------------------------------------
#                                   Disque
fonction nombre_disque ()
{
    # Fonction -> Nombre de disque
sudo lshw -class disk
}

fonction partition ()
{
    # Fonction -> Partition (nombre, nom, FS, taille) par disque
df -h
}

fonction ()
{
    # Fonction -> Espace disque restant par partition/volume
df -h | awk '{print $1"-------"$4}'
}

fonction ()
{
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
fonction liste_lecteur ()
{
    # Fonction -> Liste des lecteurs monté (disque, CD, etc.)
5) lsblk
}
# --------------------------------------------------------------------------------------
#                                    Appli/service
 # DEBUT CAS demande quel type d'info récupérer sur les logiciels

fonction liste_appli ()
{
    # Fonction -> Liste des applications/paquets installées
dpkg --list
}

fonction service_runing ()
{
    # Fonction -> Liste des services en cours d'execution
service --status-all
}
#-----------------------------------------------------------------------------------------------
#                                   GROUPE    
fonction ajout_grp_admin()
{
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

fonction add_grp_local ()
{
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

fonction ()
{
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




clear
# DEBUT BOUCLE while 

# DEBUT CAS accueil demande de sélectionner une cible , soit ordinateur, soit utilisateur
# dans le cas 1 utilisteur
echo -e "Que souhaitez vous atteindre?\n1) Utilisateur\n2) Ordinateur\n"
read targetType
clear
case $targetType in

    # DEBUT CAS demande si on doit récupérer une information ou effectuer une action
    # dans le cas 1 action
    echo -e "Que souhaitez vous faire ?\n1) Effectuer une action\n2) Récupérer une Information"
    read dowhatType
    clear
    case $dowhatType in
    
        # DEBUT CAS demande quelles actions effectuer
        # dans le cas 1 gestion des comptes
        echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Actions sur les comptes \n2) Actions sur les groupes"
        read actionType
        clear
        
        case $actionType in
        
            # DEBUT CAS Demande quel action exécuter sur les comptes
            echo -e "Quelles type d'actions effectuer sur les comptes utilisateurs ? \n1) Création de compte utilisateur local \n2) Changement de mot de passe \n3) Suppression de compte utilisateur local  \n4) Désactivation de compte utilisateur local "               
            read userManagement
            clear
            case $groupManagement in
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
            echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Actions sur l'information lié à la session \n2) Actions sur l'information lié au compte"
            read infoType
            clear
            # dans le cas 1 information lié à la session
            case $infoType in
        
                # demande quelles info lié à la session récupérer 
                echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Date de dernière connexion d’un utilisateur \n2) Date de dernière modification du mot de passe \n3) Liste des sessions ouvertes par l'utilisateur"
                read infoUser
                clear
                # dans le cas 1 - Date de dernière connexion d’un utilisateur
                case $infoUser in
              
                    # Fonction -> Date de dernière connexion d’un utilisateur
               
                # dans le cas 2 - Date de dernière modification du mot de passe
           
                    # Fonction -> Date de dernière modification du mot de passe
               
                # dans le cas 3 - Liste des sessions ouvertes par l'utilisateur
           
                    # Fonction -> Liste des sessions ouvertes par l'utilisateur
              
                # FIN CAS demande quelles info lié à la session récupérer
           
            # dans le cas 2 information lié au compte
   

                # demande quelles info lié au compte récupérer
                echo -e "Quelles type d'action souhaitez vous effectuer ?\n1) Groupe d’appartenance d’un utilisateur \n2) Historique des commandes exécutées par l'utilisateur \n3) Droits/permissions de l’utilisateur sur un dossier \n4) Droits/permissions de l’utilisateur sur un fichier"
                read actiontype 
                clear
                case $actiontype in
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
    echo -e "Que souhaitez vous faire ?\n1) Effectuer une action\n2) Récupérer une Information"
    read dowhatType
    clear
    case $dowhatType in
    
     echo -e "Que souhaitez vous faire?"\n1) Gestion de la machine\n2) Gestion des fichiers\n3) Gestion du pare-feu
    read choix_gestion
    clear
    case choix_gestion in
        
            
            # DEBUT CAS demande quelle action effectuer
            1)# dans le cas 1 gestion de la machine
            
                echo -e "Quelle action sur la machine ? \n1) Arret de la machine\n2) Redemarrage de la machine\n3) Verrouillage de la machine\n4) Mise à jour de la machine\n5) Pmad"
                read actionhost
                clear 
                # DEBUT CAS demande quelles action effectuer sur la machine
                case $actionhost in
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
    
                 
                echo -e "Quelle action sur les fichiers ? \n1) Creation repertoire \n2) Modification repertoire \n3) Suppression repertoire"
                read actionFile
                clear 
                # DEBUT CAS demande quelles actions effectuer sur les fichiers
                case $actionFile in
                
                # dans le cas 1 - Création de répertoire
 
                    # Fonction -> Création de répertoire
     
                # dans le cas 2 - Modification de répertoire

                    # Fonction -> Modification de répertoire
   
                # dans le cas 3 - Suppression de répertoire
  
                    # Fonction -> Suppression de répertoire
     
                    
                # FIN CAS demande quelles actions effectuer sur les fichiers
   
            # dans le cas 3 gestion du parefeu
   
                
                echo -e "Quelle action sur le pare-feu ? \n1) Activation du pare feu \n2) Désactivation du pare feu"
                read actionFirewall
                clear
                # DEBUT CAS demande quelles action à effectuer sur le parefeu
                case $actionFirewall in
                # dans le cas 1 - Activation du pare-feu
      
                    # Fonction -> Activation du pare-feu
 

                # dans le cas 2 - Désactivation du pare-feu
         
                    # Fonction -> Désactivation du pare-feu
         
                    
                # FIN CAS demande quelles action à effectuer sur le parefeu
                

            # dans le cas 4 gestion des logiciels

            
                echo -e "Que voulez-vous faire ?\n1) Instalaltion de logiciel\n2) Désinstaller un logiciel\n3) Exécuter un script sur la machine\n0) Sortie"
                read action_logiciel
                clear
                case $action_logiciel in
                # dans le cas 1
                    # Fonction -> Installation de logiciel

                # dans le cas 2 
                    # Fonction -> Désinstallation de logiciel

                # dans le cas 3
                    # Fonction -> Exécution de script sur la machine distante
               
                # FIN CAS demande quelles actions à effectuer sur les logiciel
 
            # FIN CAS demande quelle action effectuer
   

    # dans le cas 2 information

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

            # dans le cas 2 - Mémoire RAM totale
            # Fonction -> Mémoire RAM totale

            # dans le cas 3 - Utilisation de la RAM
            # Fonction -> Utilisation de la RAM

            # dans le cas 4 - Liste des utilisateurs locaux
            # Fonction -> Liste des utilisateurs locaux
            
            # FIN CAS demande quel type d'info machine récupérer
          

        # dans le cas 3 information sur les disques

            
                # DEBUT CAS demande quel type d'info récuperer sur les disques
            echo -e "\n1) Nombre de disque \n2) Détail partition \n3) Espace restant \n4) Détails dossier \n5) Liste lecteur \n0) Sortie"
            read actionHost
            clear
            case $actionHost in
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
        echo -e "Quells informations à récupérer? \n1) Liste des applications/paquets \n2) Liste des services en cours d'écéxution \0) sortie"
        read infoHost
        clear
        case $infoHost in
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

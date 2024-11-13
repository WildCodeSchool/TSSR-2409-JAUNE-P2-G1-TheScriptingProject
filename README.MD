### Présentation du projet


**Objectif principal :**  
L'objectif est de créer un script permettant l'automatisation de la gestion de postes et d'utilisateurs client.

**Objectif secondaire :**  
Depuis un serveur, cibler une machine cliente avec un type d’OS différent.


### Membres du groupe de projet (rôles par sprint)


**Semaine 1:**

|   Nom    |     Rôles     |             Tâche              |
| :------: | :-----------: | :----------------------------: |
| Baudouin | Développeur   | Installation et config réseau  |
|  Damien  | Developpeur   | Installation et config réseau  |
|  Arnaud  | Scrum Master  | Installation et config réseau  |
| Anthony  | Product Owner | Installation et config réseau  |

**Semaine 2:**

|   Nom    |     Rôles     |    Tâche    |
| :------: | :-----------: | :---------: |
| Baudouin | Scrum Master  | Script Bash |
|  Damien  | Product Owner | Script Bash |
|  Arnaud  |  Développeur  | ScriptBash  |
| Anthony  |  Développeur  | Script Bash |

**Semaine 3:**

|   Nom    |     Rôles     |       Tâche       |
| :------: | :-----------: | :---------------: |
| Baudouin | Développeur   | Script Powershell |
|  Damien  | Product Owner | Script powershell |
|  Arnaud  |  Scrum Master |    Script Bash    |
| Anthony  |   Développeur |    Script Bash    |

**Semaine 4:**

|   Nom    |     Rôles     |       Tâche       |
| :------: | :-----------: | :---------------: |
| Baudouin | Scrum Master  | Script Powershell |
|  Damien  | Product Owner | Script Powershell |
|  Arnaud  |  Développeur  |  Doc/Script bash  |
| Anthony  |  Développeur  |  Doc/Script bash  |



### Choix techniques


Environnement imposé par le client :

|   Nom    | Fonction |  Operating System   |    Compte     | Mot de passe |  Adresse IP  | CIDR |
| :------: | :------: | :-----------------: | :-----------: | :----------: | :----------: | :--: |
| SRVWIN01 | Serveur  | Windows Server 2022 | Administrator |   Azerty1*   | 172.16.10.5  | /24  |
| CLIWIN01 |  Client  |     Windows 10      |    wilder     |   Azerty1*   | 172.16.10.20 | /24  |
| SRVLX01  | Serveur  |      Debian 12      |     root      |   Azerty1*   | 172.16.10.10 | /24  |
| CLILIN01 |  Client  |    Ubuntu 22.04     |    wilder     |   Azerty1*   | 172.16.10.30 | /24  |

### Difficultés rencontrées : problèmes techniques rencontrés


**Semaine 2**


- Soucis de méthode, de code.


**Semaine 3**

- Accéder a une machine distante en SSH puis exécuter une commande par la suite (bash).
- Soucis de syntaxe sript (bash).
- le fichier journal ne va pas dans documents (Bash).
- Encodage des log  en utf16 (Powershell).


### Solutions trouvées : Solutions et alternatives trouvées





**Semaine 3**

- remise en forme du squelette script bash avec ajout de fonction (bash).
- relecture du script pour corriger syntaxe et faute de frappe dans les fonctions (bash).
- encodage des log résolu en changeant la fonction outfile (powershell).


**Semaine 4**

- Solution connexion ssh
- fichier journal va dans documents en créant une fonction.

### Améliorations possibles : suggestions d’améliorations futures

- Un menu plus lisible, graphique.

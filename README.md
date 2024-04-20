<p align="center">
  <img src="https://i0.wp.com/www.virtualtothecore.com/wp-content/uploads/2023/09/packer-winserver.png?fit=1280%2C640&ssl=1" width="500" alt="project-logo">
</p>
<p align="center">
    <h1 align="center">PACKER_WINDOWS_SRV_2022_GUI_or_CORE</h1>
</p>
<p align="center">
    <em><code>► ESGI 5SRC2 PA Projet</code></em>


<br><!-- TABLE OF CONTENTS -->
<details>
  <summary>Sommaire</summary><br>

- [ Objectif](#-Objectif)
- [ Prérequis](#-Prérequis)
- [ Structure du Projet ](#-Structure_du_Projet)
- [ Contenu du dossier ](#-Contenu_du_dossier)
- [ Getting Started](#-getting-started)
  - [ Installation](#-installation)
  - [ Usage](#-usage)
  - [ Tests](#-tests)

</details>
<hr>

##  Objectif

<code>► Ce projet a pour objectif d'automatiser la création d'images de machines virtuelles Windows Server 2022 à l'aide de Packer. Les images peuvent être configurées soit avec une interface graphique, soit en Core. </code>

---

##  Prérequis

<code> ► Avant de commencer, il faut avoir les élements suivants :
- Packer installé sur votre système. Vous pouvez le télécharger depuis le site officiel de Packer : [Packer.io](https://www.packer.io/downloads).
- Avoir l'ISO sur le vcenter. 
- Clé d'activation de windows server.
- Ne pas oublier les fichiers de configuration et les scripts dont vous avez besoin pour la création du template. 

</code>

---

##  Structure du Projet

```sh
 packer_windows
    ├── setup
    │   ├── cert
    │   │   ├── rootcaindio.cer
    │   │   └── subcaindio.cer
    │   ├── core
    │   │   └── autounattend.xml
    │   ├── gui
    │   │   └── autounattend.xml
    │   └── setup.ps1
    ├── variables.json
    └── win22.json
```

---

##  Contenu du dossier

<details closed><summary>.</summary>

| Fichiers                                                                                         |  Descriptions                          |
| ---                                                                                          | ---                             |
| win22.json        | <code>► Fichier de configuration Packer pour la création de l'image Windows Server.</code> |
| variables.json | <code>► Fichier de configuration contenant les variables.</code> |

</details>

<details closed><summary>setup</summary>

| Fichier                                                                                     |  Description                          |
| ---                                                                                      | ---                             |
| setup.ps1 | <code>► Script PowerShell pour les configurations lors de l'installation (Réseau, Installation VMware Tools et certificat, Autorisation RDP). </code> |

</details>

<details closed><summary>setup/cert</summary>

| Fichiers                                                                                                    
| ---                                                                      
| rootcaindio.cer
| subcaindio.cer

</details>

<details closed><summary>setup/core</summary>

| Fichier                                                                                     |  Description                          |
| ---                                                                                      | ---                             |
| autounattend.xml | <code>► Le fichier contiennent les réponses aux questions d'installation de Windows Server. </code> |

</details>


<details closed><summary>setup/gui</summary>

| Fichier                                                                                     |  Description                          |
| ---                                                                                      | ---                             |
| autounattend.xml | <code>► Le fichier contiennent les réponses aux questions d'installation de Windows Server. </code> |

</details>

---

##  Utilisation

###  1- Installation de packer
https://developer.hashicorp.com/packer/install?product_intent=packer

###  2- Configuration des variables

Avant de commencer le déploiement de la machin,  il faut modifier le fichier variables. Voici les variables que vous devrez configurer :
```console
{
    "vsphere_server": "L'adresse IP ou le nom DNS de votre serveur vSphere.",
    "vsphere_user": "Le nom d'utilisateur pour accéder à vSphere",
    "vsphere_password": "Le mot de passe associé à l'utilisateur vSphere",
    "vsphere_template_name": "Le nom de la mchine qui sera convertie en template",
    "vsphere_folder": "Indiquer le nom du dossier",
    "vsphere_dc_name": "Indiquer le nom du datacenter",
    "vsphere_compute_cluster": "Indiquer le nom du cluster",
    "vsphere_portgroup_name": "Indiquer le nom du portgroup",
    "vsphere_datastore": " Indiquer le nom Datastore",
    "winadmin_password": "Le mot de passe de l'administrateur Windows",
    "cpu_num": "Le nombre de CPU à attribuer ",
    "mem_size": "La taille de la mémoire RAM en Mo",
    "disk_size": "La taille de l'espace disqueen Mo",
    "os_iso_path": "Le chemin pour récupérer l'iso ISO",
    "floppy_file_1": "Le chemins d'accès aux fichiers à inclure dans le lecteur du disque a",
    "guest_os_type": "Indique le système d'exploitation",
    "insecure_connection": "Indiquer la connexion à vspshere est sécurisé par true ou false",
    "network_card_type": "Indiquer Le type de carte réseau"
}

voici un exemple : 
{
    "vsphere_server": "10.75.64.10",
    "vsphere_user": "toto@infra.indio",
    "vsphere_password": "toto",
    "vsphere_template_name": "Tpl-Win22_testcore1",
    "vsphere_folder": "00-templates",
    "vsphere_dc_name": "igfrdct01p",
    "vsphere_compute_cluster": "igfresx01p.infra.indio",
    "vsphere_portgroup_name": "DPG_SRV",
    "vsphere_datastore": "vsanDatastore",
    "winadmin_password": "Secretpassword",
    "cpu_num": "4",
    "mem_size": "8192",
    "disk_size": "102400",
    "os_iso_path": "[vsanDatastore] contentlib-624cc564-621f-46d1-8f15-7f40a0cdc961/d7e50001-ce96-456b-bc39-d504681712ff/Windows Server 2022 July 2023 (2)_1b989e4a-233d-4f13-9018-fbf5db8f4be2.iso",
    "floppy_file_1": "setup/gui/autounattend.xml",
    "floppy_file_2": "setup/setup.ps1",
    "floppy_file_3": "setup/cert/rootcaindio.cer",
    "floppy_file_4": "setup/cert/subcaindio.cer",
    "guest_os_type": "windows2019srvNext_64Guest",
    "insecure_connection": "true",
    "network_card_type": "vmxnet3"
}



<h4></h4>

> 1. Clone the packer_windows repository:
>
> ```console
> $ git clone https://github.com/GMukilventhan/packer_windows
> ```
>
> 2. Change to the project directory:
> ```console
> $ cd packer_windows
> ```
>
> 3. Install the dependencies:
> ```console
> $ > INSERT-INSTALL-COMMANDS
> ```

###  Usage

<h4>From <code>source</code></h4>

> Run packer_windows using the command below:
> ```console
> $ > INSERT-RUN-COMMANDS
> ```

###  Tests

> Run the test suite using the command below:
> ```console
> $ > INSERT-TEST-COMMANDS
> ```

---

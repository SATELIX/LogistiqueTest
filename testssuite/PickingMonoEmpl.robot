
*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    AppiumLibrary
# Resource   ${CURDIR}/../resources/utils.resource
# Resource   ${CURDIR}/../resources/page_accueil.resource
Resource   ${CURDIR}/../resources/module_preparation.resource
Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource
Resource   ${CURDIR}/../resources/module_preparation_handlingUnit.resource

Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   AppiumLibrary.Terminate Application    ${appPackage}

*** Variables ***
&{BARCODES}    BAAR01=A1T2N1P2

*** Keywords ***
Sur le terminal, sélectionner le module "Picking Mono Empl"
    Choisir Le Module Dans La Liste Des Modules    Picking Mono Empl

Sélectionner le document
    [Arguments]    ${document}
    module_preparation.Choisir Le Document A Preparer Dans La Liste Des Documents    ${document}

Sélectionner à la main l'article dans la liste
    [Arguments]    ${article}
    module_preparation_listearticles.Choisir L Article A Preparer    ${article}

Scanner le code barre correspondant à l'article 
    [Arguments]    ${article}
    Choisir L Article A Preparer Avec Le Lecteur CodeBarre    ${article}
	
Aller dans la liste et sélectionner le numéro de lot
    [Arguments]    ${lot}
    Afficher Les Lots Disponibles
    Choisir Le Lot    ${lot}
    
Appuyer sur "+"
    Ajoute Un Colis

Appuyer sur la flèche retour et "Finaliser"
    Appuyer sur la flèche retour
    Cliquer sur le bouton de finalisation
    

*** Test Cases ***
Cas Nominal De Preparation De Commande
    Sur le terminal, sélectionner le module "Picking Mono Empl"
    Sélectionner le document             PL00013
    Sélectionner à la main l'article dans la liste     BAAR01
    Entrer une quantité et valider    2
    Scanner le code barre correspondant à l'article     BAAR01
    Entrer une quantité et valider    13
    Scanner le code barre correspondant à l'article     BAAR01
    Entrer une quantité et valider    8
    Scanner le code barre correspondant à l'article     LINGOR18
    Aller dans la liste et sélectionner le numéro de lot     LOT-10
    Entrer une quantité et valider    2
    Scanner le code barre correspondant à l'article     LINGOR18 avec un lot associé
    Entrer une quantité et valider    3
    Appuyer Sur La Pastille Colis Avec Le Petit Carton   # et un "1"
    Appuyer sur "+"
    Rester appuyé sur l unite logistique          COLIS 2
    Sélectionner Un type d Unite Logistique Et valider    Palette Europe
    Appuyer sur la flèche retour    
    Scanner le code barre correspondant à l'article     BAOR01 avec la gamme Emeraude
    Entrer une quantité et valider    3
    Sélectionner à la main l'article dans la liste     BAOR01 Rubis
    Entrer une quantité et valider    1
    Scanner le code barre correspondant à l'article     EM040
    Sélectionner le conditionnement	    Pièce
    Entrer une quantité et valider    3
    Scanner le code barre correspondant à l'article     EM050
    Entrer une quantité et valider    26
    Scanner le code barre correspondant à l'article     MODIV01
    Saisir une valeur et valider    SERIE1
    Scanner le code barre correspondant au numéro de série     MF81
    Scanner le code barre correspondant au numéro de série     MF88     # qui n'existe pas
    Effacer le numéro de série, ne rien mettre et valider
    Appuyer sur "ok" et la "flèche retour"
    Appuyer sur la pastille colis avec le petit carton      # et un "2"
    Appuyer sur "+"
    Rester appuyé sur l unite logistique                 PALETTE EUROPE 3
    Sélectionner Un type d Unite Logistique Et valider   Palette Perdue
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article     CHAAR/VAR   # avec les gammes 42 et Forcat
    Entrer une quantité et valider    12
    Sélectionner à la main l'article dans la liste         CHAAR/VAR 34cm Classique
    Entrer une quantité et valider    1
    Appuyer sur la flèche retour et "Finaliser"
    # Appuyer sur "Terminer la saisie"
    # Mettre 1 et appuyer sur "Clôturer"
    # Mettre 12 et appuyer sur "Clôturer"
    # Mettre 0 et appuyer sur "Clôturer"
    # Mettre 15 et appuyer sur "Clôturer"
    # Valider le mode expédition sur Colissimo
    # Appuyer sur "Transférer"
    # Sélectionner "Valider picking"
    # Ouvrir le fichier Sage "Bijou_TEST" fichier commercial dans C:\Satelix
    # Cliquer sur "Traitement" puis "Documents des Ventes"
    # Sélectionner "Préparation de livraison"

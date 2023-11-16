
*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
# Resource   ${CURDIR}/../resources/utils.resource
# Resource   ${CURDIR}/../resources/page_accueil.resource
Resource   ${CURDIR}/../resources/module_preparation.resource
Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource
Resource    ../resources/module_prepaationLivrason.resource

Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   AppiumLibrary.Terminate Application    ${appPackage}

*** Variables ***
&{BARCODES}    BAAR01=A1T2N1P2

*** Test Cases ***
PickingMonoEmpl
    Sur le terminal, sélectionner le module     Picking Mono Empl
    Sélectionner le document             PL00013
    Sélectionner à la main l'article dans la liste     BAAR01
    Entrer une quantité et valider    2
    Scanner le code barre correspondant à l'article     BAAR01
    Entrer une quantité et valider    13
    Scanner le code barre correspondant à l'article     BAAR01
    Entrer une quantité et valider    8
    Appuyer sur "ok" et la "flèche retour"
    Scanner le code barre correspondant à l'article     LINGOR18
    Aller dans la liste et sélectionner le numéro de lot     LOT-10
    Entrer une quantité et valider    2
    Scanner le code barre correspondant à l'article     LINGOR18\\;LOT-10       # LINGOR18 avec un lot associé
    Entrer une quantité et valider    3
    Appuyer Sur La Pastille Colis Avec Le Petit Carton   # et un "1"
    Appuyer sur "+"
    Rester appuyé sur l unite logistique        COLIS\ 2
    Sélectionner Un type d Unite Logistique Et valider    Palette Europe
    Appuyer sur la flèche retour    
    Scanner le code barre correspondant à l'article       21731003            #BAOR01 avec la gamme Emeraude
    Entrer une quantité et valider    3
    Sélectionner à la main l'article dans la liste     BAOR01              # Rubis
    Entrer une quantité et valider    1
    Scanner le code barre correspondant à l'article     EM040
    Sélectionner le conditionnement	    Pièce
    Entrer une quantité et valider    3
    Scanner le code barre correspondant à l'article     EM050
    Entrer une quantité et valider    26
    Scanner le code barre correspondant à l'article     MODIV01
    Saisir une valeur et valider      SERIE1
    Scanner le code barre correspondant au numéro de série     MF81
    Scanner le code barre correspondant au numéro de série qui n'existe pas     MF88     
    Effacer le numéro de série, ne rien mettre et valider
    Appuyer sur "ok" et la "flèche retour"
    Appuyer sur la pastille colis avec le petit carton      # et un "2"
    Appuyer sur "+"
    Rester appuyé sur l unite logistique                 PALETTE EUROPE 3
    Sélectionner Un type d Unite Logistique Et valider   Palette Perdue
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article      38141025        # CHAAR/VAR avec les gammes 42 et Forcat
    Entrer une quantité et valider    12
    # Sélectionner à la main l'article dans la liste         CHAAR/VAR;037001034100000160    # 34cm Classique
    Sélectionner à la main l'article dans la liste         CHAAR/VAR;38141021;A1T2N3P3       # 34cm Classique
    Entrer une quantité et valider    1
    Appuyer sur la flèche retour et "Finaliser"
    Cliquer sur le bouton de finalisation                # Appuyer sur "Terminer la saisie"
    Entrer Le Poids Et Appuyer Sur Cloturer    1         # Mettre 1 et appuyer sur "Clôturer"
    Entrer Le Poids Et Appuyer Sur Cloturer    12        # Mettre 12 et appuyer sur "Clôturer"
    Entrer Le Poids Et Appuyer Sur Cloturer    0        # Mettre 0 et appuyer sur "Clôturer"
    Entrer Le Poids Et Appuyer Sur Cloturer    15        # Mettre 15 et appuyer sur "Clôturer"
    Valider Le Mode Expedition Sur             Colissimo
    # Appuyer sur Transferer
    # Valider La Préparation                                # Sélectionner "Valider picking"
    # Ouvrir le fichier Sage "Bijou_TEST" fichier commercial dans C:\Satelix
    # Cliquer sur "Traitement" puis "Documents des Ventes"
    # Dans Le Module Préparation De Livraison Le Statut de La péparation doit changer    PL00013    A livrer
    # Sur le terminal, sélectionner le module     Préparation de livraison

Testing
    Pause Execution
    Sleep    2s
    ${mycount}    AppiumLibrary.Get Matching Xpath Count    xpath=//androidx.cardview.widget.CardView[@id='card_item_article']
    ${mycount}    AppiumLibrary.Get Matching Xpath Count    xpath = //*[contains(@resource-id,'card_item_article')] 	

*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem



Resource    ../resources/module_prepaationLivrason.resource

Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}

*** Variables ***
${LOT-10}    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/tv_intitule_lot_serie" and @text="LOT-10"]

#Test OK pb bdd lot
*** Test Cases ***
PickingMonoEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module               Picking Mono Empl
    Sélectionner le document                              PL00013
    Sélectionner l article                                BAAR01
    Entrer une quantité et valider                        2
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       BAAR01
    Entrer une quantité et valider                        13
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       BAAR01
    Entrer une quantité et valider                        8
    Appuyer sur ok et back
    Scanner le code barre correspondant à l'article       LINGOR18
    Aller dans la liste et sélectionner le numéro de lot    LOT-10
    Entrer une quantité et valider                        2
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       LINGOR18\\;LOT-BDF9412083       # LINGOR18 avec un lot associé
    Entrer une quantité et valider                        3
    Appuyer Sur La Pastille Colis Avec Le Petit Carton    # et un "1"
    Appuyer sur "+"
    Rester appuyer sur l unite logistique                 COLIS\ 2
    Sélectionner Un type d Unite Logistique Et valider    Palette Europe
    Sleep                                                 2s
    Appuyer sur la flèche retour    
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       21731003            #BAOR01 avec la gamme Emeraude
    Entrer une quantité et valider                        18
    Sleep                                                 2s
    Sélectionner l article                                Pierres : Rubis              # BAOR01 avec la gamme Rubis
    Entrer une quantité et valider                        1
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       EM040
    Sélectionner le conditionnement vers droite           PIÈCE        # Pièce
    Entrer une quantité et valider                        3
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       EM050
    Entrer une quantité et valider                        26
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       MODIV01
    Saisir un Numero De Serie et valider                  SERIE1
    Sleep                                                 2s
    Scanner le code barre correspondant au numéro de série     MF81
    Sleep                                                 2s
    Scanner le code barre correspondant au numéro de série qui n'existe pas     MF88     
    Effacer le numéro de série, ne rien mettre et valider
    Press ENTER
    Appuyer sur ok et back
    Appuyer sur la pastille colis avec le petit carton      # et un "2"
    Appuyer sur "+"
    Rester appuyer sur l unite logistique                 PALETTE EUROPE 3
    Sélectionner Un type d Unite Logistique Et valider    Palette Perdue
    Sleep                                                 2s
    Appuyer sur la flèche retour
    Sleep                                                 2s
    Scanner le code barre correspondant à l'article       38141025        # CHAAR/VAR avec les gammes 42 et Forcat
    Entrer une quantité et valider                        12
    Sleep                                                 2s
    Sélectionner à la main Un Article Avec 2 Criteres     CHAAR/VAR    Longueur : 34 cm       #34cm         # 34cm Classique
    Entrer une quantité et valider                        1
    Sleep                                                 2s
    Appuyer sur la flèche retour et "Finaliser" 
    Confirmer la preparation incomplete
    Entrer Le Poids Et Appuyer Sur Cloturer               1           # Mettre 1 et appuyer sur "Clôturer"
    Entrer Le Poids Et Appuyer Sur Cloturer               12          # Mettre 12 et appuyer sur "Clôturer"
    Entrer Le Poids Et Appuyer Sur Cloturer               0           # Mettre 0 et appuyer sur "Clôturer"
    Press ENTER
    Une Erreur Doit Etre Indiquee Avec Le Message Correspondant  
    Entrer Le Poids Et Appuyer Sur Cloturer               15          # Mettre 15 et appuyer sur "Clôturer"
    Sleep                                                 2s
    Choisir LA Valeur Dans La Liste                       id=dropdown_list    Colissimo
    Appuyer sur Transferer
    Valider
    Sleep                                                 5s
    # Ouvrir le fichier Sage "Bijou_TEST" fichier commercial dans C:\Satelix
    # Cliquer sur "Traitement" puis "Documents des Ventes"
    # Dans Le Module Préparation De Livraison Le Statut de La péparation doit changer    PL00013    A livrer
    # Sur le terminal, sélectionner le module     Préparation de livraison



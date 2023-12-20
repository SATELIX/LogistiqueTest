*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem


Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/module_preparation.resource

Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
${MODIV01}          xpath = (//androidx.cardview.widget.CardView[@resource-id="fr.satelix.logistique:id/card_item_article"])[4]/android.view.ViewGroup
${SERIE_2206001}       //android.view.ViewGroup[@content-desc="Sélectionner le numéro de série SERIE-2206001"] 
${menu}        //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
${TAT}           //androidx.cardview.widget.CardView[@content-desc="Mode d'expédition TAT"]/android.view.ViewGroup 



*** Test Cases ***
PickingMultiEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                       Picking Multi Empl
    Sleep                                                         2s
    Sélectionner le document                                      PL00014
    Sélectionner l article                                        BAAR01
    Sélectionner l emplacement                                    A1T1N1P1
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Sleep                                                         2s
    Entrer une quantité supérieure au stock puis valider          200
    Entrer une quantité et valider                                3
    # Scanner le code barre correspondant à l'article               LINGOR18
    # Sélectionner l emplacement                                    A1T3N1P3            Pb bdd lot
    # Aller dans la liste et sélectionner le numéro de lot          LOT-10
    # Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               LINGOR18\\;LOT-10
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                3
    Appuyer sur la pastille du colis                           
    Appuyer sur "+"
    Rester appuyer sur l unite logistique                         COLIS 2
    Sleep                                                         2s
    Sélectionner Un type d Unite Logistique Et valider            Palette Europe
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BAOR01
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003
    Sleep                                                         2s
    Sélectionner l emplacement                                    A1T1N1P1
    Entrer une quantité et valider                                8
    Sleep                                                         2s
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAOR01   
    Sélectionner l emplacement                                    A1T1N1P2
    Sleep                                                         2s
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               EM040
    Sélectionner l emplacement                                    A1T3N1P2
    Sélectionner le conditionnement vers droite                   PIÈCE
    Entrer une quantité et valider                                3
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               EM050
    Sélectionner l emplacement                                    A1T1N1P1
    Entrer une quantité et valider                                24
    Sleep                                                         2s
    # Scanner le code barre correspondant à l'article               MODIV01
    # Sélectionner l emplacement                                    A2T1N2P2
    # Saisir un Numero De Serie et valider                          SERIE5
    # Scanner le code barre correspondant au numéro de série        SERIE4
    # Scanner le code barre correspondant au numéro de série        MF88
    # Sleep                                                         2s            #bug de l'app
    # Effacer le numéro de série, ne rien mettre et valider
    # Sleep                                                         4s
    # Appuyer sur ok et back
    # Sleep                                                         2s
    # Vider barre de recherche                                                                   
    # Afficher Les Articles Disponibles
    Scroll Vers Element                                           ${MODIV01}   bas
    Sleep                                                         2s    
    Sélectionner le document par element                          ${MODIV01}
    Sleep                                                         2s
    Sélectionner l emplacement                                    A2T1N2P2
    Choisir au menu déroulant avec scroll                         ${menu}    ${SERIE_2206001}
    Valider series
    Appuyer sur la pastille du colis
    Appuyer sur "+"
    Rester appuyer sur l unite logistique                         PALETTE EUROPE 3
    Sélectionner Un type d Unite Logistique Et valider            Palette Perdue
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025            #article CHAAR/VAR avec gammes 42 et Forçat
    Sélectionner l emplacement                                    A1T2N3P2
    Entrer une quantité et valider                                12
    Sélectionner l article                                        CHAAR/VAR
    Sélectionner l emplacement                                    A1T2N3P3
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Appuyer sur la flèche retour et "Finaliser"
    Confirmer la preparation incomplete
    Entrer Le Poids Et Appuyer Sur Cloturer                       1
    Entrer Le Poids Et Appuyer Sur Cloturer                       12
    Entrer Le Poids Et Appuyer Sur Cloturer                       0
    Press ENTER
    Une Erreur Doit Etre Indiquee Avec Le Message Correspondant
    Entrer Le Poids Et Appuyer Sur Cloturer                       15   
    Sleep                                                         2s        
    Valider Le Mode Expedition Sur                                ${TAT}
    Mettre date du lendemain
    Appuyer sur Transferer
    Sélectionner le document                                      VALIDER PICKING MULTI EMPL 
    Sleep                                                         5s
    Scanner code barre                                            TRA98745001                #tracking 1 pour le colis 1
    Sleep                                                         5s
    Scanner code barre                                            TRA98745001                #tracking 1 pour le colis 2, affiche une erreur
    Sleep                                                         5s
    Appuyer sur ok
    Sleep                                                         5s
    Scanner code barre                                            TRA98745002                #tracking 2 pour le colis 2
    Sleep                                                         5s
    Scanner code barre                                            TRA98745003                #tracking 3 pour le colis 3
    Sleep                                                         5s
    Appuyer sur Transferer
    Valider
    Sleep                                                         5s
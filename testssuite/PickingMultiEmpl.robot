*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem

Resource   ${CURDIR}/../resources/module_preparation.resource
Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource
Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/shared.resource
Resource    ../resources/module_preparation.resource

Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
&{BARCODES}    BAAR01=A1T2N1P2



*** Test Cases ***
PickingMultiEmpl
    Sur le terminal, sélectionner le module                       Picking Multi Empl
    Sélectionner le document                                      PL00014
    Sélectionner à la main l'article dans la liste                BAAR01
    Sélectionner l emplacement                                    A1T1N1P1
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Entrer une quantité supérieure au stock puis valider          200
    Entrer une quantité et valider                                3
    Scanner le code barre correspondant à l'article               LINGOR18
    Sélectionner l emplacement                                    A1T3N1P3
    Aller dans la liste et sélectionner le numéro de lot          LOT-10
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               LINGOR18\\;LOT-10
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                3
    Appuyer sur la pastille du colis                           
    Appuyer sur "+"
    Rester appuyé sur l unite logistique                          COLIS 2
    Sélectionner Un type d Unite Logistique Et valider            Palette Europe
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               BAOR01
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               21731003
    Sélectionner l emplacement                                    A1T1N1P1
    Entrer une quantité et valider                                8
    Aller dans la liste et sélectionner la préparation            BAOR01   #a parfois du mal à passer cette étape, raison?
    Sélectionner l emplacement                                    A1T1N1P2
    Entrer une quantité et valider                                1
    Scanner le code barre correspondant à l'article               EM040
    Sélectionner l emplacement                                    A1T3N1P2
    Sélectionner le conditionnement	                              PIÈCE
    Entrer une quantité et valider                                3
    Scanner le code barre correspondant à l'article               EM050
    Sélectionner l emplacement                                    A1T1N1P1
    Entrer une quantité et valider                                24
    Scanner le code barre correspondant à l'article               MODIV01
    Sélectionner l emplacement                                    A2T1N2P2
    Saisir un Numero De Serie et valider                          SERIE5
    Scanner le code barre correspondant au numéro de série        SERIE4
    Scanner le code barre correspondant au numéro de série        MF88
    Effacer le numéro de série, ne rien mettre et valider bis
    Sleep    2s
    Appuyer sur ok et back
    Supprimer Recherche Article                                   MF88    #le demande parfois                                        
    Scroll Vers Element                                           fr.satelix.logistique:id/tv_item_article_html   bas
    Sélectionner l article                                        MODIV01
    Sélectionner l emplacement                                    A2T1N2P2
    Aller dans la liste et sélectionner le numéro de lot valider  SERIE-2206001
    Appuyer sur la pastille du colis
    Appuyer sur "+"
    Rester appuyé sur l unite logistique                          PALETTE EUROPE 3
    Sélectionner Un type d Unite Logistique Et valider            Palette Perdue
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               38141025
    Sélectionner l emplacement                                    A1T2N3P2
    Entrer une quantité et valider                                12
    Sélectionner l article                                        CHAAR/VAR
    Sélectionner l emplacement                                    A1T2N3P3
    Entrer une quantité et valider                                1
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour et "Finaliser"
    Confirmer la preparation incomplete
    Entrer Le Poids Et Appuyer Sur Cloturer                       1
    Entrer Le Poids Et Appuyer Sur Cloturer                       12
    Entrer Le Poids Et Appuyer Sur Cloturer                       0
    Press ENTER
    Une Erreur Doit Etre Indiquee Avec Le Message Correspondant
    Entrer Le Poids Et Appuyer Sur Cloturer                       15
    Valider Le Mode Expedition Sur                                TAT
    Sélectionner date du lendemain
    Selectionner le document                                      VALIDER PICKING MULTI EMPL 
    Scanner code barre                                            TRA98745001
    Scanner code barre                                            TRA98745001
    Scanner code barre                                            TRA98745002
    Scanner code barre                                            TRA98745003
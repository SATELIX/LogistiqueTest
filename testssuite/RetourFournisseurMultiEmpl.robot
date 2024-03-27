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

${fournisseur}    //android.widget.ImageButton[@content-desc="Afficher la liste"]
${DUBOI}    //androidx.cardview.widget.CardView[@content-desc="Fournisseur Duboi expert comptable"]/android.view.ViewGroup
${série}    //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
${MF80}     //android.view.ViewGroup[@content-desc="Sélectionner le numéro de série MF80"]
${menu}    fr.satelix.logistique:id/text_input_end_icon
${LOT-10}    //android.view.ViewGroup[@content-desc="Sélectionner le numéro de lot LOT-10"]

*** Test Cases ***
RetourFournisseurMultiEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                       Retour fournisseur Multi Empl
    Sleep                                                         2s
    Choisir LA Valeur Dans La Liste                               id=dropdown_list    Bijou SA
    Choisir au menu déroulant                                     ${fournisseur}    ${DUBOI}
    Valider les informations
    Saisir l Article a la Main                                    BAAR01
    Sleep                                                         2s
    Sélectionner l emplacement                                    A1T2N1P2
    Sleep                                                         2s
    Entrer une quantité et valider                                3
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Sleep                                                         2s
    Entrer une quantité et valider                                3
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               LINGOR18
    Sleep                                                         4s
    Sélectionner l emplacement                                    A1T3N1P3                                                       
    Choisir au menu déroulant avec scroll                         ${menu}     ${LOT-10}
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               LINGOR18\\;LOT-BDF9411123
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Saisir l Article a la Main                                    EM040
    Sélectionner l emplacement                                    A1T3N1P2
    Sleep                                                         3s
    Sélectionner le conditionnement vers droite                   ECRIN DE 12
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               EM050
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               EM050/24                    #Scan de l'article EM050 avec le conditionnement ECRIN DE 24
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               MODIV01
    Sélectionner l emplacement                                    A2T1N2P2
    Choisir au menu déroulant                                     ${série}    ${MF80}
    Valider les informations
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               MF84                        #numéro de série MF84
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               MF88                        #numéro de série n'existant pas
    Sleep                                                         2s
    Appuyer sur ok
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    MF81
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s    
    Scanner le code barre correspondant à l'article               EM055                        #article n'existant pas
    Sleep                                                         2s
    Appuyer sur ok
    Vider barre de recherche
    Saisir l Article a la Main                                    BAOR01
    Sélectionner l emplacement                                    A1T1N1P1
    Sélection gamme                                               Emeraude
    Entrer une quantité et valider                                4
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003                     #article avec gamme associée
    Sélectionner l emplacement                                    A1T1N1P1
    Modifier une quantite                                         9
    Appuyer sur la flèche retour et "Mettre En Attente"
    Sur le terminal, sélectionner le module                       Retour fournisseur Multi Empl
    Cliquer sur Oui
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélectionner l emplacement                                    A1T2N3P2
    Sélection gamme                                               42
    Sélection sous gamme                                          Forçat
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025                    #article avec gammes associées
    Sélectionner l emplacement                                    A1T2N3P2
    Entrer une quantité et valider                                8
    Cliquer sur le bouton de finalisation
    #Mettre date du jour
    Transferer
    Valider
    Sleep                                                         5s



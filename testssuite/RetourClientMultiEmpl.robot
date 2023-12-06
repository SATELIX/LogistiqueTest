*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem


Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource
Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/shared.resource
Resource    ../resources/module_preparation.resource
Resource    retour_fournisseur_monoempl.robot


Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
${depot}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${destination}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${client}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[3]
${bagues}    //androidx.cardview.widget.CardView[@content-desc="Client Bague's en or"]/android.view.ViewGroup


*** Test Cases ***
Retour Client Multi Empl
    Sur le terminal, sélectionner le module                       Retour client multi empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${destination}          ${A1T1N1P1}
    Choisir au menu déroulant                                     ${client}          ${bagues}
    Valider les informations
    Saisir l Article a la Main     BAAR01
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Saisir l Article a la Main     BA
    Cliquer sur Non
    Sélectionner l article    BAAR01
    Sleep    2s
    Hide Keyboard
    Changer emplacement    A1T2N1P2
    Entrer une quantité et valider    2
    Vider barre de recherche    BA
    Saisir l Article a la Main     LINGOR18
    Changer emplacement    A1T3N1P3
    Appuyer sur la flèche retour
    #Scanner le code barre correspondant au lot    L1234        #pas de lot dans base de donnée
    #Entrer une quantité et valider    1
    #Scanner le code barre correspondant au lot    (92)59531012(10)LOT-TEST2
    #Changer emplacement    A1T3N1P3
    #Entrer une quantité et valider    1
    Saisir l Article a la Main     BAOR01
    Sélection gamme    Emeraude
    Entrer une quantité et valider    8
    Scanner le code barre correspondant à l'article    21731003
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Saisir l Article a la Main     CHAAR/VAR
    Sélection gamme    34
    Sélection sous gamme    Classique
    Entrer une quantité et valider    2
    Scanner le code barre correspondant à l'article    38141025
    Entrer une quantité et valider    3
    #Sélectionner l article    LINGOR18
    #Choisir Le Lot    L789                                #pas de lot dans base de donnée
    #Entrer une quantité et valider    2
    Finaliser
    Valider
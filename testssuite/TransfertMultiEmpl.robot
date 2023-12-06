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
${destination}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[3]
${Annexe Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Annexe Bijou SA"]/android.view.ViewGroup
${emplacement}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[4]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup


*** Test Cases ***
TransfertMultiEmpl
    Sur le terminal, sélectionner le module                       Transfert multi empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${destination}          ${Annexe Bijou SA}
    Choisir au menu déroulant                                     ${emplacement}          ${A1T1N1P1}
    Valider les informations
    Afficher Les Articles Disponibles
    Sélectionner l article    BAAR01
    Sélectionner l emplacement    A1T2N1P2
    Entrer une quantité et valider    2
    #Saisir l Article a la Main     LINGOR18
    #Sélectionner l emplacement    A1T3N1P3
    #Choisir Le Lot    LOT-10                        #Pas de lot dans base de donnée
    #Entrer une quantité et valider    1
    #Scanner le code barre correspondant au lot    LINGOR18;LOT-ABC
    #Appuyer sur la flèche retour
    Saisir l Article a la Main    BAOR01
    Sélectionner l emplacement    A1T1N1P1
    Sélection gamme    Rubis
    Entrer une quantité et valider    1
    Saisir l Article a la Main    CHAAR/VAR
    Sélectionner l emplacement    A1T1N1P1
    Sélection gamme    34
    Sélection sous gamme    Classique
    Entrer une quantité et valider    1
    Scanner le code barre correspondant à l'article    38141025
    Sélectionner l emplacement    A1T2N3P2
    Entrer une quantité et valider    2
    Cliquer sur le bouton de finalisation
    Valider
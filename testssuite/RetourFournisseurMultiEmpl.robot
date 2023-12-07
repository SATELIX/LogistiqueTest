*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem


Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource
Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/module_preparation.resource


Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
${depot}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${fournisseur}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${DUBOI}    ?


*** Test Cases ***
Retour Fournisseur multi empl
    Sur le terminal, sélectionner le module                       Retour fournisseur multi empl
    Choisir au menu déroulant    ${depot}    ${Bijou SA}
    Choisir au menu déroulant    ${fournisseur}    ${DUBOI}
    Valider les informations
    Saisir l Article a la Main    BAAR01
    Sélectionner l emplacement    A1T2N1P2
    Entrer une quantité et valider    3
    Scanner le code barre correspondant à l'article    BAAR01
    Sélectionner l emplacement    3
    Scanner le code barre correspondant à l'article    LINGOR18
    Sélectionner l emplacement    A1T3N1P3
    Choisir Le Lot    LOT-10
    Entrer une quantité et valider    1
    Scanner le code barre correspondant à l'article    LINGOR18;LOT-BDF9411123
    Sélectionner l emplacement    A1T3N1P3
    Entrer une quantité et valider    2
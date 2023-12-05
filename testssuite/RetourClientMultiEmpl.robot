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
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}





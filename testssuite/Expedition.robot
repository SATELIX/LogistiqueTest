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
${expe}    //android.widget.ImageButton[@content-desc="Afficher la liste"]
${Chronoposte}    //androidx.cardview.widget.CardView[@content-desc="Mode d'expédition Chronoposte"]/android.view.ViewGroup
${nb_colis}    //android.widget.EditText[@text="Nb colis"]
${nb_palettes_perdues}    //android.widget.EditText[@text="Nb palettes perdues"]
${nb_palettes_europe}    //android.widget.EditText[@text="Nb palettes Europe"]


#Test OK
*** Test Cases ***
Expedition
    Sur le terminal, sélectionner le module                       Expédition
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               PL00008            
    Choisir au menu déroulant                                     ${expe}          ${Chronoposte}
    Remplir donnée                                                ${nb_colis}    3
    Remplir donnée                                                ${nb_palettes_perdues}    1
    Remplir donnée                                                ${nb_palettes_europe}    2
    Appuyer sur Transferer
    Valider

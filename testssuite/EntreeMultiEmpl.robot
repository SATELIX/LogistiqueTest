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
${depot}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${emplacement}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup

#Test OK
*** Test Cases ***
EntreeMultiEmpl
    Sur le terminal, sélectionner le module                       Entrée multi empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${emplacement}          ${A1T1N1P1}
    Valider les informations
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BAAR01
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    LINGOR18\\;LOT-TEST2        
    Entrer une quantité et valider                                5
    Saisir l Article a la Main                                    LINGOR18  
    Sleep                                                         2s                                  
    Scanner le code barre correspondant au lot                    LINGOR18\\;LOT-999
    Entrer une quantité et valider                                2
    Saisir l Article a la Main                                    BAOR01
    Sélection gamme                                               Emeraude
    Entrer une quantité et valider                                3
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               EM040
    Sélectionner le conditionnement vers droite                   ECRIN DE 12
    Entrer une quantité et valider                                2
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélection gamme                                               34
    Sélection sous gamme                                          Classique
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025
    Sleep                                                         2s
    
    Entrer une quantité et valider                                2
    Cliquer sur le bouton de finalisation
    Valider
    Sleep                                                         5s






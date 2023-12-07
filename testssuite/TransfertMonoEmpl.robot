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
${destination}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${Annexe Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Annexe Bijou SA"]/android.view.ViewGroup



*** Test Cases ***
TransfertMonoEmpl
    Sur le terminal, sélectionner le module                       Transfert mono empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${destination}          ${Annexe Bijou SA}
    Valider les informations
    Afficher Les Articles Disponibles
    Sélectionner l article    BAAR01
    Entrer une quantité et valider    2
    #Saisir l Article a la Main     LINGOR18
    #Choisir Le Lot    LOT-10
    #Sélectionner le lot avec la DLC et a date de FAB renseignées.        #pas de lot dans base de donnée
    #Entrer une quantité et valider    1
    #Scanner le code barre correspondant au lot    LINGOR18;LOT-999
    #Appuyer sur la flèche retour
    Saisir l Article a la Main     BAOR01
    Sélection gamme    Rubis
    Entrer une quantité et valider    1
    Scanner le code barre correspondant au lot    21731003
    Entrer une quantité et valider    3
    Saisir l Article a la Main     CHAAR/VAR
    Sélection gamme    34
    Sélection sous gamme    Classique
    Entrer une quantité et valider    5
    Scanner le code barre correspondant à l'article    38141025
    Entrer une quantité et valider    2
    Cliquer sur le bouton de finalisation
    Valider
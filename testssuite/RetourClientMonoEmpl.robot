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
${client}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${BAGUES}    //androidx.cardview.widget.CardView[@content-desc="Client Bague's en or"]/android.view.ViewGroup


*** Test Cases ***
Retour Client Mono Empl
    Sur le terminal, sélectionner le module                       Retour Client Mono Empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${client}         ${BAGUES}
    Valider les informations
    Saisir l Article a la Main                                    BAAR01
    Entrer une quantité et valider                                5
    #Afficher Les Articles Disponibles    #Demandé dans le scénario, mais ne permet pas d'aller à l'étape suivante
    Saisir l Article a la Main                                    BA
    Cliquer sur Non
    Sélectionner l article                                        BAAR01
    Entrer une quantité et valider                                2
    Vider barre de recherche   
    Saisir l Article a la Main                                    LINGOR18
    Appuyer sur la flèche retour
    Scanner le code barre correspondant au lot                    LINGOR18;LOT-999
    Entrer une quantité et valider                                10
    Scanner le code barre correspondant au lot                    LINGOR18;LOT-TEST2           
    Entrer une quantité et valider                                2
    Saisir l Article a la Main                                    BAOR01
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               21731003            #gamme emeraude
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               TESTBLBKAD          #gamme rubis
    Entrer une quantité et valider                                1
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélection gamme                                               34
    Sélection sous gamme                                          Classique
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               38141025
    Entrer une quantité et valider                                2
    Finaliser
    Valider





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
${BRELO}    #?
${série}    #?
${SERIE2}    #xpath=?



*** Test Cases ***
Retour Fournisseur mono empl
    Sur le terminal, sélectionner le module                       Retour fournisseur mono empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${fournisseur}          ${BRELO}
    Valider les informations
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               BAAR01
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               LINGOR18
    Choisir Le Lot                                                LOT-TEST2
    Entrer une quantité et valider                                1
    Scanner le code barre correspondant au lot                    LINGOR18;LOT-BDF9411123
    Entrer une quantité et valider                                2
    Saisir l Article a la Main                                    EM040
    Sélectionner le conditionnement vers droite                   ECRIN DE 12
    Entrer une quantité et valider                                1
    Scanner le code barre correspondant à l'article               EM050
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               EM050/24
    Entrer une quantité et valider                                1
    Scanner le code barre correspondant à l'article               MODIV01
    Choisir au menu déroulant                                     ${série}    ${SERIE2}
    Valider les informations
    Scanner le code barre correspondant à l'article               MODIV01
    Ouvrir menu déroulant                                         ${série}
    Valider les informations
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               EM055
    Appuyer sur ok
    Vider barre de recherche  
    Saisir l Article a la Main                                    BAOR01
    Sélection gamme                                               Emeraude
    Entrer une quantité et valider                                4
    Scanner le code barre correspondant à l'article               21731003                #BAOR01 avec gamme Emeraude
    Entrer une quantité et valider                                5
    Scanner le code barre correspondant à l'article               21731003                #BAOR01 avec gamme Emeraude
    Modifier une quantite                                         7
    Appuyer sur la flèche retour et "Mettre En Attente"
    Sur le terminal, sélectionner le module                       Retour fournisseur mono empl
    Cliquer sur Oui
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélection gamme                                               42
    Sélection sous gamme                                          Forçat
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               38141025
    Entrer une quantité et valider                                8
    Cliquer sur le bouton de finalisation
    Valider

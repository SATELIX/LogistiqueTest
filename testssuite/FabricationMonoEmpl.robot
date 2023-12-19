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

${depot}     xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}   //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${doc}     xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${OF00004}    //androidx.cardview.widget.CardView[@content-desc="Document OF00004 du tiers 1"]/android.view.ViewGroup
${LINGOR18}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
${CHAAR/VAR34classique}    xpath=(//androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"])[1]/android.view.ViewGroup
${BAAR01}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Argent"]/android.view.ViewGroup


#Test OK pb lot bdd
*** Test Cases ***
FabricationMonoEmpl
    Sur le terminal, sélectionner le module                       Fabrication mono empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${doc}          ${OF00004}
    Valider les informations
    Sleep                                                         2s
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Entrer une quantité et valider                                6
    Appuyer sur ok
    Sleep                                                         2s
    Effacer la quantité                                           6
    Entrer une quantité et valider                                3
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Emeraude
    Entrer une quantité et valider                                13
    Sleep                                                         2s
    Appuyer sur ok
    Sleep                                                         2s
    Effacer la quantité                                           13
    Entrer une quantité et valider                                2
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Rubis
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025            #CHAAR/VAR longueur 42 cm Forçat
    Entrer une quantité et valider                                2
    Afficher Les Articles Disponibles
    Scroll Vers Element                                           ${CHAAR/VAR34classique}    haut
    Sélectionner à la main Un Article Avec 2 Criteres             34    classique
    Entrer une quantité et valider                                2
    Appuyer sur ok et back
    # Afficher Les Articles Disponibles
    # Scroll Vers Element                                           ${LINGOR18}   bas
    # Sélectionner l article                                        LINGOR18                #pb lot bdd
    # Choisir Le Lot                                                lot0001
    # Entrer une quantité et valider                                2
    Finaliser
    Appuyer sur Terminer La Saisie
    Sleep                                                         5s




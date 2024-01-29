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

${emplacement}     xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${doc}     xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${OF00005}    //androidx.cardview.widget.CardView[@content-desc="Document OF00005 du tiers 1"]/android.view.ViewGroup
${CHAAR/VAR34classique}    xpath=(//androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"])[1]/android.view.ViewGroup
${LINGOR18}        //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup

#Test OK, pb lot bdd
*** Test Cases ***
FabricationMultiEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                       Fabrication multi empl
    Choisir LA Valeur Dans La Liste                               id=dropdown_list   Bijou SA
    Choisir au menu déroulant                                     ${emplacement}          ${A1T1N1P1}
    Choisir au menu déroulant                                     ${doc}          ${OF00005}
    Valider les informations
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BAAR01
    Entrer une quantité et valider                                3
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003        #Scan article BAAR01/EM
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               TESTBLBKAD    #Scan Article BAAR01/Rubis
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025    #CHAAR/VAR longueur 42 cm Forçat
    Entrer une quantité et valider                                2
    Afficher Les Articles Disponibles
    Scroll Vers Element                                           ${CHAAR/VAR34classique}    bas
    Sélectionner l article par element                            ${CHAAR/VAR34classique}
    Entrer une quantité et valider                                2
    Afficher Les Articles Disponibles
    Scroll Vers Element                                           ${LINGOR18}    bas
    Sélectionner l article                                        LINGOR18
    Saisir le Numéro de lot                                       0001
    Entrer une quantité et valider                                2
    Finaliser
    Appuyer sur Terminer La Saisie
    Valider
    Sleep                                                         5s
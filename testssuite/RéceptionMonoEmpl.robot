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

${depot}     xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}   //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${fournisseur}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${Joaill}        //androidx.cardview.widget.CardView[@content-desc="Fournisseur Joaillier Frères"]/android.view.ViewGroup
${commande}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[3]
${FBC00011}    //androidx.cardview.widget.CardView[@content-desc="Document FBC00011 du tiers JOAILL"]/android.view.ViewGroup


${STYPLOR}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Stylo plume dorée Sill Vany"]/android.view.ViewGroup
${BAAR01}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Argent"]/android.view.ViewGroup


*** Test Cases ***
Réception mono empl
    Sur le terminal, sélectionner le module                       Réception mono empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant avec scroll                         ${fournisseur}    ${Joaill}
    Choisir au menu déroulant                                     ${commande}       ${FBC00011}
    Valider les informations
    Sleep    1s
    Afficher Les Articles Disponibles
    Scroll Vers Element                                           ${STYPLOR}        bas
    Sélectionner l article                                        STYPLOR
    Entrer une quantité et valider                                3
    Afficher Les Articles Disponibles
    Scroll Vers Element                                           ${BAAR01}    haut
    Sélectionner l article                                        BAAR01  
    Entrer une quantité et valider                                7
    Scanner le code barre correspondant à l'article               BAAR01
    Modifier une quantite                                         6    7
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Pierres : Emeraude
    Entrer une quantité et valider                                2
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Pierres : Rubis
    Entrer une quantité et valider                                50
    Sélectionner ok
    Effacer la quantité                                           50
    Entrer une quantité et valider                                22
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Longueur : 34 cm
    Entrer une quantité et valider                                2
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Longueur : 42 cm
    Entrer une quantité et valider                                2
    #Afficher Les Articles Disponibles
    #Sélectionner l article    LINGOR18                                            Car pas de lot dans la base de donnée
    #Aller dans la liste et sélectionner le numéro de lot          L159
    #Valider les informations
    Appuyer sur la flèche retour et "Mettre En Attente"
    Sur le terminal, sélectionner le module                       Réception mono empl
    Cliquer sur Oui
    Cliquer sur le bouton de finalisation
    Appuyer sur Terminer La Saisie
    Valider La Préparation




    

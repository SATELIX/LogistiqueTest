*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem


Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource
Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/module_preparation.resource
Resource    retour_fournisseur_monoempl.robot


Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
${depot}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${emplacement}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${fournisseur}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[3]
${BILLO}    //androidx.cardview.widget.CardView[@content-desc="Fournisseur Billot"]/android.view.ViewGroup
${liste_article}    //android.widget.ImageButton[@content-desc="Liste des articles"]
${STYPLOR}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Stylo plume dorée Sill Vany"]/android.view.ViewGroup
${ARTLOT}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Article suivi en lot avec conditionnement virtuel"]/android.view.ViewGroup


*** Test Cases ***
Réception multi empl
    Sur le terminal, sélectionner le module                       Réception multi empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${emplacement}          ${A1T1N1P1}
    Choisir au menu déroulant                                     ${fournisseur}          ${BILLO}
    Sélectionner document origine                                 FBC00012
    Valider les informations
    Sleep                                                         1s
    Scanner le code barre correspondant à l'article               BRAAR10
    Sleep                                                         1s
    Sélectionner ok
    Scanner le code barre correspondant à l'article               CB-INCONNU
    Cliquer sur Oui
    Choisir au menu déroulant avec scroll                         ${liste_article}    ${STYPLOR}
    Valider association
    Press ENTER
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Entrer une quantité et valider                                1
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Entrer une quantité et valider                                3
    Scanner le code barre correspondant à l'article               BAOR01
    Sélectionner l article                                        Emeraude
    Entrer une quantité et valider                                20
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Rubis
    Entrer une quantité et valider                                1
    Afficher Les Articles Disponibles
    Sélectionner l article                                        34 cm
    Entrer une quantité et valider                                35
    Sélectionner ok
    Effacer la quantité                                           35
    Entrer une quantité et valider                                25
    Scanner le code barre correspondant à l'article               38141025
    Entrer une quantité et valider                                2
    #Afficher Les Articles Disponibles
    #Sélectionner l article    LINGOR18
    #Saisir le Numéro de lot    lot_inexistant    #pas de lot dans base de donnée
    #Sélectionner ok
    #Effacer le lot
    #Saisir le Numéro de lot    L1234        #pas de lot dans base de donnée
    #Entrer une quantité et valider    1
    #Scanner le code barre correspondant au lot    (92)59531012(10)LOT-TEST2    #pas de lot dans base de donnée
    #Entrer une quantité et valider    5
    Afficher Les Articles Disponibles
    Scroll Vers Element   ${ARTLOT}     haut        #peut être à modifier lorsque les lots seront ajoutés
    #Sélectionner l article    ARTLOT
    #Saisir le Numéro de lot    COMPL123        #pas de lot dans base de donnée
    #Entrer une quantité et valider    1
    #Cliquer sur continuer
    #Afficher Les Articles Disponibles
    Sélectionner l article                                        ARTLOT
    Press ENTER
    Entrer une quantité et valider                                5
    Modifier nb de numéro de lot à générer                        1    2
    Cliquer sur continuer
    Cliquer sur le bouton de finalisation
    Appuyer sur Terminer La Saisie


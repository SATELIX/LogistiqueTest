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
${client}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${BAGUES}    //androidx.cardview.widget.CardView[@content-desc="Client Bague's en or"]/android.view.ViewGroup


*** Test Cases ***
Réception CommandeClient
    Sur le terminal, sélectionner le module                       Commande Client
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${client}         ${BAGUES}
    Valider les informations
    Afficher Les Articles Disponibles
    Sélectionner l article    BAAR01
    Entrer une quantité et valider    10
    Scanner le code barre correspondant à l'article    BAAR01
    Entrer une quantité et valider    5
    Scanner le code barre correspondant à l'article    LINGOR18
    Entrer une quantité et valider    5
    Saisir l Article a la Main     EM040
    Sélectionner le conditionnement    ECRIN DE 12
    Entrer une quantité et valider    1
    Scanner le code barre correspondant à l'article    EM050
    Entrer une quantité et valider    2
    Scanner le code barre correspondant à l'article    EM050/24
    Entrer une quantité et valider    1
    Scanner le code barre correspondant à l'article    MODIV01
    Entrer une quantité et valider    3
    Scanner le code barre correspondant à l'article    MODIV01
    Valider La Quantité
    Appuyer sur OK
    Entrer une quantité et valider    0
    Appuyer sur OK
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article    EM055
    Appuyer sur OK
    Vider barre de recherche    EM055
    Saisir l Article a la Main     BAOR01
    Sélection gamme    Emeraude
    Entrer une quantité et valider    20
    Scanner le code barre correspondant à l'article    21731003
    Entrer une quantité et valider    5
    Scanner le code barre correspondant à l'article    21731003
    Modifier une quantite    18    25
    Appuyer sur la flèche retour
    Cliquer sur le bouton de mise en attente
    Sur le terminal, sélectionner le module                       Commande Client
    Cliquer sur Oui
    Saisir l Article a la Main     CHAAR/VAR
    Sélection gamme    42
    Sélection sous gamme    Forçat
    Entrer une quantité et valider    2
    Scanner le code barre correspondant à l'article    38141025
    Entrer une quantité et valider    10
    Cliquer sur le bouton de finalisation
    Valider




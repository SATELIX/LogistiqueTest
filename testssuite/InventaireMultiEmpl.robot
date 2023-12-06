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
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${A1T2N3P2}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T2 Niv N3 Pos P2"]/android.view.ViewGroup

*** Test Cases ***
InventaireMultiEmpl
    #Ouvrir le BO test et choisir l'inventaire "InventaireTestMulti"
    Sur le terminal, sélectionner le module                       Inventaire Multi empl
    Sélectionner le document    InventaireTestMulti
    Saisir l Article a la Main     BAAR01
    Sélectionner l emplacement    A1T2N1P2
    Entrer une quantité et valider    137
    Cliquer sur le bouton de finalisation
    #Dans le BO retourner sur le tableau de l'inventaire et cliquer sur l'icone "Actualiser"
    #Modifier la quantité inventaire et mettre 140
    Sur le terminal, sélectionner le module                       Inventaire Multi empl
    Sélectionner le document    InventaireTestMulti
    Saisir l Article a la Main     BA
    Sélectionner l article    BAAR01
    Sélectionner l emplacement    A1T2N1P2
    Modifier une quantite    140    277
    Cliquer sur le bouton de finalisation
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"
    Sur le terminal, sélectionner le module                       Inventaire Multi empl
    Sélectionner le document    InventaireTestMulti
    #Scanner le code barre correspondant au lot    LINGOR18;LOT-BDF9411123
    #Sélectionner l emplacement    A1T3N1P3
    #Entrer une quantité et valider    5
    #Saisir l Article a la Main     LINGOR18        #pas de lot dans base de donnée
    #Sélectionner l emplacement    A1T1N1P1
    #Choisir Le Lot    LOT-999
    #Entrer une quantité et valider    10
    #Cliquer sur le bouton de finalisation
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"
    #Toujours dans le BO cliquer sur "Quantité inventaire" de la ligne de l'article BAOR01 avec Emeraude en "Gamme premier niveau" et l'emplacement A1T1N1P1
    #Ecrire 20 comme quantité et valider
    #Sur le terminal, sélectionner le module                       Inventaire Multi empl
    #Sélectionner le document    InventaireTestMulti
    Saisir l Article a la Main     BAOR01
    Scroll Vers Element    ${A1T1N1P1}    haut
    Sélectionner l emplacement    A1T1N1P1
    Sélection gamme    Emeraude
    Entrer une quantité et valider    20
    Scanner le code barre correspondant à l'article    21731003
    Sélectionner l emplacement    A1T1N1P1
    Entrer une quantité et valider    10
    Cliquer sur le bouton de finalisation
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"
    #Cliquer sur le bouton "Afficher" dans la colonne "Utilisateur(s)"
    Sur le terminal, sélectionner le module                       Inventaire Multi empl
    Sélectionner le document    InventaireTestMulti
    Saisir l Article a la Main     CHAAR/VAR
    Sélectionner l emplacement    A1T2N3P2
    Sélection gamme    42
    Sélection sous gamme    Forçat
    Entrer une quantité et valider    25
    Scanner le code barre correspondant à l'article    38141025
    Scroll Vers Element    ${A1T2N3P2}    haut
    Sélectionner l emplacement    A1T2N3P2
    Entrer une quantité et valider    10
    Cliquer sur le bouton de finalisation
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"


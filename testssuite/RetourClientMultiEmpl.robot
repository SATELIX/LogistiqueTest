*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem



Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/module_preparation.resource


Suite Setup     Set Log Level    TRACE
# Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
# Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
${depot}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${destination}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${client}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[3]
${bagues}    //androidx.cardview.widget.CardView[@content-desc="Client Bague's en or"]/android.view.ViewGroup
${LINGOR18}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup

*** Test Cases ***
RetourClientMultiEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module bis                   Retour client multi empl
    Choisir au menu déroulant                                     ${depot}          ${Bijou SA}
    Choisir au menu déroulant                                     ${destination}          ${A1T1N1P1}
    Choisir au menu déroulant                                     ${client}          ${bagues}
    Valider les informations
    Saisir l Article a la Main                                    BAAR01
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Saisir l Article a la Main                                    BA
    Cliquer sur Non
    Sélectionner l article                                        BAAR01
    Sleep                                                         2s
    Hide Keyboard
    Changer emplacement                                           A1T2N1P2
    Entrer une quantité et valider                                2
    Vider barre de recherche 
    Saisir l Article a la Main                                    LINGOR18
    Changer emplacement                                           A1T3N1P3
    Sleep                                                         2s
    Hide Keyboard
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    L1234        
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    # Scanner le code barre correspondant au lot                    (92)59531012(10)LOT-TEST2        #code barre article de type 128
    # Changer emplacement                                           A1T3N1P3                    #code barre ne fonctionne pas
    # Entrer une quantité et valider                                1
    Saisir l Article a la Main                                    BAOR01
    Sélection gamme                                               Emeraude
    Entrer une quantité et valider                                8
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003                        #scan article avec gamme associée
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélection gamme                                               34
    Sélection sous gamme                                          Classique
    Entrer une quantité et valider                                2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025                        #scan article avec les gammes associées
    Entrer une quantité et valider                                3
    # Afficher Les Articles Disponibles
    # Scroll Vers Element                                           ${LINGOR18}     bas
    # Sélectionner l article                                        LINGOR18
    # Choisir Le Lot                                                L789                     #lot inexistant dans bdd              
    # Entrer une quantité et valider                                2
    Finaliser
    Valider
    Sleep                                                         5s
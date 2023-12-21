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
${emplacement}    //android.widget.ImageButton[@content-desc="Afficher la liste"]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup


*** Test Cases ***
SortieStockMultiEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                       Sortie Stock multi empl
    Choisir LA Valeur Dans La Liste                               id=dropdown_list    Bijou SA
    Choisir au menu déroulant                                     ${emplacement}    ${A1T1N1P1}
    Sélectionner référence doc                                    test multi
    Valider les informations
    Saisir l Article a la Main                                    LINGOR18
    Choisir Le Lot                                                LOT-10
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    LINGOR18\\;LOT-999
    Sleep                                                         2s
    Hide Keyboard
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Saisir l Article a la Main                                    BAOR01
    Sélection gamme                                               Rubis
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003        #scan de l'article avec la gamme associée
    Entrer une quantité et valider                                1
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélection gamme                                               34
    Sélection sous gamme                                          Forçat
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               38141025        #scan de l'article avec les gammes associées
    Entrer une quantité et valider                                2
    Cliquer sur le bouton de finalisation
    Valider
    Sleep                                                         5s


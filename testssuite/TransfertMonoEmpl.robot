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
${destination}   //android.widget.ImageButton[@content-desc="Afficher la liste"]
${Annexe Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Annexe Bijou SA"]/android.view.ViewGroup



*** Test Cases ***
TransfertMonoEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                       Transfert mono empl
    Choisir LA Valeur Dans La Liste                               id=dropdown_list    Bijou SA
    Choisir au menu déroulant                                     ${destination}    ${Annexe Bijou SA}
    Valider les informations
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Entrer une quantité et valider                                2
    Saisir l Article a la Main                                    LINGOR18
    Choisir Le Lot                                                LOT-10  
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    LINGOR18\\;LOT-999
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Saisir l Article a la Main                                    BAOR01
    Sélection gamme                                               Rubis
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    21731003
    Entrer une quantité et valider                                3
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélection gamme                                               34
    Sélection sous gamme                                          Classique
    Entrer une quantité et valider                                5
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025            #scan de l'article avec les gammes associées
    Entrer une quantité et valider                                2
    Cliquer sur le bouton de finalisation
    Valider
    Sleep                                                         5s
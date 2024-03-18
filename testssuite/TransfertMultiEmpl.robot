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
${emplacement}    fr.satelix.logistique:id/text_input_end_icon
${A1T1N1P1}       //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${menu}            //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
${Lot-10}          //android.widget.TextView[@resource-id="fr.satelix.logistique:id/tv_intitule_lot_serie" and @text="LOT-10"]

*** Test Cases ***
TransfertMultiEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module bis                   Transfert multi empl  
    Sleep                                                         2s         
    Choisir LA Valeur Dans La Liste                               id=dropdown_list    Bijou SA
    Sleep                                                         2s
    Choisir LA Valeur Dans Une Des Listes                         id=dropdown_list    Annexe Bijou SA    1
    Sleep                                                         2s
    Choisir dans un des Menus Déroulants                          ${emplacement}     ${A1T1N1P1}    3
    Valider les informations
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Entrer une quantité et valider                                2
    Saisir l Article a la Main                                    LINGOR18
    Sélectionner l emplacement                                    A1T3N1P3
    Choisir au menu déroulant avec scroll                         ${menu}    ${Lot-10}                    
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    LINGOR18\\;LOT-ABC        #lot associé sans stock
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Saisir l Article a la Main                                    BAOR01
    Sélectionner l emplacement                                    A1T1N1P1
    Sélection gamme                                               Rubis
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003        #Scan de l'article avec gamme associée
    Sleep                                                         2s
    Scanner code barre                                            A1T1N1P1 
    Sleep                                                         2s 
    Entrer une quantité et valider                                1
    Sleep                                                         2s         
    Saisir l Article a la Main                                    CHAAR/VAR    
    Sélectionner l emplacement                                    A1T1N1P1
    Sélection gamme                                               34
    Sélection sous gamme                                          Classique
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025            #Scan de l'article avec les gammes associées
    Sélectionner l emplacement                                    A1T2N3P2
    Entrer une quantité et valider                                2
    Cliquer sur le bouton de finalisation
    Valider
    Sleep                                                         5s
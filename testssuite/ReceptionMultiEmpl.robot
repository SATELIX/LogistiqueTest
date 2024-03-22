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

${emplacement}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${A1T1N1P1}    //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${fournisseur}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${BILLO}    //androidx.cardview.widget.CardView[@content-desc="Fournisseur Billot"]/android.view.ViewGroup
${liste_article}    //android.widget.ImageButton[@content-desc="Liste des articles"]
${STYPLOR}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Stylo plume dorée Sill Vany"]/android.view.ViewGroup
${ARTLOT}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Article suivi en lot avec conditionnement virtuel"]/android.view.ViewGroup


*** Test Cases ***
ReceptionMultiEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                       Réception multi empl
    Sleep                                                         2s
    Choisir LA Valeur Dans La Liste                               id=dropdown_list        Bijou SA
    Choisir au menu déroulant                                     ${emplacement}          ${A1T1N1P1}
    Choisir au menu déroulant                                     ${fournisseur}          ${BILLO}
    Sélectionner document origine                                 FBC00012
    Valider les informations
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BRAAR10
    Sleep                                                         2s
    Appuyer sur ok
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               CB-INCONNU
    Sleep                                                         2s
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
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BAOR01
    Sélectionner l article                                        Emeraude
    Entrer une quantité et valider                                20
    Afficher Les Articles Disponibles
    Sélectionner l article                                        Rubis
    Entrer une quantité et valider                                1
    Afficher Les Articles Disponibles
    Sélectionner l article                                        34    #CHAAR/VAR 34 cm
    Entrer une quantité et valider                                35
    Appuyer sur ok
    Effacer la quantité                                           35
    Entrer une quantité et valider                                25
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025            #article CHAAR/VAR de longueur 42 Forçat
    Entrer une quantité et valider                                2
    Afficher Les Articles Disponibles
    Sélectionner l article                                        LINGOR18
    saisir le Numéro de lot                                       lot inexistant
    Sleep                                                         2s    
    Appuyer sur ok                                                                #Text 'OK' did not appear in 5 seconds
    Effacer le lot
    Saisir le Numéro de lot                                       L1234        
    Entrer une quantité et valider                                1
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    9259531012\u001D10LOT-TEST2    # \u001D est le caractère unicode équivalent au caractère ASCII 29 qui correspond à FNC1
    Sleep                                                         2s    
    Entrer une quantité et valider                                5
    Afficher Les Articles Disponibles
    Sleep                                                         2s
    Scroll Vers Element                                           ${ARTLOT}     haut  
    Sleep                                                         2s      
    Sélectionner l article                                        ARTLOT
    Saisir le Numéro de lot                                       COMPL123        
    Entrer une quantité et valider                                1
    Cliquer sur continuer
    Afficher Les Articles Disponibles
    Sélectionner l article                                        ARTLOT
    Press ENTER
    Entrer une quantité et valider                                5
    Modifier nb de numéro de lot à générer                        2
    Cliquer sur continuer
    Cliquer sur le bouton de finalisation
    Appuyer sur Terminer La Saisie
    Valider
    Sleep                                                         5s


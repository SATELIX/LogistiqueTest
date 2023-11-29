*** Settings ***
Documentation       ce test pour executer l'application
...                 ldkjdldjldkjd
...
 
Library    AppiumLibrary
Library    Process
 
Resource    ../resources/page_accueil.resource
Resource    ../resources/SatelixLogistique.resource
Resource    ../resources/module_preparation_listearticles.resource
 
*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity
${liste_articles}       //android.widget.ImageButton[@content-desc="Liste des articles"]
${button_finaliser}     fr.satelix.logistique:id/fab_quitter
${module_sortie_mono_empl}    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock mono empl"]
${CHAOR42}               //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaînes mailles fines"]/android.view.ViewGroup
 
*** Test Cases ***
Test De L Application
    Demarrer L Application
    Sur le terminal, sélectionner le module    Sortie Stock mono empl
    #Swipe Down    ${module_sortie_mono_empl}
    #Sélectionner le module Sortie mono empl
    #Affiche sélection dépot d origine la date et la reference
    Sélectionner le dépôt origine Bijou SA 
    Sélectionner référence doc    test
    Valider les informations
    Afficher Liste des articles
    Choisir Article    ${CHAOR42}   
    Entrer une quantité et valider    2
    Sélectionner l Article a la Main    LINGOR18    
    Saisir le Numéro de lot    Lot-10
    Sélectionner le Lot avec DLC et FAB     
    Entrer une quantité et valider    1      
    Scanner code barre    LINGOR18\;LOT-AAA    #le lot n'existant pas, une erreur de validation doit s'afficher
    Dialog Cliquer Ok
    Back      #<-- refacto testée jusqu'ici
    Sélectionner l Article a la Main    BAOR01
    Sélectionner la Gamme    Rubis
    Valider Quantite    1
    Scanner code barre    21731003
    Valider Quantite    1
    Sélectionner l Article a la Main    CHAAR/VAR
    Sélectionner la Gamme    34 cm
    Sélectionner la Gamme    Forçat
    Valider Quantite    1
    Scanner code barre    38141025
    Valider Quantite    2
    Finaliser
    Valider

*** Keywords ***
Scroll To Sortie Stock Mono
    [Documentation]    Scroll down vers le module pas encore visible
    Scroll Down    xpath=//android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock mono empl"]
 
Sélectionner le module Sortie mono empl      
    Click Text    Sortie Stock mono empl
 
Affiche sélection dépot d origine la date et la reference    # vérifie que la page s'affiche: Sortie de stock - Sélection dépot d'origine, la date et la référence
    Wait Until Page Contains    text=Sortie Stock mono empl
    Wait Until Element Is Visible    accessibility_id=Sélectionner une date
    Wait Until Page Contains    Saisi référence doc

Afficher Liste des articles
    Wait Until Page Contains    fr.satelix.logistique:id/input_text_recherche  
    Click Element    ${liste_articles} 

Sélectionner la Gamme
    [Arguments]    ${gamme}
    Wait Until Page Contains    ${gamme}
    Click Text    ${gamme}

Finaliser
    Wait Until Page Contains    ${button_finaliser}
    Click Element    ${button_finaliser}

Valider
    Wait Until Page Contains    fr.satelix.logistique:id/bt_quitter_module_valider_transfert
    Click Element    fr.satelix.logistique:id/bt_quitter_module_valider_transfert
    


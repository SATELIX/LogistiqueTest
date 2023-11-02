*** Settings ***
Documentation       ce test pour executer l'application
...                 ldkjdldjldkjd
...
 
Library             AppiumLibrary
 
 
*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity
${button_valider}       fr.satelix.logistique:id/fab_valider
${liste_articles}       //android.widget.ImageButton[@content-desc="Liste des articles"]
 
 
*** Test Cases ***
Test De L Application
    Demarrer Une Application    fr.satelix.logistique
    Swipe Down test
    #Swipe down    id=fr.satelix.logistique:id/rv_liste_modules
    #Scroll Down Until Element Is Visible    xpath=//android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock Mono"] 
    #Scroll To Sortie Stock Mono
    #Faire Defiler Les Modules Pour Trouver Le Bon    ${module_sortie_mono}
    Sélectionner le module Sortie mono empl
    Affiche sélection dépot d origine la date et la reference
    Sélectionner le dépôt origine Bijou SA 
    Sélectionner référence doc
    Valider les informations pour le nouveau traitement
    Sélectionner un articles 

*** Keywords ***
Demarrer Une Application
    [Documentation]    ce que fait le mot clé
    [Arguments]    ${appPackage}
    AppiumLibrary.Open Application
    ...    http://127.0.0.1:4723
    ...    automationName=${automationName}
    ...    platformName=${platformName}
    ...    appPackage=${appPackage}
    ...    appActivity=${appActivity}
    ...    autoGrantPermissions=true
    ...    noReset=true
    ...    fullReset=false
    ...    forceAppLaunch=true    # force l'application à se lancer à chaque fois
    # ...    app=${app}
    # ...    udid=${deviceUdid}

Scroll To Sortie Stock Mono
    [Documentation]    Scroll down vers le module pas encore visible
    Scroll Down    xpath=//android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock Mono"]
 
Sélectionner le module Sortie mono empl      
    Click Text    Sortie Stock Mono
 
Affiche sélection dépot d origine la date et la reference    # vérifie que la page s'affiche: Sortie de stock - Sélection dépot d'origine, la date et la référence
    Wait Until Page Contains    text=Sortie Stock Mono
    Wait Until Element Is Visible    accessibility_id=Sélectionner une date
    Wait Until Page Contains    Saisi référence doc

Sélectionner le dépôt origine Bijou SA
    Click Element    xpath=//android.widget.ImageButton[@content-desc="Afficher la liste"]
    Wait Until Page Contains    text=Bijou SA
    Click Text    Bijou SA  True

Sélectionner référence doc
    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text="Saisi référence doc"]
    Click Element    xpath=//android.widget.EditText[@text="Saisi référence doc"]
    Input Text Into Current Element    test

Swipe Down test
    FOR    ${counter}    IN RANGE    0    5
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    Sortie Stock Mono    timeout=1s
        Swipe    0    495    0    100    500
        IF    ${status}    BREAK
    END

Valider les informations pour le nouveau traitement
    Hide Keyboard
    Wait Until Page Contains    VALIDER
    Click Element    ${button_valider}

Sélectionner un articles
    Wait Until Page Contains    fr.satelix.logistique:id/input_text_recherche  
    Click Element    ${liste_articles}  



    

    



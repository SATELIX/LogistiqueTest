*** Settings ***
Documentation       ce test pour executer l'application
...                 ldkjdldjldkjd
...
 
Library    AppiumLibrary
Library    Process
 
 
*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity
${button_valider}       fr.satelix.logistique:id/fab_valider
${liste_articles}       //android.widget.ImageButton[@content-desc="Liste des articles"]
${button_finaliser}     fr.satelix.logistique:id/fab_quitter
${module_sortie_mono_empl}    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock mono empl"]
${CHAOR42}               //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaînes mailles fines"]/android.view.ViewGroup
 
*** Test Cases ***
Test De L Application
    Demarrer Une Application    fr.satelix.logistique
    Swipe Down    ${module_sortie_mono_empl}
    Sélectionner le module Sortie mono empl
    Affiche sélection dépot d origine la date et la reference
    Sélectionner le dépôt origine Bijou SA 
    Sélectionner référence doc    test
    Valider les informations pour le nouveau traitement
    Afficher Liste des articles
    Choisir Article    ${CHAOR42}
    Valider Quantite    2
    Sélectionner l Article a la Main    LINGOR18
    Saisir le Numéro de logistique    Lot-10
    Sélectionner le Lot avec DLC et FAB 
    Valider Quantite    1
    Scanner code barre    LINGOR18\;LOT-AAA    #le lot n'existant pas, une erreur de validation doit s'afficher
    Dialog Cliquer Ok
    Back
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
Demarrer Une Application
    [Documentation]    ce que fait le mot clé
    [Arguments]    ${appPackage}
    AppiumLibrary.Open Application
    ...    http://127.0.0.1:4723/wd/hub
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

Attendre
    Sleep    5s

Scroll To Sortie Stock Mono
    [Documentation]    Scroll down vers le module pas encore visible
    Scroll Down    xpath=//android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock Mono"]
 
Sélectionner le module Sortie mono empl      
    Click Text    Sortie Stock mono empl
 
Affiche sélection dépot d origine la date et la reference    # vérifie que la page s'affiche: Sortie de stock - Sélection dépot d'origine, la date et la référence
    Wait Until Page Contains    text=Sortie Stock mono empl
    Wait Until Element Is Visible    accessibility_id=Sélectionner une date
    Wait Until Page Contains    Saisi référence doc

Sélectionner le dépôt origine Bijou SA
    Click Element    xpath=//android.widget.ImageButton[@content-desc="Afficher la liste"]
    Wait Until Page Contains    text=Bijou SA
    Click Text    Bijou SA  True

Sélectionner référence doc
    [Arguments]    ${reference}
    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text="Saisi référence doc"]
    Click Element    xpath=//android.widget.EditText[@text="Saisi référence doc"]
    Input Text Into Current Element    ${reference}

Swipe Down
    [Arguments]    ${element}
    FOR    ${counter}    IN RANGE    0    10
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    timeout=1s
        IF    ${status}    BREAK
        Swipe    0    495    0    100    150
    END

Valider les informations pour le nouveau traitement
    Hide Keyboard
    Wait Until Page Contains    VALIDER
    Click Element    ${button_valider}

Afficher Liste des articles
    Wait Until Page Contains    fr.satelix.logistique:id/input_text_recherche  
    Click Element    ${liste_articles} 

Choisir Article    
    [Arguments]    ${article}
    Swipe Down     ${article}
    Wait Until Element Is Visible    ${article}
    Click Element    ${article} 

Valider Quantite
    [Arguments]    ${quantite}
    Input Text Into Current Element    ${EMPTY}
    Input Text Into Current Element    ${quantite}
    Sleep    2
    Click Element    fr.satelix.logistique:id/fab_ajouter
    Attendre
.
Sélectionner l Article a la Main
    [Arguments]    ${article}
    Wait Until Element Is Visible    fr.satelix.logistique:id/input_text_recherche
    Click Element    fr.satelix.logistique:id/input_text_recherche
    Input Text Into Current Element    ${article}
    Click Element    //android.widget.ImageButton[@content-desc="Valider cet article"]

Saisir le Numéro de logistique
    [Arguments]    ${numero}
    Wait Until Element Is Visible    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/textinput_placeholder"]
    Click Element    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/textinput_placeholder"]
    Input Text Into Current Element    ${numero}
    Run Keyword    pressKeyCode    66

Sélectionner le Lot avec DLC et FAB
    Wait Until Element Is Visible    //androidx.recyclerview.widget.RecyclerView[@resource-id="fr.satelix.logistique:id/rv_liste"]
    Click Text    DLC : 24/03/2023

Scanner code barre
    [Arguments]    ${codeBarre}
    ${result}=    Run Process
    ...    adb
    ...    shell
    ...    am
    ...    broadcast
    ...    -a
    ...    fr.satelix.logistique.scan
    ...    --es
    ...    com.motorolasolutions.emdk.datawedge.data_string
    ...    "${codeBarre}"

Dialog Cliquer Ok
    Wait Until Element Is Visible    android:id/button1
    Click Element    android:id/button1

Back
    Go Back

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
    


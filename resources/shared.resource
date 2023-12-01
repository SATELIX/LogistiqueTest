*** Settings ***
Documentation       Keywords réutilisables dans les tests

Library             AppiumLibrary
Library             Process


*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity


*** Keywords ***
Demarrer Une Application
    [Documentation]    Démarre l'application
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

Sélectionner le module
    [Arguments]    ${module}
    Log To Console    Sélection du module ${module}
    Wait Until Page Contains    ${module}    30
    Click Text    ${module}

Recherche article
    Log To Console    Aller sur la liste de la recherche des articles
    Wait Until Page Contains    Recherche article    30
    Click Element    //android.widget.ImageButton[@content-desc="Liste des articles"]

Sélection article texte
    [Arguments]    ${codeArticle}
    Log To Console    Sélection de l'article ${codeArticle}
    Wait Until Page Contains    ${codeArticle}    30
    Sleep    5s
    Click Text    ${codeArticle}

Sélection article element
    [Arguments]    ${element}
    Log To Console    Sélection de l'article ${element}
    Wait Until Element Is Visible    ${element}    30
    Click Element    ${element}

Fermer le clavier
    Log To Console    Fermeture du clavier
    Sleep    5s
    Hide Keyboard

Retour arrière
    Log To Console    Retour arrière
    Go Back

Saisir code article manuellement
    [Arguments]    ${codeArticle}
    Log To Console    Saisie du code article ${codeArticle}
    Wait Until Page Contains    fr.satelix.logistique:id/input_text_recherche    30
    Input Text    fr.satelix.logistique:id/input_text_recherche    ${codeArticle}
    Wait Until Element Is Visible    //android.widget.ImageButton[@content-desc="Valider cet article"]
    Click Element    //android.widget.ImageButton[@content-desc="Valider cet article"]

Pas d'association code barre
    Log To Console    Pas d'association code barre
    Wait Until Element Is Visible    //android.widget.Button[@resource-id="android:id/button2"]
    Click Element    //android.widget.Button[@resource-id="android:id/button2"]

Saisir quantité article
    [Arguments]    ${quantite}
    Log To Console    Saisie de la quantité ${quantite}
    Input Text Into Current Element    ${EMPTY}
    Input Text Into Current Element    ${quantite}

Valider quantité article
    Log To Console    Validation de la quantité
    Sleep    5
    Click Element    fr.satelix.logistique:id/fab_ajouter

Vider recherche article
    Log To Console    Vider la recherche article
    Wait Until Page Contains    fr.satelix.logistique:id/input_text_recherche    30
    Input Text    fr.satelix.logistique:id/input_text_recherche    ${EMPTY}

Scroll Vers Element
    [Arguments]    ${elementVisible}    ${direction}
    Log To Console    Scroll vers l'élément ${elementVisible} dans la direction ${direction}
    FOR    ${counter}    IN RANGE    0    100
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${elementVisible}    timeout=1s
        IF    ${status}    BREAK
        IF    "${direction}" == "bas"
            Scroll bas    fr.satelix.logistique:id/rv_liste
        ELSE
            Scroll haut    fr.satelix.logistique:id/rv_liste
        END
    END

Scroll bas
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    30
    ${element_size}=    Get Element Size    id=${locator}
    ${element_location}=    Get Element Location    id=${locator}
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.7)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.3)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    150

Scroll haut
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    30
    ${element_size}=    Get Element Size    id=${locator}
    ${element_location}=    Get Element Location    id=${locator}
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.3)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.7)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y}    150

Affiche Element
    [Arguments]    ${element}
    Log To Console    Attente de l'affichage de l'élément ${element}
    Wait Until Page Contains Element    ${element}    30

Sélection gamme
    [Arguments]    ${gamme}
    Log To Console    Sélection de la gamme ${gamme}
    Wait Until Page Contains    ${gamme}    30
    Click Text    ${gamme}

Sélection sous gamme
    [Arguments]    ${sousGamme}
    Log To Console    Sélection de la sous gamme ${sousGamme}
    Sélection gamme    ${sousGamme}

Attendre
    Log To Console    Attente de 5 secondes
    Sleep    5s

Valider module
    Log To Console    Validation du module
    Wait Until Page Contains    fr.satelix.logistique:id/fab_quitter    30
    Click Element    fr.satelix.logistique:id/fab_quitter
    Wait Until Page Contains    fr.satelix.logistique:id/bt_quitter_module_valider_transfert    30
    Click Element    fr.satelix.logistique:id/bt_quitter_module_valider_transfert

Sélection dépot destination
    [Arguments]    ${depot}
    Log To Console    Sélection du dépot destination
    Wait Until Page Contains    ${depot}    30
    Click Text    ${depot}    True

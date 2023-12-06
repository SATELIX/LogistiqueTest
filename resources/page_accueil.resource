*** Settings ***
Documentation    contient les mots clés gérant les actions sur la page d'accueil/home
...              où se touve la liste des modules disponibles.

Resource    ../resources/utils.resource

Library    AppiumLibrary

*** Variables ***
${module}    ${EMPTY}
# ${module_xpath}    xpath=//androidx.cardview.widget.CardView[contains(text(),"${module}")]

${LISTE_MODULES_A_L_ECRAN}    rv_liste_modules

*** Keywords ***
Sur le terminal, sélectionner le module
    [Arguments]    ${monModule}
    Choisir Le Module Dans La Liste Des Modules    ${monModule}

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
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y+120}    150

Scroll haut
    [Arguments]    ${locator}
    Wait Until Page Contains Element    ${locator}    30
    ${element_size}=    Get Element Size    id=${locator}
    ${element_location}=    Get Element Location    id=${locator}
    ${start_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${start_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.3)
    ${end_x}=    Evaluate    ${element_location['x']} + (${element_size['width']} * 0.5)
    ${end_y}=    Evaluate    ${element_location['y']} + (${element_size['height']} * 0.7)
    Swipe    ${start_x}    ${start_y}    ${end_x}    ${end_y+40}    150


Choisir au menu déroulant avec scroll
    [Arguments]    ${menu}    ${choix}
    Wait Until Element Is Visible    ${menu}
    AppiumLibrary.Click Element    ${menu}
    Sleep    5s
    Scroll Vers Element    ${choix}    bas
    AppiumLibrary.Click Element    ${choix}


Sélectionner document origine
    [Arguments]    ${txt}
    Wait Until Element Is Visible    //android.widget.EditText[@text="Sélection document origine"]
    Click Element    //android.widget.EditText[@text="Sélection document origine"]
    Taper Un Mot Au Clavier    ${txt}
    Press ENTER

Remplir donnée
    [Arguments]    ${source}    ${data}
    Wait Until Element Is Visible    ${source}
    Click Element    ${source}
    Taper Un Mot Au Clavier    ${data}
    Hide Keyboard

Choisir le module Peparation
	Choisir le module dans la liste des modules    ${module}

Choisir le module Expedition
	Choisir le module dans la liste des modules    ${module}

Choisir Le Module Dans La Liste Des Modules
    [Documentation]  Clique sur le module passé en paramètre
    [Arguments]      ${module_name}
    ${module_present}    Run Keyword And Return Status    AppiumLibrary.Wait Until Page Contains    ${module_name}
    ...    3s
    ...    La liste des modules ne contient pas le module demandé ${module_name}  
    Run Keyword If    ${module_present}
    ...    AppiumLibrary.Click Text    ${module_name}
    ...  ELSE
    ...    Wait Until Keyword Succeeds    4x    0.5s    Faire Defiler Les Modules Pour Trouver Le Bon     ${module_name}


Faire Defiler Les Modules Pour Trouver Le Bon 
    [Documentation]    Scroll module par module pour trouver celui recerché.
    ...  Les coordonnées du premier et du dernier modules affichés à l'écran sont récupérées,
    ...  Un swipe est effectué entre ces deux coordonnées, du dernier vers le premier,
    ...  jusqu'à ce que le module recherché soit trouvé et cliqué 
    ...  \n pour info, les données que renvoie Get Element Rec sont 
    ...  \n ${rec} = {'height': 957, 'width': 720, 'x': 0, 'y': 211}
    ...  
    [Arguments]    ${module_name}
    ${rec}=    AppiumLibrary.Get Element Rect   ${LISTE_MODULES_A_L_ECRAN}
    Log     ${rec}
    ${swipe_height}    Evaluate    ${rec}[y]/5
    ${swipe_height}    Convert To Integer    ${swipe_height}
    Swipe    10    ${rec}[height]    0      -${swipe_height}    #-${rec}[height]/4
    AppiumLibrary.Click Text    ${module_name}


    

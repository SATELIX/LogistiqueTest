*** Settings ***
Documentation    contient les mots clés gérant les actions sur la page d'accueil/home
...              où se touve la liste des modules disponibles.

Library    AppiumLibrary

*** Variables ***

${module_preparation}    xpath=//androidx.cardview.widget.CardView[@content-desc="Select the module Prépa."]
${module_expedition}    xpath=//androidx.cardview.widget.CardView[@content-desc="Select the module Expédition."]

${LISTE_MODULES_A_L_ECRAN}    rv_liste_modules

*** Keywords ***
Choisir le module Peparation
	Choisir le module dans la liste des modules    ${module_preparation}

Choisir le module Expedition
	Choisir le module dans la liste des modules    ${module_expedition}

Choisir Le Module Dans La Liste Des Modules
    [Documentation]  Clique sur le module passé en paramètre
    [Arguments]      ${module_name}
    ${module_present}    Run Keyword And Return Status    AppiumLibrary.Wait Until Element Is Visible    ${module_name}
    ...    3s
    ...    La liste des modules ne contient pas le module demandé ${module_name}  
    Run Keyword If    ${module_present}
    ...    AppiumLibrary.Click Element    ${module_name}
    ...  ELSE
    ...    Wait Until Keyword Succeeds    4x    0.5s    Faire Defiler Les Modules Pour Trouver Le Bon     ${module_name}
    
Faire Defiler Les Modules Pour Trouver Le Bon 
    [Documentation]    ce mot clé scroll module pa module pour trouver celui recercher
    ...  il récupèe les coordonnées du premier et du dernier modules affichés à l'écran
    ...  et scroll du dernie vers le premier
    ...  et tente de cliquer sur le module cherché. 
    ...  \n pour info, les données que renvoie Get Element Rec sont 
    ...  \n ${rec} = {'height': 957, 'width': 720, 'x': 0, 'y': 211}
    ...  
    ...  
    [Arguments]    ${module_name}
    ${rec}=    AppiumLibrary.Get Element Rect   ${LISTE_MODULES_A_L_ECRAN}
    Log     ${rec}
    Swipe    10    ${rec}[height]    0    -${rec}[height]
    AppiumLibrary.Click Element    ${module_name}


    

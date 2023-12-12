*** Settings ***

Documentation    contient les mots clés gérant les actions sur la page d'accueil/home
...              où se touve la liste des modules disponibles.



Resource    ../resources/utils.resource

Library    AppiumLibrary
*** Variables ***
${module}    ${EMPTY}
${automationName}       UIAutomator2
${platformName}         Android
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity


${LISTE_MODULES_A_L_ECRAN}    rv_liste_modules

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


Sur le terminal, sélectionner le module
    [Arguments]    ${monModule}
    Choisir Le Module Dans La Liste Des Modules    ${monModule}


Choisir Le Module Dans La Liste Des Modules
    [Documentation]  Clique sur le module passé en paramètre
    [Arguments]      ${module_name}
    ${module_present}    Run Keyword And Return Status    AppiumLibrary.Wait Until Page Contains    ${module_name}
    ...    30s
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


    

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


*** Test Cases ***
Test De L Applicaiton
    Demarrer Une Application    fr.satelix.logistique
    Sélectionner le module Entrée mono empl
    Affiche sélection dépot destination
    Sélection dépot destination


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

Sélectionner le module Entrée mono empl
    Click Text    Entrée de stock

Affiche sélection dépot destination
    Wait Until Page Contains    Sélection dépôt destination

Sélection dépot destination
    Click Element
    ...    //android.widget.Spinner[@resource-id="fr.satelix.logistique:id/dropdown_list" and @text="Sélection dépôt destination"]
    Wait Until Page Contains Element    //*[@text="Bijou SA"]
    Click Element    //*[@text="Bijou SA"]

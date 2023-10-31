*** Settings ***
Documentation       ce test pour executer l'application
...                 ldkjdldjldkjd
...

Library             AppiumLibrary
Resource            SatelixLogistique.resource


*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${platformVersion}      10.0
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity


*** Test Cases ***
Test De L Applicaiton
    Demarrer Une Application    fr.satelix.logistique


*** Keywords ***
Demarrer Une Application
    [Documentation]    ce que fait le mot clé
    [Arguments]    ${appPackage}
    AppiumLibrary.Open Application
    ...    http://127.0.0.1:4723
    ...    automationName=${automationName}
    ...    platformName=${platformName}
    ...    platformVersion=${platformVersion}
    ...    appPackage=${appPackage}
    ...    appActivity=${appActivity}
    ...    autoGrantPermissions=true
    ...    noReset=true
    ...    fullReset=false
    ...    forceAppLaunch=true    # force l'application à se lancer à chaque fois
    # ...    app=${app}
    # ...    udid=${deviceUdid}

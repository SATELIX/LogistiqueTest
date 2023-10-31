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
    Sélectionner le module Sortie mono empl
    Affiche sélection dépot d origine la date et la reference
 
 
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
 
Sélectionner le module Sortie mono empl
    Click Text    Sortie de stock
 
Affiche sélection dépot d origine la date et la reference    # vérifie que la page s'affiche: Sortie de stock - Sélection dépot d'origine, la date et la référence
    Wait Until Page Contains    text=Sortie de stock
    Wait Until Element Is Visible    accessibility_id=Sélectionner une date
    Wait Until Page Contains    Saisi référence doc

Sélectionner le dépôt origine Bijou SA
    Click Element    resource-id=fr.satelix.logistique:id/dropdown_list    #impossible d'ouvir le drop down pour le moment (tests faits : xpath, id, inputlist)
 
    #//android.widget.Spinner[@resource-id="fr.satelix.logistique:id/dropdown_list" and @text="Sélection dépôt origine"]


    

    



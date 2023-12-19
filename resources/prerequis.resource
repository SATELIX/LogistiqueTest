*** Settings ***
Documentation       Ce fichier regroupe les mots clés "généraux" de l'application Logistique \n
...                 Par défaut le test lance la version démo de Logistique.
...

Library     Process
Library     AppiumLibrary
Resource    page_accueil.resource
Resource    utils.resource

*** Variables ***
${remoteURL}                    http://localhost:4723/wd/hub
${automationName}               UIAutomator2
${platformName}                 Android

${newapp}               D:${/}SATELIX${/}app${/}new_version.apk
${oldapp}               D:${/}SATELIX${/}app${/}old_version.apk
${appPackage}        fr.satelix.logistique
${appActivity}       fr.satelix.logistique.activities.MainActivity

${menu}    //android.widget.FrameLayout[@content-desc="Menu"]
${accueil}    //android.widget.FrameLayout[@content-desc="Accueil"]
*** Keywords ***

DemarrerLaNouvelleVersion
    Open Application    ${remoteURL}
    ...    automationName=${automationName}
    ...    platformName=${platformName}
    ...    appPackage=${appPackage}
    ...    appActivity=${appActivity}
    ...    autoGrantPermissions=true
    ...    noReset=true
    ...    app=${newapp}
    Activate Application    ${appPackage}


DemarrerLAncienneVersion
    Open Application    ${remoteURL}
    ...    automationName=${automationName}
    ...    platformName=${platformName}
    ...    appPackage=${appPackage}
    ...    appActivity=${appActivity}
    ...    autoGrantPermissions=true
    ...    noReset=true
    ...    app=${oldapp}
    Activate Application    ${appPackage}


FaireSynchroComplete
    Wait Until Element Is Visible    ${menu}
    Click Element    ${menu}
    Wait Until Page Contains    Paramètres
    Click Text    Paramètres
    Wait Until Page Contains    Synchronisation complète
    Click Text    Synchronisation complète
    Cliquer sur Oui
    Sleep    5s
    Go Back
    Sleep    2s
    Wait Until Element Is Visible    ${accueil}
    Click Element    ${accueil}
    Sleep    2s


SAuthentifier
    Wait Until Page Contains    CONNEXION
    Click Text    CONNEXION
    Sleep    5s
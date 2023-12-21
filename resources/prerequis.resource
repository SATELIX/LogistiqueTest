*** Settings ***
Documentation       Ce fichier regroupe les mots clés "généraux" de l'application Logistique \n
...                 Par défaut le test lance la version démo de Logistique.
...

Library     Process
Library     AppiumLibrary
Resource    page_accueil.resource
Resource    utils.resource
Resource    SatelixLogistique.resource


*** Variables ***
${remoteURL}                    http://localhost:4723/wd/hub
${automationName}               UIAutomator2
${platformName}                 Android
${platformVersion}=    Get Environment Variable    ANDROIDVERSION	9.0     # 10.0    # 9.0    # 12.0    # 
# ${newapp}               C:${\}Users${\}user${\}Documents${\}TestsVersions${\}Logistique-release-1.0.46_216.apk
${oldapp}               D:${/}SATELIX${/}app${/}old_version.apk
${appPackage}        fr.satelix.logistique
${appActivity}       fr.satelix.logistique.activities.MainActivity

${menu}    //android.widget.FrameLayout[@content-desc="Menu"]
${accueil}    //android.widget.FrameLayout[@content-desc="Accueil"]

${DRIVE_PACKAGE}                com.google.android.apps.docs
${DRIVE_ACTIVITY}               com.google.android.apps.docs.app.NewMainProxyActivity

${shared}    id=com.google.android.apps.docs:id/menu_navigation_shared
${installation}    xpath=(//android.view.ViewGroup[@resource-id="com.google.android.apps.docs:id/document_layout"])[2]
${check}    xpath=(//android.widget.FrameLayout[@resource-id="com.google.android.apps.docs:id/document_layout"])[2]/android.view.ViewGroup
${changemode}    id=com.google.android.apps.docs:id/list_button
${identification}    //android.widget.EditText[@text="Identifiant"]

${id_alexis}=  {"serveur":"SRV_SAT_TEST","uuid":"0FB4EF6B-FB21-4A22-A2E9-9BFA0885B0F6","ip":"172.17.1.36","ip_distante":"logistique.test.satelix.fr","port":"7991","port_public":7991,"port_mqtt":"1893"}
${plusdoption}    //android.widget.ImageView[@content-desc="Plus d'options"]
*** Keywords ***


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



Install Application Local
    Open Application    ${remoteURL}
    ...    platformName=Android    platformVersion=${platformVersion}
    ...    deviceName=${DEVICE_NAME}    app=${NEW_APP_PATH}    appPackage=${appPackage}
    ...    appActivity=${appActivity}
    ...    automationName=UiAutomator2

Ouvrir Google Drive
    Open Application    ${remoteURL}
    ...    platformName=Android    platformVersion=${platformVersion}
    ...    deviceName=${DEVICE_NAME}    appPackage=${DRIVE_PACKAGE}
    ...    appActivity=${DRIVE_ACTIVITY}
    ...    automationName=UiAutomator2 

Changer de mode de vue
    [Documentation]    Vérifie le type de fenêtre pour pouvoir sélectionner le bon xpath
    Wait Until Element Is Visible    ${changemode}
    Click Element    ${changemode}
IsOuiVisible
    [Documentation]    Vérifie le type de fenêtre pour pouvoir sélectionner le bon xpath
    ${ispresent}=     Run Keyword And Return Status    Wait Until Page Contains    OUI    timeout=10
    IF    ${ispresent}
        Sélectionner le document    OUI
    END

Installer la nouvelle version
    Sélectionner le document par element    ${shared}
    Sélectionner le document    LogistiqueV2
    Sélectionner le document    Application mobile
    Sélectionner le document    APK
    Sélectionner le document    Test
    Sleep    2s
    Changer de mode de vue
    Sleep    2s
    Sélectionner le document par element    ${installation}
    Wait Until Page Contains    Satelix Logistique     timeout=60
    Sélectionner le document    INSTALLER
    Wait Until Page Contains    OUVRIR     timeout=60
    Sélectionner le document    OUVRIR


Installer version antérieur
    Sélectionner le document par element    ${shared}
    Sélectionner le document    LogistiqueV2
    Sélectionner le document    Application mobile
    Sélectionner le document    APK
    Sélectionner le document    public
    Sleep    2s
    Changer de mode de vue
    Sleep    2s
    Sélectionner le document par element    ${installation}
    Wait Until Page Contains    Satelix Logistique     timeout=60
    Sélectionner le document    INSTALLER
    Wait Until Page Contains    OUVRIR     timeout=60
    Sélectionner le document    OUVRIR


Se Connecter
    [Arguments]    ${login}
    Sleep    2s
    Sélectionner le document par element    ${plusdoption}
    Sélectionner le document    Ajout configuration
    Sélectionner le document    Chaine de configuration
    Input Text Into Current Element    ${id_alexis}
    Sleep    2s
    Hide Keyboard
    Sleep    2s
    Sélectionner le document    AJOUTER
    Sleep    2s
    Cliquer sur Oui
    Sleep    2s
    Appuyer sur la flèche retour
    IsOuiVisible
    Sélectionner le document     LogistiqueV2Test
    Sélectionner le document par element    ${identification}
    Taper Un Mot Au Clavier    ARTHUR
    Sleep    2s
    Hide Keyboard
    Sleep    2s
    Sélectionner le document    CONNEXION
    Sleep    10s





PrerequisOld
    #Dupliquer le scénario tests models 
    #Se connecter à partir du bureau à distance sur le serveur "SRV-SAT-TEST"
    #Contrôler qu'on est bien sur la bonne branche
    #Démarrer le travail SQL "SxRestaurationBasesTest" via Sql Management Studio --> SQL Server Agent -> Travaux
    Demarrer L Application
    Remove Application  ${appPackage}
    Close Application
    Ouvrir Google Drive
    Installer version antérieur
    Se Connecter    ${id_alexis}
    FaireSynchroComplete
    #Mettre mode fenêtre
    #La base Sage sur laquelle les tests sont fait se nomme "Bijou_Test"

PrerequisNew
    #Se connecter à partir du bureau à distance sur le serveur "SRV-SAT-TEST"
    #Contrôler qu'on est bien sur la bonne branche
    #Démarrer le travail SQL "SxRestaurationBasesTest" via Sql Management Studio --> SQL Server Agent -> Travaux
    Demarrer L Application
    Remove Application  ${appPackage}
    Close Application
    Ouvrir Google Drive
    Installer la nouvelle version
    Se Connecter    ${id_alexis}
    FaireSynchroComplete
    #Mettre mode fenêtre
    #La base Sage sur laquelle les tests sont fait se nomme "Bijou_Test"

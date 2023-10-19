*** Settings ***
Documentation    Ce fichier regroupe les mots clés "généraux" de l'application Logistique \n
...              Par défaut le test lance la version démo de Logistique.
...    

Library    AppiumLibrary
Resource    utils.resource

*** Variables ***
${remoteURL}         http://localhost:4723/wd/hub
${automationName}    UIAutomator2
${platformName}      Android
${platformVersion}   7.0
${deviceUdid}        04157df438b0b226
# ${app}               /d/SATELIX/app/Logistique-demo-release-1.0.34 141.apk
${app}               D:${/}SATELIX${/}app${/}Logistique-release-1.0.41 197.apk
# ${app}               D:${/}SATELIX${/}app${/}Logistique-demo-release-1.0.34 141.apk
${appPackage}        fr.satelix.logistique
# ${appPackage}        fr.satelix.logistique.demo
${appActivity}       fr.satelix.logistique.activities.MainActivity

${BOUTON_AJOUTER_DOSSIER}     id=fab_ajout_config
${FENETRE_VALIDATION_AJOUT}   content
${BOUTON_VALIDATION_AJOUT}    button1

${DOSSIER}                    DemoSatelix
${LOGIN}                      AURELIEN
${PASSWORD}

${listederoulante_logins}     //android.widget.ImageButton[@content-desc="Show drop-down menu"]
${INPUT_LOGIN}                class=android.widget.EditText
${INPUT_PASSWORD}
${BUTTON_LOGIN}                bt_connexion    

*** Keywords ***
Demarrer L Application Et Se Connecter Au Dossier
    [Documentation]    Ce mot clé démarre l'application et vérifie si le bouton pour ajouter un dossier est présent.
    ...    \n si le bouton pou ajoute un dossier est présent, il est utilisé. 
    ...    \n l'ajout du dossier est géré par le mot clé Ajouter Un  Dossier
    [Arguments]    ${Dossier}
    Demarrer L Application
    Ajouter Un Dossier Si Besoin
    Choisir Le Dossier    ${Dossier}
    Se Connecter Au Dossier

Demarrer L Application
    AppiumLibrary.Open Application   ${remoteURL} 
    ...    automationName=${automationName}
    ...    udid=${deviceUdid}
    ...    platformName=${platformName}
    ...    platformVersion=${platformVersion}
    ...    app=${app}
    ...    appPackage=${appPackage}      
    ...    appActivity=${appActivity}
    ...    autoGrantPermissions=true
    ...    fullReset=false

Ajouter Un Dossier Si Besoin
    [Documentation]    Vérifie si le bouton d'aout du QR Code est présent.
    ${ajoutPossible}=    Run Keyword And Return Status    AppiumLibrary.Page Should Contain Element    ${BOUTON_AJOUTER_DOSSIER}
    Run Keyword If    ${ajoutPossible}
    ...    Ajouter Un Dossier 

Ajouter Un Dossier 
    [Documentation]    Ajoute un dossier à l'application en scannant le QR code correpsondant
    AppiumLibrary.Click Element    ${BOUTON_AJOUTER_DOSSIER}
    Sleep    4s
    # utils.Press ENTER
    # utils.Press ENTER
    # Valider 10 fois si beosin L Ajout Du Dossier Tant Que La Question Est Posee
    Wait Until Keyword Succeeds    20    1s    Valider L Ajout D Un Dossier

Valider L Ajout D Un Dossier
    AppiumLibrary.Text Should Be Visible    ${FENETRE_VALIDATION_AJOUT}
    AppiumLibrary.Click Element    ${BOUTON_VALIDATION_AJOUT}
    AppiumLibrary.Page Should Not Contain Element    ${FENETRE_VALIDATION_AJOUT}
    
Choisir Le Dossier    
    [Documentation]    Au démarage de l'application, l'utilisateur doit choisir le dossier 
    ...                sur le quel il veut travailler.
    ...    \nCe mot clé clique sur le nom du dossier donné en argument.
    [Arguments]    ${Dossier}
    AppiumLibrary.Click Text    ${Dossier}

Se Connecter Au Dossier
    AppiumLibrary.Wait Until Page Contains    ${INPUT_LOGIN}    
    ...    La page de Login ne s'est pas affichée dans les 5secondes.
    AppiumLibrary.Input Text       ${INPUT_LOGIN}    ${LOGIN}
    AppiumLibrary.Click Element    ${BUTTON_LOGIN}    

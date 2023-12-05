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

${app}               D:${/}SATELIX${/}app${/}Logistique-demo-release-1.0.34 141.apk
${appPackage}        fr.satelix.logistique
${appActivity}       fr.satelix.logistique.activities.MainActivity
# ${appActivity}       fr.satelix.logistique.activities.dossiers.DossierActivity
# ${appActivity}       fr.satelix.logistique.activities.identification.IdentificationActivity

${BOUTON_AJOUTER_DOSSIER}       id=fab_ajout_config
${FENETRE_VALIDATION_AJOUT}     content
${BOUTON_VALIDATION_AJOUT}      button1

${BOUTON_AUTHENT}    id=bt_authentification

${LOGIN}                      QUENTIN 
${PASSWORD}

${listederoulante_logins}       //android.widget.ImageButton[@content-desc="Show drop-down menu"]
${INPUT_LOGIN}                  class=android.widget.EditText
# ${INPUT_LOGIN}    class=android.widget.AutoCompleteTextView
# ...    fr.satelix.logistique.demo:id/dropdown_identifiant//android.widget.AutoCompleteTextView
${INPUT_PASSWORD}               class=android.widget.EditText
${BUTTON_LOGIN}                 bt_connexion
${button_valider}       fr.satelix.logistique:id/fab_valider
${button_finaliser}     fr.satelix.logistique:id/fab_quitter
 
 
*** Keywords ***
Demarrer L Application Et Se Connecter Au Dossier
    [Documentation]    Ce mot clé démarre l'application et vérifie si le bouton pour ajouter un dossier est présent.
    ...    \n si le bouton pou ajoute un dossier est présent, il est utilisé. 
    ...    \n l'ajout du dossier est géré par le mot clé Ajouter Un  Dossier
    ...    \n le but de se mot clé est d'ariver sur la page d'accueil avec la liste des modules.
    ...    \n\n Note : l'url par défaut est le local host. Dans le ca où les terminaux seraient connecté à un serveur dédié
    ...    il faudra changer l'url avec l'ip ou le nom de ce serveur    (http://serveurAppium:4723/wd/hub)
    [Arguments]    ${Dossier}
    Demarrer L Application
    ${fenetre}=    Verifier La Fenete D Ouverture
    Run Keyword If    "${fenetre}" == "dossier"
    ...    Choisir Le Dossier Et Se Connecter    ${Dossier}
    ...  ELSE IF    "${fenetre}" == "login"
    ...    Se Connecter Au Dossier
    ...  ELSE IF    "${fenetre}" == "authent"
    ...    Aller Sur LA page De Login Et Se Connecter
    ...  ELSE IF    "${fenetre}" == "accueil"
    ...    Log    La page d'acueil est ouverte avec la liste des modules.

Verifier La Fenete D Ouverture
    ${status}    Run Keyword And Return Status    AppiumLibrary.Page Should Contain Element    ${BOUTON_AJOUTER_DOSSIER}
    Return From Keyword If    ${status}    dossier
    ${status}    Run Keyword And Return Status    AppiumLibrary.Page Should Contain Element    ${BUTTON_LOGIN}
    Return From Keyword If    ${status}    login
    ${status}    Run Keyword And Return Status    AppiumLibrary.Page Should Contain Element    ${BOUTON_AUTHENT}
    Return From Keyword If    ${status}    authent
    ${status}    Run Keyword And Return Status    AppiumLibrary.Page Should Contain Element    id=tv_intitule_modules
    Return From Keyword If    ${status}    accueil

Demarrer L Application
    Open Application    ${remoteURL}
    ...    automationName=${automationName}
    ...    platformName=${platformName}
    ...    appPackage=${appPackage}
    ...    appActivity=${appActivity}
    ...    autoGrantPermissions=true
    ...    noReset=true
    # ...    fullReset=true
    # ...    platformVersion=${platformVersion}
    # ...    udid=${deviceUdid}
    # ...    app=${app}
    Activate Application    ${appPackage}

Ajouter Un Dossier 
    [Documentation]    Ce mot clé tente d'ajouter un dossier à l'application
    ...    en scannant le QR code correpsondant
    Click Element    ${BOUTON_AJOUTER_DOSSIER}
    Wait Until Keyword Succeeds    60    4s    Valider L Ajout D Un Dossier
 
Valider L Ajout D Un Dossier
    Text Should Be Visible    ${FENETRE_VALIDATION_AJOUT}
    FOR    ${i}    IN RANGE    10
        # AppiumLibrary.Click Element    ${BOUTON_VALIDATION_AJOUT}
        Ajouter Un Dossier
    END
    Page Should Not Contain Element    ${FENETRE_VALIDATION_AJOUT}

Choisir Le Dossier Et Se Connecter
    [Arguments]    ${Dossier}
    Choisir Le Dossier    ${Dossier}
    Se Connecter Au Dossier

Choisir Le Dossier    
    [Documentation]    Au démarage de l'application, l'utilisateur doit choisir le dossier 
    ...                sur le quel il veut travailler.
    ...    \nCe mot clé clique sur le nom du dossier donné en argument.
    ...    \nSi le dossier n'est pas trouver, le mot clé tente d'ajouter un nouveau dossier.
    [Arguments]    ${Dossier}
    ${dossier_trouve}=    AppiumLibrary.Wait Until Page Contains    ${Dossier}    6s
    ...    La page ne contient pas le dossier demandé : ajout du dossieravec QR code.
    IF    ${dossier_trouve} == ${False}    Ajouter Un Dossier
    Click Text    ${Dossier}

Aller Sur LA page De Login Et Se Connecter
    Click Element    ${BOUTON_AUTHENT}
    Se Connecter Au Dossier

Se Connecter Au Dossier
    Wait Until Page Contains Element    ${INPUT_LOGIN}    6s
    ...    La page de Login ne s'est pas affichée dans les 6 secondes.
    Input Text       ${INPUT_LOGIN}    ${LOGIN}
    Click Element    ${BUTTON_LOGIN}    

# Revenir Au Choix Des Dossiers
#     [Documentation]    Ce mot clé permet de reveni sur l'écran de choix du dossier. 
#     ...   cela suppose qu'en fin de test, l'application se trouve sur l'écran desd'accueil ou news
#     AppiumLibrary.Click Element    //*[@content-desc="Menu"]/android.widget.ImageView
#     AppiumLibrary.Click Element    id=icon_deconnexion 
#     AppiumLibrary.Go Back 
#     AppiumLibrary.Click Element    id=bt_liste_dossiers 
    # Switch App
    # AppiumLibrary.Close Application

# Fermer L Application
#     ${id}=    AppiumLibrary.Get Appium SessionId
#     AppiumLibrary.Stop Application    ${id}
    # Switch App
    # AppiumLibrary.Close All Applications

# Revenir Au Choix Des Dossiers Et Fermer Les Applications
#     AppiumLibrary.Start Activity    ${appPackage}    fr.satelix.logistique.activities.dossiers.DossierActivity
#     # fr.satelix.logistique.activities.identification.IdentificationActivity
#     Revenir Au Choix Des Dossiers
#     Fermer L Application

Sélectionner le dépôt origine Bijou SA
    Wait Until Page Contains    //android.widget.ImageButton[@content-desc="Afficher la liste"]  
    Click Element    //android.widget.ImageButton[@content-desc="Afficher la liste"]
    Wait Until Page Contains    text=Bijou SA
    Click Text    Bijou SA  True

Sélectionner référence doc
    [Arguments]    ${reference}
    Wait Until Element Is Visible    xpath=//android.widget.EditText[@text="Saisi référence doc"]
    Click Element    xpath=//android.widget.EditText[@text="Saisi référence doc"]
    Input Text Into Current Element    ${reference}

Valider les informations
    Hide Keyboard
    Wait Until Page Contains    VALIDER
    Click Element    ${button_valider}

Valider association
    Wait Until Page Contains    VALIDER
    Click Text     VALIDER
    Wait Until Page Contains    REMPLACER
    Click Text     REMPLACER

Swipe Down
    [Arguments]    ${element}
    FOR    ${counter}    IN RANGE    0    10
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    timeout=1s
        IF    ${status}    BREAK
        Swipe    0    495    0    100    150
    END

Scanner code barre
    [Arguments]    ${codeBarre}
    ${result}=    Run Process
    ...    adb
    ...    shell
    ...    am
    ...    broadcast
    ...    -a
    ...    fr.satelix.logistique.scan
    ...    --es
    ...    com.motorolasolutions.emdk.datawedge.data_string
    ...    "${codeBarre}"
    ...    

Dialog Cliquer Ok
    Wait Until Element Is Visible    android:id/button1
    Click Element    android:id/button1

Attendre
    Sleep    5s

Back
    Go Back


Fermer L Application 
    Sleep    3s
    Close Application    #    ${appPackage}

Finaliser
    Wait Until Page Contains    ${button_finaliser}
    Click Element    ${button_finaliser}

Valider
    Wait Until Page Contains    fr.satelix.logistique:id/bt_quitter_module_valider_transfert
    Click Element    fr.satelix.logistique:id/bt_quitter_module_valider_transfert    

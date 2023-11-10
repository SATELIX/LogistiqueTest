*** Settings ***
Documentation    Ce fichier regroupe les mots clés "généraux" de l'application Logistique \n
...              Par défaut le test lance la version démo de Logistique.
...    

Library     AppiumLibrary
Resource    page_accueil.resource
Resource    utils.resource

*** Variables ***
${remoteURL}         http://localhost:4723/wd/hub
${automationName}    UIAutomator2
${platformName}      Android

${app}               D:${/}SATELIX${/}app${/}Logistique-demo-release-1.0.34 141.apk
${appPackage}        fr.satelix.logistique.demo
${appActivity}       fr.satelix.logistique.activities.MainActivity
# ${appActivity}       fr.satelix.logistique.activities.dossiers.DossierActivity
# ${appActivity}       fr.satelix.logistique.activities.identification.IdentificationActivity

${BOUTON_AJOUTER_DOSSIER}     id=fab_ajout_config
${FENETRE_VALIDATION_AJOUT}   content
${BOUTON_VALIDATION_AJOUT}    button1

${BOUTON_AUTHENT}    id=bt_authentification

${LOGIN}                      QUENTIN 
${PASSWORD}

${listederoulante_logins}     //android.widget.ImageButton[@content-desc="Show drop-down menu"]
${INPUT_LOGIN}                class=android.widget.EditText
# ${INPUT_LOGIN}                class=android.widget.AutoCompleteTextView
# ...    fr.satelix.logistique.demo:id/dropdown_identifiant//android.widget.AutoCompleteTextView
${INPUT_PASSWORD}             class=android.widget.EditText
${BUTTON_LOGIN}                bt_connexion    

*** Keywords ***
Demarrer L Application Et Se Connecter Au Dossier
    [Documentation]    Ce mot clé démarre l'application et vérifie si le bouton pour ajouter un dossier est présent.
    ...    \n si le bouton pou ajoute un dossier est présent, il est utilisé. 
    ...    \n l'ajout du dossier est géré par le mot clé Ajouter Un  Dossier
    ...    \n le but de se mot clé est d'ariver sur la page d'accueil avec la liste des modules.
    ...    \n\n Note : l'url par défaut est le local host. Dans le ca où les terminaux seraient connecté à un serveur dédié
    ...    il faudra changer l'url avec l'ip ou le nom de ce serveur  (http://serveurAppium:4723/wd/hub)
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
    AppiumLibrary.Open Application   ${remoteURL} 
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
    AppiumLibrary.Activate Application    ${appPackage}

Ajouter Un Dossier 
    [Documentation]    Ce mot clé tente d'ajouter un dossier à l'application
    ...    en scannant le QR code correpsondant
    AppiumLibrary.Click Element    ${BOUTON_AJOUTER_DOSSIER}
    Wait Until Keyword Succeeds    60   4s    Valider L Ajout D Un Dossier

Valider L Ajout D Un Dossier
    AppiumLibrary.Text Should Be Visible    ${FENETRE_VALIDATION_AJOUT}
    FOR    ${i}    IN RANGE    10
        # AppiumLibrary.Click Element    ${BOUTON_VALIDATION_AJOUT}
        Ajouter Un Dossier
    END
    AppiumLibrary.Page Should Not Contain Element    ${FENETRE_VALIDATION_AJOUT}

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
    Run Keyword If    ${dossier_trouve} == ${False}
    ...    Ajouter Un Dossier
    AppiumLibrary.Click Text    ${Dossier}

Aller Sur LA page De Login Et Se Connecter
    AppiumLibrary.Click Element    ${BOUTON_AUTHENT}
    Se Connecter Au Dossier

Se Connecter Au Dossier
    AppiumLibrary.Wait Until Page Contains Element   ${INPUT_LOGIN}    6s    
    ...    La page de Login ne s'est pas affichée dans les 6 secondes.
    AppiumLibrary.Input Text       ${INPUT_LOGIN}    ${LOGIN}
    AppiumLibrary.Click Element    ${BUTTON_LOGIN}    

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

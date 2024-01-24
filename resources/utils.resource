*** Settings ***
Documentation    Ce fichier de ressources contient les mots clé robot
...              qui sont utiles globalement pou les tests et la gestion des 
...              liens avec Squash : lecture des jeux de données par exemple
...    
...    <BR>L'utilisation du clavier d'Android se fait come pour un tilisateur
...    en appuyat sur le touches du clavier. 
...    <BR> La correspondances de KEYCODE peut se retrouver à la page :
...    https://developer.android.com/reference/android/view/KeyEvent

Library    OperatingSystem
Library    String
Library    AppiumLibrary
Library    DateTime
Library    squash_tf.TFParamService
Resource   SatelixLogistique.resource
Resource    module_preparation.resource

*** Variables ***

${DEVICE_NAME}    Your_Device_Name
${PLATFORM_NAME}  Android
${APP_ACTIVITY}   com.google.android.apps.docs.home.HomeActivity
${NEW_APP_PATH}    C:/Users/user/Documents/TestsVersions/Logistique-release-1.0.46_216.apk
${OLD_APP_PATH}    /chemin/vers/old/app.apk

${date}    //android.widget.ImageButton[@content-desc="Sélectionner une date"]
${edit}    //android.widget.ImageButton[@content-desc="Passer au mode de saisie Texte"]
${automationName}               UIAutomator2
${modulehaut}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner le module Consultation Mono Empl."]/android.view.ViewGroup
# Les Keycode Android pour gérer les entrées comme un utilisateur réel
&{KEYCODES}    0=7
...    1=8
...    2=9
...    3=10
...    4=11
...    5=12
...    6=13
...    7=14
...    8=15
...    9=16
...    A=29
...    B=30
...    C=31
...    D=32
...    E=33
...    F=34
...    G=35
...    H=36
...    I=37
...    J=38
...    K=39
...    L=40
...    M=41
...    N=42
...    O=43
...    P=44
...    Q=45
...    R=46
...    S=47
...    T=48
...    U=49
...    V=50
...    W=51
...    X=52
...    Y=53
...    Z=54
...    .=158
...    ,=55
...    /=76
...    clear=28
...    del=67
...    foward_del=112
...    select=109 
...    ctrl=4096
...    alt=50
...    enter=66
...    app_switch=187
...    down=20


*** Keywords ***
Switch App
    AppiumLibrary.Press Keycode    keycode${KEYCODES}[app_switch]

Press ENTER
    AppiumLibrary.Press Keycode    ${KEYCODES}[enter]
    

Taper Un Nombre Au Clavier   
    [Documentation]    Mot clé qui efface ce que contient la zone de texte
    ...    qui boucle sur chaque chiffre (et point) du nombre passé en argument
    ...    et qui envoie le KeyCode pour chaque chiffre correpsondant.
    [Arguments]     ${nombre}
    Supprimer Un Nombre Au Clavier
    ${nombre}=    Convert To String    ${nombre}
    ${chiffres_a_taper}=    Split String To Characters    ${nombre}
    FOR    ${chiffre}    IN    @{chiffres_a_taper}
        AppiumLibrary.Press Keycode    ${KEYCODES}[${chiffre}]
    END

Taper Un Mot Au Clavier   
    [Documentation]    Mot clé qui efface ce que contient la zone de texte
    ...    qui boucle sur chaque chiffre (et point) du nombre passé en argument
    ...    et qui envoie le KeyCode pour chaque chiffre correpsondant.
    [Arguments]     ${mot}
    Supprimer Un Nombre Au Clavier
    ${mot}=    Convert To Upper Case    ${mot}
    ${Lettres_a_taper}=    Split String To Characters    ${mot}
    FOR    ${lettre}    IN    @{Lettres_a_taper}
        AppiumLibrary.Press Keycode    ${KEYCODES}[${lettre}]
    END

Supprimer Un Nombre Au Clavier
    [Documentation]    Mot clé qui efface ce que contient la zone de texte
    ...    qui boucle sur chaque chiffre (et point) du nombre passé en argument
    ...    et qui envoie le KeyCode pour chaque chiffre correpsondant.
    AppiumLibrary.Press Keycode     ${KEYCODES}[del]    ${KEYCODES}[ctrl]
    AppiumLibrary.Press Keycode     ${KEYCODES}[foward_del]    ${KEYCODES}[ctrl]


Lire La Quantite Restante A Preparer
    [Documentation]     Ce mot clé prend la quantié à préparer 
    ...                 qui est un texte au format QtyRestante/QtyTotale
    ...                 et renvoie la quantité restante à préparer : QtyRestante     
    [Arguments]  ${Quantite}
    ${QtyRestante}=    Split String    ${Quantite}    /
    RETURN    ${QtyRestante}[0]

Lire Les Variables Du Tests Et Demarrer L Application
    Lire Les Variables De Tests
    Demarrer L Application Et Se Connecter Au Dossier    ${DOSSIER}

Lire Les Variables De Tests
    [Documentation]    Lit et met en place les variables
    Lire Les Variables D Environnement
  	Lire Les Jeux De Donnees

Lire Les Jeux De Donnees
    [Documentation]    Ce mot clé lit les valeurs des jeux de données si la demnade 
    ...                d'exécution vient de Squash sinon ce sont les valeurs par défaut 
    ...                qui sont paramétées. 
	${module}=           Get Param           DS_module             Picking Mono Empl   # Preparation   # Picking Multi Empl# 
	${document}=         Get Param           DS_document           PL00013  # PL000002
    ${articles}=         Get Param           DS_articles           BAOR01    #0012;0013;0015
    ${lot}=              Get Param           DS_lots               L947652;231;L741852
    ${poids}=            Get Param           DS_poids              34.5
    ${modeExpedition}=   Get Param           DS_modeExpedition     TNT
	Set Test Variable    ${module}           ${module}
	Set Test Variable    ${document}         ${document}
	Set Test Variable    ${lot}              ${lot}
	Set Test Variable    ${articles}         ${articles}
	Set Test Variable    ${poids}            ${poids}
	Set Test Variable    ${modeExpedition}   ${modeExpedition}

Lire Les Variables D Environnement
    [Documentation]    Lecture des variables d'environnement et écrasmeent des 
    ...    variables pa défaut.   
 	${platformVersion}=    Get Environment Variable    ANDROIDVERSION	9.0     # 10.0    # 9.0    # 12.0    # 
	${app}=                Get Environment Variable    APP              D:${/}SATELIX${/}app${/}Logistique-demo-release-1.0.34 141.apk
	${appPackage}=         Get Environment Variable    APPPACKAGE	    fr.satelix.logistique    #fr.satelix.logistique
	${appActivity}=        Get Environment Variable    APPACTIVTY	    fr.satelix.logistique.activities.MainActivity
	# ${appActivity}=        Get Environment Variable    APPACTIVTY	    fr.satelix.logistique.activities.dossiers.DossierActivity
	# ${appActivity}=        Get Environment Variable    APPACTIVTY	    fr.satelix.logistique.activities.identification.IdentificationActivity
	${deviceUdid}=         Get Environment Variable    UDID	            42005819e4569431     #    emulator-5558    #    # emulator-5556    # 
	${dossier}=            Get Environment Variable    DOSSIER	        LogistiqueV2Test   #      #DemoSatelix # LogistiqueV2Test
	Set Test Variable      ${platformVersion}    ${platformVersion}
	Set Test Variable      ${app}                ${app}	
	Set Test Variable      ${appPackage}         ${appPackage}
	Set Test Variable      ${appActivity}        ${appActivity}
	Set Test Variable      ${deviceUdid}         ${deviceUdid} 
	Set Test Variable      ${dossier}            ${dossier} 

Scanner Un Code
    [Documentation]    Ce mot clé simule un scanner en appelant l'intent fr.satelix.logistique.scan
    ...    prévu à cet effet.
    [Arguments]    ${text}
    Run    adb shell am broadcast -a fr.satelix.logistique.scan --es com.motorolasolutions.emdk.datawedge.data_string ${text}

Choisir LA Valeur Dans La Liste
    [Arguments]    ${identifiantListe}    ${valeurAchoisir}
    FOR    ${counter}    IN RANGE    1    10
        ${valeurLue}    AppiumLibrary.Get Text    ${identifiantListe}
        Log To Console  ${valeurLue}
        Return From Keyword If    "${valeurLue}" == "${valeurAchoisir}"    ${True}
        AppiumLibrary.Click Element    ${identifiantListe}
        AppiumLibrary.Press Keycode    ${KEYCODES}[down]    ${KEYCODES}[alt]   #KEYCODE_DPAD_DOWN    META_ALT_MASK
        Repeat Keyword    ${counter}        AppiumLibrary.Press Keycode    ${KEYCODES}[down]    #KEYCODE_DPAD_DOWN
        Press ENTER
    END
    Fail    La valeur cherchée n'a pas été trouvée dans la liste


Appuyer sur la flèche retour
    AppiumLibrary.Go Back


Mettre date du jour
    Wait Until Element Is Visible    ${date}
    Click Element    ${date}
    Appuyer sur la flèche retour


Mettre date du lendemain
    Wait Until Element Is Visible    ${date}
    Click Element    ${date}
    Sleep    1s
    Wait Until Element Is Visible    ${edit}
    Click Element    ${edit}
    Sleep    1s
    ${current_date}    Get Current Date
    ${tomorrow_date}    Add Time To Date    ${current_date}    1 days
    ${formatted_date}    Convert Date   ${tomorrow_date}    result_format=%d/%m/%Y
    Taper Un Mot Au Clavier    ${formatted_date}
    Sleep    1s
    Press ENTER
    Sleep    1s
    Appuyer sur ok
    
LeDernierTestEstIlTermine
    [Documentation]     Cette fonction sert à supprimer les actions effectués lors du test du dernier module s'il n'a pas réussi à aller jusqu'au bout
    ${ispresent}=    Run Keyword And Return Status    Wait Until Page Contains    OUI    timeout=15
    IF    ${ispresent}    
        ispresent
    END

AnotherBack
    ${isneeded}=    Run Keyword And Return Status    Wait Until Element Is Visible     //android.widget.ImageButton[@content-desc="Liste des articles"]    timeout=5
    IF     ${isneeded}
        Sleep    2s
        Go Back
        Sleep    2s
    END

EstASupprimer
    [Documentation]    Supprime les actions faites au dernier module
    ${ispresent}=     Run Keyword And Return Status    Wait Until Page Contains    SUPPRIMER    timeout=5
    IF    ${ispresent}
        Click Text    SUPPRIMER
        Wait Until Page Contains    CONFIRMER
        Click Text    CONFIRMER
    END
ispresent
    Click Text    OUI
    Sleep    4s
    Go Back
    Sleep    4s
    AnotherBack
    Sleep    4s
    EstASupprimer
    Sleep    4s
    Scroll Vers Element    ${modulehaut}    haut

Choisir L Emplacement
    [Documentation]    Choisit l'emplacement (element) dans la liste DEJA ouverte
    [Arguments]    ${emplacement}
    Wait Until Page Contains Element    ${emplacement}
    Click Element    ${emplacement}   




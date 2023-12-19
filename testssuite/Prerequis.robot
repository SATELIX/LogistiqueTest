*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem


Resource    ../resources/prerequis.resource


Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***

*** Keywords ***

*** Test Cases ***
PrerequisOld
    #Dupliquer le scénario tests models 
    #Se connecter à partir du bureau à distance sur le serveur "SRV-SAT-TEST"
    #Contrôler qu'on est bien sur la bonne branche
    #Démarrer le travail SQL "SxRestaurationBasesTest" via Sql Management Studio --> SQL Server Agent -> Travaux
    Remove Application  ${appPackage}
    Close Application
    Open Application    ${remote_url}
    Install App    ${OLD_APP_PATH}    ${appPackage}
    DemarrerLAncienneVersion
    FaireSynchroComplete
    #Accès au BO pour scan du QR Code(si besoin)
    #La base Sage sur laquelle les tests sont fait se nomme "Bijou_Test"

PrerequisNew
    #Se connecter à partir du bureau à distance sur le serveur "SRV-SAT-TEST"
    #Contrôler qu'on est bien sur la bonne branche
    #Démarrer le travail SQL "SxRestaurationBasesTest" via Sql Management Studio --> SQL Server Agent -> Travaux
    Remove Application  ${appPackage}
    Close Application
    Open Application    ${remote_url}
    Install App    ${NEW_APP_PATH}    ${appPackage}
    DemarrerLaNouvelleVersion
    FaireSynchroComplete
    #Accès au BO pour scan du QR Code(si besoin)
    #La base Sage sur laquelle les tests sont fait se nomme "Bijou_Test"

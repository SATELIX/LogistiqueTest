*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem



Resource    ../resources/prerequis.resource


Suite Setup     Set Log Level    TRACE
# Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
# Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***


*** Test Cases ***
PrerequisOld
    #Dupliquer le tableau "Scénarios Tests Models"
    #Se connecter à partir du bureau à distance sur le serveur "SRV-SAT-TEST"
    #Contrôler qu'on est bien sur la bonne branche
    #Démarrer le travail SQL "SxRestaurationBasesTest" via Sql Management Studio --> SQL Server Agent -> Travaux
    DemarrerLAncienneVersion
    SAuthentifier
    FaireSynchroComplete
    #Accès au BO pour scan du QR Code(si besoin)

PrerequisNew
    #Dupliquer le tableau "Scénarios Tests Models"
    #Se connecter à partir du bureau à distance sur le serveur "SRV-SAT-TEST"
    #Contrôler qu'on est bien sur la bonne branche
    #Démarrer le travail SQL "SxRestaurationBasesTest" via Sql Management Studio --> SQL Server Agent -> Travaux
    DemarrerLaNouvelleVersion
    SAuthentifier
    FaireSynchroComplete
    #Accès au BO pour scan du QR Code(si besoin)
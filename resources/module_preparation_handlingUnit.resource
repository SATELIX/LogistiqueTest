*** Settings ***

Library    AppiumLibrary

*** Variables ***
${PASTILLE_PLUS}                   id=fab_ajout_colis

*** Keywords ***
Ajoute Un Colis
    AppiumLibrary.Wait Until Page Contains Element    ${PASTILLE_PLUS}
    AppiumLibrary.Click Element                       ${PASTILLE_PLUS}
    
Rester appuyé sur l unite logistique
    [Arguments]    ${nomHandlingUnit}
    AppiumLibrary.Wait Until Page Contains Element    //*[contains(text(),${nomHandlingUnit})]
    AppiumLibrary.Long Press                          //*[contains(text(),${nomHandlingUnit})]    3000

Sélectionner Un type d Unite Logistique Et valider
    [Arguments]    ${typeUL}
    AppiumLibrary.Wait Until Page Contains Element    //*[@id=android:id/text1 and contains(text(),${typeUL})]
    AppiumLibrary.Click Element                       //*[@id=android:id/text1 and contains(text(),${typeUL})]
    AppiumLibrary.Click Element                       id=android:id/button1

    
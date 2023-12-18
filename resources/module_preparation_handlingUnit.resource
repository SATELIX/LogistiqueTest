*** Settings ***

Library    AppiumLibrary
Library    String

*** Variables ***
${PASTILLE_PLUS}                   id=fab_ajout_colis

*** Keywords ***
Appuyer sur "+"
    Ajouter Un Colis

Ajouter Un Colis
    AppiumLibrary.Wait Until Page Contains Element    ${PASTILLE_PLUS}
    AppiumLibrary.Click Element                       ${PASTILLE_PLUS}
    
Rester appuyer sur l unite logistique
    [Arguments]    ${nomHandlingUnit}
    ${myUL}=    Set Variable    //android.widget.TextView[@text="${nomHandlingUnit}"]
    AppiumLibrary.Text Should Be Visible    ${nomHandlingUnit}
    AppiumLibrary.Wait Until Page Contains Element        ${myUL}
    ${position}=    AppiumLibrary.Get Element Location    ${myUL}
    ${position}=    Create List    ${position}[x]    ${position}[y]
    AppiumLibrary.Tap With Positions                      2000        ${position}

Sélectionner Un type d Unite Logistique Et valider
    [Arguments]    ${typeUL}
    AppiumLibrary.Wait Until Page Contains    ${typeUL}
    AppiumLibrary.Click Text                  ${typeUL}
    AppiumLibrary.Click Element               id=android:id/button1
    ${UL_affichee}    Convert To Upper Case    ${typeUL}
    

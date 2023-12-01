*** Settings ***
Library     RequestsLibrary


*** Test Cases ***
Test
    ${before}=    Récupération personnage    1
    Log To Console    ${before}[height]
    ${after}=    Récupération personnage    2
    Log To Console    ${after}[height]
    Should Be Equal As Integers    ${before}[height]    ${after}[height]

*** Keywords ***
Récupération personnage
    [Arguments]    ${id}
    ${response}=    GET    https://swapi.dev/api/people/${id}
    RETURN    ${response.json()}
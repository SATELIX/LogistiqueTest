*** Settings ***
Library     RequestsLibrary


*** Test Cases ***
# Test
#    ${before}=    Récupération personnage    1
#    Log To Console    ${before}[height]
#    ${after}=    Récupération personnage    2
#    Log To Console    ${after}[height]
#    Should Be Equal As Integers    ${before}[height]    ${after}[height]

Test APK
    ${test}=    Récupération fichier
    Log To Console    ${test}


*** Keywords ***
Récupération personnage
    [Arguments]    ${id}
    ${response}=    GET    https://swapi.dev/api/people/${id}
    RETURN    ${response.json()}

Récupération fichier
    Create Session    google_drive    https://drive.google.com
    ${response}=    Get Request
    ...    google_drive
    ...    "https://drive.google.com/u/0/uc?id=1PqEKNnbmgFs--mxQnlkAn27YOlg_qjvl&export=download"
    Should Be Equal As Strings    ${response.status_code}    200
    RETURN    ${response}

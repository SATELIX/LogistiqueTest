*** Settings ***
Documentation    contient les mots clés gérant les actions sur la page d'accueil/home
...              où se touve la liste des modules disponibles.

Library    AppiumLibrary

*** Variables ***
${module_preparation}    //

*** Keywords ***
Choisir Le Module Dans La Liste Des Modules
    [Documentation]  Clique sur le module passé en paramètre
    [Arguments]      ${module_name}
    AppiumLibrary.Wait Until Element Is Visible    ${module_name}
    ...    6s
    ...    La liste des modules ne contient pas le module demandé ${module_name}  
    AppiumLibrary.Click Element    ${module_name}
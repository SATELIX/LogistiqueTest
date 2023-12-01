*** Settings ***
Documentation    ce fichier contient les mots clé nécessaires pour accéder au module
...   préparation de livraison


Library     AppiumLibrary
Resource    utils.resource

*** Variables ***


*** Keywords ***
Dans Le Module Préparation De Livraison Le Statut de La péparation doit changer
    [Arguments]    ${ref_preparation}    ${nouveau_statut}
    [Documentation]    Ce mot clé vérifie le nouveau statut d une preparation       
    Wait Until Page Contains    ${document}   15s 
    ...    Le document ${document} n'apparait pas dans la liste des documents à peparer
    AppiumLibrary.Click Text    ${document}
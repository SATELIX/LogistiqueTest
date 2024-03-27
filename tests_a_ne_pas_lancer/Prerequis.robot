*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem
Library    Collections
Library    JSONLibrary

Resource    ../resources/prerequis.resource


Suite Setup     Set Log Level    TRACE




*** Test Cases ***
Prerequis
    PrerequisNew
    # PrerequisOld
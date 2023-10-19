*** Settings ***
Documentation
...
...    \n  remarque sur les ID existants qui comporte le nom du package
...    \n quand on est en démo, package fr.satelix.logistique.demo
...    \n ce qui complique la réutilisation des scripts pour de nouvelles
...    versions (prod, démo...)
...    
...    \n\nLosque les éléments sont natifs (ex: clavier ou dropDown list) il n'est pas possible d'utiliser les
...    Méthodes Appium standard "click element" Il faut passe par les KEYCODES et éventuellement capture d'écran 
...    

Library    Dialogs
Library    AppiumLibrary
Library    squash_tf.TFParamService
Library    OperatingSystem
Resource   ${CURDIR}/../resources/utils.resource
Resource   ${CURDIR}/../resources/page_accueil.resource
Resource   ${CURDIR}/../resources/module_preparation.resource
Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource

Suite Setup    Set Log Level    TRACE
Test Setup     Lire Les Variables Du Tests Et Demarrer L Application

*** Variables ***

${module_preparation}    xpath=//androidx.cardview.widget.CardView[@content-desc="Select the module Prépa."]

*** Test Cases ***
Cas Nominal De Preparation De Commande
	Choisir le module dans la liste des modules    ${module_preparation}
	Choisir La Commande A Preparer Dans La Liste Des Commandes     ${document}
	Preparer Les Articles De La Commande
	Cliquer sur le bouton de finalisation
	Entrer Le Poids Du Colis     ${poids}  
	Prendre Une Photo Du Colis
	Cliquer Sur Le Bouton De Cloture
	Laisser Le Mode D Envoi Par Defaut et Transférer
	# Choisir le mode d'expédition ${modeExpedition}
	# Cliquer Sur Le Bouton De Transfert
	Valider La Préparation


*** Keywords ***
Lire Les Variables Du Tests Et Demarrer L Application
    Lire Les Variables De Tests
    Demarrer L Application Et Se Connecter Au Dossier    ${DOSSIER}

Lire Les Variables De Tests
    [Documentation]    TO DO
    Lire Les Variables D Environnement
	Lire Les Jeux De Donnees

Lire Les Jeux De Donnees
    [Documentation]    TODO 
	${module}=         Get Param           DS_module           Preparation
	${document}=         Get Param           DS_document           PL000002
    ${poids}=            Get Param           DS_poids              34.5
    ${modeExpedition}=   Get Param           DS_modeExpedition     TNT
	Set Test Variable    ${document}         ${document}
	Set Test Variable    ${poids}            ${poids}
	Set Test Variable    ${modeExpedition}   ${modeExpedition}

Lire Les Variables D Environnement
    [Documentation]    TODO 
	${platformVersion}=    Get Environment Variable    ANDROIDVERSION	7.0
	${app}=                Get Environment Variable    APP
	${appPackage}=         Get Environment Variable    APPPACKAGE	fr.satelix.logistique
	${appActivity}=        Get Environment Variable    APPACTIVTY	fr.satelix.logistique.activities.MainActivity
	${deviceUdid}=         Get Environment Variable    DEVICEUDID	04157df438b0b226
	Set Test Variable    ${platformVersion}    ${platformVersion}
	Set Test Variable    ${app}                ${app}	
	Set Test Variable    ${appPackage}         ${appPackage}
	Set Test Variable    ${appActivity}        ${appActivity}
	Set Test Variable    ${deviceUdid}         ${deviceUdid}
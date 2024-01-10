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

Library    AppiumLibrary
Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   AppiumLibrary.Terminate Application    ${appPackage}
Resource    ../resources/page_accueil.resource
Resource    ../resources/module_preparation.resource

*** Variables ***

*** Test Cases ***
Cas Nominal De Preparation De Commande
    [Tags]    sans_codebarre
	Choisir Le Module Dans La Liste Des Modules    ${module}
	Choisir Le Document A Preparer Dans La Liste Des Documents     ${document}
	Preparer Les Articles Du document
	Cliquer sur le bouton de finalisation
	Entrer Le Poids Du Colis     ${poids}  
	Prendre Une Photo Du Colis
	Cliquer Sur Le Bouton De Cloture
	Laisser Le Mode D Envoi Par Defaut et Transférer
	# Choisir le mode d'expédition ${modeExpedition}
	# Cliquer Sur Le Bouton De Transfert
	Valider La Préparation

Cas Nominal De Preparation De Commande Avec Lecteur Code-Barres
    [Tags]    avec_codebarre
	Choisir Le Module Dans La Liste Des Modules    ${module}
	Choisir Le Document A Preparer Dans La Liste Des Documents    ${document}
	Preparer Les Articles Du Document Avec Le Lecteur CodeBarre
	Cliquer sur le bouton de finalisation
	Entrer Le Poids Du Colis     ${poids}  
	Prendre Une Photo Du Colis
	Cliquer Sur Le Bouton De Cloture
	Laisser Le Mode D Envoi Par Defaut et Transférer
	# Choisir le mode d'expédition ${modeExpedition}
	# Cliquer Sur Le Bouton De Transfert
	Valider La Préparation

*** Settings ***
Documentation
...
...    \n  remarque sur les ID existants qui comporte le nom du package
...    \n quand on est en démo, package fr.satelix.logistique.demo
...    \n ce qui complique la réutilisation des scripts pour de nouvelles
...    versions (prod, démo...)
...    

Library    Dialogs
Library    AppiumLibrary
# Resource   ${CURDIR}/../resources/page_accueil.resource
Resource   ${CURDIR}/../resources/module_preparation.resource
Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource

Suite Setup    Set Log Level    TRACE
Test Setup     Lire Les Variables Du Tests Et Demarrer L Application

Suite Teardown    AppiumLibrary.Close Application

*** Variables ***

${module}
${document}              PL000002
${poids}                 34
${modeExpedition}        

*** Test Cases ***
Ajout d une quantité supérieure à celle nécessaire pour un article dans une préparation
	Choisir Le Module Dans La Liste Des Modules    ${module}
	Choisir Le Document A Preparer Dans La Liste Des Documents     ${document}
	${quantite}=    Lire La Quantite Demandee Pour Le Premier Article
	Choisir Le Premier Article De La Liste A Preparer
	Afficher Les Lots Disponibles
	Choisir un numéro de lot dont le stock est supérieur ou égal à la quantité    ${quantite}
	Entrer Une Quantité Supérieure A Celle Demandee Et Valider    ${quantite}    1
	La pop up "Larger quantity" s'affiche
	Valider Le Message D Erreur De La Popup
	Entrer la quantité complète à préparer et valider    ${quantite}
	Afficher Les Articles Prepares
	module_preparation_listearticles.Choisir Le Premier Article De La Liste Des Articles Prepares
	${restant_a_peparer}=    Lire La Quantite Restante A Preparer Dans Le Detail De L Article
	Entrer Une Quantité Supérieure A Celle Demandee Et Valider    ${restant_a_peparer}    1
	La pop up "Larger quantity" s'affiche
	# prendre une capture d'écan
	AppiumLibrary.Capture Page Screenshot





    

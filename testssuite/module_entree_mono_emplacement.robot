*** Settings ***
Documentation       Test du module Entrée Mono Emplacement
...

Library             AppiumLibrary
Library             Process
Resource            ${CURDIR}/../resources/shared.resource
Resource    ../resources/SatelixLogistique.resource
Resource    ../resources/module_preparation_detailArticle.resource
Resource    ../resources/module_preparation.resource


*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity


*** Test Cases ***
Test De L Application
    Demarrer Une Application    fr.satelix.logistique
    Sur le terminal, sélectionner le module    Entrée mono empl
    Sélection dépot destination    Bijou SA
    Recherche article
    Sélectionner l article    BAAR01
    Hide Keyboard
    Appuyer sur la flèche retour
    Saisir code article manuellement    BA
    Pas d'association code barre
    Sélectionner l article    BAAR01
    Entrer une quantité et valider    2
    Valider quantité article
    Vider barre de recherche    BA
    Recherche article
    Scroll Vers Element 
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
    ...    bas
    Sélection article element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
    Affiche Element
    ...    //android.widget.EditText[@resource-id="fr.satelix.logistique:id/dropdown_list" and @text="Numéro de lot"]
    Scanner code barre    LINGOR18\;LOT-TEST2
    Entrer une quantité et valider    2
    Valider quantité article
    Recherche article
    Scroll Vers Element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
    ...    haut
    Sélection article element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
    Sélection gamme    Emeraude
    Entrer une quantité et valider    2
    Valider quantité article
    Attendre
    Scanner code barre    EM040
    Hide Keyboard
    Affiche Element    //android.widget.TextView[@text="EM040"]
    Appuyer sur la flèche retour
    Recherche article
    Scroll Vers Element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"]/android.view.ViewGroup
    ...    haut
    Sélection article element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"]/android.view.ViewGroup
    Sélection gamme    34
    Sélection sous gamme    Classique
    Hide Keyboard
    Appuyer sur la flèche retour
    Attendre
    Scanner code barre    38141025
    Entrer une quantité et valider    2
    Valider quantité article
    Finaliser
    Valider

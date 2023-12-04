*** Settings ***
Documentation       Test du module Entrée Mono Emplacement
...

Library             AppiumLibrary
Library             Process
Resource            ${CURDIR}/../resources/shared.resource
Resource    ../resources/SatelixLogistique.resource


*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity


*** Test Cases ***
Test De L Application
    Demarrer Une Application    fr.satelix.logistique
    Sélectionner le module    Entrée mono empl
    Sélection dépot destination    Bijou SA
    Recherche article
    Sélection article texte    BAAR01
    Fermer le clavier
    Retour arrière
    Saisir code article manuellement    BA
    Pas d'association code barre
    Sélection article texte    BAAR01
    Saisir quantité article    2
    Valider quantité article
    Vider recherche article
    Recherche article
    Scroll Vers Element 
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
    ...    bas
    Sélection article element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
    Affiche Element
    ...    //android.widget.EditText[@resource-id="fr.satelix.logistique:id/dropdown_list" and @text="Numéro de lot"]
    Scanner code barre    LINGOR18\;LOT-TEST2
    Saisir quantité article    2
    Valider quantité article
    Recherche article
    Scroll Vers Element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
    ...    haut
    Sélection article element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
    Sélection gamme    Emeraude
    Saisir quantité article    2
    Valider quantité article
    Attendre
    Scanner code barre    EM040
    Fermer le clavier
    Affiche Element    //android.widget.TextView[@text="EM040"]
    Retour arrière
    Recherche article
    Scroll Vers Element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"]/android.view.ViewGroup
    ...    haut
    Sélection article element
    ...    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"]/android.view.ViewGroup
    Sélection gamme    34
    Sélection sous gamme    Classique
    Fermer le clavier
    Retour arrière
    Attendre
    Scanner code barre    38141025
    Saisir quantité article    2
    Valider quantité article
    Valider module

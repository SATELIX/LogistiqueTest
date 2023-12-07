*** Settings ***
Documentation       Test du module Entrée Mono Emplacement
...

Library             AppiumLibrary
Library             Process
Resource    ../resources/SatelixLogistique.resource
Resource    ../resources/module_preparation_detailArticle.resource
Resource    ../resources/module_preparation.resource
Resource    ../resources/module_preparation_listearticles.resource


*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity
${depot}     xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}   //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${LINGOR18}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
${ListeLot}    //android.widget.EditText[@resource-id="fr.satelix.logistique:id/dropdown_list" and @text="Numéro de lot"]
${BAAR01}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
${EM040}    //android.widget.TextView[@text="EM040"]
${CHAAR/VAR}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"]/android.view.ViewGroup

*** Test Cases ***
Test De L Application
    Sur le terminal, sélectionner le module                        Entrée mono empl
    Choisir au menu déroulant                                      ${depot}    ${Bijou SA}
    Afficher Les Articles Disponibles
    Sélectionner l article                                         BAAR01
    Hide Keyboard
    Appuyer sur la flèche retour
    Saisir l Article a la Main                                     BA
    Pas d'association code barre
    Sélectionner l article                                         BAAR01
    Entrer une quantité et valider                                 2
    Vider barre de recherche 
    Afficher Les Articles Disponibles
    Scroll Vers Element                                            ${LINGOR18}    bas
    Sélection article element                                      ${LINGOR18}
    Affiche Element                                                ${ListeLot}
    Scanner code barre                                             LINGOR18\;LOT-TEST2
    Entrer une quantité et valider                                 2
    Afficher Les Articles Disponibles
    Scroll Vers Element                                            ${BAAR01}  haut
    Sélection article element                                      ${BAAR01}
    Sélection gamme                                                Emeraude
    Entrer une quantité et valider                                 2
    Attendre
    Scanner code barre                                             EM040
    Hide Keyboard
    Affiche Element                                                ${EM040}
    Appuyer sur la flèche retour
    Afficher Les Articles Disponibles
    Scroll Vers Element                                            ${CHAAR/VAR}    haut
    Sélection article element                                      ${CHAAR/VAR}
    Sélection gamme                                                34
    Sélection sous gamme                                           Classique
    Hide Keyboard
    Appuyer sur la flèche retour
    Attendre
    Scanner code barre                                             38141025            #Scan article avec gammes associés
    Entrer une quantité et valider                                 2
    Finaliser
    Valider

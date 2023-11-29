*** Settings ***
Documentation       ce test pour executer l'application
...                 ldkjdldjldkjd
...
 
Library    AppiumLibrary
Library    Process
 
Resource    ../resources/page_accueil.resource
Resource    ../resources/SatelixLogistique.resource
Resource    ../resources/module_preparation_listearticles.resource
 
*** Variables ***
${automationName}       UIAutomator2
${platformName}         Android
${app}                  ${EMPTY}
${appPackage}           fr.satelix.logistique
${appActivity}          fr.satelix.logistique.activities.MainActivity
${liste_articles}       //android.widget.ImageButton[@content-desc="Liste des articles"]
${module_sortie_mono_empl}    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock mono empl"]
${CHAOR42}               //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaînes mailles fines"]/android.view.ViewGroup
 
*** Test Cases ***
Test De L Application
    Demarrer L Application
    Sur le terminal, sélectionner le module    Sortie Stock mono empl
    #Swipe Down    ${module_sortie_mono_empl}
    #Sélectionner le module Sortie mono empl
    #Affiche sélection dépot d origine la date et la reference
    Sélectionner le dépôt origine Bijou SA 
    Sélectionner référence doc    test
    Valider les informations
    Afficher Liste des articles    ${liste_articles}
    Choisir Article    ${CHAOR42}   
    Entrer une quantité et valider    2
    Saisir l Article a la Main    LINGOR18    
    Saisir le Numéro de lot    Lot-10
    Sélectionner le Lot avec DLC et FAB     
    Entrer une quantité et valider    1      
    Scanner code barre    LINGOR18\;LOT-AAA    #le lot n'existant pas, une erreur de validation doit s'afficher
    Dialog Cliquer Ok
    Back      #<-- refacto testée jusqu'ici
    Saisir l Article a la Main    BAOR01
    Sélectionner la Gamme    Rubis
    Valider Quantite    1
    Scanner code barre    21731003
    Valider Quantite    1
    Saisir l Article a la Main    CHAAR/VAR
    Sélectionner la Gamme    34 cm
    Sélectionner la Gamme    Forçat
    Valider Quantite    1
    Scanner code barre    38141025
    Valider Quantite    2
    Finaliser
    Valider

    


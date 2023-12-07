*** Settings ***
Documentation       Test du Scenario de Sortie Stock mono emplacement
 
Library    AppiumLibrary
Library    Process
 
Resource    ../resources/page_accueil.resource
Resource    ../resources/SatelixLogistique.resource
Resource    ../resources/module_preparation_listearticles.resource
Resource    ../resources/shared.resource
Resource    retour_fournisseur_monoempl.robot
 
*** Variables ***
${app}                  ${EMPTY}
${liste_articles}       //android.widget.ImageButton[@content-desc="Liste des articles"]
${module_sortie_mono_empl}    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock mono empl"]
${CHAOR42}               //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaînes mailles fines"]/android.view.ViewGroup
 
*** Test Cases ***
Test De L Application
    Demarrer L Application
    Sur le terminal, sélectionner le module    Sortie Stock mono empl
    Sélectionner le dépôt origine Bijou SA
    Sélectionner référence doc    test
    Valider les informations
    Afficher Liste des articles    ${liste_articles}
    Choisir l Article dans une Liste    ${CHAOR42}   
    Entrer une quantité et valider    2
    Saisir l Article a la Main    LINGOR18    
    Saisir le Numéro de lot    Lot-10
    Sélectionner le Lot avec DLC et FAB     
    Entrer une quantité et valider    1      
    Scanner code barre    LINGOR18\;LOT-AAA    #le lot n'existant pas, une erreur de validation doit s'afficher
    Appuyer sur ok
    Appuyer sur la flèche retour   
    Saisir l Article a la Main    BAOR01
    Sélectionner la Gamme    Rubis
    Entrer une quantité et valider    1
    Scanner code barre    21731003
    Entrer une quantité et valider    1
    Saisir l Article a la Main    CHAAR/VAR    #BUG sur l'apk de manière aléatoire la quantité en stock n'est pas récupérée (APK 1.0.44)
    Sélectionner la Gamme    34 cm
    Sélectionner la Gamme    Forçat
    Entrer une quantité et valider   1
    Scanner code barre    38141025
    Entrer une quantité et valider    2
    Finaliser
    Valider
*** Settings ***
Documentation       Test du module Entrée Mono Emplacement

Resource    ../resources/page_accueil.resource
Resource    ../resources/module_preparation.resource

Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}

*** Variables ***
${liste_articles}       //android.widget.ImageButton[@content-desc="Liste des articles"]
${module_sortie_mono_empl}    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Sortie Stock mono empl"]
${CHAOR42}               //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaînes mailles fines"]/android.view.ViewGroup


*** Test Cases ***
SortieStockMonoEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                        Sortie Stock mono empl
    Choisir LA Valeur Dans La Liste                                id=dropdown_list    Bijou SA
    Sélectionner référence doc                                     test
    Valider les informations
    Afficher Les Articles Disponibles
    Scroll Vers Element                                            ${CHAOR42}    bas
    Sélectionner l article                                         CHAOR42
    Entrer une quantité et valider                                 2
    Saisir l Article a la Main                                     LINGOR18    
    Saisir le Numéro de lot                                        Lot-10
    Sélectionner le Lot avec DLC et FAB     
    Entrer une quantité et valider                                 1      
    Sleep                                                          2s
    # Scanner code barre                                             LINGOR18\\;LOT-AAA    #le lot n'existant pas, une erreur de validation doit s'afficher
    # Sleep                                                          2s
    # Appuyer sur ok
    Sleep                                                          2s
    Saisir l Article a la Main                                     BAOR01
    Sélection gamme                                                Rubis
    Entrer une quantité et valider                                 1
    Sleep                                                          2s
    Scanner code barre                                             21731003              #scan de l'article avec la gamme associée
    Entrer une quantité et valider                                 1
    Saisir l Article a la Main                                     CHAAR/VAR             
    Sélection gamme                                                34
    Sélection gamme                                                Forçat
    Entrer une quantité et valider                                 1
    Sleep                                                          2s
    Scanner code barre                                             38141025              #scan de l'article avec la gamme associée
    Entrer une quantité et valider                                 2
    Finaliser
    Valider
    Sleep                                                          5s
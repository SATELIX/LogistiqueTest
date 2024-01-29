*** Settings ***
Documentation       Test du module Entrée Mono Emplacement

Resource    ../resources/page_accueil.resource
Resource    ../resources/module_preparation.resource

Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}

*** Variables ***

${LINGOR18}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
${ListeLot}    //android.widget.EditText[@resource-id="fr.satelix.logistique:id/dropdown_list" and @text="Numéro de lot"]
${BAOR01}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
${CHAAR/VAR}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Chaîne Argent maille et longueur variables"]/android.view.ViewGroup

*** Test Cases ***
EntreeMonoEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                        Entrée mono empl
    Sleep                                                          5s
    Choisir LA Valeur Dans La Liste                                id=dropdown_list   Bijou SA
    Valider les informations
    Afficher Les Articles Disponibles
    Sélectionner l article                                         BAAR01
    Hide Keyboard
    Sleep                                                          2s
    Appuyer sur la flèche retour
    Sleep                                                          2s
    Appuyer sur la flèche retour
    Saisir l Article a la Main                                     BA
    Pas d'association code barre
    Sélectionner l article                                         BAAR01
    Entrer une quantité et valider                                 2
    Vider barre de recherche
    Afficher Les Articles Disponibles 
    Scroll Vers Element                                            ${LINGOR18}    bas    # start était commenté
    Sélection article element                                      ${LINGOR18}
    Affiche Element                                                ${ListeLot}                #pb bdd dans certains modules
    Scanner code barre                                             LINGOR18\;LOT-TEST2
    Entrer une quantité et valider                                 2                    # end était commenté
    Afficher Les Articles Disponibles
    Scroll Vers Element                                            ${BAOR01}  haut
    Sélection article element                                      ${BAOR01}
    Sélection gamme                                                Emeraude
    Entrer une quantité et valider                                 2
    Attendre
    Scanner code barre                                             EM040
    Sleep                                                          2s
    Hide Keyboard
    Appuyer sur la flèche retour
    Afficher Les Articles Disponibles
    Scroll Vers Element                                            ${CHAAR/VAR}    haut
    Sélection article element                                      ${CHAAR/VAR}
    Sélection gamme                                                34
    Sélection sous gamme                                           Classique
    Sleep                                                          2s
    Hide Keyboard
    Appuyer sur la flèche retour
    Attendre
    Scanner code barre                                             38141025            #Scan article avec gammes associés
    Entrer une quantité et valider                                 2
    Finaliser
    Valider
    Sleep                                                          5s

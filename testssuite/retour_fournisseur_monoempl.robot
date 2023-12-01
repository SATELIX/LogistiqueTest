*** Settings ***
Documentation       ce test pour executer l'application
...                 
...
 
Library    AppiumLibrary
Library    Process
Resource    ../resources/SatelixLogistique.resource
 
*** Variables ***
${module_retour_fournisseur_mono_empl}    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/item_nom_module" and @text="Retour fournisseur mono empl"]
${button_valider}   fr.satelix.logistique:id/fab_valider
${BAAR01}           BAAR01 Bague Argent
${Liste Articles}   //android.widget.ImageButton[@content-desc="Liste des articles"]
#${LOT-TEST2}    (//android.widget.TextView[@resource-id="fr.satelix.logistique:id/tv_intitule_lot_serie"])[4]

*** Test Cases ***
Test De L Application
    Demarrer L Application
    Swipe Down    ${module_retour_fournisseur_mono_empl}
    Sélectionner le module Retour Fournisseur mono empl
    Sélectionner dépot Bijou SA
    Sélectionner le fournisseur BRELO
    Valider la sélection
    Rechercher les articles
    Sélectionner bgar a la Main
    Valider Quantite    3
    Attendre
    Scanner code barre  BAAR01
    Attendre
    Valider Quantite    2
    Scanner code barre    LINGOR18
    Sélectionner lot lingor18
    Valider Quantite    1
    Scanner code barre    LINGOR18
    Sélectionner lot BDF23
    Valider Quantite   2
    Sélectionner EM040 à la Main
    Sélectionner Ecrin de 12
    Valider Quantite    1
    Scanner code barre  EM050
    Valider Quantite    2
    Scanner code barre  EM050/24
    Valider Quantite    1
    Scanner code barre  MODIV01
    Afficher numéros de série et select
    Attendre
    Scanner code barre  MODIV01
    Afficher numéros de série et no select
    Appuyer sur retour
    Appuyer sur retour
    Attendre
    Scanner code barre  EM150  #Affiche un message d'erreur
    Appuyer sur OK
    Validation
    Vider barre de recherche
    Sélectionner BAOR01 à la Main
    Sélectionner gamme Emeraude
    Valider Quantite    4
    Scanner code barre    21731003
    Valider Quantite    5
    Scanner code barre    21731003
    Appuyer sur le crayon
    Modifier la valeur et valider
    Appuyer sur retour
    Selectionner Mettre En Attente
    Swipe Down    ${module_retour_fournisseur_mono_empl}
    Sélectionner le module Retour Fournisseur mono empl
    Confirmer traitement en attente
    Sélectionner chaar/var a la Main
    Sélectionner gamme 42cm
    Sélectionner sous-gamme forcat
    Valider Quantite    2
    Scanner code barre    38141025
    Valider Quantite    8
    Appuyer finaliser
    Valider Retour fournisseur




*** Keywords ***

Attendre
    Sleep    5s



Swipe Down
    [Arguments]    ${element}
    FOR    ${counter}    IN RANGE    0    10
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    timeout=3s
        IF    ${status}    BREAK
        Swipe    0    495    0    250    150
    END



Sélectionner le module Retour Fournisseur mono empl
    Click Text  Retour fournisseur mono empl



Sélectionner dépot Bijou SA
    Click Element    xpath = (//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
    Wait Until Page Contains    text=Bijou SA
    Click Text    Bijou SA  True


Sélectionner le fournisseur BRELO
    Click Element    xpath = (//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
    Wait Until Page Contains    text=BRELO
    Click Text    BRELO

Valider la sélection
    Wait Until Page Contains    VALIDER
    Click Element    ${button_valider}



Rechercher les articles
    Wait until Page Contains  fr.satelix.logistique:id/text_input_end_icon
    Click Element   ${Liste Articles}

    
Sélectionner bgar a la Main
    Wait Until Element Is Visible    //android.widget.EditText[@text="Recherche article"]
    Click Element    //android.widget.EditText[@text="Recherche article"]
    Input Text Into Current Element    BAAR01
    Click Element    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Argent"]/android.view.ViewGroup


Valider Quantite
    [Arguments]    ${quantite}
    Input Text Into Current Element    ${EMPTY}
    Input Text Into Current Element    ${quantite}
    Sleep    5s
    Click Element    fr.satelix.logistique:id/fab_ajouter
    Attendre   

Sélectionner lot lingor18
    Click Element    xpath = //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
    Swipe Down   xpath = //android.view.ViewGroup[@content-desc="Sélectionner le numéro de lot LOT-TEST2"]
    Click Text   LOT-TEST2  True

Sélectionner lot BDF23
    Click Element    xpath = //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
    Swipe Down   xpath = //android.view.ViewGroup[@content-desc="Sélectionner le numéro de lot LOT-BDF9411123"]
    Click Text    LOT-BDF9411123  True


Sélectionner EM040 à la Main
    Wait Until Element Is Visible    //android.widget.EditText[@text="Recherche article"]
    Click Element    //android.widget.EditText[@text="Recherche article"]
    Input Text Into Current Element    EM040
    Wait Until Element Is Visible    //android.widget.ImageButton[@content-desc="Valider cet article"]
    Click Element    //android.widget.ImageButton[@content-desc="Valider cet article"]



Sélectionner Ecrin de 12
    Wait Until Element Is Visible   //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_connexion" and @text="ECRIN DE 12"]
    Click Element  //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_connexion" and @text="ECRIN DE 12"]


Afficher numéros de série et select
    Click Element    xpath = //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
    Wait Until Page Contains Element    xpath = (//android.widget.CheckBox[@resource-id="fr.satelix.logistique:id/iv_item_checkbox"])[1]
    Click Element    xpath = (//android.widget.CheckBox[@resource-id="fr.satelix.logistique:id/iv_item_checkbox"])[1]
    Click Element    //android.widget.Button[@content-desc="Valider les numéros de série"]


Afficher numéros de série et no select
    Click Element    xpath = //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
    Wait Until Element Is Visible    //android.widget.Button[@content-desc="Valider les numéros de série"]
    Click Element    //android.widget.Button[@content-desc="Valider les numéros de série"]



Appuyer sur retour
    Attendre
    Wait Until Element Is Visible   xpath = //android.widget.ImageButton
    Click Element    xpath = //android.widget.ImageButton


Appuyer sur OK
    Click Element    xpath = //android.widget.Button[@resource-id="android:id/button1"]

Validation
    Click Element    //android.widget.EditText[@resource-id="fr.satelix.logistique:id/input_text_recherche"]
    Click Element    //android.widget.ImageButton[@content-desc="Valider cet article"]

Vider barre de recherche
    Wait Until Element Is Visible    //android.widget.EditText[@text="EM150"]
    Click Element    //android.widget.EditText[@text="EM150"]
    Wait Until Element Is Visible    //android.widget.ImageButton[@content-desc="Effacer le texte"]
    Click Element    //android.widget.ImageButton[@content-desc="Effacer le texte"]
    
Sélectionner BAOR01 à la Main
    Wait Until Element Is Visible    //android.widget.EditText[@text="Recherche article"]
    Click Element    //android.widget.EditText[@text="Recherche article"]
    Input Text Into Current Element    BAOR01
    Wait Until Element Is Visible    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
    Click Element    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup


Sélectionner gamme Emeraude
    Wait Until Element Is Visible    //androidx.cardview.widget.CardView[@content-desc="Sélectionner cette gamme Emeraude"]/android.view.ViewGroup
    Click Element    //androidx.cardview.widget.CardView[@content-desc="Sélectionner cette gamme Emeraude"]/android.view.ViewGroup


Appuyer sur le crayon
    Wait Until Element Is Visible    //android.widget.Button[@content-desc="Édition de la quantité validée"]
    Click Element    //android.widget.Button[@content-desc="Édition de la quantité validée"]


Modifier la valeur et valider
    Wait Until Element Is Visible    //android.widget.EditText[@text="9"]
    Click Element    //android.widget.EditText[@text="9"]
    Input Text Into Current Element    7
    CLick Element    //android.widget.ImageButton[@content-desc="Remplacer la quantité saisie pour l'article"]


Selectionner Mettre En Attente
    Wait Until Element Is Visible    //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_quitter_module_mettre_en_attente"]
    Click Element    //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_quitter_module_mettre_en_attente"]


Confirmer traitement en attente
    Wait Until Element Is Visible    //android.widget.Button[@resource-id="android:id/button1"]
    Click Element    //android.widget.Button[@resource-id="android:id/button1"]


Sélectionner chaar/var a la Main
    Wait Until Element Is Visible    //android.widget.EditText[@resource-id="fr.satelix.logistique:id/input_text_recherche"]
    Click Element    //android.widget.EditText[@resource-id="fr.satelix.logistique:id/input_text_recherche"]
    Input Text Into Current Element      CHAAR/VAR
    Click Element    //android.widget.ImageButton[@content-desc="Valider cet article"]


Sélectionner gamme 42cm
    Wait Until Page Contains    42 cm
    Click Text    42 cm

Sélectionner sous-gamme forcat
    Wait Until Element Is Visible    //androidx.cardview.widget.CardView[@content-desc="Sélectionner cette gamme Forçat"]/android.view.ViewGroup
    Click Element    //androidx.cardview.widget.CardView[@content-desc="Sélectionner cette gamme Forçat"]/android.view.ViewGroup


Appuyer finaliser
    Wait Until Element Is Visible    //android.widget.Button[@content-desc="Valider et terminer cette saisie"]
    Click Element    //android.widget.Button[@content-desc="Valider et terminer cette saisie"]


Valider Retour fournisseur
    Wait Until Element Is Visible    //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_quitter_module_valider_transfert"]
    Click Element    //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_quitter_module_valider_transfert"]
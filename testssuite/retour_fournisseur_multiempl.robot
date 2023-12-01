*** Settings ***
Documentation       ce test pour executer l'application
...                 
...
 
Library    AppiumLibrary
Library    Process
Resource    ../resources/SatelixLogistique.resource
Resource    retour_fournisseur_monoempl.robot


*** Variables ***
${module_retour_fournisseur_multi_empl}      //androidx.cardview.widget.CardView[@content-desc="Sélectionner le module Retour fournisseur Multi Empl."]/android.view.ViewGroup
${module_retour_fournisseur_multi_empl_attente}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner le module Retour fournisseur Multi Empl. Il y a des traitements en attente pour ce module.."]/android.view.ViewGroup
${depot}                                     xpath = (//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}                                  //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${fournisseur}                               xpath = (//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${Duboi}                                     //androidx.cardview.widget.CardView[@content-desc="Fournisseur Duboi expert comptable"]/android.view.ViewGroup
${valider_nouveau_traitement}                //android.widget.Button[@content-desc="Valider les informations pour le nouveau traitement"]
${liste_article}                             //android.widget.ImageButton[@content-desc="Liste des articles"]
${recherche_article}                         //android.widget.EditText[@text="Recherche article"]
${valider_article}                           //android.widget.ImageButton[@content-desc="Valider cet article"]
${bague_argent}                              //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Argent"]/android.view.ViewGroup
${A1T2N1P2}                                  //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T2 Niv N1 Pos P2"]/android.view.ViewGroup
${A1T3N1P3}                                  //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T3 Niv N1 Pos P3"]/android.view.ViewGroup
${menu_déroulant}                            //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
${lot10}                                     //android.view.ViewGroup[@content-desc="Sélectionner le numéro de lot LOT-10"]
${A1T3N1P2}                                  //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T3 Niv N1 Pos P2"]/android.view.ViewGroup
${ecrin12}                                   //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_connexion" and @text="ECRIN DE 12"]
${A2T1N2P2}                                  //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A2 Trav T1 Niv N2 Pos P2"]/android.view.ViewGroup
${valider_series}                            //android.widget.Button[@content-desc="Valider les numéros de série"]
${ok}                                        //android.widget.Button[@resource-id="android:id/button1"]
${retour}                                    //android.widget.ImageButton[@content-desc="Remonter"]
${MF80}                                      //android.view.ViewGroup[@content-desc="Sélectionner le numéro de série MF80"]
${BAOR01}                                    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Or et pierres"]/android.view.ViewGroup
${A1T1N1P1}                                  //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${Emeraude}                                  //androidx.cardview.widget.CardView[@content-desc="Sélectionner cette gamme Emeraude"]/android.view.ViewGroup
${EditQuant}                                 //android.widget.Button[@content-desc="Édition de la quantité validée"]
${MettreEnAttente}                           //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_quitter_module_mettre_en_attente"]
${A1T2N3P2}                                  //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T2 Niv N3 Pos P2"]/android.view.ViewGroup
${42cm}                                      //androidx.cardview.widget.CardView[@content-desc="Sélectionner cette gamme 42 cm"]/android.view.ViewGroup
${Forcat}                                    //androidx.cardview.widget.CardView[@content-desc="Sélectionner cette gamme Forçat"]/android.view.ViewGroup
${finaliser}                                 //android.widget.Button[@content-desc="Valider et terminer cette saisie"]
${transferer}                                //android.widget.Button[@content-desc="Valider le traitement"]
${ValiderRetourFournisseurMultiEmpl}         //android.widget.Button[@resource-id="fr.satelix.logistique:id/bt_quitter_module_valider_transfert"]



*** Test Cases ***
Test De L Application
    Demarrer L Application
    Swipe Down    ${module_retour_fournisseur_multi_empl}
    Sur le terminal, sélectionner le module    $monModule
    Sélectionner Element    ${module_retour_fournisseur_multi_empl}
    Sélectionner Element    ${depot}
    Sélectionner Element    ${Bijou SA}
    Sélectionner Element    ${fournisseur}
    Sélectionner Element    ${Duboi}    
    Sélectionner Element    ${valider_nouveau_traitement}
    Sélectionner Element    ${liste_article}
    Sélectionner barre de recherche écrire à la main    BAAR01
    Sélectionner Element    ${bague_argent}
    Sélectionner Element    ${A1T2N1P2}
    Valider Quantite    3
    Scanner code barre    BAAR01
    Sélectionner Element    ${A1T2N1P2}
    Valider Quantite    3
    Scanner code barre    LINGOR18
    Sélectionner Element    ${A1T3N1P3}
    Sleep    2s
    Sélectionner Element    ${menu_déroulant}
    Sélectionner Element    ${lot10}
    Valider Quantite    1
    Scanner code barre    LINGOR18;LOT-BDF9411123
    Sélectionner Element    ${A1T3N1P3}
    Valider Quantite    2
    Sélectionner barre de recherche écrire à la main    EM040
    Sélectionner Element    ${valider_article}
    Sélectionner Element    ${A1T3N1P2}
    Sleep    2s
    Sélectionner Element    ${ecrin12}
    Valider Quantite    1
    Scanner code barre    EM050
    Sélectionner Element    ${A1T3N1P3}
    Valider Quantite    2
    Scanner code barre    EM050/24
    Sélectionner Element    ${A1T3N1P3}
    Valider Quantite    1
    Scanner code barre    MODIV01
    Sélectionner Element    ${A2T1N2P2}
    Sélectionner Element    ${menu_déroulant}
    Sélectionner Element    ${MF80}
    Sleep    5s
    Sélectionner Element    ${valider_series}
    Scanner code barre    MF84
    Sélectionner Element    ${A2T1N2P2}
    Sélectionner Element    ${retour}
    Scanner code barre    MF88
    Sélectionner Element    ${ok}
    Scanner code barre    MODIV01;MF81
    Sélectionner Element    ${A2T1N2P2}
    Sélectionner Element    ${retour}
    Scanner code barre    MODIV01;MF88
    Go Back
    Scanner code barre    EM055
    Sélectionner Element    ${ok}
    Vider barre de recherche    EM055
    Sleep    1s
    Sélectionner barre de recherche écrire à la main    BAOR01
    Sélectionner Element    ${BAOR01}
    Sélectionner Element    ${A1T1N1P1}
    Sélectionner Element    ${Emeraude}
    Valider Quantite    4
    Scanner code barre    21731003
    Sélectionner Element    ${A1T1N1P1}
    Valider Quantite    7
    Scanner code barre    21731003
    Sélectionner Element    ${A1T1N1P1}
    Sélectionner Element    ${EditQuant}
    Valider Quantite    9
    Sélectionner Element    ${retour}
    Sélectionner Element    ${MettreEnAttente}
    Swipe Down    ${module_retour_fournisseur_multi_empl_attente}
    Sélectionner Element    ${module_retour_fournisseur_multi_empl_attente}
    Sélectionner Element    ${ok}     #Sélectionne Oui (car même xpath)
    Sélectionner barre de recherche écrire à la main    CHAAR/VAR
    Sélectionner Element    ${valider_article}
    Sélectionner Element    ${A1T2N3P2}
    Sélectionner Element    ${42cm}
    Sélectionner Element    ${Forcat}
    Valider Quantite    2
    Scanner code barre    38141025
    Sélectionner Element    ${A1T2N3P2}
    Valider Quantite    8
    Sélectionner Element    ${finaliser}
    Sélectionner Element    ${transferer}
    Sélectionner Element    ${ValiderRetourFournisseurMultiEmpl}



















*** Keywords ***

Swipe Down
    [Arguments]    ${element}
    FOR    ${counter}    IN RANGE    0    10
        ${status}=    Run Keyword And Return Status    Wait Until Element Is Visible    ${element}    timeout=3s
        IF    ${status}    BREAK
        Swipe    0    1000    0    100    150
    END


Sélectionner Element
    [Arguments]    ${destination}
    Wait Until Element Is Visible    ${destination}
    Click Element    ${destination}


Sélectionner Texte
    [Arguments]    ${destination}
    Wait Until Page Contains   text = ${destination}
    Click Text    ${destination}  true


Sélectionner barre de recherche écrire à la main
    [Arguments]    ${texte}
    Sélectionner Element    ${recherche_article}
    Input Text Into Current Element    ${texte}


Valider Quantite
    [Arguments]    ${quantite}
    Input Text Into Current Element    ${EMPTY}
    Input Text Into Current Element    ${quantite}
    Sleep  2s
    Click Element    fr.satelix.logistique:id/fab_ajouter

Vider barre de recherche
    [Arguments]    ${texte}
    Wait Until Element Is Visible    ${valider_article}
    Click Element    ${valider_article}
    Wait Until Element Is Visible    //android.widget.EditText[@text="${texte}"]
    Click Element    //android.widget.EditText[@text="${texte}"]
    Wait Until Element Is Visible    //android.widget.ImageButton[@content-desc="Effacer le texte"]
    Click Element    //android.widget.ImageButton[@content-desc="Effacer le texte"]
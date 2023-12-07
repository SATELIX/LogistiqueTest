*** Settings ***
Documentation    ce fichier contient les mots clé nécessaires pour accéder au module
...   de préparation et de finalisation
...   Les écrans avec le détails des articles et des lots sont décits dans des dichiers séparés  

Library     AppiumLibrary
Library    DateTime
Resource    utils.resource
Resource    module_preparation_handlingUnit.resource

*** Variables ***

${TITRE_MODULE}          id=tv_intitule_modules
${DOCUMENTS_AFFCIHES}    id=tv_item_doc_html

#
# Ecran de finalisation
# 
${BOUTON_FINALISER}              id=fab_quitter
${BOUTON_ATTENTE}                id =bt_quitter_module_mettre_en_attente

# id=Validate and complete this entry

${pastille_colis}                id=fr.satelix.logistique:id/fab_colisage
${TEXTE_POIDS}                   id=input_cloture_colis_poids    #textinput_placeholder
${BOUTON_PHOTO}                  id=bt_input_button
${BOUTON_CLOTURE}                id=fab_cloturer

${BUTTON_LISTE_MODE_EXPEDITION}  id=text_input_end_icon
${BOUTON_TRANSFERT}              id=fab_quitter

${POPUP_VALIDATION_PREPA}        id=bt_quitter_module_valider_transfert
${terminer_saisie}               id=android:id/button1
${POPUP_RETOUR_PREPA}            id=bt_quitter_module_annuler

${BOUTON_TERMINER_SAISIE_INCOMLETE}     id=button1
${text_recherche}                id =input_text_recherche

# content-desc=Validate and complete this entry
# id=fr.satelix.logistique.demo:id/fab_quitter


*** Keywords ***
Choisir Le Document A Preparer Dans La Liste Des Documents
    [Documentation]    Ce mot clé parcour la liste des documents du module
    ...    Préparation et Click sur le document correspondant à celui passé
    ...    en Argument <BR>
    ...    La variable "document" est la référence de la préparation.<BR>
    ...    TO DO :       
    [Arguments]    ${document}
    Wait Until Page Contains    ${document}   15s 
    ...    Le document ${document} n'apparait pas dans la liste des documents à peparer
    AppiumLibrary.Click Text    ${document}    true

Choisir Le Document A Preparer Dans La Liste Des Documents Element
    [Documentation]    Ce mot clé parcour la liste des documents du module
    ...    Préparation et Click sur le document correspondant à celui passé
    ...    en Argument <BR>
    ...    La variable "document" est la référence de la préparation.<BR>
    ...    TO DO :       
    [Arguments]    ${document}
    Wait Until Element Is Visible    ${document}   15s 
    ...    Le document ${document} n'apparait pas dans la liste des documents à peparer
    AppiumLibrary.Click Element    ${document}


Sélectionner le document
    [Arguments]    ${document}
    Choisir Le Document A Preparer Dans La Liste Des Documents    ${document}

Sélectionner l article
    [Arguments]    ${article}
    Choisir Le Document A Preparer Dans La Liste Des Documents    ${article}

Sélectionner l article par element
    [Arguments]    ${article}
    Choisir Le Document A Preparer Dans La Liste Des Documents Element   ${article}

Sélectionner l emplacement
    [Arguments]    ${emplacement}
    Choisir Le Document A Preparer Dans La Liste Des Documents    ${emplacement}


Ouvrir menu déroulant
    [Arguments]    ${menu}
    Wait Until Element Is Visible    ${menu}
    AppiumLibrary.Click Element    ${menu} 

Choisir au menu déroulant
    [Arguments]    ${menu}    ${choix}
    Ouvrir menu déroulant    ${menu}    
    Wait Until Page Contains Element   ${choix}
    Click Element    ${choix}  



Sélectionner ok
    Wait Until Page Contains    OK
    AppiumLibrary.Click Text    OK


#Sélectionner date du lendemain
    # ${today}=    Get Current Date
    # Choisir Le Document A Preparer Dans La Liste Des Documents    ${today}
    # Choisir Le Document A Preparer Dans La Liste Des Documents    5

Affiche Element
    [Arguments]    ${element}
    Log To Console    Attente de l'affichage de l'élément ${element}
    Wait Until Page Contains Element    ${element}    30

Sélection gamme
    [Arguments]    ${gamme}
    Log To Console    Sélection de la gamme ${gamme}

    Wait Until Page Contains    ${gamme}    30
    Click Text    ${gamme}

Sélection sous gamme
    [Arguments]    ${sousGamme}
    Log To Console    Sélection de la sous gamme ${sousGamme}
    Sélection gamme    ${sousGamme}


Transferer
    Choisir Le Document A Preparer Dans La Liste Des Documents    TRANSFÉRER

Supprimer Recherche Article
    [Arguments]    ${article}
    Choisir Le Document A Preparer Dans La Liste Des Documents Element    //android.widget.ImageButton[@content-desc="Valider cet article"]
    Wait Until Element Is Visible    //android.widget.EditText[@text="${article}"]
    Clear Text    //android.widget.EditText[@text="${article}"]

Appuyer sur la pastille du colis
    Choisir Le Document A Preparer Dans La Liste Des Documents Element   ${pastille_colis}


# Fonction non utilisée

# Cliquer sur le bouton de finalisation Et Verifier Que La Commande Est Complète
#     [Documentation]    
#     Cliquer sur le bouton de finalisation


Cliquer sur le bouton de finalisation
    AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_FINALISER}        
    AppiumLibrary.Click Element    ${BOUTON_FINALISER}

Cliquer sur le bouton de mise en attente
    AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_ATTENTE}        
    AppiumLibrary.Click Element    ${BOUTON_ATTENTE}

Confirmer la preparation incomplete
    AppiumLibrary.Wait Until Element Is Visible    id=android:id/button1        
    AppiumLibrary.Click Element                    id=android:id/button1
    
# Verifier Que La Commande Est Complète
#     [Documentation]      TO DO :   
#     ...    Depuis l'écran de finalisation de la Commande
#     ...    la liste des articles doit être affichée avec les quantités 
#     ...    égales à celles enregistrées 
#     AppiumLibrary.Wait Until Element Is Visible    ${TEXTE_POIDS}
#     No Operation

Entrer Le Poids Du Colis
    [Arguments]     ${poids}
    Sleep    0.2s
    AppiumLibrary.Wait Until Element Is Visible    ${TEXTE_POIDS}    8s
    AppiumLibrary.Click Element    ${TEXTE_POIDS}
    Taper Un Nombre Au Clavier    ${poids}

Une Erreur Doit Etre Indiquee Avec Le Message Correspondant
    AppiumLibrary.Page Should Contain Element    id=text_input_error_icon
    AppiumLibrary.Page Should Contain Element    id=textinput_error


Prendre Une Photo Du Colis
    [Documentation]    Démarre l'appareil photo attend 1seconde 
    ...     et valider la photo
    ...    (il aut appuye 2 fois sur entrer pour prendre la photo)
    ...    puis attend que l'appareil photo se ferme en controlant
    ...    le reotu sur l'écran de finalisation des la commande
    AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_PHOTO}
    AppiumLibrary.Click Element    ${BOUTON_PHOTO}
    Sleep    1s
    AppiumLibrary.Press Keycode    66    # press enter
    AppiumLibrary.Press Keycode    66    # press enter
    AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_PHOTO}

Cliquer Sur Le Bouton De Cloture
    AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_CLOTURE}
    AppiumLibrary.Click Element    ${BOUTON_CLOTURE}

Entrer Le Poids Et Appuyer Sur Cloturer
    [Arguments]     ${poids}
    Entrer Le Poids Du Colis    ${poids}
    Cliquer Sur Le Bouton De Cloture

Laisser Le Mode D Envoi Par Defaut et Transférer
    AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_TRANSFERT}
    AppiumLibrary.Click Element    ${BOUTON_TRANSFERT}

Valider Le Mode Expedition Sur     
    [Arguments]    ${modeExpedition}
    Choisir le mode d'expédition    ${modeExpedition}

Appuyer sur Transferer
    Cliquer Sur Le Bouton De Transfert


Appuyer sur la flèche retour et "Finaliser"
    Appuyer sur la flèche retour
    Cliquer sur le bouton de finalisation

Appuyer sur la flèche retour et "Mettre En Attente"
    Appuyer sur la flèche retour
    Sleep    2s
    Cliquer sur le bouton de mise en attente



# Fonction non utilisée

# Choisir le mode d'expédition et Transférer
#     [Documentation]    choisi le mode d'expédition donné en argument dans la liste de l'écran 
#     [Arguments]    ${modeExpedition}
#     AppiumLibrary.Wait Until Element Is Visible    ${BUTTON_LISTE_MODE_EXPEDITION}    6s    
#     ...    Le choix de mode de livraison n'est pas disponible au bout de 6secondes
#     Choisir le mode d'expédition    ${modeExpedition}
#     Cliquer Sur Le Bouton De Transfert

Cliquer Sur Le Bouton De Transfert
    AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_TRANSFERT}
    AppiumLibrary.Click Element    ${BOUTON_TRANSFERT}

Cliquer sur Oui
    AppiumLibrary.Wait Until Page Contains    OUI
    AppiumLibrary.Click Text    OUI

Cliquer sur Non
    AppiumLibrary.Wait Until Page Contains    NON
    AppiumLibrary.Click Text    NON

Changer emplacement
    [Arguments]    ${Emplacement}
    AppiumLibrary.Wait Until Element Is Visible    fr.satelix.logistique:id/bt_emplacement
    AppiumLibrary.Click Element    fr.satelix.logistique:id/bt_emplacement
    AppiumLibrary.Wait Until Page Contains   ${Emplacement} 
    AppiumLibrary.Click Text    ${Emplacement}

Choisir le mode d'expédition
    [Arguments]    ${modeExpedition}
    #  AppiumLibrary.Click Element    ${BUTTON_LISTE_MODE_EXPEDITION}
     AppiumLibrary.Wait Until Element Is Visible    id=dropdown_list
     Choisir LA Valeur Dans La Liste    id=dropdown_list    ${modeExpedition}

Valider La Préparation
    AppiumLibrary.Wait Until Element Is Visible    ${POPUP_VALIDATION_PREPA}
    AppiumLibrary.Click Element    ${POPUP_VALIDATION_PREPA}


Appuyer sur Terminer La Saisie
    AppiumLibrary.Wait Until Element Is Visible    ${terminer_saisie}
    AppiumLibrary.Click Element    ${terminer_saisie}

Modifier code barre
    [Arguments]    ${newcb}    ${oldcb}    
    Wait Until Page Contains    ${oldcb}
    Click Text    ${oldcb}
    Clear Text    //android.widget.EditText[@text="${oldcb}"]
    Taper Un Mot Au Clavier    ${newcb}
    Press ENTER
    Hide Keyboard
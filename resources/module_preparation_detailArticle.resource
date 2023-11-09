*** Settings ***
Documentation    
...

Library     AppiumLibrary
Library     String
Resource    utils.resource
Resource    module_preparation_listelots.resource

*** Variables ***
${LAYOUT_HAUT}                       //androidx.appcompat.widget.LinearLayoutCompat/android.webkit.WebView/android.webkit.WebView/
${TEXTE_LOT}                         ${LAYOUT_HAUT}android.widget.TextView[1]
${TEXTE_NOM_ARTICLE}                 ${LAYOUT_HAUT}android.widget.TextView[2]
${BUTON_CHOIX_DES_LOTS}              id=ctn_saisie_num_lot_serie
${BUTON_LISTE_DES_LOTS_EN_STOCK}     id=text_input_end_icon

${TEXT_STOCK_GLOBAL}                 id=tv_qte_stock

${ZONE_GESTION_QUANTITE}             id=layout_quantite
${TEXT_QUANTITE_PREPAREE}            id=tv_qte_preparee
${TEXT_QUANTITE_VALIDEE}             id=tv_qte_validee

${BOUTON_AJOUTER}                    id=fab_ajouter

${MESSAGE_ERREUR_QUANTITE}           id=android:id/message
${BOUTON_OK_MESSAGE_ERREUR}          id=android:id/button1


*** Keywords ***
Preparer Les Quantités De L Article
    [Documentation]    Vérifie que les données affichées sont identiques
    ...    à celles passées en argument.
    ...    \n vérifie que le stock est supérieur à la quantité demandée
    ...    \n choisit les lot avec la bonne quantité
    ...    \n si il n'y a pas de notion de lot sur l'article donné, le mot clé entre la quantité directement.
    [Arguments]    ${Lot}    ${nomArticle}    ${quantite}
    AppiumLibrary.Swipe By Percent    10    10    10    80
    Le Lot Choisi Est Bien Celui Demandé    ${Lot}
    L Article Choisi Est Bien Celui Demandé    ${nomArticle}
    # Si il n'y a pas de gestion de lot, on entre directmeent la quantité
    ${status}=    Run Keyword And Return Status    Element Should Be Visible  ${BUTON_CHOIX_DES_LOTS}
    IF    ${status}
        Afficher Les Lots Disponibles
        Choisir un numéro de lot dont le stock est supérieur ou égal à la quantité   ${quantite}    
    END
    Entrer la quantité complète à préparer et valider    ${quantite}

L Article Choisi Est Bien Celui Demandé
    [Documentation]    Compare le nom de l'article affiché qui doit être
    ...                le même que celui selectionné dans le menu 
    ...                et qui est passé en argument
    [Arguments]     ${nomArticle}
    AppiumLibrary.Wait Until Element Is Visible    ${TEXTE_NOM_ARTICLE}
    ${nomAffiche}=    AppiumLibrary.Get Text    ${TEXTE_NOM_ARTICLE}
    Should Be Equal As Strings    ${nomArticle}    ${nomAffiche}
    ...    Le nom d'article affiché n'est pas celui qui a été sectionné dans la liste de la prépration

Le Lot Choisi Est Bien Celui Demandé
    [Documentation]    Compare le nom de le lot affiché qui doit être
    ...                le même que celui selectionné dans le menu 
    ...                et qui est passé en argument
    [Arguments]     ${lot}
    AppiumLibrary.Wait Until Element Is Visible    ${TEXTE_LOT}
    ${lotAffiche}=    AppiumLibrary.Get Text    ${TEXTE_LOT}
    Should Be Equal As Strings    ${lot}    ${lotAffiche}    
    ...    Le numero de lot affiché n'est pas celui qui a été sectionné dans la liste de la prépration

Afficher Les Lots Disponibles
    AppiumLibrary.Wait Until Page Contains Element    ${BUTON_LISTE_DES_LOTS_EN_STOCK}
    Click Element    ${BUTON_LISTE_DES_LOTS_EN_STOCK}

Entrer la quantité complète à préparer et valider
    [Documentation]    Ce mot clé prend un nombre en entrée 
    ...    boucle sur chaque caractère et appuie sur la touche du clavier correspondante
    ...    Cela permet de simuler les gestes d'un utilisateur.
    [Arguments]    ${quantite}
    # AppiumLibrary.Scroll Down    ${BOUTON_AJOUTER}
    # AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_AJOUTER}
    Taper Un Nombre Au Clavier   ${quantite}
    Valider La Quantité

Entrer Une Quantité Supérieure A Celle Demandee Et Valider
    [Documentation]    Ce mot clé prend un nombre en entrée 
    ...    boucle sur chaque caractère et appuie sur la touche du clavier correspondante
    ...    Cela permet de simuler les gestes d'un utilisateur.
    [Arguments]    ${quantite}    ${quantiteSupplémentaire}=1
    # AppiumLibrary.Scroll Down    ${BOUTON_AJOUTER}
    # AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_AJOUTER}
    ${qty}=    Evaluate    ${quantite}+${quantiteSupplémentaire}
    Taper Un Nombre Au Clavier   ${qty}
    Valider La Quantité

Valider La Quantité
    AppiumLibrary.Click Element    ${BOUTON_AJOUTER}

Entrer une quantité automatiquement
    Click Element    Show dropdown menu
    Wait Until Page Contains Element    Available batch numbers    5
    Click Element    //androidx.cardview.widget.CardView[@index='0']        # BATCH NUMBER 0 OU 1
    Wait Until Page Contains Element    tv_qte_preparee    5
    ${quantity_totale}    Get Text    tv_qte_preparee
    ${remaining}=    Split String    ${quantity_totale}    / 
    Log To Console    la quantité récupérée est : ${remaining}[0]
    Input Text    textinput_placeholder    ${remaining}[0]        # RECUPERE LA QUANTITE TOTALE A PREPARER (DEVANT LE "/")
    
    # ${quantity}    Get Text    tv_qte_preparee
    # ${first_two_characters}    Set Variable    ${quantity[:2]}        
    # Input Text    textinput_placeholder    ${first_two_characters}        # RECUPERE LA QUANTITE TOTALE A PREPARER (LES 2 PREMIERS CARACTERES)
    
    Click Element    Add to the quantity entered to the existing quantity
    Wait Until Page Contains Element    Items to be picked    5

La pop up "Larger quantity" s'affiche
    Wait Until Page Contains Element    ${MESSAGE_ERREUR_QUANTITE}
    Wait Until Element Is Visible       ${MESSAGE_ERREUR_QUANTITE}
    Wait Until Element Is Visible       ${BOUTON_OK_MESSAGE_ERREUR}

Valider Le Message D Erreur De La Popup
    Wait Until Element Is Visible       ${BOUTON_OK_MESSAGE_ERREUR}
    Click Element       ${BOUTON_OK_MESSAGE_ERREUR}

Lire La Quantite Restante A Preparer Dans Le Detail De L Article
    [Documentation]    Sur l'écran de détail de l'article affiché, 
    ...  ce mot clé lit la valeur de la quantité "Remaining" avant le caractère "/"
    ...  et envoie cette valeur
    ...  
     AppiumLibrary.Wait Until Element Is Visible    ${TEXT_QUANTITE_PREPAREE}    
     ...    6s   La quantité restante à préparée n'est pas visible dans le détail de l'article
    ${remaning}     AppiumLibrary.Get Text    ${TEXT_QUANTITE_PREPAREE}
    ${remaning}     utils.Lire La Quantite Restante A Preparer    ${remaning}
    RETURN    ${remaning}
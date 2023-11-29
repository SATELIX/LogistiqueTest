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

${CHAMP_QUANTITE}                    id=textinput_placeholder

${BOUTON_AJOUTER}                    id=fab_ajouter

${MESSAGE_ERREUR_QUANTITE}           id=android:id/message
${BOUTON_OK_MESSAGE_ERREUR}          id=android:id/button1


*** Keywords ***
Preparer Les Quantités De L Article
    [Documentation]    Vérifie que les données affichées sont identiques
    ...    à celles passées en argument.
    ...    \n vérifie que le stock est supérieur à la quantité demandée
    ...    \n choisit les lot avec la bonne quantité
    ...    \n si il n'y a pas de notion de lot sur l'article donné, la quantité est directement saisie.
    [Arguments]    ${Lot}    ${nomArticle}    ${quantite}
    AppiumLibrary.Swipe By Percent    10    10    10    80
    Le Lot Choisi Est Bien Celui Demandé    ${Lot}
    L Article Choisi Est Bien Celui Demandé    ${nomArticle}
    # Si il n'y a pas de gestion de lot la quantité est entrée directement
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

Sélectionner la Gamme
    [Arguments]    ${gamme}
    Wait Until Page Contains    ${gamme}
    Click Text    ${gamme}

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

Entrer une quantité et valider
    [Arguments]    ${quantite}
    AppiumLibrary.Wait Until Element Is Visible    ${CHAMP_QUANTITE}  30s
    Taper Un Nombre Au Clavier   ${quantite}
    Valider La Quantité

Entrer la quantité complète à préparer et valider
    [Documentation]    Pprend un nombre en entrée, 
    ...    boucle sur chaque caractère et appuie sur la touche du clavier correspondante.
    ...    Cela permet de simuler les gestes d'un utilisateur.
    [Arguments]    ${quantite}
    # AppiumLibrary.Scroll Down    ${BOUTON_AJOUTER}
    # AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_AJOUTER}
    Taper Un Nombre Au Clavier   ${quantite}
    Valider La Quantité

Valider Quantite
    [Documentation]    Saisit la quantité et la valide sur un input déjà sélectionné.
    ...                L'input est vidé avant d'être rempli.
    [Arguments]    ${quantite}
    Input Text Into Current Element    ${EMPTY}
    Input Text Into Current Element    ${quantite}
    Sleep    2
    Click Element    fr.satelix.logistique:id/fab_ajouter
    Attendre

Saisir une valeur et valider
    [Arguments]    ${valeur}
    AppiumLibrary.Input Text Into Current Element    ${valeur}
    utils.Press ENTER
    
Entrer Une Quantité Supérieure A Celle Demandee Et Valider
    [Documentation]    Prend un nombre en entrée,
    ...    boucle sur chaque caractère et appuie sur la touche du clavier correspondante.
    ...    Cela permet de simuler les gestes d'un utilisateur.
    [Arguments]    ${quantite}    ${quantiteSupplémentaire}=1
    # AppiumLibrary.Scroll Down    ${BOUTON_AJOUTER}
    # AppiumLibrary.Wait Until Element Is Visible    ${BOUTON_AJOUTER}
    ${qty}=    Evaluate    ${quantite}+${quantiteSupplémentaire}
    Taper Un Nombre Au Clavier   ${qty}
    Valider La Quantité

Valider La Quantité
    AppiumLibrary.Click Element    ${BOUTON_AJOUTER}
    AppiumLibrary.Wait Until Page Does Not Contain Element    ${BOUTON_AJOUTER}

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

Sélectionner le conditionnement
    [Documentation]    Le conditionnement passé en paramètre est recherché sur l'écran.
    ...               \n Seinsible à la casse.
    [Arguments]    ${conditionnement}
    # ${choix_conditionnement}    Set Variable    //*[@id=bt_connexion and contains(text(), "${conditionnement}")]
    # ${choix_conditionnement}    Set Variable    //*[@text="${conditionnement}"]
    # AppiumLibrary.Wait Until Page Contains Element    ${choix_conditionnement}    6s
    # AppiumLibrary.Click Element                       ${choix_conditionnement}
    AppiumLibrary.Wait Until Page Contains Element    id=bt_connexion
    AppiumLibrary.Hide Keyboard
    Sleep    0.2s
    ${choix_conditionnements}        AppiumLibrary.Get Webelements    id=bt_connexion
    ${loc_premieconitionnement}    AppiumLibrary.Get Element Rect    ${choix_conditionnements}[0]
    ${x}    Evaluate    ${loc_premieconitionnement}[x]+${loc_premieconitionnement}[width]
    ${y}    Evaluate    ${loc_premieconitionnement}[y]+20
    ${offset_x}    Evaluate    -${loc_premieconitionnement}[width]/2
    Swipe    ${x}    ${y}    ${loc_premieconitionnement}[x]    ${y}
    # ous les choix devraient affichés après avoir bouger swiper/scroller les boutons.
    ${choix_conditionnements}        AppiumLibrary.Get Webelements    id=bt_connexion
    FOR    ${element}    IN    @{choix_conditionnements}
        ${choix_lu}    AppiumLibrary.Get Text    ${element}
        Log To Console    ${choix_lu}
        IF    "${choix_lu}" == "${conditionnement}"
            AppiumLibrary.Click Element           ${element}
            RETURN    ${True}
        END
    END
    Fail    Le conditionnement n a pas été trouvé

Saisir un Numero De Serie et valider
    [Arguments]    ${numSerie}
    ${champ_numero_serie}    Set Variable    id=textinput_placeholder
    AppiumLibrary.Wait Until Element Is Visible    ${champ_numero_serie}
    AppiumLibrary.Click Element   ${champ_numero_serie}
    utils.Taper Un Mot Au Clavier    ${numSerie}
    # AppiumLibrary.Input Text      ${champ_numero_serie}    ${numSerie}
    Press ENTER

Saisir le Numéro de lot
    [Arguments]    ${numero}
    Wait Until Element Is Visible    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/textinput_placeholder"]
    Click Element    //android.widget.TextView[@resource-id="fr.satelix.logistique:id/textinput_placeholder"]
    Input Text Into Current Element    ${numero}
    Run Keyword    pressKeyCode    66

Sélectionner le Lot avec DLC et FAB
    [Documentation]    Cas très spécifique où l'on recherche un lot avec DLC
    Wait Until Element Is Visible    //androidx.recyclerview.widget.RecyclerView[@resource-id="fr.satelix.logistique:id/rv_liste"]
    Click Text    DLC :

Scanner le code barre correspondant au numéro de série
    [Arguments]    ${numSerie}
    utils.Scanner Un Code    ${numSerie}

Scanner le code barre correspondant au numéro de série qui n'existe pas
    [Arguments]    ${numSerie}
    utils.Scanner Un Code    ${numSerie}
    # AppiumLibrary.Element Should Be Visible    id=alertTitle    Le message d erreur n'est pas affcihé suite à la lectue d'un codebarre inconnu.
    AppiumLibrary.Wait Until Element Is Visible    id=android:id/message    2s    Le message d erreur n'est pas affcihé suite à la lectue d'un codebarre inconnu.
    # AppiumLibrary.Element Should Be Visible    id=message    Le message d erreur n'est pas affcihé suite à la lectue d'un codebarre inconnu.
    AppiumLibrary.Click Text    OK

Effacer le numéro de série, ne rien mettre et valider
    utils.Supprimer Un Nombre Au Clavier
    utils.Press ENTER


Appuyer sur "ok" et la "flèche retour"
    AppiumLibrary.Wait Until Page Contains    OK
    AppiumLibrary.Click Text    OK
    AppiumLibrary.Wait Until Page Does Not Contain    OK
    AppiumLibrary.Go Back
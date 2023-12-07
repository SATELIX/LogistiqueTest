*** Settings ***
Documentation    Mot clé correspondant à l'écran de la liste des Lots
...              cet écran apparait los de la prépation des Commandes
...              et montre la liste des lots en stock correspondant
...              à l'article en préparation

Library    AppiumLibrary
Library    String
Resource    module_preparation_detailArticle.resource


*** Variables ***
# ${LISTE_CARDVIEW_LOTS}        //*[@id="fr.satelix.logistique.demo:id/rv_liste"]/androidx.cardview.widget.CardView
${LISTE_VIEW_LOTS}      id=const_layout_lot_serie
${LOT_EN_STOCK}         id=tv_intitule_lot_serie
${PREPARATION_EN_STOCK}  id=tv_item_article_html
${TEXT_QUANTITE_STOCK}  id=tv_qte_restante
${DATE_LOT_EN_STOCK}    id=item_dates
# ${LISTE_VIEW_LOTS}      id=fr.satelix.logistique.demo:id/const_layout_lot_serie
# ${LOT_EN_STOCK}         id=fr.satelix.logistique.demo:id/tv_intitule_lot_serie
# ${TEXT_QUANTITE_STOCK}  id=fr.satelix.logistique.demo:id/tv_qte_restante
# ${DATE_LOT_EN_STOCK}    id=fr.satelix.logistique.demo:id/item_dates

*** Keywords ***
Choisir Le Lot    
    [Arguments]    ${lot}
    AppiumLibrary.Wait Until Page Contains Element    ${LOT_EN_STOCK}
    Click Element    ${LOT_EN_STOCK}
    Wait Until Page Contains    ${lot}
    AppiumLibrary.Click Text    ${lot}

Choisir La Préparation    
    [Arguments]    ${preparation}
    AppiumLibrary.Wait Until Page Contains    ${preparation}
    AppiumLibrary.Click Text    ${preparation}


Aller dans la liste et sélectionner le numéro de lot
    [Arguments]    ${lot}
    module_preparation_detailArticle.Afficher Les Lots Disponibles
    Choisir Le Lot    ${lot}

# Fonction non utilisée

# Aller dans la liste et sélectionner la préparation
#     [Arguments]    ${preparation}
#     module_preparation_detailArticle.Afficher Les Preparations Disponibles
#     Choisir La Préparation    ${preparation}

Choisir un numéro de lot dont le stock est supérieur ou égal à la quantité
    [Documentation]    Ce mot clé parcours la liste des lots affichée 
    ...            lit les quantités de chaque lot et vérifie qu'elle 
    ...            est supérieure à la quantité nécessaire.
    ...            Si aucun lot n'a une quantité supérieure, il renvoit None
    ...            renvoie le 1er numéro de lot qui contient la bonne quantité
    ...    /!\Ce mot clé ne prend pas en compte les limites de 20 aticles par pages pour le moment
    ...    /!\Ce mot clé ne prend pas en compte les lots qui ne sont pas affichés
    ...    à l'écran pour le moment

    [Arguments]    ${quantite}
    AppiumLibrary.Wait Until Element Is Visible    ${LISTE_VIEW_LOTS}    15s
    ${lots}=    AppiumLibrary.Get Webelements    ${LISTE_VIEW_LOTS}
    ${numero_lot}    Set Variable    ${EMPTY}
    FOR    ${lot}    IN    @{lots}
        AppiumLibrary.Wait Until Element Is Visible    ${TEXT_QUANTITE_STOCK}
        ${elt}=    AppiumLibrary.Get Webelement In Webelement 
        ...    ${lot}
        ...    ${TEXT_QUANTITE_STOCK}
        ${stockQuantite}=    Get Text    ${elt}
        Continue For Loop If    ${stockQuantite} < ${quantite}
        ${elt}=    AppiumLibrary.Get Webelement In Webelement
        ...    ${lot}
        ...    ${LOT_EN_STOCK}
        ${numero_lot}=    Get Text    ${elt}
        ${elt}=    AppiumLibrary.Get Webelement In Webelement
        ...    ${lot}
        ...    ${DATE_LOT_EN_STOCK}
        ${stockDate}=    Get Text    ${elt}
        AppiumLibrary.Click Element    ${lot}
        Exit For Loop
    END
    RETURN    ${numero_lot}

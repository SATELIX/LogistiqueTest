*** Settings ***

Library    AppiumLibrary
Library    String


Resource    module_preparation_detailArticle.resource
Resource    utils.resource
# Resource    module_preparation.resource

*** Variables ***
${CHAMP_RECHERCHE}        //*[@id='input_recherche_module']/android.widget.EditText
# ${CHAMP_RECHERCHE}        //*[@id='fr.satelix.logistique.demo:id/input_recherche_module']/android.widget.EditText
${ONGLET_TOBEPICKED}
${ONGLET_PICKED}
${NOMBREARTICLE_AFFICHE}             id=tv_nb_articles
# ${ARTICLES_VISIBLES_DE_LA LISTE}    id=fr.satelix.logistique.demo:id/card_item_article
${ARTICLES_VISIBLES_DE_LA LISTE}    id=card_item_article
${ARTICLES_VISIBLES_DE_LA LISTE}    id=tv_item_article_html
${TAB_ITEMS_PICKED}                 //android.widget.LinearLayout[@content-desc="Items picked"]
# La pastille colis avec le petit carton}    id=tv_item_article_nb_pieces
${PASTILLE_COLIS}                   id=fab_colisage


*** Keywords ***

Afficher Liste des articles
    [Arguments]    ${liste_articles}
    Wait Until Page Contains    fr.satelix.logistique:id/input_text_recherche  
    Click Element    ${liste_articles}

La Liste Des Articles De La Commande S Affichent
    [Documentation]    Vérifie que le nombre d'articles affiché n'est aps à zéro
    ...                 et qu'au moins un article est affiché. 
    AppiumLibrary.Wait Until Element Is Visible    ${NOMBREARTICLE_AFFICHE}    15s    Le texte avec le nombre d'article n'est pas afiché.
    ${NombreArticle_lu}=    Lire Le Nombre D Articles Affiché
    Should Be True    ${NombreArticle_lu}    L'application affiche un nombre d'articles à ZERO
    ${ListeArticles}=    Lister Les Articles
    Should Be True    ${ListeArticles}    Aucun article n'est affiché à l'écran.

Preparer Les Articles Du Document
    [Documentation]    TODO : 
    ...                \n pour le moment le mot clé fonctionne avec les articles affichés à l'écran.
    ...                \n voir dicumentation de "Lister Les Articles" 
    AppiumLibrary.Wait Until Element Is Visible    ${NOMBREARTICLE_AFFICHE}    15s    Le texte avec le nombre d'articles n'est pas affiché.
    ${NombreArticle_lu}=    Lire Le Nombre D Articles Affiché
    ${ListeArticles}=    Lister Les Articles
    # Length Should Be    ${ListeArticles}    ${NombreArticle_lu}

    FOR    ${index}    IN RANGE    ${NombreArticle_lu}
        AppiumLibrary.Wait Until Page Contains Element    ${ARTICLES_VISIBLES_DE_LA LISTE}    6s
        AppiumLibrary.Wait Until Element Is Visible    ${ARTICLES_VISIBLES_DE_LA LISTE}    6s
        ${article}=     AppiumLibrary.Get Webelement   ${ARTICLES_VISIBLES_DE_LA LISTE}
        ${reference}    ${nomArticle}    ${emplacement}    ${colis}    ${quantite}    
        ...    Lire Les Informations De L Article    ${article}
        Choisir L Article A Preparer   ${article}
        ${Qte_restante}=    Lire La Quantite Restante A Preparer    ${Quantite}
        Preparer Les Quantités De L Article  ${reference}    ${nomArticle}    ${Qte_restante}
    END

Preparer Les Articles Du Document Avec Le Lecteur CodeBarre
    [Documentation]    Ce mot clé reprend le fonctionnement de la Préparation des articles 
    ...                avec l'utilisation d'un lecteur de code-barres.
    ...                /n Dans le cas où la donnée d'un code-barre est commune à plusieurs articles, 
    ...    l'application logsituqe flitre et affiche les articles correspodnant dasn une liste. Dans ce 
    ...    cas, ce mot clé choisi le premier de la liste pour pousuivre la préparation.

    AppiumLibrary.Wait Until Element Is Visible    ${NOMBREARTICLE_AFFICHE}    15s    Le texte avec le nombre d'articles n'est pas affiché.
    ${NombreArticle_lu}=    Lire Le Nombre D Articles Affiché
    ${ListeArticles}=    Lister Les Articles
    # Length Should Be    ${ListeArticles}    ${NombreArticle_lu}

    FOR    ${index}    IN RANGE    ${NombreArticle_lu}
        AppiumLibrary.Wait Until Page Contains Element    ${ARTICLES_VISIBLES_DE_LA LISTE}    6s
        AppiumLibrary.Wait Until Element Is Visible       ${ARTICLES_VISIBLES_DE_LA LISTE}    6s
        Get Text    ${ARTICLES_VISIBLES_DE_LA LISTE}
        ${article}=     AppiumLibrary.Get Webelement      ${ARTICLES_VISIBLES_DE_LA LISTE}
        ${reference}    ${nomArticle}    ${emplacement}    ${colis}    ${quantite}    
        ...    Lire Les Informations De L Article    ${article}
        Choisir L Article A Preparer Avec Le Lecteur CodeBarre   ${reference}
        ${status}=    Run Keyword And Return Status    AppiumLibrary.Wait Until Page Does Not Contain Element    ${NOMBREARTICLE_AFFICHE}
        Run Keyword If    ${status}    Choisir L Article A Preparer    ${reference}
        ${Qte_restante}=    Lire La Quantite Restante A Preparer    ${Quantite}
        Preparer Les Quantités De L Article  ${reference}    ${nomArticle}    ${Qte_restante}
    END

Lire La Quantite Demandee Pour Le Premier Article
    [Documentation]     Prend le Premier Article de la liste, 
    ...                 récupère la quantité Affichée et renvoie la quantité 
    ...                 avant le caractère "/"   
    [Arguments]    ${article}=${ARTICLES_VISIBLES_DE_LA LISTE}
   AppiumLibrary.Wait Until Page Contains Element    ${article}
    ${content-desc}=    AppiumLibrary.Get Element Attribute    ${article}    content-desc
    ${quantite}=    AppiumLibrary.Get Text
    ...  //*[@content-desc="${content-desc}"]/android.view.ViewGroup/android.widget.TextView[@resource-id="${appPackage}:id/tv_item_article_nb_pieces"]
    # ...  //*[@content-desc="${content-desc}"]/android.view.ViewGroup/android.widget.TextView[@id="tv_item_article_nb_pieces"]
    # ...  //*[@content-desc="${content-desc}"]/android.view.ViewGroup/android.widget.TextView[@resource-id="fr.satelix.logistique.demo:id/tv_item_article_nb_pieces"]
    ${quantiteRestante}=    Lire La Quantite Restante A Preparer        ${quantite}
    Return From Keyword    ${quantiteRestante}    

Lire Les Informations De L Article
    [Documentation]    
    ...    Prend la CardView d'un article en argument et lit les textView qui le composent:
    ...    \n par défaut c'est le premier Cardview qui est pris en compte.
    ...  Les composants vérifiés sont les textview qui possèdent les resource-id suivants :
    ...  \n resource-id="fr.satelix.logistique.demo:id/tv_item_article_html"
    ...  \n resource-id="fr.satelix.logistique.demo:id/tv_item_article_emplacement"
    ...  \n resource-id="fr.satelix.logistique.demo:id/tv_item_article_nb_pieces"
    ...  \n resource-id="fr.satelix.logistique.demo:id/tv_item_article_colis"
    ...  \n 
    ...  \n 5 textes sont retournés, si un des texte est vide, cela ne génère pas d'erreur.
    ...           
    [Arguments]    ${article}=${ARTICLES_VISIBLES_DE_LA LISTE}
#    AppiumLibrary.Wait Until Page Contains Element    ${article}
    ${content-desc}=    AppiumLibrary.Get Element Attribute    ${article}    content-desc
    # nom et lot de l'article
    ${nomArticleEtLot}=    AppiumLibrary.Get Text
    ...  //*[@content-desc="${content-desc}"]/android.view.ViewGroup/*[@resource-id="${appPackage}:id/tv_item_article_html"]
    ${nomArticleEtLot}=    Split To Lines    ${nomArticleEtLot}
    ${reference}=                Set Variable      ${nomArticleEtLot}[0]
    ${nomArticle}=         Set Variable      ${nomArticleEtLot}[1]
    # emplacement
    ${emplacement}=    AppiumLibrary.Get Text
    ...  //*[@content-desc="${content-desc}"]/android.view.ViewGroup/android.widget.TextView[@resource-id="${appPackage}:id/tv_item_article_emplacement"]
    # colis
    ${colis}=    AppiumLibrary.Get Text
    ...  //*[@content-desc="${content-desc}"]/android.view.ViewGroup/android.widget.TextView[@resource-id="${appPackage}:id/tv_item_article_colis"]
    # quantité
    ${quantite}=    AppiumLibrary.Get Text
    ...  //*[@content-desc="${content-desc}"]/android.view.ViewGroup/android.widget.TextView[@resource-id="${appPackage}:id/tv_item_article_nb_pieces"]
    
    Return From Keyword    ${reference}    ${nomArticle}    ${emplacement}    ${colis}    ${quantite}    

Choisir L Article A Preparer Par Son Nom
    [Documentation]    Clique sur le nom de l'article donné en Argument
    ...    <BR> Si le nom de l'aticle plusieurs fois sur la page, c'est la première occcurence qui est cliqué.
    ...    <BR> ce mot clé attend 5secondes par défaut.
    [Arguments]    ${nomArticle}    ${timeout}=5s
    Wait Until Page Contains    ${nomArticle}     ${timeout}   
    ...    L'article ${nomArticle} n'apparait pas dans la liste des article à peparer au bout de ${timeout}
    AppiumLibrary.Click Text    ${nomArticle}

Choisir l Article dans une Liste    
    [Arguments]    ${article}
    Swipe Down     ${article}
    Wait Until Element Is Visible    ${article}
    Click Element    ${article}    

Lister Les Articles
    [Documentation]    Lit la liste des composants de la page qui montre les articles
    ...          TO DO
    ...                \n pour le moment le mot clé fonctionne avec les acrticles affichés à l'écrans.
    ...                \n il faut créer un mot clé pour parcourir les artciles de la commande, ce mot doit renvoyer le nombre d'article
    ...                 et la liste des références.
    ${Articles}=    AppiumLibrary.Get Webelements    ${ARTICLES_VISIBLES_DE_LA LISTE}
    Return From Keyword    ${Articles}

Lire Le Nombre D Articles Affiché
    [Documentation]    Lit le composant le texte du haut de l'écran avec le nombre d'articles 
    ...                attendus dans la préparation.
    ${NombreArticle}=    AppiumLibrary.Get Text   ${NOMBREARTICLE_AFFICHE}
    ${NombreArticle}=    Split String    ${NombreArticle}
    Return From Keyword    ${NombreArticle}[0]

Choisir Le Premier Article De La Liste Des Articles Prepares
    Choisir Le Premier Article De La Liste A Preparer

Choisir Le Premier Article De La Liste A Preparer
    [Documentation]    Ce mot clé clique sur le premier element CardView de la liste
    AppiumLibrary.Wait Until Page Contains Element    ${ARTICLES_VISIBLES_DE_LA LISTE}
    AppiumLibrary.Wait Until Element Is Visible       ${ARTICLES_VISIBLES_DE_LA LISTE}
    AppiumLibrary.Click Element    ${ARTICLES_VISIBLES_DE_LA LISTE}
    
Choisir L Article A Preparer
    [Documentation]    Ce mot clé clique sur l'element CardView de l'article donné en 
    ...               argument
    [Arguments]    ${article}
    AppiumLibrary.Wait Until Element Is Visible    ${article}    15s    Il n'y a pas d'article à préparer dans pour cette péparation.
    AppiumLibrary.Click Element    ${article} 

Choisir L Article A Preparer Avec Le Lecteur CodeBarre
    [Documentation]    Ce mot clé attend la référence de l'article en entrée au format texte.
    ...   si la eference donnée est la même pour plusieurs articles du document, alors l'aplication
    ...    filtre les articles correspondants. 
    [Arguments]    ${reference}
    Sleep    0.5s
    #AppiumLibrary.Wait Until Element Is Visible    ${ARTICLES_VISIBLES_DE_LA LISTE}    15s    Il n'y a pas d'aticle à préparer dans pour cette péparation.
    utils.Scanner Un Code    ${reference} 


Chercher Un Article Par La Recheche
    [Documentation]    Utilisation de la recherche en haut de la page <BR>
    ...                L'article trouvé apparait automatiquement seul dans la liste des articles
    ...                S'il y a plusieurs articles, la liste est à gérée ou non, par défaut on 
    ...                considère que le 1er de la liste est pris en compte.
    [Arguments]    ${texteDeLaRecherche}
    AppiumLibrary.Input Text    ${CHAMP_RECHERCHE}    ${texteDeLaRecherche}

Afficher Les Articles Prepares
    [Documentation]    clique sur l'onglet des articles préparés
    ...                "items picked"
    Wait Until Element Is Visible    ${TAB_ITEMS_PICKED}    15s    L'onglet des articles préparés n'est pas disponible.
    Click Element    ${TAB_ITEMS_PICKED}

Appuyer Sur La Pastille Colis Avec Le Petit Carton
    AppiumLibrary.Wait Until Page Contains Element    ${PASTILLE_COLIS}
    AppiumLibrary.Click Element                       ${PASTILLE_COLIS}

Sélectionner à la main l'article dans la liste
    [Arguments]    ${article}
    module_preparation_listearticles.Choisir L Article A Preparer Par Son Nom    ${article}

Choisir l'article dans la liste
    [Documentation]  Clique sur le module passé en paramètre
    [Arguments]      ${article_name}
    ${article_present}    Run Keyword And Return Status    AppiumLibrary.Wait Until Page Contains    ${article_name}
    ...    3s
    ...    La liste des modules ne contient pas le module demandé ${article_name}  
    Run Keyword If    ${article_present}
    ...    AppiumLibrary.Click Text    ${article_name}
    ...  ELSE
    ...    Wait Until Keyword Succeeds    4x    0.5s    Faire Defiler Les Modules Pour Trouver Le Bon     ${article_name}

Scanner le code barre correspondant à l'article 
    [Arguments]    ${article}
    Choisir L Article A Preparer Avec Le Lecteur CodeBarre    ${article}

Scanner le code barre correspondant au lot 
    [Arguments]    ${lot}
    Choisir L Article A Preparer Avec Le Lecteur CodeBarre    ${lot}

Saisir l Article a la Main
    [Documentation]    Recherche un article en cliquant sur l'input de recherche et en tapant le nom de l'article.
    ...                Puis clique sur le bouton de validation
    [Arguments]    ${article}
    Wait Until Element Is Visible    fr.satelix.logistique:id/input_text_recherche
    Click Element    fr.satelix.logistique:id/input_text_recherche
    Input Text Into Current Element    ${article}
    Click Element    //android.widget.ImageButton[@content-desc="Valider cet article"]

Sélectionner à la main Un Article Avec 2 Criteres
    [Documentation]    Prend en entrée la référence d'un article et sa gamme, 
    ...                parcours la liste des articles visibles à preparer et choisit celui qui correspond 
    ...                TODO : les articles non visibles à l'écran ne sont pas pris en compte
    [Arguments]    ${reference}    ${gamme}
    AppiumLibrary.Wait Until Element Is Visible    ${ARTICLES_VISIBLES_DE_LA LISTE}
    # scrolle la liste pou afficher le premier aticle en entier
    ${myitems}    AppiumLibrary.Get Webelements    ${ARTICLES_VISIBLES_DE_LA LISTE}
    ${coordonnees}    AppiumLibrary.Get Element Rect    ${myitems}[1]
    ${y_offset}   Evaluate    ${coordonnees}[y]+${coordonnees}[height]
    AppiumLibrary.Swipe    ${coordonnees}[x]    ${coordonnees}[y]    0    ${y_offset}

    ${affichage_ref_article}      Set Variable    id=tv_item_article_html
    ${affichage_gamme_article}    Set Variable    id=tv_item_article_gamme_1
    FOR    ${element}    IN    @{myitems}
        ${ref_aticle}    AppiumLibrary.Get Webelement In Webelement    ${element}    ${affichage_ref_article}
        ${ref_article_correcte}    Run Keyword And Return Status    
        ...    AppiumLibrary.Element Should Contain Text    ${ref_aticle}    ${reference}
        Continue For Loop If    ${ref_article_correcte} == ${False}
        ${presence_ref_gamme}    Run Keyword And Return Status     
        ...    AppiumLibrary.Get Webelement In Webelement              ${element}    ${affichage_gamme_article}
        Continue For Loop If    ${presence_ref_gamme} == ${False}
        ${ref_gamme}    AppiumLibrary.Get Webelement In Webelement     ${element}    ${affichage_gamme_article}
        ${ref_article_correcte}    Run Keyword And Return Status    
        ...    AppiumLibrary.Element Should Contain Text    ${ref_gamme}    ${gamme}
        Continue For Loop If    ${ref_article_correcte} == ${False}
        AppiumLibrary.Click Element    ${element}
        Return From Keyword    ${True}
    END
    Fail    L'article ${reference} avec la gamme ${gamme} demandé n'a pas été trouvé dans la liste 
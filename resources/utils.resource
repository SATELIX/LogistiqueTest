*** Settings ***
Documentation    Ce fichier de ressources contient les mots clé robot
...              qui sont utiles globalement pou les tests et la gestion des 
...              liens avec Squash : lecture des jeux de données par exemple
...    
...    <BR>L'utilisation du clavier d'Android se fait come pour un tilisateur
...    en appuyat sur le touches du clavier. 
...    <BR> La correspondances de KEYCODE peut se retrouver à la page :
...    https://developer.android.com/reference/android/view/KeyEvent

Library    String
Resource   SatelixLogistique.resource

*** Variables ***
# Les Keycode Android pour gérer les entrées comme un utilisateur réel
&{KEYCODES}    0=7
...    1=8
...    2=9
...    3=10
...    4=11
...    5=12
...    6=13
...    7=14
...    8=15
...    9=16
...    .=158
...    ,=55
...    clear=28
...    del=67
...    select=109 
...    ctrl=4096
...    enter=66

*** Keywords ***
Press ENTER
    AppiumLibrary.Press Keycode    ${KEYCODES}[enter]
    
Taper Un Nombre Au Clavier   
    [Documentation]    Mot clé qui efface ce que contient la zone de texte
    ...    qui boucle sur chaque chiffre (et point) du nombre passé en argument
    ...    et qui envoie le KeyCode pour chaque chiffre correpsondant.
    [Arguments]     ${nombre}
    Supprimer Un Nombre Au Clavier
    ${nombre}=    Convert To String    ${nombre}
    ${chiffres_a_taper}=    Split String To Characters    ${nombre}
    FOR    ${chiffre}    IN    @{chiffres_a_taper}
        AppiumLibrary.Press Keycode    ${KEYCODES}[${chiffre}]
    END

Supprimer Un Nombre Au Clavier
    [Documentation]    Mot clé qui efface ce que contient la zone de texte
    ...    qui boucle sur chaque chiffre (et point) du nombre passé en argument
    ...    et qui envoie le KeyCode pour chaque chiffre correpsondant.
    AppiumLibrary.Press Keycode     ${KEYCODES}[del]    ${KEYCODES}[ctrl]



Lire La Quantite Restante A Preparer
    [Documentation]     Ce mot clé prend la quantié à préparer 
    ...                 qui est un texte au format QtyRestante/QtyTotale
    ...                 et renvoie la quantité restante à préparer : QtyRestante     
    [Arguments]  ${Quantite}
    ${QtyRestante}=    Split String    ${Quantite}    /
    RETURN    ${QtyRestante}[0]

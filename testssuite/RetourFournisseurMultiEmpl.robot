*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem


Resource   ${CURDIR}/../resources/module_preparation_listearticles.resource
Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/module_preparation.resource


Suite Setup     Set Log Level    TRACE
Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
${depot}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[1]
${Bijou SA}    //androidx.cardview.widget.CardView[@content-desc="Dépôt Bijou SA"]/android.view.ViewGroup
${fournisseur}    xpath=(//android.widget.ImageButton[@content-desc="Afficher la liste"])[2]
${DUBOI}    ?
${série}    ?
${MF80}     ?


*** Test Cases ***
Retour Fournisseur multi empl
    Sur le terminal, sélectionner le module                       Retour fournisseur multi empl
    Choisir au menu déroulant                                     ${depot}    ${Bijou SA}
    Choisir au menu déroulant                                     ${fournisseur}    ${DUBOI}
    Valider les informations
    Saisir l Article a la Main                                    BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Entrer une quantité et valider                                3
    Scanner le code barre correspondant à l'article               BAAR01
    Sélectionner l emplacement                                    3
    Scanner le code barre correspondant à l'article               LINGOR18
    Sélectionner l emplacement                                    A1T3N1P3
    Choisir Le Lot                                                LOT-10
    Entrer une quantité et valider                                1
    Scanner le code barre correspondant à l'article               LINGOR18;LOT-BDF9411123
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                2
    Saisir l Article a la Main                                    EM040
    Sélectionner l emplacement                                    A1T3N1P2
    Sélectionner le conditionnement vers droite                   ECRIN DE 12
    Entrer une quantité et valider                                1
    Scanner le code barre correspondant à l'article               EM050
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               EM050/24                    #Scan de l'article EM050 avec le conditionnement ECRIN DE 24
    Sélectionner l emplacement                                    A1T3N1P3
    Entrer une quantité et valider                                1
    Scanner le code barre correspondant à l'article               MODIV01
    Sélectionner l emplacement                                    A2T1N2P2
    Afficher Les Articles Disponibles
    Choisir au menu déroulant                                     ${série}    ${MF80}
    Valider les informations
    Scanner le code barre correspondant à l'article               MF84                        #numéro de série MF84
    Scanner le code barre correspondant à l'article               MF88                        #numéro de série n'existant pas
    Appuyer sur ok
    Scanner le code barre correspondant au lot                    MF81
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               EM055                        #article n'existant pas
    Appuyer sur ok
    Vider barre de recherche
    Saisir l Article a la Main                                    BAOR01
    Sélectionner l emplacement                                    A1T1N1P1
    Sélection gamme                                               Emeraude
    Entrer une quantité et valider                                4
    Scanner le code barre correspondant à l'article               21731003                     #article avec gamme associée
    Sélectionner l emplacement                                    A1T1N1P1
    Modifier une quantite                                         9
    Appuyer sur la flèche retour et "Mettre En Attente"
    Sur le terminal, sélectionner le module                       Retour fournisseur multi empl
    Cliquer sur Oui
    Saisir l Article a la Main                                    CHAAR/VAR
    Sélectionner l emplacement                                    A1T2N3P2
    Sélection gamme                                               42
    Sélection sous gamme                                          Forçat
    Entrer une quantité et valider                                2
    Scanner le code barre correspondant à l'article               38141025                    #article avec gammes associées
    Sélectionner l emplacement                                    A1T2N3P2
    Entrer une quantité et valider                                8
    Cliquer sur le bouton de finalisation
    #mettre date du jour
    Appuyer sur Transferer
    Valider



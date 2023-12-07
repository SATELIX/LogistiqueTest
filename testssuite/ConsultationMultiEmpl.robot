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
${série}
${MF80}
${LINGOR18}
${A1T2N3P2}
${A1T1N1P1}


*** Test Cases ***
ConsultationMultiEmpl
    Sur le terminal, sélectionner le module                       Consultation Multi Empl
    Sélectionner le document                                      Bijou SA
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Valider La Quantité
    Appuyer sur la flèche retour
    Afficher Les Lots Disponibles
    Scroll Vers Element                                           ${LINGOR18}    bas
    Sélectionner l article                                        LINGOR18
    Sélectionner l emplacement                                    A1T3N1P3
    Scanner le code barre correspondant au lot                    LOT-0000
    Appuyer sur ok
    Choisir Le Lot                                                LOT-10
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant au lot                    LINGOR18;LOT-10
    Scroll Vers Element                                           ${A1T1N1P1}    haut
    Scanner le code barre correspondant à l'article               A1T1N1P1        #à modifier
    Modifier une quantite                                         180
    Confirmer régularisation
    Saisir l Article a la Main                                    EM040
    Sélectionner l emplacement                                    A1T3N1P2
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               EM040/12
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               EM050
    Sélectionner l emplacement                                    A1T3N1P3
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               EM050/24
    Sélectionner l emplacement                                    A1T3N1P3
    Sélectionner le conditionnement vers gauche                   ECRIN DE 4
    Entrer une quantité et valider                                50
    Saisir l Article a la Main                                    MODIV01
    Sélectionner l emplacement                                    A2T1N2P2
    Choisir au menu déroulant                                     ${série}    ${MF80}
    Valider
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               MODIV01
    Sélectionner l emplacement                                    A2T1N2P2
    Scanner le code barre correspondant à l'article               MF81
    Scanner le code barre correspondant à l'article               MF90
    Appuyer sur la flèche retour
    Afficher Les Lots Disponibles
    Sélectionner l article                                        BAOR01
    Scroll Vers Element                                           ${A1T1N1P1}    haut
    Sélectionner l emplacement                                    A1T1N1P1
    Sélection gamme                                               Emeraude
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               21731003            #scan de l'article avec la gamme associée
    Sélectionner l emplacement                                    A1T1N1P2
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Afficher Les Lots Disponibles
    Sélectionner l article                                        CHAAR/VAR
    Scroll Vers Element                                           ${A1T2N3P2}    haut
    Sélectionner l emplacement                                    A1T2N3P2
    Sélection gamme                                               42
    Sélection sous gamme                                          Forçat
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article               38141025            #scan de l'article avec les gammes associées
    Sélectionner l emplacement                                    A1T2N3P2
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour







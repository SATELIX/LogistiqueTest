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
${série}            //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
${MF80}
${LINGOR18}        //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Lingot Or 18 cts"]/android.view.ViewGroup
${A1T2N3P2}        //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T2 Niv N3 Pos P2"]/android.view.ViewGroup
${A1T1N1P1}        //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P1"]/android.view.ViewGroup
${A2T1N2P2}        //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A2 Trav T1 Niv N2 Pos P2"]/android.view.ViewGroup
${A1T1N1P2}        //androidx.cardview.widget.CardView[@content-desc="Emplacement Allée A1 Trav T1 Niv N1 Pos P2"]/android.view.ViewGroup
${BAOR01}        //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Article suivi en lot avec conditionnement virtuel"]/android.view.ViewGroup


#fonction ok, pb de scan pour un lot, pb de bdd
*** Test Cases ***
ConsultationMultiEmpl
    Sur le terminal, sélectionner le module                       Consultation Multi Empl
    Sélectionner le document nom exact                            Bijou SA
    Afficher Les Articles Disponibles
    Sélectionner l article                                        BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               BAAR01
    Sélectionner l emplacement                                    A1T2N1P2
    Sleep                                                         1s
    Valider La Quantité
    Appuyer sur la flèche retour
    Afficher Les Lots Disponibles
    Sleep                                                         2s
    Scroll Vers Element                                           ${LINGOR18}    bas
    Sélectionner l article                                        LINGOR18
    Sélectionner l emplacement                                    A1T3N1P3
    Sleep                                                         2s
    Scanner le code barre correspondant au lot                    LOT-0000
    Appuyer sur ok
    Choisir Le Lot                                                LOT-10
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                         1s
    Scanner le code barre correspondant au lot                    LINGOR18\\;LOT-10
    Sleep                                                         2s
    Scroll Vers Element                                           ${A1T1N1P1}    haut
    Sleep                                                         2s          
    Scanner le code barre correspondant à l'article               A1T1N1P1
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s 
    Modifier un stock                                             180
    Sleep                                                         2s
    Confirmer régularisation
    Saisir l Article a la Main                                    EM040
    Sélectionner l emplacement                                    A1T3N1P2
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               EM040/12
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               EM050
    Sélectionner l emplacement                                    A1T3N1P3
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Appuyer sur la flèche retour

    # Scanner le code barre correspondant à l'article               EM050/24
    # Sélectionner l emplacement                                    A1T3N1P3
    # Sélectionner le conditionnement vers gauche                   ECRIN DE 4                #Pb bdd num séries
    # Entrer une quantité et valider                                50
    # Sleep                                                         2s
    # Saisir l Article a la Main                                    MODIV01
    # Sélectionner l emplacement                                    A2T1N2P2
    # Choisir au menu déroulant                                     ${série}    ${MF80}
    # Valider series
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               MODIV01
    Sleep                                                         2s
    Scroll Vers Element                                           ${A2T1N2P2}    bas        
    Sélectionner l emplacement                                    A2T1N2P2
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               MF81
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               MF90
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Appuyer sur la flèche retour
    Afficher Les Articles Disponibles
    Sleep                                                         2s
    Scroll Vers Element                                           ${BAOR01}    haut
    Sélectionner l article                                        BAOR01
    Sleep                                                         2s
    Scroll Vers Element                                           ${A1T1N1P1}    haut
    Sélectionner l emplacement                                    A1T1N1P1
    Sélection gamme                                               Emeraude
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003            #scan de l'article avec la gamme associée
    Scroll Vers Element                                           ${A1T1N1P2}    haut            
    Sélectionner le document par element                          ${A1T1N1P2}        #sélectioner emplacement via l'element
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    # Afficher Les Articles Disponibles
    # Sleep    2s
    # Sélectionner l article                                        CHAAR/VAR
    # Scroll Vers Element                                           ${A1T2N3P2}    haut        #pb bdd gammes
    # Sélectionner l emplacement                                    A1T2N3P2
    # Sélection gamme                                               42
    # Sélection sous gamme                                          Forçat
    # Appuyer sur la flèche retour
    # Appuyer sur la flèche retour
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               38141025            #scan de l'article avec les gammes associées
    Scroll Vers Element                                           ${A1T2N3P2}   haut
    Sélectionner l emplacement                                    A1T2N3P2
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                         5s







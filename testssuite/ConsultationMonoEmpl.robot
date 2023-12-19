*** Settings ***
Documentation    Reprise du Cas de Test
...    

Library    String
Library    AppiumLibrary
Library    OperatingSystem



Resource    ../resources/module_prepaationLivrason.resource
Resource    ../resources/module_preparation.resource



Suite Setup     Set Log Level    TRACE
# Test Setup      Lire Les Variables Du Tests Et Demarrer L Application
# Test Teardown   Run Keyword And Ignore Error    AppiumLibrary.Terminate Application    ${appPackage}




*** Variables ***
${info}    fr.satelix.logistique:id/bt_fiche_article
${modif}    fr.satelix.logistique:id/fab_edition_fiche
${numserie}    //android.widget.ImageButton[@content-desc="Afficher le menu déroulant"]
${MF82}    //android.view.ViewGroup[@content-desc="Sélectionner le numéro de série MF82"]
${BAAR01}    //androidx.cardview.widget.CardView[@content-desc="Sélectionner l'article Bague Argent"]/android.view.ViewGroup


#fonction ok, modifier modifier code barre, pb bdd lots
*** Test Cases ***
ConsultationMonoEmpl
    LeDernierTestEstIlTermine
    Sur le terminal, sélectionner le module                  Consultation Mono Empl
    Sleep                                                    2s
    Sélectionner le document nom exact                       Bijou SA
    Sleep                                                    1s
    Afficher Les Articles Disponibles                                                   
    Sélectionner l article                                   BAAR01
    Sleep                                                    2s
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                    5s
    Cliquer sur le bouton de finalisation
    Sleep                                                    4s
    Sur le terminal, sélectionner le module                  Consultation Mono Empl
    Sleep                                                    2s
    Sélectionner le document nom exact                       Bijou SA
    Sleep                                                    5s
    Saisir l Article a la Main                               BA
    Cliquer sur Non
    Sleep                                                    2s
    Sélectionner l article par element                       ${BAAR01}
    Sleep                                                    2s
    Appuyer sur la flèche retour
    Sélectionner le document par element                     ${info}
    Sélectionner le document par element                     ${modif} 
    Modifier code barre                                      1234567890128
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          1234567890128
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Saisir l Article a la Main                               LINGOR18
    Appuyer sur la flèche retour
    # Scanner le code barre correspondant au lot               LINGOR18\\;LOT-TEST2        #Pb lot bdd
    # Scanner le code barre correspondant au lot               LINGOR18\\:LOT-10           
    Saisir l Article a la Main                               EM040
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          EM040
    Appuyer sur la flèche retour   
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          EM040/12
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Saisir l Article a la Main                               EM050
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          EM050
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          EM050/24
    Sélectionner le conditionnement vers gauche              ECRIN DE 4
    Entrer une quantité et valider                           60
    Saisir l Article a la Main                               MODIV01
    Choisir au menu déroulant avec scroll                    ${numserie}   ${MF82}
    Valider series
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          MODIV01\\;MF81        #ne comprend pas la série
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          MF80
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          MF90
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          MODIV01\\;MF81
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Saisir l Article a la Main                               BAOR01
    Sélection gamme                                          Emeraude
    Sleep                                                    2s
    Hide Keyboard
    Sleep                                                    2s
    Appuyer sur la flèche retour
    Scanner le code barre correspondant à l'article          BAOR01
    Sleep                                                    2s
    Sélection gamme                                          Rubis
    Appuyer sur la flèche retour
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Scanner le code barre correspondant à l'article          21731003            #scan de l'article avec la gamme associée
    Sleep                                                    2s
    Appuyer sur la flèche retour
    Sleep                                                    2s
    Appuyer sur la flèche retour
    Saisir l Article a la Main                               CHAAR/VAR
    Sélection gamme                                          42
    Sélection sous gamme                                     Forçat
    Appuyer sur la flèche retour
    Sleep                                                    5s
    Appuyer sur la flèche retour
    Sleep                                                    5s
    Scanner le code barre correspondant à l'article          38141025            #scan de l'article avec les gammes associées
    Entrer une quantité max et valider
    Cliquer sur le bouton de finalisation
    Sleep                                                    5s





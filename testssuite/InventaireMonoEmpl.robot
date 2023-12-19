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


#Test OK, pb lot bdd
*** Test Cases ***
InventaireMonoEmpl
    LeDernierTestEstIlTermine
    #Ouvrir le BO test et choisir l'inventaire "InventaireTestMono"
    Sur le terminal, sélectionner le module                       Inventaire mono empl
    Sélectionner le document                                      InventaireTestMono
    Saisir l Article a la Main                                    BAAR01
    Entrer une quantité et valider                                150
    Cliquer sur le bouton de finalisation
    Sleep                                                         2s
    #Dans le BO, retourner sur le tableau de l'inventaire et cliquer sur l'icone "Actualiser"
    #Modifier la quantité inventaire et mettre 145
    Sur le terminal, sélectionner le module                       Inventaire mono empl
    Sélectionner le document                                      InventaireTestMono
    Saisir l Article a la Main                                    BA
    Sélectionner l article                                        BAAR01
    Modifier une quantite                                         145
    Sleep                                                         2s
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"
    # Cliquer sur le bouton de finalisation
    # Sur le terminal, sélectionner le module                       Inventaire mono empl
    # Sélectionner le document                                      InventaireTestMono
    # Scanner le code barre correspondant à l'article               LINGOR18;LOT-BDF9411123         #pb lot bdd
    # Entrer une quantité et valider                                5
    # Saisir l Article a la Main                                    LINGOR18
    # Choisir Le Lot                                                LOT-999
    # Entrer une quantité et valider                                10
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"
    #Toujours dans le BO cliquer sur "Quantité inventaire" de la ligne de l'article BAOR01 avec Emeraude en "Gamme premier niveau"
    #Ecrire 20 comme quantité et valider
    Cliquer sur le bouton de finalisation
    Sur le terminal, sélectionner le module                       Inventaire mono empl
    Sélectionner le document                                      InventaireTestMono
    Saisir l Article a la Main                                    BAOR01
    Sélection gamme                                               Emeraude
    Sleep                                                         2s
    Entrer une quantité et valider                                20
    Sleep                                                         2s
    Scanner le code barre correspondant à l'article               21731003                #article BAOR01 avec la gamme Emeraude
    Entrer une quantité et valider                                12
    Cliquer sur le bouton de finalisation
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"
    #Cliquer sur le bouton "Afficher" dans la colonne "Utilisateur(s)"
    Sleep                                                         2s
    Sur le terminal, sélectionner le module                       Inventaire mono empl
    Sélectionner le document                                      InventaireTestMono
    Saisir l Article a la Main                                    CHAAR/VAR
    Sleep                                                         2s
    Sélection gamme                                               42
    Sleep                                                         2s
    Sélection sous gamme                                          Forçat                                            
    Sleep                                                         2s
    Entrer une quantité et valider                                10
    Sleep                                                         2s
    Cliquer sur le bouton de finalisation
    Sleep                                                         5s
    #Retourner sur le tableau de l'inventaire du BO et cliquer sur l'icone "Actualiser"
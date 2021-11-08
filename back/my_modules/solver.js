const solver = {

    board: {
        data: {

            line: [], //contiendra les données de la grille en lecture en lignes
            column: [], //contiendra les données de la grille en lecture en colonnes
            square: [], //contiendra les données de la grille en lecture en carrés
            emptyCells: [], //tableau des cellules vides, leurs coordonnées (la prochaine vide est la prochaine à être calculée)
        },

        isFinished: function () {//passera à true si le solveur a réussi: tous les chiffres >0 et un total par ligne/colonne/square de xx

        },

        tracker: [ //tableau recensent toutes les cellules calculées, chaque cellule est un objet (coordonnées, résultats possibles et résultats testés)
            {
                cellCalculated: [],
                possibleResults: [],
                testedResults: [] //coordonnées des cellules calculées
            }
        ],

        calculateCell: function () {

            //fonction qui calcule tous les résultats possibles pour une cellule
        },

        solve: function () { //fonction solver récursive

            //On prends la première cellule vide dans [emptyCells]
            //On calcule cette cellule vide (tous les résultats possibles) à l'aide de la fonction calculateCell

            //Si on a plusieurs résultats possibles:
            //On enregistre la cellule calculée, les résultats possibles et le résultat testé (ce sera le premier résultat trouvé) dans le tracker
            //on enlève les coordonnées de cette cellule du tableau des cellules vides
            //on remplit board.data (ligne/colonne/square) avec la valeur que l'on teste
            //on vérifie si la grille est terminée avec la méthode isFinished 
            //-> si oui on fait un return pour stopper la fonction
            //-> si non on relance le solveur (récursivité)

            //S'il n'y a pas de solution trouvée, cela signifie qu'il faut revenir en arrière sur les choix effectués

            //BOUCLE
            //On regarde dans le tracker la dernière cellule qui a été calculée et on voit s'il reste des résultats possibles

            //Si on a au moins encore 1 résultat possible alors:
            //On met à jour le tracker : résultats possibles, résultats testés
            //on met à jour board.data (ligne/colonne/square) avec la valeur que l'on teste à la place de l'ancienne
            //on vérifie si la grille est terminée avec la méthode isFinished
            //-> si oui on fait un return pour stopper la fonction
            //-> si non on relance le solveur (récursivité)

            //Si on a pas d'autres résultats possibles dans le tracker pour la cellule précédente
            //On supprime du tracker la référence précédente
            //on supprime de board.data (ligne/colonne/square) la valeur qui n'était pas bonne
            //on remplit emptyCells avec la cellule car elle redevient vide
            //TODO on retourne sur boucle - voir comment faire (s'agit-il d'une fonction? ou d'une boucle while ?)

        },

        speedUpSolve: function () { //fonction qui résous quelques cellules pour lesquelles il n'y avait qu'un seul résultat possible

        },
    }

module.exports = solver;
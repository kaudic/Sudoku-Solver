const login = {

    init: () => {

        //Donner un addEventListenner au bouton de modification afin de Rendre les input modifiables
        //Et également modifier le comportement du bouton Annuler

        const amendBtnElt = document.getElementById('amendAccount');

        amendBtnElt.addEventListener('click', (e) => {
            e.preventDefault();

            const inputs = document.getElementsByTagName('input');

            for (const input of inputs) {
                input.disabled = false;
                input.style.backgroundColor = 'white';
                input.style.color = 'black';
            }


            //Modification du comportement d'un bouton Annuler 
            //Il ne va plus retourner sur la page d'accueil, il va refresh la page

            const cancelAccountModification = document.getElementById('cancelAccountModification');
            cancelAccountModification.removeEventListener('click', login.cancelBtnHandler);
            cancelAccountModification.addEventListener('click', (e) => {
                e.preventDefault();
                location.reload();

            });

            //Création du bouton de validation

            const accountValidation = document.createElement('button');
            accountValidation.textContent = 'Valider';
            accountValidation.className = 'loginFormBtn';
            document.getElementById('loginBtnBar').appendChild(accountValidation);
            accountValidation.addEventListener('click', (e) => {
                //On modifie la route du formulaire
                const formElts = document.getElementsByTagName('form');
                formElts[0].action = '/sudoku/login/modify';
            });

            //Création du bouton de suppression

            const deleteAccount = document.createElement('button');
            deleteAccount.textContent = 'Supprimer';
            deleteAccount.className = 'loginFormBtnDelete';
            document.getElementById('loginBtnBar').appendChild(deleteAccount);
            deleteAccount.addEventListener('click', (e) => {
                //On modifie la route du formulaire
                const formElts = document.getElementsByTagName('form');
                formElts[0].action = '/sudoku/login/delete';
            });

        });


        //Comportement initial du bouton annuler
        const cancelAccountModification = document.getElementById('cancelAccountModification');
        cancelAccountModification.addEventListener('click', login.cancelBtnHandler);
    },

    cancelBtnHandler: (e) => {
        e.preventDefault();
        window.location.href = `${app.baseUrl}/sudoku`;
    },

};

document.addEventListener('DOMContentLoaded', login.init);




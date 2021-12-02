const menu = {

    init: () => {

        menu.menuBurger();
        menu.setDisplaySettings();

    },

    menuBurger: () => {

        //Gestion de l'affichage du Menu
        const menuBurger = document.getElementById('menuBurger');

        if (menuBurger) { //condition qui permet de savoir si on est sur la page de connexion et si oui on appliquera qd même les couleurs présentes dans le localstorage 
            menuBurger.addEventListener('click', () => {
                const menuBurgerMenu = document.getElementsByClassName('menuBurger')[0];

                if (menuBurgerMenu.style.display != 'block') {
                    menuBurgerMenu.style.display = 'block';

                } else {
                    menuBurgerMenu.style.display = 'none';
                }
            });


            //Gestion du bouton nuit/jour, menu accessible uniquement pour les utilisateurs connectés
            //On va mettre à jour la table actor avec le choix décidé
            //Puis on va requêter la table actor et display pour connaître les couleurs choisies

            const toggleDayNightBtnElt = document.getElementById('toggleDayNight');

            toggleDayNightBtnElt.addEventListener('click', (e) => {
                e.preventDefault();

                const toggleEltValue = e.target.value;
                let displayId = null;

                switch (toggleEltValue) {
                    case '0':
                        displayId = 2;
                        break;
                    case '1':
                        displayId = 1;
                        break;
                };

                const route = '/sudoku/displaySettings/update/' + displayId;
                console.log(route);

                //On met à jour la table client 
                //(si val = 0 alors mode nuit on met l'id 2 dans la table actor)
                //(si val = 1 alors mode jour on met l'id 1 dans la table actor)

                fetch(route) //on fait une demande au back des couleurs choisies par l'utilisateur
                    .then(function (response) {
                        if (response) {
                            console.log('Table actor mis à jour avec l\'affichage souhaité.')
                        }
                    });


                //on requête la table actor pour récupérer les couleurs correspondants à son choix
                fetch('/sudoku/displaySettings/getColors') //on fait une demande au back des couleurs choisies par l'utilisateur
                    .then(function (response) {
                        const responseTreated = response.json(); //on décrypte la réponse du back
                        return responseTreated;
                    })
                    .then((colors) => {
                        console.log((colors));

                        //On applique les couleurs réceptionnées
                        document.documentElement.style.setProperty('--color1', colors.display_color1);
                        document.documentElement.style.setProperty('--color2', colors.display_color2);
                        document.documentElement.style.setProperty('--color3', colors.display_color3);
                        document.documentElement.style.setProperty('--color4', colors.display_color4);
                        document.documentElement.style.setProperty('--color5', colors.display_color5);

                        //TODO si le local storage colorsSettings existe alors on le modifie
                        //TODO S'il n'existe pas on le créé

                        //on enregistre dans le localstorage les préférences utilisateurs
                        localStorage.setItem('colorsSettings', JSON.stringify(colors));

                    });

            });
        }
    },

    setDisplaySettings: () => {

        //On va chercher les couleurs dans le local storage

        const colors = localStorage.getItem('colorsSettings');
        const parsedColors = JSON.parse(colors);

        //On applique les couleurs du local storage
        document.documentElement.style.setProperty('--color1', parsedColors.display_color1);
        document.documentElement.style.setProperty('--color2', parsedColors.display_color2);
        document.documentElement.style.setProperty('--color3', parsedColors.display_color3);
        document.documentElement.style.setProperty('--color4', parsedColors.display_color4);
        document.documentElement.style.setProperty('--color5', parsedColors.display_color5);

        //On positionne le curseur du toggleDayNight en fonction de la valeur du localHost

        const toggleDayNightBtnElt = document.getElementById('toggleDayNight');

        console.log('parsedColors.display_type:' + parsedColors.display_type);

        if (parsedColors.display_type === 'LIGHT') {
            toggleDayNightBtnElt.value = 0;
        } else {
            toggleDayNightBtnElt.value = 0;
        }

    }

};


//Lancement de la gestion de l'affichage du menu Burger

document.addEventListener('DOMContentLoaded', menu.init());
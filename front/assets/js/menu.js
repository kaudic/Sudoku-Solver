const menu = {

    menuBurger: () => {
        const menuBurger = document.getElementById('menuBurger');
        menuBurger.addEventListener('click', () => {
            const menuBurgerMenu = document.getElementsByClassName('menuBurger')[0];

            if (menuBurgerMenu.style.display != 'block') {
                menuBurgerMenu.style.display = 'block';

            } else {
                menuBurgerMenu.style.display = 'none';
            }
        });
    }
};


//Lancement de la gestion de l'affichage du menu Burger

document.addEventListener('DOMContentLoaded', menu.menuBurger());
const menu = {

    menuBurger: () => {
        const menuBurger = document.getElementById('menuBurger');
        menuBurger.addEventListener('click', () => {
            const menuBurgerMenu = document.getElementsByClassName('menuBurger');
            menuBurgerMenu[0].style.display = 'block';
        });
    }
};


//Lancement de la gestion de l'affichage du menu Burger

document.addEventListener('DOMContentLoaded', menu.menuBurger());
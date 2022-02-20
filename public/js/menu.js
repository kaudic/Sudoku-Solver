const menu = {

    init: () => {
        menu.menuBurger();
        menu.setDisplaySettings();
    },

    // Création Listenner pour afficher/masquer le menu burger
    menuBurgerSetDisplay() {
        const menuBurger = document.getElementById('menuBurger');
        if (menuBurger) {
            menuBurger.addEventListener('click', () => {
                const menuBurgerMenu = document.getElementsByClassName('menuBurger')[0];
                if (menuBurgerMenu.style.display !== 'block') {
                    menu.menuBurgerInitialModeState();
                    menuBurgerMenu.style.display = 'block';
                } else {
                    menuBurgerMenu.style.display = 'none';
                }
            });
        }
    },

    // lecture LS pour setup affichage toggle de manière cohérente avec le mode
    menuBurgerInitialModeState() {
        const toggleDayNightBtnElt = document.getElementById('toggleDayNight');
        const mode = menu.getColorsModeInLS();
        if (mode === 'BRIGHT') {
            toggleDayNightBtnElt.value = 1;
        } else {
            toggleDayNightBtnElt.value = 0;
        }
    },

    // Création du listenner sur le toggle pour MAJ pref user 0/1 DARK/BRIGHT
    menuBurgerSetDarkModeToggle() {
        const toggleDayNightBtnElt = document.getElementById('toggleDayNight');
        toggleDayNightBtnElt.addEventListener('click', (e) => {
            e.preventDefault();
            const displayId = Number(e.target.value) + 1;
            fetch(`/api/settings/colors/${displayId}`, { method: 'PUT' });
            menu.menuBurgerSetColors();
        });
    },

    // Requête sur la BDD pour voir les couleurs choisies
    // Lancement de setColorsInLS pour mettre à jour le LS
    // Lancement de setDisplaySettings pour mettre à jour le fichier CSS
    menuBurgerSetColors() {
        fetch('/api/settings/colors')
            .then((res) => res.json())
            .then((colors) => {
                menu.setColorsInLS(colors);
                menu.setDisplaySettings();
            });
    },

    // Lit le LS et renvoie BRIGHT ou DARK
    getColorsModeInLS() {
        const parsedColors = JSON.parse(localStorage.getItem('colorsSettings'));
        return parsedColors.display_type;
    },

    // Enregistrement dans LS des couleurs passées en param
    setColorsInLS(colors) {
        localStorage.setItem('colorsSettings', JSON.stringify(colors));
    },

    // Lancement de 3 fcts
    // 1-Création Listenner pour afficher/masquer le menu burger
    // 2-Création du listenner sur le toggle pour MAJ pref user 0/1 DARK/BRIGHT
    // 3-Requête sur la BDD pour voir les couleurs choisies
    // 3-Application des couleurs dans le fichier CSS
    // 3-Lancement de setColorsInLS pour mettre à jour le LS
    menuBurger() {
        menu.menuBurgerSetDisplay();
        menu.menuBurgerSetDarkModeToggle();
        menu.menuBurgerSetColors();
    },

    // Lecture du localStorage et application des pref sur le fichier CSS
    setDisplaySettings: () => {
        const parsedColors = JSON.parse(localStorage.getItem('colorsSettings'));
        document.documentElement.style.setProperty('--color1', parsedColors.display_color1);
        document.documentElement.style.setProperty('--color2', parsedColors.display_color2);
        document.documentElement.style.setProperty('--color3', parsedColors.display_color3);
        document.documentElement.style.setProperty('--color4', parsedColors.display_color4);
        document.documentElement.style.setProperty('--color5', parsedColors.display_color5);
    },
};

// Lancement de la gestion de l'affichage du menu Burger
document.addEventListener('DOMContentLoaded', menu.init());

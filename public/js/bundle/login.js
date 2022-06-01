(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
// const app = require('./app');

const login = {
    init() {
        login.addListennerToActions();
    },

    addListennerToActions() {
        // également modifier le comportement du bouton Annuler
        const modifyBtnElt = document.getElementById('amendAccount');
        modifyBtnElt.addEventListener('click', login.modifyBtnHandler);

        // Comportement initial du bouton annuler
        const cancelAccountModification = document.getElementById('cancelAccountModification');
        cancelAccountModification.addEventListener('click', login.cancelBtnHandler);
    },

    changeStyles() {
        const form = document.getElementById('loginForm');
        const inputs = form.querySelectorAll('input');
        inputs.forEach((input) => {
            input.disabled = false;
            input.style.backgroundColor = 'white';
            input.style.color = 'black';
        });
    },

    changeCancelBtn() {
        // Modification du comportement d'un bouton Annuler
        // Il ne va plus retourner sur la page d'accueil, il va refresh la page
        const cancelAccountModification = document.getElementById('cancelAccountModification');
        cancelAccountModification.removeEventListener('click', login.cancelBtnHandler);
        cancelAccountModification.addEventListener('click', (e) => {
            e.preventDefault();
            window.location.reload();
        });
    },

    createValidationBtn() {
        // if accountValidation button already exists then return
        if (document.getElementById('accountValidation')) {
            return;
        }
        // Création du bouton de validation
        const accountValidation = document.createElement('button');
        accountValidation.id = 'accountValidation';
        accountValidation.textContent = 'Valider';
        accountValidation.className = 'loginFormBtn';
        document.getElementById('loginBtnBar').appendChild(accountValidation);
        accountValidation.addEventListener('click', () => {
            // On modifie la route du formulaire
            const formElts = document.getElementsByTagName('form');
            formElts[0].action = '/sudoku/login/modify';
        });
    },

    createDeleteBtn() {
        // if deleteAccount button already exists then return
        if (document.getElementById('deleteAccount')) {
            return;
        }
        // Création du bouton de suppression
        const deleteAccount = document.createElement('button');
        deleteAccount.id = 'deleteAccount';
        deleteAccount.textContent = 'Supprimer';
        deleteAccount.className = 'loginFormBtnDelete';
        document.getElementById('loginBtnBar').appendChild(deleteAccount);
        deleteAccount.addEventListener('click', () => {
            // On modifie la route du formulaire
            const formElts = document.getElementsByTagName('form');
            formElts[0].action = '/sudoku/login/delete';
        });
    },

    modifyBtnHandler(e) {
        e.preventDefault();
        login.changeStyles();
        login.changeCancelBtn();
        login.createValidationBtn();
        login.createDeleteBtn();
    },

    cancelBtnHandler(e) {
        e.preventDefault();
        // window.location.href = `${app.baseUrl}/sudoku`;
        window.location.href = `http://localhost:3000/sudoku`;
    },
};

document.addEventListener('DOMContentLoaded', login.init);

},{}]},{},[1]);

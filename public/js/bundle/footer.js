(function(){function r(e,n,t){function o(i,f){if(!n[i]){if(!e[i]){var c="function"==typeof require&&require;if(!f&&c)return c(i,!0);if(u)return u(i,!0);var a=new Error("Cannot find module '"+i+"'");throw a.code="MODULE_NOT_FOUND",a}var p=n[i]={exports:{}};e[i][0].call(p.exports,function(r){var n=e[i][1][r];return o(n||r)},p,p.exports,r,e,n,t)}return n[i].exports}for(var u="function"==typeof require&&require,i=0;i<t.length;i++)o(t[i]);return o}return r})()({1:[function(require,module,exports){
const footer = {
    init: () => {
        console.log('Footer initialisé');
        footer.addListenerToAction();
    },
    addListenerToAction: () => {
        const hideLegalNoticeBtn = document.querySelector('.mentions_modal__retour');
        hideLegalNoticeBtn.addEventListener('click', footer.hideLegalNotice);
        const showLegalNoticeBtn = document.querySelector('.Footer-nav__Legal_Notice');
        showLegalNoticeBtn.addEventListener('click', footer.showLegalNotice);
    },
    hideLegalNotice: () => {
        document.querySelector('.mentions_modal').classList.add('hidden');
    },
    showLegalNotice: async (e) => {
        e.preventDefault();
        // Get the legal notice from the back side
        let legalNotice = await fetch(`${BASE_URL}/api/settings/mentions`);
        legalNotice = await legalNotice.json();
        const legalNoticeTextArea = document.querySelector('.mentions_modal__text');
        legalNoticeTextArea.innerHTML = legalNotice.legalNoticeText.legal_notice_text;
        document.querySelector('.mentions_modal').classList.remove('hidden');
    },
};

document.addEventListener('DOMContentLoaded', footer.init);

},{}]},{},[1]);

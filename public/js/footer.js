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

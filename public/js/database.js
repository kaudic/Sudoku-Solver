var Swal = require('sweetalert2');

const database = {
    init: () => {
        console.log('initialisation du script de la database');
        // we give the generate button a function to fetch on the API the generation script
        const generateBtn = document.getElementById('dataGeneratorBtn');
        generateBtn.addEventListener('click', database.generateBoards);
    },
    generateBoards: async (e) => {
        e.preventDefault();
        const formElement = document.querySelector('.main-form');
        const formData = new FormData(formElement);
        const generationResult = await fetch(`${BASE_URL}/api/db/generate`,
            {
                method: "POST",
                body: formData,
            })
            .then((res) => res.json());

        console.log(JSON.stringify(generationResult));

        if (generationResult.result === true) {
            Swal.fire({
                title: 'Les grilles ont été générées !',
                icon: 'success',
                confirmButtonText: 'OK'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.reload();
                }
            });
        } else {
            Swal.fire({
                title: 'Les grilles n\'ont pas été générées',
                text: `${generationResult.message}`,
                icon: 'error',
                confirmButtonText: 'OK'
            });
        };
    },
};

document.addEventListener('DOMContentLoaded', database.init);

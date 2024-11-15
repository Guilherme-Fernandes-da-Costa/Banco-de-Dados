document.getElementById('loginForm').addEventListener('submit', function(e) {
    e.preventDefault();
    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    if (username === 'Patricia' && password === '12345') {
        const logoImage = document.getElementById('logoImage');
        const logoVideo = document.getElementById('logoVideo');

        // Esconde a imagem
        logoImage.style.display = 'none';

        // Mostra e reproduz o vídeo
        logoVideo.style.display = 'block';
        logoVideo.play();

        // Opcional: Se você quiser que o vídeo volte para a imagem quando terminar
        logoVideo.addEventListener('ended', function() {
            logoVideo.style.display = 'none';
            logoImage.style.display = 'block';
        });

        // Redireciona para a nova página
        window.location.href = 'nova-pagina.html';
    } else {
        alert('Usuário ou senha incorretos');
    }
});
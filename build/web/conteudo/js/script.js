const conteudoPrincipal = document.getElementById('conteudo-principal');
const footer = document.getElementById('footer-add-aluno');
const addAluno = document.getElementById('btnAdicionarAluno');

// Lista de links de edição
const editAlunos = [
    document.getElementById('edit-aluno'),
    document.getElementById('edit-aluno-2'),
    document.getElementById('edit-aluno-3'),
    document.getElementById('edit-aluno-4'),
    document.getElementById('edit-aluno-5'),
    document.getElementById('edit-aluno-6'),
    document.getElementById('edit-aluno-7'),
    document.getElementById('edit-aluno-8')
];

// Função genérica para carregar conteúdo de edição
function carregarConteudoEditar(url) {
    fetch(url)
        .then(response => response.text())
        .then(data => {
            conteudoPrincipal.innerHTML = data;
        })
        .catch(error => console.error('Erro ao carregar o conteúdo: ', error));

    // Alterna a classe do footer para exibir ou esconder
    footer.classList.toggle('footer-add-aluno');
}

// Evento para adicionar aluno
if (addAluno) {
    addAluno.addEventListener('click', function() {
        fetch('adicionar-aluno.html')
            .then(response => response.text())
            .then(data => {
                conteudoPrincipal.innerHTML = data;
            })
            .catch(error => console.error('Erro ao carregar o conteúdo: ', error));

        // Adiciona o id CSS ao footer quando o button for clicado
        footer.classList.toggle('footer-add-aluno');
    });
}

// Adiciona os event listeners para os links de edição
editAlunos.forEach(editAluno => {
    if (editAluno) {  // Verifica se o elemento existe no DOM
        editAluno.addEventListener('click', function() {
            carregarConteudoEditar('editar-aluno.html');
        });
    }
});

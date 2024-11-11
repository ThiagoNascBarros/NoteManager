const conteudoPrincipal = document.getElementById('conteudo-principal');
const footer = document.getElementById('footer-add-aluno');
const footerLink = document.getElementById('footer-add-aluno-link');
const addAluno = document.getElementById('btnAdicionarAluno');
// Lista do link EDIT
const editAluno = document.getElementById('edit-aluno');
const editAlunoO = document.getElementById('edit-aluno-2');
const editAlunoS = document.getElementById('edit-aluno-3');
const editAlunoT = document.getElementById('edit-aluno-4');
const editAlunoF = document.getElementById('edit-aluno-5');
const editAlunoC = document.getElementById('edit-aluno-6');
const editAlunoB = document.getElementById('edit-aluno-6');
const editAlunoV = document.getElementById('edit-aluno-7');
const editAlunoN = document.getElementById('edit-aluno-8');


addAluno.addEventListener('click', function() {
    fetch('/src/pages/adicionar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Erro ao carregar o conteúdo: ', error));
});

addAluno.addEventListener('click', function(){
    // Adiciona o id CSS ao footer quando o button for clicado
    footer.classList.toggle('footer-add-aluno');
})

editAlunoO.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})

editAlunoS.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})

editAlunoT.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})

editAlunoF.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})

editAlunoC.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})

editAlunoB.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno-link');
})

editAlunoV.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})

editAluno.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})

editAlunoN.addEventListener('click', function(){ 
    fetch('/src/pages/editar-aluno.html')
    .then(Response => Response.text())
    .then(data => {
        document.getElementById('conteudo-principal').innerHTML = data;
    })
    .catch(error => console.error('Error ao carregar o conteúdo: ', error));
    footer.classList.toggle('footer-add-aluno');
})


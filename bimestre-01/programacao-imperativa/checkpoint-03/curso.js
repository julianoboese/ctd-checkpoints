const { Aluno, alunos } = require('./aluno'); // Passo 4

// Passo 3
const curso = {
  nomeDoCurso: 'Programação Imperativa',
  notaDeAprovacao: 8,
  faltasMaximas: 2,
  listaDeEstudantes: alunos,
  // Passo 4
  adicionarEstudantes(nome, quantidadeDeFaltas, notas) {
    this.listaDeEstudantes.push(new Aluno(nome, quantidadeDeFaltas, notas));
  },
  // Passo 5
  aprovado(aluno) {
    const estudante = this.listaDeEstudantes.find((objetoAluno) => objetoAluno.nome === aluno);
    const faltas = estudante.quantidadeDeFaltas;
    const media = estudante.calcularMedia();
    const criterio1 = (faltas < this.faltasMaximas && media >= this.notaDeAprovacao);
    const criterio2 = (faltas === this.faltasMaximas && media >= this.notaDeAprovacao * 1.1);
    return (criterio1 || criterio2);
  },
  // Passo 6
  resultados() {
    const aprovados = [];
    this.listaDeEstudantes.forEach((objetoAluno) => {
      aprovados.push(this.aprovado(objetoAluno.nome));
    });
    return aprovados;
  },
};

// Demonstração do funcionamento:
curso.adicionarEstudantes('Juliano Boese', 0, [10, 9, 9.5, 8, 10]); // adiciona um estudante
console.log(curso); // imprime o objeto 'curso'
console.log(curso.listaDeEstudantes); // imprime o valor da propriedade 'listaDeEstudantes'
curso.listaDeEstudantes[0].faltas(); // adiciona uma falta para o primeiro estudante
console.log(curso.listaDeEstudantes[0]); // imprime o primeiro estudante com a falta adicionada
console.log(curso.listaDeEstudantes[1].calcularMedia()); // imprime a média do segundo estudante
console.log(curso.aprovado('Fernanda Rocha')); // imprime se 'Fernanda Rocha' foi aprovada
console.log(curso.resultados()); // imprime o array com o resultado da aprovação de todos os alunos

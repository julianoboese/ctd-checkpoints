// Passo 1
function Aluno(nome, quantidadeDeFaltas, notas) {
  this.nome = nome;
  this.quantidadeDeFaltas = quantidadeDeFaltas;
  this.notas = notas;
  // Passo 2
  this.calcularMedia = () => this.notas.reduce((acum, num) => acum + num) / this.notas.length;
  this.faltas = () => { (this.quantidadeDeFaltas += 1); };
}

const aluno1 = new Aluno('João Medeiros', 0, [9, 10, 8, 9, 10]);
const aluno2 = new Aluno('Fernanda Rocha', 2, [9, 7, 8, 9, 7]);
const aluno3 = new Aluno('Gilberto Souza', 1, [9, 6, 5, 7, 9]);
const aluno4 = new Aluno('Juliana Oliveira', 3, [9, 9, 8, 10, 9]);
const aluno5 = new Aluno('Felipe Silva', 2, [9, 10, 8, 9, 8]);

const alunos = [aluno1, aluno2, aluno3, aluno4, aluno5];

module.exports = { Aluno, alunos };

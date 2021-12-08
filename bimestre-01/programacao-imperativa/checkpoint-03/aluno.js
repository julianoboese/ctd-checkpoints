// Passo 1
function Aluno(nome, quantidadeDeFaltas, notas) {
  this.nome = nome;
  this.quantidadeDeFaltas = quantidadeDeFaltas;
  this.notas = notas;
  // Passo 2
  this.calcularMedia = () => this.notas.reduce((acum, num) => acum + num) / this.notas.length;
  this.faltas = () => { (this.quantidadeDeFaltas += 1); };
}

module.exports = Aluno;

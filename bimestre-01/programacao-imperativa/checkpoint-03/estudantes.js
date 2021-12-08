// Passo 7
const Aluno = require('./aluno');

const aluno1 = new Aluno('João Medeiros', 0, [9, 10, 8, 9, 10]);
const aluno2 = new Aluno('Fernanda Rocha', 2, [9, 7, 8, 9, 7]);
const aluno3 = new Aluno('Gilberto Souza', 1, [9, 6, 5, 7, 9]);
const aluno4 = new Aluno('Juliana Oliveira', 3, [9, 9, 8, 10, 9]);
const aluno5 = new Aluno('Felipe Silva', 2, [9, 10, 8, 9, 8]);

module.exports = [aluno1, aluno2, aluno3, aluno4, aluno5];

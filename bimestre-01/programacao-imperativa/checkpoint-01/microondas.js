function microondas(comida, tempo) {
  let tempoPadrao; // variável que recebe o tempo padrão de acordo com a comida
  let mensagem; // variável que recebe a mensagem a ser exibida de acordo com a comida e com o tempo
  const pratoPronto = 'Prato pronto, bom apetite!!!'; // mensagem a ser exibida em todos os casos exceto "Prato inexistente"

  // condicional para permitir que a comida seja selecionada por código ou nome
  if (typeof comida === 'number') {
    // condicional para definir o tempo padrão de acordo com o código da comida
    switch (comida) {
      case 1:
        tempoPadrao = 10;
        break;
      case 2:
        tempoPadrao = 8;
        break;
      case 3:
        tempoPadrao = 15;
        break;
      case 4:
        tempoPadrao = 12;
        break;
      case 5:
        tempoPadrao = 8;
        break;
      default:
        mensagem = 'Prato inexistente';
    }
  } else {
    // condicional para definir o tempo padrão de acordo com o nome da comida
    switch (comida.toLowerCase()) {
      case 'pipoca':
        tempoPadrao = 10;
        break;
      case 'macarrão':
        tempoPadrao = 8;
        break;
      case 'carne':
        tempoPadrao = 15;
        break;
      case 'feijão':
        tempoPadrao = 12;
        break;
      case 'brigadeiro':
        tempoPadrao = 8;
        break;
      default:
        mensagem = 'Prato inexistente';
    }
  }

  // condicional para definir a mensagem de acordo com o tempo em relação ao tempo padrão
  if (tempo >= tempoPadrao * 3) {
    mensagem = `Kabumm\n${pratoPronto}`;
  } else if (tempo > tempoPadrao * 2) {
    mensagem = `A comida queimou\n${pratoPronto}`;
  } else if (tempo >= tempoPadrao) {
    mensagem = pratoPronto;
  } else if (tempo < tempoPadrao) {
    mensagem = `Tempo insuficiente\n${pratoPronto}`;
  }

  console.log(mensagem); // exibe a mensagem
}

// O primeiro parâmetro da função "microondas" deve receber a comida, por código ou nome
// (não esquecer os acentos)
// O segundo parâmetro da função "microondas" deve receber o tempo em segundos
microondas('Pipoca', 10);

enum tipoEjercicio{
  ejercicioLetras
}

enum dificultad{
  facil, normal, dificil
}

String dificultadEjercicioLetras(int int){
  switch(int){
    case 3: {
      return "Fácil";
    }
    break;

    case 6: {
      return "Normal";
    }
    break;

    case 9: {
      return "Difícil";
    }
    break;

    default: {
      return "Dificultad nula";
    }
    break;
  }
}
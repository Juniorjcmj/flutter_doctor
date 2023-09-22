import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  
 static String formatarDataHora(DateTime data, TimeOfDay hora) {
  DateTime novaData = DateTime(data.year, data.month, data.day, hora.hour, hora.minute);
  String dataFormatada = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(novaData.toUtc());

  return dataFormatada;
}

static Color obterCorParaTipoDeConsulta(String tipoDeConsulta) {
  switch (tipoDeConsulta) {
    case 'Primeira vez':
      return Colors.blue; // Exemplo de cor para o tipo 1
    case 'Tratamento':
      return Colors.green; // Exemplo de cor para o tipo 2
    case 'Urgência':
      return Colors.red; // Exemplo de cor para o tipo 3
    case 'Procedimento':
      return Colors.orange; // Exemplo de cor para o tipo 4
    case 'Revisão':
      return Colors.purple; // Exemplo de cor para o tipo 5
    case 'Avaliação':
      return Colors.yellow; // Exemplo de cor para o tipo 6
    default:
      return Colors.black; // Cor padrão para tipos desconhecidos
  }
}
}
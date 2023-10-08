import 'package:timezone/timezone.dart' as tz;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util {
  
 static String formatarDataHora(DateTime data, TimeOfDay hora) {
  DateTime novaData = DateTime(data.year, data.month, data.day, hora.hour, hora.minute);
  String dataFormatada = DateFormat("yyyy-MM-ddTHH:mm:ss.SSS'Z'").format(novaData.toUtc());

  return dataFormatada;
}

static tz.TZDateTime formatarDataHoraTz(String dataString) {
 
 tz.Location location = tz.getLocation('America/Sao_Paulo');

  // Faz o parsing da string para DateTime
  tz.TZDateTime dateTime = tz.TZDateTime.parse(location, dataString);

  return dateTime;
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
static String formatarDataHoraUtc(DateTime data, TimeOfDay hora) {
 

  return '${data.toString().split(' ')[0]}T${hora.hour.toString().padLeft(2, '0')}:${hora.minute.toString().padLeft(2, '0')}:00-03:00';
}

static DateTime timezoneBrasil(DateTime data) {
  return data.toLocal();
}
static String converterParaISO8601(DateTime data) {
  return DateFormat('yyyy-MM-ddTHH:mm:ss.SSSZ').format(data);
}



}
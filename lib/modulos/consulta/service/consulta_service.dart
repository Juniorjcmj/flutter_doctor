import 'package:dio/dio.dart';
import 'package:flutter_doctor/modulos/consulta/state/consulta_controller.dart';
import 'package:flutter_doctor/modulos/paciente/state/paciente_controller.dart';
import 'package:get/instance_manager.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_doctor/model/consulta.dart';
import 'package:flutter_doctor/modulos/paciente/service/paciente_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';

import '../../../interceptor/http_interceptor.dart';

class ConsultaService {

 static ConsultaController _controller = Get.put(ConsultaController());
 PacienteController _pacienteController = Get.put(PacienteController());

  /// URL base da API para consultas.
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-consulta';

  /// Instância do cliente Dio com o interceptor configurado.
  static final Dio _dio = DioInterceptor().dioInstance;

  /// Obtém uma lista de consultas.
  ///
  /// Retorna uma lista de [Consulta].
  static Future<List<Consulta>> getConsultas1() async {
    String url = '$apiUrl/json';
    List<Consulta> consultas = [];
    try {
      Response response = await _dio.get(url);

      if (response.statusCode == 200) {
        List data = response.data;
        for (dynamic registro in data) {
          consultas.add(Consulta.fromJson(registro));
        }
        _controller.atualizarListaConsulta(consultas);
        return consultas;
      }
      // ignore: empty_catches
    } on DioError catch (e) {
      throw ArgumentError.value(e.message);
    }
     _controller.atualizarListaConsulta(consultas);
    return consultas;
  }

  /// Obtém uma lista de consultas por profissional.
  ///
  /// Retorna uma lista de [Consulta].
  static Future<List<Consulta>> getPorProfissional() async {
    List<Consulta> consultas = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        //print(response.data);
        List data = response.data;
        for (dynamic registro in data) {
          consultas.add(Consulta.fromJson(registro));
        }
         _controller.atualizarListaConsulta(consultas);
        return consultas;
      }
    } on DioError catch (e) {
      throw ArgumentError.value(e.message);
    }
    _controller.atualizarListaConsulta(consultas);
    return consultas;
  }

  /// Cadastra uma nova consulta.
  ///
  /// [dados] é um mapa contendo os dados da consulta.
  ///
  /// Retorna `true` se o cadastro for bem-sucedido, caso contrário, retorna `false`.
  static Future<bool> cadastrarConsulta(Map<String, dynamic> dados) async {
    try {
      Response response = await _dio.post(
        apiUrl,
        data: dados,
      );

      if (response.statusCode == 200) {
          getConsultas1();
        return true;
      } else {
        return false;
      }
    } catch (error) {
      throw ArgumentError.value(error);
    }
  }

  /// Envia uma mensagem no WhatsApp para o paciente da consulta.
  ///
  /// [consulta] é a consulta para a qual a mensagem será enviada.
  void enviarMensagemWhatsapp(Consulta consulta) async {
    var paciente = await _pacienteController.findById(consulta.pacienteId);
    final mensagemPadrao =
        'Olá ${paciente.nome}!\nGostaria de confirmar sua consulta na data  ${extractDate(consulta.start)} ás ${extractTime(consulta.start)}. ';
    final url =
        'https://api.whatsapp.com/send?phone=5555${paciente.whatsapp}&text= $mensagemPadrao';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Não foi possível abrir o WhatsApp.';
    }
  }

   Future<String> confirmarConsulta(Consulta consulta) async {
    var id = consulta.id;
    try {
      if (bool.parse(consulta.confirmado)) {
        Response response = await _dio.get('$apiUrl/cancelar-consulta/$id');
        if (response.statusCode == 200) {
           getConsultas1();
          return 'false';
        }
      } else {
        Response response = await _dio.get('$apiUrl/confirmar-consulta/$id');
        if (response.statusCode == 200) {
           getConsultas1();
          return 'true';
        }
      }
    } on DioError catch (e) {}
    return 'false';
  }

  /// Extrai a data de uma string de data e a formata no formato "DD-MM-YYYY".
  ///
  /// [dateTimeString] é a string contendo a data e hora no formato ISO 8601.
  /// Retorna a data formatada no formato "YYYY-MM-DD".
  String extractDate(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedDate =
        "${dateTime.day.toString().padLeft(2, '0')}/${dateTime.month.toString().padLeft(2, '0')}/${dateTime.year}";
    return formattedDate;
  }

  /// Extrai a hora de uma string de data e a formata no formato "HH:MM".
  ///
  /// [dateTimeString] é a string contendo a data e hora no formato ISO 8601.
  /// Retorna a hora formatada no formato "HH:MM:SS".
  String extractTime(String dateTimeString) {
    DateTime dateTime = DateTime.parse(dateTimeString);
    String formattedTime =
        "${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}";
    return formattedTime;
  }
}

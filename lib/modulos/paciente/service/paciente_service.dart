import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import '../../../interceptor/http_interceptor.dart';

class PacienteService {
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-paciente';

  static final Dio _dio = DioInterceptor().dioInstance;

  static Future<List<Paciente>> getPacientes() async {
    List<Paciente> pacientes = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        for (dynamic registro in data) {
          pacientes.add(Paciente.fromJson(registro));
        }
        return pacientes;
      }
    } on DioError catch (e) {
      log(e.message);
    }

    return pacientes;
  }
}

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

 static Future<Map<String, dynamic>> cadastrarPaciente(Map<String, dynamic> dados) async {
    Response response;
      final Map<String, dynamic> data = {};
  try {
    if(dados['id'] != null){
     response = await _dio.put(
      apiUrl,
      data: dados,
    );

    }else{
      response = await _dio.post(
      apiUrl,
      data: dados,
    );
    }
    
  
    if (response.statusCode == 200) {
      data.addAll({'status': true, 'Paciente': Paciente.fromJson(response.data)});
     return data;
    } else {
       data.addAll({'status': false, 'Paciente': Paciente()});
      return data;
    }
  } catch (error) {
   throw ArgumentError.value(error);
  }
}
 static  Future<Map<String, dynamic>> buscarEnderecoPorCEP(String cep) async {    

          Response response = await _dio.get('https://viacep.com.br/ws/$cep/json/');
          if (response.statusCode == 200) {
            final Map<String, dynamic> data = response.data;
               return data;          
          } else {
            return {"":""};
          }
        }

 static  Future<bool> deletar(String id) async {    

          Response response = await _dio.delete('$apiUrl/$id');
          if (response.statusCode == 200) {           
               return true;          
          } else {
            return false;
          }
        }

static Future<Paciente> findById(String id) async {
  var paciente = Paciente();
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {     
          paciente = Paciente.fromJson(response.data);       
        return paciente;
      }
    } on DioError catch (e) {
      log(e.message);
    }

    return paciente;
  }

}

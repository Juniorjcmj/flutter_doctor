
import 'package:dio/dio.dart';
import 'package:flutter_doctor/model/consulta.dart';
import 'package:flutter_doctor/shared/util/config.dart';


import '../../../interceptor/http_interceptor.dart';

class ConsultaService {
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-consulta';

  static final Dio _dio = DioInterceptor().dioInstance;

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
        return consultas;
      }
    // ignore: empty_catches
    } on DioError catch (e) {
     throw ArgumentError.value(e.message);
    }

    return consultas;
  }

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
        return consultas;
      }
    } on DioError catch (e) {
     throw ArgumentError.value(e.message);
    }

    return consultas;
  }

  static Future<bool> cadastrarConsulta(Map<String, dynamic> dados) async {
   
  try {
    Response response = await _dio.post(
      apiUrl,
      data: dados,
    );
  
    if (response.statusCode == 200) {
     return true;
    } else {
      return false;
    }
  } catch (error) {
   throw ArgumentError.value(error);
  }
}


  
}

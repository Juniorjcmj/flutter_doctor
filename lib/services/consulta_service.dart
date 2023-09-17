
import 'package:dio/dio.dart';
import 'package:flutter_doctor/model/consulta.dart';
import 'package:flutter_doctor/utils/config.dart';


import '../interceptor/http_interceptor.dart';

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
    } on DioError catch (e) {
      print(e);
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
      print(e);
    }

    return consultas;
  }

  
}

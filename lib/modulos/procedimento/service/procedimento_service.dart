import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter_doctor/modulos/procedimento/model/procedimento.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import '../../../interceptor/http_interceptor.dart';

class ProcedimentoService {
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-procedimento';

  static final Dio _dio = DioInterceptor().dioInstance;

  static Future<List<Procedimento>> getProcedimentos() async {
    List<Procedimento> procedimentos = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        for (dynamic registro in data) {
          procedimentos.add(Procedimento.fromJson(registro));
        }
        return procedimentos;
      }
    } on DioError catch (e) {
      log(e.message);
    }

    return procedimentos;
  }

 static Future<Map<String, dynamic>> cadastrar(Map<String, dynamic> dados) async {
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
      data.addAll({'status': true, 'procedimento': Procedimento.fromJson(response.data)});
     return data;
    } else {
       data.addAll({'status': false, 'procedimento': Procedimento()});
      return data;
    }
  } catch (error) {
   throw ArgumentError.value(error);
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

static Future<Procedimento> findById(String id) async {
  var procedimento = Procedimento();
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {     
          procedimento = Procedimento.fromJson(response.data);       
        return procedimento;
      }
    } on DioError catch (e) {
      log(e.message);
    }
    return procedimento;
  }

}

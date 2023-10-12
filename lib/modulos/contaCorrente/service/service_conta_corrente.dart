
import 'package:dio/dio.dart';
import 'package:flutter_doctor/interceptor/http_interceptor.dart';
import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:moment_dart/moment_dart.dart';

class ServiceContaCorrente {
   static String apiUrl = '${Config.apiUrl!}/api/v1/api-conta-corrente';

  static final Dio _dio = DioInterceptor().dioInstance;

  static Future<List<ContaCorrente>> getContas() async {
    List<ContaCorrente> contas = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        List data = response.data;
        for (dynamic registro in data) {
          contas.add(ContaCorrente.fromJson(registro));
        }
        return contas;
      }
    } on DioError catch (e) {
      
    }

    return contas;
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
      //var contaCorrente  = {'id': response.data['id'],'banco': response.data['banco'], 'saldo': response.data['saldo']};
      data.addAll({'status': true, 'conta': ContaCorrente.fromJson(response.data)});
     return data;
    } else {
       data.addAll({'status': false, 'conta': ContaCorrente()});
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

static Future<ContaCorrente> findById(String id) async {
  var contaCorrente = ContaCorrente();
    try {
      Response response = await _dio.get('$apiUrl/$id');

      if (response.statusCode == 200) {     
          contaCorrente = ContaCorrente.fromJson(response.data);       
        return contaCorrente;
      }
    } on DioError catch (e) {
      throw Exception(e.message);
    }

    return contaCorrente;
  }
}
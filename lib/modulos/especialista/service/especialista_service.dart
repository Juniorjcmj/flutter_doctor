
import 'package:dio/dio.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import '../../../interceptor/http_interceptor.dart';
import '../model/especialista.dart';

class EspecialistaService {
  static String apiUrl = '${Config.apiUrl!}/api/v1/api-doctors';

  static final Dio _dio = DioInterceptor().dioInstance;

  static Future<List<Especialista>> getPorProfissional() async {
    List<Especialista> result = [];
    try {
      Response response = await _dio.get(apiUrl);

      if (response.statusCode == 200) {
        //print(response.data);
        List data = response.data;
        for (dynamic registro in data) {
          result.add(Especialista.fromJson(registro));
        }
        return result;
      }
    } on DioError catch (e) {
     
    }

    return result;
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

 static Future<Map<String, dynamic>> cadastrarEspecialista(Map<String, dynamic> dados) async {
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
      data.addAll({'status': true, 'especialista': Especialista.fromJson(response.data)});
     return data;
    } else {
       data.addAll({'status': false, 'especialista': Especialista()});
      return data;
    }
  } catch (error) {
   throw ArgumentError.value(error);
  }
}
  
}

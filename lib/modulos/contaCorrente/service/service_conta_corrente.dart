
import 'package:dio/dio.dart';
import 'package:flutter_doctor/interceptor/http_interceptor.dart';
import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/shared/util/config.dart';

/// Esta classe fornece métodos para interagir com a API de backend para gerenciar contas bancárias.
class ServiceContaCorrente {

    /// A URL base do ponto de extremidade da API para gerenciamento de contas.
   static String apiUrl = '${Config.apiUrl!}/api/v1/api-conta-corrente';

  /// Uma instância do Dio com interceptadores adicionados para fazer requisições HTTP.
  static final Dio _dio = DioInterceptor().dioInstance;


 /// Obtém uma lista de contas bancárias.
  /// Retorna uma lista de objetos [ContaCorrente].
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

 /// Registra uma nova conta bancária ou atualiza uma existente.
  /// Retorna um mapa contendo o status e o objeto [ContaCorrente] criado/atualizado.
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
 /// Exclui uma conta bancária com base no seu ID.
  /// Retorna `true` se a exclusão foi bem-sucedida, caso contrário, `false`.
 static  Future<bool> deletar(String id) async {    

          Response response = await _dio.delete('$apiUrl/$id');
          if (response.statusCode == 200 || response.statusCode == 204) {           
               return true;          
          } else {
            return false;
          }
        }
/// Obtém uma conta bancária pelo seu ID.
  /// Retorna o objeto [ContaCorrente] com o ID especificado.
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
import 'package:dio/dio.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../interceptor/http_interceptor.dart';

class AuthService{

    static String apiUrl = '${Config.apiUrl!}/api/v1/auth/authenticate';
    static String apiUrlBase = '${Config.apiUrl!}/api/v1';

  static final Dio _dio = DioInterceptor().dioInstance;

   static Future<Map<String, dynamic>> generateToken(String username, String password) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': username, 'password': password});

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);    
      return responseData;
    } else {
      
      throw Exception('Failed to generate token');
    }

  }
  /// Retorna `true` se a solicitação de recuperação de senha foi bem-sucedida, ou `false` se falhou.
///
/// Se a solicitação falhar, uma mensagem de erro será impressa no console.

    static Future<dynamic> recuperarSenha(String email) async {  
    try {
      Response response = await _dio.get("$apiUrlBase/auth/recuperar-senha",
        queryParameters: {
          'email': email
          }
    );
     if (response.statusCode == 200) {
             
        return true;
      }
    } on DioError catch (e) {
      print(e);
    }

    return false;
  }

/// Retorna `true` se a solicitação de troca de senha foi bem-sucedida, ou `false` se falhou.
///
/// Se a solicitação falhar, uma mensagem de erro será impressa no console.

    static Future<dynamic> alterarSenha(String senha) async {  
    try {
      Response response = await _dio.get("$apiUrlBase/api-alterar-credenciais/alterar-senha",
        queryParameters: {
          'senha': senha
          }
    );
     if (response.statusCode == 200) {
             
        return true;
      }
    } on DioError catch (e) {
      print(e);
    }

    return false;
  }

  /// Retorna `true` se a solicitação de troca de email foi bem-sucedida, ou `false` se falhou.
///
/// Se a solicitação falhar, uma mensagem de erro será impressa no console.

    static Future<dynamic> trocarEmail(String email) async {  
    try {
      Response response = await _dio.get("$apiUrlBase/api-alterar-credenciais/alterar-email",
        queryParameters: {
          'email': email
          }
    );
     if (response.statusCode == 200) {
             
        return true;
      }
    } on DioError catch (e) {
      print(e);
    }

    return false;
  }


}
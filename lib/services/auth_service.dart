import 'package:dio/dio.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

import '../interceptor/http_interceptor.dart';

class AuthService{

    static String apiUrl = '${Config.apiUrl!}/api/v1/auth/authenticate';
    static String apiUrlBase = '${Config.apiUrl!}/api/v1/auth';

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
    static Future<dynamic> recuperarSenha(String email) async {  
    try {
      Response response = await _dio.get("$apiUrlBase/recuperar-senha",
        queryParameters: {
          'email': email
          }
    );
    print("Resposta:  $response.data");
      if (response.statusCode == 200) {
             
        return true;
      }
    } on DioError catch (e) {
      print(e);
    }

    return false;
  }

}
import 'package:flutter_doctor/utils/config.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class AuthService{

    static String apiUrl = Config.apiUrl!+'/api/v1/auth/authenticate';

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

}
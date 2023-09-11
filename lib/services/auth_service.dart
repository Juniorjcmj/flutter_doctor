import 'package:http/http.dart' as http;

import 'dart:convert';

class AuthService{

    static String apiUrl = 'https://api-sec-virtual-production.up.railway.app/api/v1/auth/authenticate';

  static Future<String> generateToken(String username, String password) async {
    final headers = {'Content-Type': 'application/json'};
    final body = jsonEncode({'email': username, 'password': password});

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: headers,
      body: body,
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> responseData = json.decode(response.body);
     
      String token = responseData['access_token'];
       print("Login realizado com sucesso token é $token");
      return token;
    } else {
      print( json.decode(response.body));
      throw Exception('Failed to generate token');
    }

  }

}
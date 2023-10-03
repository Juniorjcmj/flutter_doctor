import 'package:http/http.dart' as http;

import 'dart:convert';
class CepService{
  static String path = "https://viacep.com.br/ws/";

  static Future<Map> getEndereco(String cep) async{
    //path = path + cep + "/json/";
    var url = Uri.parse("$path$cep/json/");

    final http.Response response =  await http.get(url);
    if(response.statusCode == 200){      
      Map<String, dynamic> resp = json.decode(response.body);
      if(resp['erro'] != null){
        
          throw Exception("cep não encontrado");
      }
      return json.decode(response.body);
    }else{
      throw Exception("Erro ao efetuar busca de endereço");
    }
  }


}
import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageService {
  static final LocalStorageService _instance = LocalStorageService._internal();

  factory LocalStorageService() => _instance;

  LocalStorageService._internal();

   Future<void> saveDados(Map<String, dynamic> dados) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
     await prefs.setString('token', dados['access_token']);
     await prefs.setString('nome',  dados['empresa']);
     await prefs.setString('empresa', dados['nome']);

     
  }

 

   Future<String?> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

   Future<void> clearToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');
    
  }

  // Future<void> saveNome(String nome) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();    
  //   await prefs.setString('nome', nome);
  // }

   Future<String?> getNome() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('nome');
  }
  // Future<void> saveEmpresa(String empresa) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();    
  //   await prefs.setString('empresa', empresa);
  // }

   Future<String?> getEmpresa() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('empresa');
  }
}

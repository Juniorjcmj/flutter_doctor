
import 'dart:convert';

import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/shared/service/local_storage_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get_connect/connect.dart';

class GetPacienteService extends GetConnect {


 @override
 void onInit(){
  httpClient.baseUrl = '${Config.apiUrl!}/api/v1/api-paciente';

  Future<String?> token =  LocalStorageService().getToken();

      httpClient.addRequestModifier<Object?>((request)  {
      request.headers['Authorization'] = 'Bearer $token';
      return request;
    });
 } 

  Future<List<Paciente>> getPacientes() async{
     List<Paciente> pacientList = [];
     final response = await get(httpClient.baseUrl as String);

     final pacientes = response.body;

      for (dynamic registro in pacientes) {
          pacientList.add(Paciente.fromJson(registro));
        } 
    return pacientList;
  }


}
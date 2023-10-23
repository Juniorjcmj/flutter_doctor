import 'package:flutter_doctor/model/consulta.dart';
import 'package:get/get.dart';


/// Controller para gerenciar a lista de consultas.
class ConsultaController extends GetxController {  
  /// Lista observável de consultas.
  var listConsulta = <Consulta>[].obs;

  /// Atualiza a lista de consultas com uma nova lista [lista].
  void atualizarListaConsulta(List<Consulta> lista){
    listConsulta.value = lista; 
    update();
  }

  /// Atualiza a consulta na posição [index] com [novaConta].
  void atualizarConsulta(int index, Consulta novaConta) {
    listConsulta[index] = novaConta;
    update(); 
  }

  /// Remove a consulta na posição [index].
  void removerConsulta(int index) {
    listConsulta.removeAt(index);
    update(); 
  }  
}

import 'package:flutter_doctor/modulos/especialista/model/especialista.dart';
import 'package:get/get.dart';
 // Importe o arquivo onde está definido o Paciente

class EspecialistaController extends GetxController {
  Rx<Especialista> especialista = Especialista().obs; // O Rx torna o objeto observável

  void atualizarEspecialista(Especialista novoEspecialista) {
    especialista.value = novoEspecialista;
  }
}
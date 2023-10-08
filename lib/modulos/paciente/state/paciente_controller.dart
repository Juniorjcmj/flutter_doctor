import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:get/get.dart';
 // Importe o arquivo onde está definido o Paciente

class PacienteController extends GetxController {
  Rx<Paciente> paciente = Paciente().obs; // O Rx torna o objeto observável

  void atualizarPaciente(Paciente novoPaciente) {
    paciente.value = novoPaciente;
  }
}

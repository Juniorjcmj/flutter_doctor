import 'package:get/get.dart';

import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/modulos/paciente/service/paciente_service.dart';
// Importe o arquivo onde está definido o Paciente

class PacienteController extends GetxController {
  PacienteService service = PacienteService(); 
  Rx<Paciente> paciente = Paciente().obs; 
  void atualizarPaciente(Paciente novoPaciente) {
    paciente.value = novoPaciente;
  }

  Future<List<Paciente>> pacientsList() async => await service.getPacientes();

  Future<Map<String, dynamic>> cadastrarPaciente(Map<String, dynamic> dados) async  => await service.cadastrarPaciente( dados);

  Future<Map<String, dynamic>> buscarEnderecoPorCEP(String cep) async => await service.buscarEnderecoPorCEP(cep);

  Future<Paciente> findById(String id) async => await service.findById(id);

  Future<bool> deletar(String id) async => service.deletar(id);




}

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/modulos/paciente/screens/paciente_form.dart';
import 'package:flutter_doctor/modulos/paciente/service/paciente_service.dart';
import 'package:flutter_doctor/modulos/paciente/state/paciente_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

// ignore: must_be_immutable
class PageDetailPaciente extends StatefulWidget {

  late Paciente? pacienteDetail;

   PageDetailPaciente({ Key? key, required this.pacienteDetail }) : super(key: key);

  @override
  State<PageDetailPaciente> createState() => _PageDetailPacienteState();

}

class _PageDetailPacienteState extends State<PageDetailPaciente> {

final PacienteController pacienteController = Get.put(PacienteController()); 

  @override
  void initState() {  
   pacienteController.atualizarPaciente(widget.pacienteDetail!);
    super.initState();
  }

   
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return  Scaffold(
      appBar: AppBar(
        title: const Text('Detalhes do Paciente'),
        backgroundColor:Config.primaryColor,
        
        actions: [
           IconButton(
            icon: const Icon(
              Icons.edit_note_sharp,
              size: 35,
            ),
            tooltip: 'alterar Paciente',
            onPressed: ()async {
           var response =  await Get.to( PacienteForm(paciente: pacienteController.paciente.value));    
           Paciente result = response['Paciente'] as Paciente;            
           pacienteController.atualizarPaciente(result);             
           Get.snackbar("", "Dados Atualizados com sucesso!"); 
                         },
          ),
        ], // Cor de fundo da AppBar
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => _buildInfo('Nome', pacienteController.paciente.value.nome)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildInfo('CPF', pacienteController.paciente.value.cpf)),
                Obx(() => _buildInfo('Idade', pacienteController.paciente.value.idade.toString())),
              ],
            ),
           
            _buildInfo('Email', pacienteController.paciente.value.email),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildInfo('Convênio', pacienteController.paciente.value.convenio)),
                Obx(() => _buildInfo('Carteirinha', pacienteController.paciente.value.carteirinha)),
              ],
            ),
            

            Obx(() => _buildInfo('Gênero', pacienteController.paciente.value.genero)),
            
            
            
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Obx(() => _buildInfo('Whatsapp', pacienteController.paciente.value.whatsapp)),
                Obx(() => _buildInfo('Celular', pacienteController.paciente.value.celular)),
              ],
            ),


            Obx(() => _buildInfo('Rua', pacienteController.paciente.value.rua)),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildInfo('Bairro', pacienteController.paciente.value.bairro)),
                Obx(() => _buildInfo('Cidade', pacienteController.paciente.value.cidade)),
                Obx(() => _buildInfo('UF', pacienteController.paciente.value.uf)),
              ],
            ),
           
            Obx(() => _buildInfo('CEP', pacienteController.paciente.value.cep)),                

            ElevatedButton(         
              style:  ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(Colors.red),),    
          onPressed: () {
            _confirmarExclusao(context); // Chama a função de confirmação
          },
          child: const Text('Excluir Paciente'),
        )
          ],
        ),
      ),
      
    );
  }

                  Widget _buildInfo(String label, String? value) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            label,
                            style: const TextStyle(fontWeight: FontWeight.bold, color: Config.primaryColor),
                          ),
                          Text(value ?? 'N/A'),
                        ],
                      ),
                    );
                  }


                Future<void> _confirmarExclusao(BuildContext context) async {
                // Exibe um diálogo de confirmação
                bool confirmado = await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: const Text('Confirmação'),
                      content: const Text('Tem certeza que deseja excluir este paciente?'),
                      actions: <Widget>[
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(true),
                          child: const Text('Sim'),
                        ),
                        TextButton(
                          onPressed: () => Navigator.of(context).pop(false),
                          child: const Text('Não'),
                        ),
                      ],
                    );
                  },
                );

              // Se o usuário confirmou a exclusão, proceda com a deleção
              if (confirmado == true) {
              bool result =  await PacienteService.deletar(pacienteController.paciente.value.id.toString());
              if(result){
                Get.snackbar("OK", "Paciente Excluido com sucesso!",backgroundColor: Config.primaryColor, colorText: Colors.white,  icon: const Icon(Icons.check, color: Colors.white, size: 45,));
              }else{
                Get.snackbar("Error", "Ocorreu problema ao tentar Excluir, entre em contato com administrador!",backgroundColor: Colors.red, colorText: Colors.white, icon: const Icon(Icons.check, color: Colors.white, size: 45,));
              }
              }
}

}
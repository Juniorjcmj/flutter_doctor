import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/especialista/model/especialista.dart';
import 'package:flutter_doctor/modulos/especialista/screens/especialista_form.dart';
import 'package:flutter_doctor/modulos/especialista/service/especialista_service.dart';
import 'package:flutter_doctor/modulos/especialista/state/especialista_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';


// ignore: must_be_immutable
class DetailEspecialista extends StatefulWidget {

  late   Especialista? especialista;
   DetailEspecialista({ Key? key,  required this.especialista }) : super(key: key);

  @override
  State<DetailEspecialista> createState() => _DetailEspecialistaState();
}

class _DetailEspecialistaState extends State<DetailEspecialista> {
  
final EspecialistaController especialistaController = Get.put(EspecialistaController()); 

  @override
  void initState() {  
   especialistaController.atualizarEspecialista(widget.especialista!);
    super.initState();
  }



   @override
   Widget build(BuildContext context) {
      Config().init(context);
       return Scaffold(
           appBar:AppBar(
        title: const Text('Detalhes do Paciente'),
        backgroundColor:Config.primaryColor,
        
        actions: [
           IconButton(
            icon: const Icon(
              Icons.edit_note_sharp,
              size: 35,
            ),
            tooltip: 'alterar Especialista',
            onPressed: ()async {
           var response =  await Get.to( EspecialistaForm(especialista: widget.especialista,));    
           Especialista result = response['especialista'] as Especialista;            
           especialistaController.atualizarEspecialista(result);             
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
            Obx(() => _buildInfo('Nome', especialistaController.especialista.value.nome)),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildInfo('CPF', especialistaController.especialista.value.cpf)),
                Obx(() => _buildInfo('Idade', especialistaController.especialista.value.idade.toString())),
              ],
            ),
           
            _buildInfo('Email', especialistaController.especialista.value.email),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildInfo('Especialidade',especialistaController.especialista.value.especialidade)),
                Obx(() => _buildInfo('Nº Registro', especialistaController.especialista.value.cro)),
              ],
            ),      

            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Obx(() => _buildInfo('Whatsapp', especialistaController.especialista.value.whatsapp)),
                Obx(() => _buildInfo('Celular',  especialistaController.especialista.value.celular)),
              ],
            ),


            Obx(() => _buildInfo('Rua',  especialistaController.especialista.value.rua)),
            Row(
               mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Obx(() => _buildInfo('Bairro',  especialistaController.especialista.value.bairro)),
                Obx(() => _buildInfo('Cidade', especialistaController.especialista.value.cidade)),
                Obx(() => _buildInfo('UF',  especialistaController.especialista.value.uf)),
              ],
            ),
           
            Obx(() => _buildInfo('CEP',  especialistaController.especialista.value.cep)),                

            ElevatedButton(         
              style:  ButtonStyle(backgroundColor:  MaterialStateProperty.all<Color>(Colors.red),),    
          onPressed: () {
            _confirmarExclusao(context); // Chama a função de confirmação
          },
          child: const Text('Excluir Especialista'),
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
                      content: const Text('Tem certeza que deseja excluir este especialista?'),
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
              bool result =  await EspecialistaService.deletar(especialistaController.especialista.value.id.toString());
              if(result){
                Get.snackbar("OK", "Especialista Excluido com sucesso!",backgroundColor: Config.primaryColor, colorText: Colors.white,  icon: const Icon(Icons.check, color: Colors.white, size: 45,));
              }else{
                Get.snackbar("Error", "Ocorreu problema ao tentar Excluir, entre em contato com administrador!",backgroundColor: Colors.red, colorText: Colors.white, icon: const Icon(Icons.check, color: Colors.white, size: 45,));
              }
              }
}

}
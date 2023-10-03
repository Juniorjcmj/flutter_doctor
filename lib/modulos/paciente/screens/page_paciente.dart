import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/paciente/screens/paciente_form.dart';
import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/modulos/paciente/screens/page_detail_paciente.dart';
import 'package:flutter_doctor/modulos/paciente/service/paciente_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class PagePaciente extends StatefulWidget {
  const PagePaciente({super.key});

  @override
  State<PagePaciente> createState() => _PagePacienteState();
}

class _PagePacienteState extends State<PagePaciente> {
  @override
  void initState() {
    super.initState();
    this.getPacientes();
  }

  List<Paciente> pacientes = List.empty();
  Future<void> getPacientes() async {
    await PacienteService.getPacientes().then((value) {
      setState(() {
        pacientes = value;
      });
    }).catchError((onError) {
      return;
    });
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pacientes'),
        centerTitle: true,
        backgroundColor: Config.primaryColor,
        actions: [
         IconButton(
            icon: const Icon(Icons.add,size: 35,),
            tooltip: 'Comment Icon',
            onPressed: () {
              Get.to(const PacienteForm());
            },
          ), 
        ],
      ),
      body: pacientes.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Config.primaryColor),
            )
          : ListView.builder(
              itemCount: pacientes.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 80,
                  child: GestureDetector(
                    child:  Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Row(
                        children: [
                         
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(pacientes[index].nome ?? '',
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),
                               
                                                            
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    onTap: () {
                       Get.to(()  =>  PageDetailPaciente(paciente: pacientes[index],));
                    }, //redirection doctor detail
                  ),
                )

                    // Adicione mais detalhes do paciente conforme necessário
                    );
              },
            ),
    );
  }
}

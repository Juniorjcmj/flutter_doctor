import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/paciente/screens/paciente_form.dart';
import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/modulos/paciente/screens/page_detail_paciente.dart';
import 'package:flutter_doctor/modulos/paciente/state/paciente_controller.dart';
import 'package:flutter_doctor/modulos/perfil/perfil_page.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class PagePaciente extends GetView<PacienteController> {

   PagePaciente({super.key});

  
  PacienteController controller = Get.put(PacienteController());

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
            icon: const Icon(
              Icons.add,
              size: 35,
            ),
            tooltip: 'Cadastrar Paciente',
            onPressed: () {
              Get.to(PacienteForm());
            },
          ),
        ],
      ),
      body:  _body()
    );
  }

  _body() => Center(
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: FutureBuilder(
              future: controller.pacientsList(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else {
                  if (snapshot.hasError) {
                    return Get.snackbar('Error', 'Não foi possivel carregar lista de Pacientes').snackbar;
                  }
                  if (snapshot.hasData) {
                    List<Paciente> pacientList = snapshot.data as List<Paciente>;

                  return  ListView.builder(
                      itemCount: pacientList.length,
                      itemBuilder: (context, index) => 
                       Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          height: 140,
                          child: GestureDetector(
                            child: Card(
                              elevation: 5,
                              color: Colors.white,
                              child: Row(
                                children: [
                                  Flexible(
                                      child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Center(
                                          child: Text(
                                              pacientList[index].nome ?? '',
                                              style: const TextStyle(
                                                  color: Config.primaryColor,
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.bold)),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            IconButton(
                                                iconSize: 40,
                                                onPressed: () {
                                                  Get.to(const Perfil());
                                                },
                                                icon: const FaIcon(
                                                    FontAwesomeIcons.phone,
                                                    size: 25,
                                                    color:
                                                        Config.primaryColor)),
                                            IconButton(
                                                iconSize: 40,
                                                onPressed: () {
                                                  Get.to(const Perfil());
                                                },
                                                icon: const FaIcon(
                                                    FontAwesomeIcons.whatsapp,
                                                    size: 25,
                                                    color:
                                                        Config.primaryColor)),
                                            IconButton(
                                                iconSize: 40,
                                                onPressed: () {
                                                  Get.to(const Perfil());
                                                },
                                                icon: const FaIcon(
                                                    FontAwesomeIcons.envelope,
                                                    size: 25,
                                                    color:
                                                        Config.primaryColor)),
                                            IconButton(
                                                iconSize: 40,
                                                onPressed: () {
                                                  Get.to(PageDetailPaciente(
                                                    pacienteDetail:
                                                        pacientList[index],
                                                  ));
                                                },
                                                icon: const FaIcon(
                                                    FontAwesomeIcons.share,
                                                    size: 25,
                                                    color:
                                                        Config.primaryColor)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ))
                                ],
                              ),
                            ),
                          ),
                        ),
                    );
                  }
                  return const Center();
                }
              }),
        ),
      );
}

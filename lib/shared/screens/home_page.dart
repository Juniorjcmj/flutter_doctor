// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_doctor/model/consulta.dart';
import 'package:flutter_doctor/modulos/especialista/model/especialista.dart';
import 'package:flutter_doctor/modulos/especialista/screens/especialista_form.dart';
import 'package:flutter_doctor/modulos/especialista/screens/page_especialista.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_livro_caixa.dart';
import 'package:flutter_doctor/modulos/paciente/screens/paciente_form.dart';
import 'package:flutter_doctor/modulos/paciente/screens/page_paciente.dart';
import 'package:flutter_doctor/modulos/perfil/perfil_page.dart';
import 'package:flutter_doctor/modulos/procedimento/screens/procedimento_form.dart';
import 'package:flutter_doctor/shared/service/local_storage_service.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import '../../modulos/consulta/screens/consulta_form.dart';
import '../util/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  initState() {
    super.initState();
    _getNome();
  }

  List<Map<String, dynamic>> medCat = [
    {"icon": FontAwesomeIcons.userDoctor, "category": "Geral"},
    {"icon": FontAwesomeIcons.heartPulse, "category": "Cardiologia"},
    {"icon": FontAwesomeIcons.lungs, "category": "Respiratório"},
    {"icon": FontAwesomeIcons.hand, "category": "Dermatologia"},
    {"icon": FontAwesomeIcons.personPregnant, "category": "Ginecologia"},
    {"icon": FontAwesomeIcons.teeth, "category": "Dentista"}
  ];

  late String _nome = 'Funcionário';
  final LocalStorageService _storage = LocalStorageService();

  _getNome() {
    _storage.getNome().then((value) {
      setState(() {
        _nome = value.toString();
      });
    });
  }

  var nome = "Jose".obs;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 200,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: WaveClipperTwo(),
          child: Container(
            height: 300,
            width: Config.widtSize,
            color: Config.primaryColor,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _nome,
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                IconButton(
                    iconSize: 80,
                    onPressed: () {
                      Get.to(Perfil());
                    },
                    icon: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(
                          'https://thumbs.dreamstime.com/b/smiling-medical-doctor-woman-stethoscope-isolated-over-white-background-35552912.jpg'),
                    ))
              ],
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Config.spaceSmall,
                Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Config.widtSize / 3,
                            height: Config.widtSize / 3,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.to(() => PagePaciente(),
                                          transition: Transition.downToUp,
                                          duration:
                                              Duration(milliseconds: 400));
                                    },
                                    icon: FaIcon(FontAwesomeIcons.users,
                                        size: 35, color: Config.primaryColor)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Pacientes",
                                  style: TextStyle(
                                      color: Config.primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10))),
                              elevation: 5,
                              child: Container(
                                padding: EdgeInsets.all(10),
                                width: Config.widtSize / 3,
                                height: Config.widtSize / 3,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    IconButton(
                                        alignment: Alignment.center,
                                        padding: EdgeInsets.zero,
                                        onPressed: () {
                                          Get.to(
                                              () => ConsultaForm(
                                                  consulta: Consulta()),
                                              transition: Transition.downToUp,
                                              duration:
                                                  Duration(milliseconds: 400));
                                        },
                                        icon: FaIcon(
                                            FontAwesomeIcons.solidCalendarPlus,
                                            size: 40,
                                            color: Config.primaryColor)),
                                    SizedBox(
                                      height: 8,
                                    ),
                                    Text(
                                      "Consultas",
                                      style: TextStyle(
                                          color: Config.primaryColor,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          borderOnForeground: true,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Config.widtSize / 3,
                            height: Config.widtSize / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.to(
                                          () => ConsultaForm(
                                              consulta: Consulta()),
                                          transition: Transition.downToUp,
                                          duration:
                                              Duration(milliseconds: 400));
                                    },
                                    icon: FaIcon(FontAwesomeIcons.gear,
                                        size: 40, color: Config.primaryColor)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Configurações",
                                  style: TextStyle(
                                      color: Config.primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Config.widtSize / 3,
                            height: Config.widtSize / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.to(() => PageLivroCaixa(),
                                          transition: Transition.downToUp,
                                          duration:
                                              Duration(milliseconds: 400));
                                    },
                                    icon: FaIcon(FontAwesomeIcons.calculator,
                                        size: 40, color: Config.primaryColor)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Livro Caixa",
                                  style: TextStyle(
                                      color: Config.primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                     Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          borderOnForeground: true,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Config.widtSize / 3,
                            height: Config.widtSize / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                IconButton(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.to(
                                          () => PageEspecialista(),
                                          transition: Transition.downToUp,
                                          duration:Duration(milliseconds: 400));
                                    },
                                    icon: FaIcon(FontAwesomeIcons.personDotsFromLine,
                                        size: 40, color: Config.primaryColor)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Especialistas",
                                  style: TextStyle(
                                      color: Config.primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                        Card(
                          shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          elevation: 5,
                          child: Container(
                            padding: EdgeInsets.all(10),
                            width: Config.widtSize / 3,
                            height: Config.widtSize / 3,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.zero,
                                    onPressed: () {
                                      Get.to(() => ProcedimentoForm(),
                                          transition: Transition.downToUp,
                                          duration:
                                              Duration(milliseconds: 400));
                                    },
                                    icon: FaIcon(FontAwesomeIcons.penNib,
                                        size: 40, color: Config.primaryColor)),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "Procedimentos",
                                  style: TextStyle(
                                      color: Config.primaryColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                Config.spaceSmall,
                // AppoimentCard(),
                Config.spaceBig,

                // SvgPicture.asset(
                //   'assets/home3.svg',
                //   width: Config.widtSize,
                // ),

                // Text(
                //   'Top Especialistas',
                //   style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                // ),
                // //list de top especialistas
                // Config.spaceSmall,
                // Column(
                //   children: List.generate(1, (index) => DoctorCard()),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

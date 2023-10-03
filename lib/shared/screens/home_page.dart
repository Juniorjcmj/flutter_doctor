// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_doctor/model/consulta.dart';
import 'package:flutter_doctor/modulos/paciente/screens/page_paciente.dart';
import 'package:flutter_doctor/modulos/perfil/perfil_page.dart';
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
  initState(){
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

   _getNome(){
    _storage.getNome().then((value) {
         setState(() {
           _nome = value.toString();

         });
    });
   }

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: () {                       
                        Get.to(Perfil());
                      },
                      child: Text(
                        _nome,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Config.primaryColor),
                      ),
                    ),
                    IconButton(
                      iconSize: 80,
                       onPressed: () {
                        Get.to(Perfil());
                      },
                      icon: CircleAvatar(
                         
                      radius: 30,
                      backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/smiling-medical-doctor-woman-stethoscope-isolated-over-white-background-35552912.jpg'),

                    ))
                  ],
                ),
                Config.spaceMedium,
                //categoria listing
                const Text(
                  'Menu Principal',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Config.spaceSmall,

               Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () {
                          Get.to(()  =>  PagePaciente());
                        },
                      icon: FaIcon(FontAwesomeIcons.users, size: 60, color: Config.primaryColor)
                      ),
                      SizedBox(width: 5,),
                      IconButton(
                        onPressed: () {
                          Get.to(()  => ConsultaForm(consulta: Consulta()));
                        },
                        icon: FaIcon(FontAwesomeIcons.solidCalendarPlus, size: 60, color: Config.primaryColor)
                        ),
                         SizedBox(width: 5,),
                      IconButton(
                        onPressed: () {
                          Get.to(()  => ConsultaForm(consulta: Consulta()));
                        },
                        icon: FaIcon(FontAwesomeIcons.gear, size: 60, color: Config.primaryColor)
                        ),
                         SizedBox(width: 5,),
                      IconButton(
                        onPressed: () {
                          Get.to(()  => ConsultaForm(consulta: Consulta()));
                        },
                        icon: FaIcon(FontAwesomeIcons.calculator, size: 60, color: Config.primaryColor)
                        ),
                                                            
                    ],
                  )
                ],
               ),
           
               
                Config.spaceSmall,
               // AppoimentCard(),
                Config.spaceBig,

                 SvgPicture.asset(
                  'assets/home3.svg',
                  width: Config.widtSize,
                ),

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

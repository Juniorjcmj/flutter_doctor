// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/doctor_card.dart';
import 'package:flutter_doctor/screens/perfil_page.dart';
import 'package:flutter_doctor/services/local_storage_service.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../utils/config.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

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
   LocalStorageService _storage = new LocalStorageService();

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
                        Navigator.pushNamed(context, Perfil.routNamed);
                      },
                      child: Text(
                        _nome,
                        style:
                            TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                      ),
                    ),
                    IconButton(
                      iconSize: 80,
                       onPressed: () {
                        Navigator.pushNamed(context, Perfil.routNamed);
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
                  'Categoria',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Config.spaceSmall,

                SizedBox(
                  height: Config.height * 0.05,
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List<Widget>.generate(medCat.length, (index) {
                        return Card(
                          margin: EdgeInsets.only(right: 20),
                          color: Config.primaryColor,
                          child: Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceAround,
                                children: [
                                  FaIcon(
                                    medCat[index]['icon'],
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 20,
                                  ),
                                  Text(
                                    medCat[index]['category'],
                                    style: TextStyle(
                                        fontSize: 16, color: Colors.white),
                                  ),
                                ]),
                          ),
                        );
                      }
                      )
                      ),
                ),
                Config.spaceSmall,
                Text(
                  'Consultas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                Config.spaceSmall,
               // AppoimentCard(),
                Config.spaceSmall,
                Text(
                  'Top Especialistas',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                //list de top especialistas
                Config.spaceSmall,
                Column(
                  children: List.generate(10, (index) => DoctorCard()),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

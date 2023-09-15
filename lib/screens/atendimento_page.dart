// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';

import '../components/button.dart';
import '../model/consulta.dart';
import '../utils/config.dart';

class AtendimentoPage extends StatefulWidget {
  static final String routName = "/atendimento";


  const AtendimentoPage({ super.key });

  @override
  State<AtendimentoPage> createState() => _AtendimentoPageState();
}

class _AtendimentoPageState extends State<AtendimentoPage> {


   @override
   Widget build(BuildContext context) {
     Consulta consulta = ModalRoute.of(context)!.settings.arguments as Consulta;

     Config().init(context);

       return Scaffold(
           appBar: AppBar(
            titleSpacing: 00.0,
            centerTitle: true,
            toolbarHeight: 70.2,
            toolbarOpacity: 0.8,
            elevation: 0.00,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(5),
                bottomRight: Radius.circular(5)
              )
            ),
            backgroundColor: Config.primaryColor,
            title: const Center(
              child:  Text(
                'Atendimento',
                style: TextStyle(fontWeight: FontWeight.w900),
                )
            ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.access_time_sharp,),
                 
                  onPressed: (){},
                  )
              ],
            ),
           
           body: SafeArea(
            
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment:  MainAxisAlignment.start,
                children: [
                     Container(
                      width: double.infinity,
                      height: Config.height * 0.1,
                      padding: EdgeInsets.all(15),
                      decoration: const BoxDecoration(
                        color: Config.primaryColor,    
                        borderRadius: BorderRadius.all(Radius.circular(5)),                   
                         ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                           'Dr(a) ' + consulta.nomeDentista.toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                              
                              ),
                            ),
                            SizedBox(width: 5,),
                             Text(
                           'Pcte ' + consulta.nomePaciente,
                            style: const TextStyle(
                              color: Colors.white,
                              
                              
                              ),
                            ),
                        ],
                      )
                        )
                ]
                ),
            ),
           ),

           persistentFooterButtons: [
            Column(
              children: [
                 Button(
                    width: double.infinity,
                    title: 'Finalizar',
                    disable: false,
                    onPressed: () {                    
                 })
              ],
            )
           ],
       );
  }
}
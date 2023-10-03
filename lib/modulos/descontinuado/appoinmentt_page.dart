// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/consultas_card.dart';
import 'package:flutter_doctor/modulos/consulta/service/consulta_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';

import '../../model/consulta.dart';

class AppoinmenttPage extends StatefulWidget {
  const AppoinmenttPage({super.key});

  @override
  State<AppoinmenttPage> createState() => _AppoinmenttPageState();
}

//enum for apoiment status
//enum FilterStatus { AGUARDANDO, FINALIZADA, CANCELADA }

enum FilterStatus {
  AGUARDANDO,
  FINALIZADA,
  CANCELADA,
}

extension StatusConsultaExtension on FilterStatus {
  String get descricao {
    switch (this) {
      case FilterStatus.FINALIZADA:
        return 'FINALIZADA';
      case FilterStatus.CANCELADA:
        return 'CANCELADA';
      case FilterStatus.AGUARDANDO:
        return 'AGUARDANDO';
    }
  }
}

class _AppoinmenttPageState extends State<AppoinmenttPage> {
  @override
  initState() {
    super.initState();
    getConsultas();
  }

  List<Consulta> consultas = List.empty();

  Future<void> getConsultas() async {
    await ConsultaService.getConsultas1().then((value) {
      setState(() {
        consultas = value;
      });
    });
  }

 
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: consultas.isEmpty
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: <Widget>[
                        Center(
                          child: Text(
                            'Agenda de Consultas',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                        ),
                        Column(
                            children: List.generate(consultas.length, (index) {

                          return Column(
                            children: [
                              ConsultasCard(consulta: consultas[index]),
                            ],
                          );
                        })),
                      ]),
                ),
              ));

    // List<Consulta> filteredSchedules = consultas.where((Consulta consulta) {
    //   switch (consulta.status) {
    //     case 'AGUARDANDO':
    //      status = FilterStatus.AGUARDANDO;
    //        print(consulta.status);
    //       break;

    //     case 'FINALIZADA':
    //      status = FilterStatus.FINALIZADA;
    //       print(consulta.status);
    //       break;

    //     case 'CANCELADA':
    //       status = FilterStatus.CANCELADA;
    //       print(consulta.status);
    //       break;
    //   }
    //   return status == status;
    // }).toList();

    // return SafeArea(
    //     child: Padding(
    //   padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
    //   child: Column(
    //     crossAxisAlignment: CrossAxisAlignment.stretch,
    //     children: <Widget>[
    //       Center(
    //         child: Text(
    //           'Agenda de Consultas',
    //           style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
    //         ),
    //       ),
    //       Config.spaceSmall,
    //       Stack(
    //         children: [
    //           Container(
    //             width: double.infinity,
    //             height: 40,
    //             decoration: BoxDecoration(
    //                 color: Colors.white,
    //                 borderRadius: BorderRadius.circular(20)),
    //             child: Row(
    //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //               children: [
    //                 for (FilterStatus filterStatus in FilterStatus.values)
    //                   Expanded(
    //                     child: GestureDetector(
    //                       onTap: () {
    //                         setState(() {
    //                           if (filterStatus == FilterStatus.AGUARDANDO) {
    //                             status = FilterStatus.AGUARDANDO;
    //                             _alingnment = Alignment.centerLeft;
    //                           } else if (filterStatus ==
    //                               FilterStatus.FINALIZADA) {
    //                             status = FilterStatus.FINALIZADA;
    //                             _alingnment = Alignment.center;
    //                           } else if (filterStatus == FilterStatus.CANCELADA) {
    //                             status = FilterStatus.CANCELADA;
    //                             _alingnment = Alignment.centerRight;
    //                           }
    //                         });
    //                       },
    //                       child: Center(child: Text(filterStatus.name)),
    //                     ),
    //                   ),
    //               ],
    //             ),
    //           ),
    //           AnimatedAlign(
    //             alignment: _alingnment,
    //             duration: const Duration(
    //               microseconds: 200,
    //             ),
    //             child: Container(
    //               width: 110,
    //               height: 40,
    //               decoration: BoxDecoration(
    //                   color: Config.primaryColor,
    //                   borderRadius: BorderRadius.circular(20)),
    //               child: Center(
    //                   child: Text(
    //                 status.name,
    //                 style: TextStyle(
    //                     color: Colors.white, fontWeight: FontWeight.bold),
    //               )),
    //             ),
    //           ),
    //         ],
    //       ),
    //       Config.spaceSmall,
    //       Expanded(
    //         child: ListView.builder(
    //           itemCount: filteredSchedules.length,
    //           itemBuilder: (context, index) {
    //             var _schedule = filteredSchedules[index];
    //             bool isLastElement = filteredSchedules.length + 1 == index;

    //             return Card(

    //               shape: RoundedRectangleBorder(
    //                   side: const BorderSide(color: Colors.grey),
    //                   borderRadius: BorderRadius.circular(20)),
    //               margin: isLastElement
    //                   ? const EdgeInsets.only(bottom: 20)
    //                   : EdgeInsets.zero,
    //               child: Padding(
    //                 padding: const EdgeInsets.all(15),
    //                 child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.stretch,
    //                     children: [
    //                       Row(
    //                         children: [
    //                           // CircleAvatar(
    //                           //   backgroundImage:
    //                           //       NetworkImage(_schedule['doctor_profile']),
    //                           // ),
    //                           // SizedBox(
    //                           //   width: 10,
    //                           // ),
    //                           Column(
    //                             crossAxisAlignment: CrossAxisAlignment.start,
    //                             children: [
    //                               Text(
    //                                 _schedule.nomePaciente,
    //                                 style: const TextStyle(
    //                                     color: Colors.black,
    //                                     fontWeight: FontWeight.w700),
    //                               ),
    //                               const SizedBox(
    //                                 width: 5,
    //                               ),
    //                               Text(_schedule.tipo,
    //                                   style: TextStyle(
    //                                       color: Colors.grey,
    //                                       fontSize: 12,
    //                                       fontWeight: FontWeight.w700))
    //                             ],
    //                           )
    //                         ],
    //                       ),
    //                       const SizedBox(
    //                         height: 15,
    //                       ),
    //                       const ScheduleCard(),
    //                       const SizedBox(
    //                         height: 15,
    //                       ),
    //                       Row(
    //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                         children: [
    //                           Expanded(
    //                             child: OutlinedButton(
    //                                 onPressed: () {},
    //                                 child: Text(
    //                                   'Cancelar',
    //                                   style: TextStyle(color: Config.primaryColor),
    //                                   ),
    //                                   ),
    //                           ),
    //                           const SizedBox(width: 15,),
    //                            Expanded(
    //                             child: OutlinedButton(
    //                               style: OutlinedButton.styleFrom(
    //                                 backgroundColor: Config.primaryColor
    //                               ),
    //                                 onPressed: () {},
    //                                 child: Text(
    //                                   'Reagendar',
    //                                   style: TextStyle(color: Colors.white),
    //                                   ),
    //                                   ),
    //                           ),

    //                         ],

    //                       )
    //                     ],

    //                     ),

    //               ),
    //             );

    //           },

    //         ),
    //       ),
    //     ],
    //   ),
    // ));
  }
}

class ScheduleCard extends StatelessWidget {
  const ScheduleCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        borderRadius: BorderRadius.circular(10),
      ),
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          Icon(
            Icons.calendar_today,
            color: Config.primaryColor,
            size: 15,
          ),
          SizedBox(
            width: 5,
          ),
          Text(
            'Monday, 11/25/2022',
            style: TextStyle(color: Config.primaryColor),
          ),
          SizedBox(
            width: 20,
          ),
          Icon(
            Icons.access_alarm,
            color: Config.primaryColor,
            size: 17,
          ),
          SizedBox(
            width: 5,
          ),
          Flexible(
              child: Text(
            '2:00 PM',
            style: TextStyle(color: Config.primaryColor),
          ))
        ],
      ),
    );
  }
}

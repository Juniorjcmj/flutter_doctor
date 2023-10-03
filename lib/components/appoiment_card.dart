// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/consulta/screens/atendimento_page.dart';

import '../model/consulta.dart';
import '../shared/util/config.dart';
import 'package:intl/intl.dart';

class AppoimentCard extends StatefulWidget {

  final Consulta consulta;

  const AppoimentCard({super.key, required this.consulta});

  @override
  State<AppoimentCard> createState() => _AppoimentCardState();
}


class _AppoimentCardState extends State<AppoimentCard> {
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
          color: Config.primaryColor, borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(                 
                  backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/smiling-medical-doctor-woman-stethoscope-isolated-over-white-background-35552912.jpg'),
                ),
                SizedBox(
                  width: 5,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.consulta.nomePaciente,
                      style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      widget.consulta.tipo,
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
            SizedBox(height: 15,),
             //schedule info here
             ScheduleCard(consulta: widget.consulta),
              SizedBox(height: 15,),
             //actions buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween ,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.red,
                    ),
                    onPressed: (){},
                    child: const Text('Cancelar', style: TextStyle(color: Colors.white),))
                   ),
                   const SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: (){
                      //Navigator.pushNamed(context, AtendimentoPage.routName, arguments: widget.consulta );
                       Navigator.of(context).pushNamed(AtendimentoPage.routName, arguments: widget.consulta,);
                    },
                    child: const Text('Iniciar', style: TextStyle(color: Colors.white),))
                   ),
              ],
            )
          ]
         

          ),
        ),
      ),

    );
  }
}



class ScheduleCard extends StatelessWidget {

  String formatarData(String data) {
  // Converter a string em um objeto DateTime
  DateTime dataConvertida = DateTime.parse(data);

  // Definir o formato da data desejada
  DateFormat formato = DateFormat('EE, MM/dd/yyyy','pt-BR');

  // Formatar a data para o formato desejado
  String dataFormatada = formato.format(dataConvertida);

  return dataFormatada.toUpperCase();
}

  final Consulta consulta;
  const ScheduleCard({ super.key, required this.consulta });

   @override
   Widget build(BuildContext context) {
       return Container(
        decoration: BoxDecoration(
           color: Colors.grey,
           borderRadius: BorderRadius.circular(10),
        ),
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Icon(Icons.calendar_today,
            color: Colors.white,
            size: 15,
            ),
            const SizedBox(width: 5,),
            Text(
             formatarData(consulta.start.toString()),
              style: const TextStyle(
                   color: Colors.white
              ),
            ),
              const SizedBox(width: 20,),
               const Icon(Icons.access_alarm,
              color: Colors.white,
              size: 17,
            ),
             const SizedBox(width: 5,),

             Flexible(child: Text( consulta.start.toString().split("T")[1].split('Z')[0], style: TextStyle(color: Colors.white),))
          ],
        ),
       );
  }
}
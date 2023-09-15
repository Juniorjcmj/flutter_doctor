// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_doctor/model/consulta.dart';

import '../utils/config.dart';

class ConsultasCard extends StatefulWidget {

  final Consulta consulta;
  
   const ConsultasCard({ super.key,required this.consulta});

   
  @override
  State<ConsultasCard> createState() => _ConsultasCardState();
}

class _ConsultasCardState extends State<ConsultasCard> {

 

  @override
  void initState() {
   
    super.initState();
  }

   @override
   Widget build(BuildContext context) {

     Config().init(context);

     return  Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      height: 150,
      child: GestureDetector(
        child:  Card(
          elevation: 5,
          color: Colors.white,
          child: Row(children: [
            SizedBox(
              width: Config.widtSize * 0.20,
              child: Icon(
                Icons.calendar_month_rounded,
                size: Config.widtSize * 0.20,
                color: Config.primaryColor.shade700,
                ),
            ),
             Flexible(child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget> [
                  Text(
                      widget.consulta.nomePaciente,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold
                    )
                    ),
                      Text(
                   widget.consulta.tipo,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.normal
                    ),
                    ),
                    Spacer(),
                  
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [],
                  )
                                      
                ],
              ),
            ))
          ],
          ),
        ),
        onTap: (){},//redirection doctor detail
      ),
    );
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
      padding: const EdgeInsets.all(5),
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

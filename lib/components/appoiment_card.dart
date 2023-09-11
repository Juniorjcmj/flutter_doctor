// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';

import '../utils/config.dart';

class AppoimentCard extends StatefulWidget {
  const AppoimentCard({super.key});

  @override
  State<AppoimentCard> createState() => _AppoimentCardState();
}

class _AppoimentCardState extends State<AppoimentCard> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
          color: Config.primaryColor, borderRadius: BorderRadius.circular(10)),
      child: Material(
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(children: [
            Row(
              children: [
                CircleAvatar(                 
                  backgroundImage: NetworkImage('https://thumbs.dreamstime.com/b/smiling-medical-doctor-woman-stethoscope-isolated-over-white-background-35552912.jpg'),
                ),
                SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr Juliana Tavares',
                      style: TextStyle(color: Colors.white),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      'Dental',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                )
              ],
            ),
            Config.spaceSmall,
             //schedule info here
            const ScheduleCard(),
             Config.spaceSmall,
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
                    child: const Text('Cancel', style: TextStyle(color: Colors.white),))
                   ),
                   const SizedBox(width: 20,),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                    ),
                    onPressed: (){},
                    child: const Text('Realizado', style: TextStyle(color: Colors.white),))
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

  const ScheduleCard({ super.key });

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
              'Monday, 11/25/2022',
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

             Flexible(child: Text('2:00 PM', style: TextStyle(color: Colors.white),))
          ],
        ),
       );
  }
}
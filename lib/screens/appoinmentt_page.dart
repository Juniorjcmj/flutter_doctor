// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_doctor/utils/config.dart';

class AppoinmenttPage extends StatefulWidget {
  const AppoinmenttPage({super.key});

  @override
  State<AppoinmenttPage> createState() => _AppoinmenttPageState();
}

//enum for apoiment status
enum FilterStatus { porvir, completo, cancel }

class _AppoinmenttPageState extends State<AppoinmenttPage> {
  FilterStatus status = FilterStatus.porvir;
  Alignment _alingnment = Alignment.centerLeft;

  List<dynamic> schedules = [
    {
      'doctor_name': 'Junior José',
      'doctor_profile': 'https://t4.ftcdn.net/jpg/02/60/04/09/360_F_260040900_oO6YW1sHTnKxby4GcjCvtypUCWjnQRg5.jpg',
      'category': 'Dentista',
      'status': FilterStatus.porvir
    },
    {
      'doctor_name': 'Carlos Batista',
      'doctor_profile': 'https://img.freepik.com/free-photo/attractive-young-male-nutriologist-lab-coat-smiling-against-white-background_662251-2960.jpg',
      'category': 'Cardiologista',
      'status': FilterStatus.completo
    },
    {
      'doctor_name': 'Belfort Maria',
      'doctor_profile': 'https://www.shutterstock.com/image-photo/medical-concept-indian-beautiful-female-260nw-1613858044.jpg',
      'category': 'Geral',
      'status': FilterStatus.cancel
    },
  ];

  @override
  Widget build(BuildContext context) {
    List<dynamic> filteredSchedules = schedules.where((var schedule) {
      switch (schedule['status']) {
        case 'porvir':
          schedule['status'] = FilterStatus.porvir;
          break;

        case 'completo':
          schedule['completo'] = FilterStatus.completo;
          break;

        case 'cancel':
          schedule['cancel'] = FilterStatus.cancel;
          break;
      }
      return schedule['status'] == status;
    }).toList();

    return SafeArea(
        child: Padding(
      padding: const EdgeInsets.only(left: 20, top: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Center(
            child: Text(
              'Apoiment Schedule',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Config.spaceSmall,
          Stack(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    for (FilterStatus filterStatus in FilterStatus.values)
                      Expanded(
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              if (filterStatus == FilterStatus.porvir) {
                                status = FilterStatus.porvir;
                                _alingnment = Alignment.centerLeft;
                              } else if (filterStatus ==
                                  FilterStatus.completo) {
                                status = FilterStatus.completo;
                                _alingnment = Alignment.center;
                              } else if (filterStatus == FilterStatus.cancel) {
                                status = FilterStatus.cancel;
                                _alingnment = Alignment.centerRight;
                              }
                            });
                          },
                          child: Center(child: Text(filterStatus.name)),
                        ),
                      ),
                  ],
                ),
              ),
              AnimatedAlign(
                alignment: _alingnment,
                duration: const Duration(
                  microseconds: 200,
                ),
                child: Container(
                  width: 100,
                  height: 40,
                  decoration: BoxDecoration(
                      color: Config.primaryColor,
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Text(
                    status.name,
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  )),
                ),
              ),
            ],
          ),
          Config.spaceSmall,
          Expanded(
            child: ListView.builder(
              itemCount: filteredSchedules.length,
              itemBuilder: (context, index) {
                var _schedule = filteredSchedules[index];
                bool isLastElement = filteredSchedules.length + 1 == index;

                return Card(
                  shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.grey),
                      borderRadius: BorderRadius.circular(20)),
                  margin: isLastElement
                      ? const EdgeInsets.only(bottom: 20)
                      : EdgeInsets.zero,
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(_schedule['doctor_profile']),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    _schedule['doctor_name'],
                                    style: const TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(_schedule['category'],
                                      style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 12,
                                          fontWeight: FontWeight.w700))
                                ],
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          const ScheduleCard(),
                          const SizedBox(
                            height: 15,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: OutlinedButton(
                                    onPressed: () {}, 
                                    child: Text(
                                      'Cancel',
                                      style: TextStyle(color: Config.primaryColor),
                                      ),
                                      ),
                              ),
                              const SizedBox(width: 15,),
                               Expanded(
                                child: OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                    backgroundColor: Config.primaryColor
                                  ),
                                    onPressed: () {}, 
                                    child: Text(
                                      'Reagendar',
                                      style: TextStyle(color: Colors.white),
                                      ),
                                      ),
                              ),
                            ],
                          )
                        ]),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    ));
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

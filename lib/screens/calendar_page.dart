// Copyright 2019 Aleksander Woźniak
// SPDX-License-Identifier: Apache-2.0

// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:table_calendar/table_calendar.dart';

import '../components/consulta_form.dart';
import '../model/consulta.dart';
import '../services/consulta_service.dart';
import '../utils/config_events.dart';

class TableCalendarPage extends StatefulWidget {
  static const String routName = '/calendar';

  const TableCalendarPage({super.key});
  @override
  _TableCalendarPageState createState() => _TableCalendarPageState();
}

class _TableCalendarPageState extends State<TableCalendarPage> {
  late final ValueNotifier<List<Consulta>> _selectedEvents;

  List<Consulta> consultas = List.empty();

  Future<void> getConsultas() async {
    await ConsultaService.getConsultas1().then((value) {
      setState(() {
        consultas = value;
      });
    }).catchError((onError) =>  onError);
  }

  CalendarFormat _calendarFormat = CalendarFormat.week;
  RangeSelectionMode _rangeSelectionMode = RangeSelectionMode
      .toggledOff; // Can be toggled on/off by longpressing a date
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  DateTime? _rangeStart;
  DateTime? _rangeEnd;

  @override
  void initState() {
    super.initState();
    getConsultas();

    _selectedDay = _focusedDay;
    _selectedEvents = ValueNotifier(_getConsultasForDay(_selectedDay!));
  }

  @override
  void dispose() {
    _selectedEvents.dispose();
    super.dispose();
  }

  List<Consulta> _getConsultasForDay(DateTime day) {  
    
    return consultas.where((consulta) => isSameDay(DateTime.parse(consulta.start), day)).toList();
  }

  List<Consulta> _getConsultasForRange(DateTime start, DateTime end) {
  
    return consultas.where((consulta) => DateTime.parse(consulta.start).isAfter(start) && DateTime.parse(consulta.end).isBefore(end)).toList();
  } 

  void _onDaySelected(DateTime selectedDay, DateTime focusedDay) {
    if (!isSameDay(_selectedDay, selectedDay)) {
      setState(() {
        _selectedDay = selectedDay;
        _focusedDay = focusedDay;
        _rangeStart = null; // Important to clean those
        _rangeEnd = null;
        _rangeSelectionMode = RangeSelectionMode.toggledOff;
      });

      _selectedEvents.value = _getConsultasForDay(selectedDay);
    }
  }

  void _onRangeSelected(DateTime? start, DateTime? end, DateTime focusedDay) {
    setState(() {
      _selectedDay = null;
      _focusedDay = focusedDay;
      _rangeStart = start;
      _rangeEnd = end;
      _rangeSelectionMode = RangeSelectionMode.toggledOn;
    });

    // `start` or `end` could be null
    if (start != null && end != null) {
      _selectedEvents.value = _getConsultasForRange(start, end);
    } else if (start != null) {
      _selectedEvents.value = _getConsultasForDay(start);
    } else if (end != null) {
      _selectedEvents.value = _getConsultasForDay(end);
    }
  }
  //cadastrar com dialog
  

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 05),
        child: Column(
          children: [
            TableCalendar<Consulta>(
              locale: 'pt_BR',
              availableCalendarFormats: const {
                CalendarFormat.month: "Mês",
                CalendarFormat.twoWeeks: "2 Semanas",
                CalendarFormat.week: "Semana"
              },
              firstDay: kFirstDay,
              lastDay: kLastDay,
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              rangeStartDay: _rangeStart,
              rangeEndDay: _rangeEnd,
              calendarFormat: _calendarFormat,
              rangeSelectionMode: _rangeSelectionMode,
              eventLoader: _getConsultasForDay,
              startingDayOfWeek: StartingDayOfWeek.monday,
              calendarStyle: const CalendarStyle(
                // Use `CalendarStyle` to customize the UI
                outsideDaysVisible: false,
              ),
              onDaySelected: _onDaySelected,
              onRangeSelected: _onRangeSelected,
              onFormatChanged: (format) {
                if (_calendarFormat != format) {
                  setState(() {
                    _calendarFormat = format;
                  });
                }
              },
              onPageChanged: (focusedDay) {
                _focusedDay = focusedDay;
              },
            ),
            const SizedBox(height: 8.0),
             consultas.isEmpty
            ? const Center(
                child:  CircularProgressIndicator(),
              )
            : Expanded(
              child: ValueListenableBuilder<List<Consulta>>(
                valueListenable: _selectedEvents,
                builder: (context, value, _) {
                  return ListView.builder(
                        itemCount: (20 - 8) * 2, // Calcula o número total de intervalos de 30 minutos
                        itemBuilder: (BuildContext context, int index) {
                            // Calcula a hora e o minuto com base no índice
                          int hour = (index ~/ 2) + 8;
                          int minute = (index % 2) * 30;

                          // Formata a hora e o minuto em uma string
                          String time = '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';


                        // Encontre a consulta, se houver, para este horário
                          Consulta consulta = consultas.firstWhere((consulta) {
                          DateTime consultaStart = DateTime.parse(consulta.start);
                          DateTime consultaEnd = DateTime.parse(consulta.end);

                          DateTime intervalStart = DateTime(_selectedDay!.year, _selectedDay!.month, _selectedDay!.day, hour, minute);
                          DateTime intervalEnd = intervalStart.add(const Duration(minutes: 30));

                          return intervalStart.isBefore(consultaEnd) && intervalEnd.isAfter(consultaStart);
                        }, orElse: () => Consulta.pacienteVazio("")); // Caso não haja consulta, criamos uma consulta com o nome do paciente vazio

                        return Container(
                            decoration: BoxDecoration(
                            border: const Border(
                            bottom: BorderSide(width: 1, color: Colors.black12),                           
                            ),
                            color: consulta.nomePaciente != "" ? Colors.green[50]: Colors.transparent,
                            
                            ),
                          child: ListTile(
                            title: Text(time),
                            trailing: consulta.nomePaciente != "" ? Column(
                             crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(consulta.nomePaciente, style: const TextStyle(fontSize: 14, color: Colors.black45,),),
                                Text(consulta.nomeDentista,style: const TextStyle(fontSize: 14, color: Colors.black45),),
                              ],
                            ) : null,            
                           onTap: () {
                             showDialog(context: context, builder: (context) => ConsultaForm());
                           },
                          ),
                        );
                      },
                    );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

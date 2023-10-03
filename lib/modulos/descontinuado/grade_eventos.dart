import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';

class Evento {
  final String nome;
  final DateTime data;

  Evento(this.nome, this.data);
}

class Horario {
  final String hora;
  List<String> tarefas;

  Horario(this.hora, this.tarefas);
}

class AgendaPage extends StatelessWidget {
  final List<Horario> horarios = [
    Horario('08:00 AM', ["Cortar Cabelo"]),
    Horario('08:30 AM', []),
    Horario('09:00 AM', []),
    Horario('09:30 AM', []),
    Horario('10:00 AM', []),
    Horario('10:30 AM', []),
    Horario('11:00 AM', []),
    Horario('11:30 AM', []),
    Horario('12:00 AM', []),
    Horario('12:30 AM', []),
    Horario('01:00 AM', []),
    Horario('01:30 AM', []),
    Horario('02:00 AM', []),
    Horario('02:30 AM', []),
    Horario('03:00 AM', []),
    Horario('03:30 AM', []),
    Horario('04:00 AM', []),
    Horario('04:30 AM', []),
    Horario('05:00 AM', []),
    Horario('05:30 AM', []),
    Horario('06:00 AM', []),
    Horario('06:30 AM', []),
    Horario('07:00 AM', []),
    Horario('07:30 AM', []),
    Horario('08:00 AM', []),
    Horario('08:30 AM', []),
    Horario('09:00 AM', []),
    Horario('09:30 AM', []),
    Horario('10:00 AM', []),
    Horario('10:30 AM', []),
  ];

  void _adicionarEvento(BuildContext context, String horarioSelecionado) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Novo Evento'),
          content: Text('Adicionar evento às $horarioSelecionado?'),
          actions: <Widget>[
            TextButton(
              child: Text('Cancelar'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Adicionar'),
              onPressed: () {
                Horario horario =
                    horarios.firstWhere((h) => h.hora == horarioSelecionado);

                // Adicione a tarefa ao horário
                horario.tarefas.add('Nova Tarefa');

                // Feche o diálogo
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(          
      body: ListView.builder(
        itemCount: horarios.length,
        itemBuilder: (BuildContext context, int index) {
          String horario = horarios[index].hora;
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border(
                        bottom: BorderSide(width: 1, color: Colors.black12))),
                child: ListTile(
                  title: Row(
                   
                    children: [
                      Text(
                        horario,
                        style: TextStyle(color: Colors.black87),
                      ),
                      SizedBox(width: Config.widtSize * 0.05,),
                      Column(
                      
                        children: [
                          Text(
                            (horarios[index].tarefas.isEmpty
                                ? ''
                                : "Pcte:  "+ horarios[index].tarefas[0]),
                            style: TextStyle(color: Colors.black45, fontSize: 14),
                          ),
                          Text(
                            (horarios[index].tarefas.isEmpty
                                ? ''
                                :"Dr(a):  "+ horarios[index].tarefas[0]),
                            style:const  TextStyle(color: Colors.black45,  fontSize: 14),
                          ),
                         Row(                         
                       
                          children: [ (!horarios[index].tarefas.isEmpty) ?
                           const Icon(
                              Icons.circle, color: Colors.amberAccent,
                              ) :const SizedBox(),
                               Text(
                            (horarios[index].tarefas.isEmpty
                                ? ''
                                :"PRIMEIRA VEZ"),
                            style: TextStyle(color: Colors.black45,  fontSize: 10),
                          ),
                          ],
                         )
                        ],
                      )
                    ],
                  ),
                  onTap: () => _adicionarEvento(context, horario),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: AgendaPage(),
  ));
}

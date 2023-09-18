import 'package:flutter/material.dart';

class Consulta {
  String hora;
  String paciente;

  Consulta(this.hora, this.paciente);
}

void main() {
  List<Consulta> consultas = [
    Consulta('08:00', 'Paciente 1'),
    Consulta('09:15', 'Paciente 2'),
    Consulta('10:30', 'Paciente 3'),
    // Adicione mais consultas conforme necessário
  ];

  runApp(MaterialApp(
    home: Scaffold(
      appBar: AppBar(
        title: Text('Grade de Horários'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4, // Número de colunas
        ),
        itemCount: 48, // Total de células (15 minutos * 4 células por hora * 16 horas)
        itemBuilder: (BuildContext context, int index) {
          int hora = 8 + index ~/ 4; // Calcula a hora baseado no índice
          int minuto = (index % 4) * 15; // Calcula os minutos baseado no índice

          String horaFormatada = '${hora.toString().padLeft(2, '0')}:${minuto.toString().padLeft(2, '0')}';

          Consulta? consulta = consultas.firstWhere((c) => c.hora == horaFormatada, orElse: null);

          return Container(
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Center(
              child: Text(consulta != null ? '${consulta.hora}\n${consulta.paciente}' : horaFormatada),
            ),
          );
        },
      ),
    ),
  ));
}

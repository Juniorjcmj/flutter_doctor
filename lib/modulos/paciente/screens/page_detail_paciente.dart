import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/shared/util/config.dart';

// ignore: must_be_immutable
class PageDetailPaciente extends StatefulWidget {

  late Paciente? paciente;

   PageDetailPaciente({ Key? key, required this.paciente }) : super(key: key);

  @override
  State<PageDetailPaciente> createState() => _PageDetailPacienteState();

}

class _PageDetailPacienteState extends State<PageDetailPaciente> {

  @override
  void initState() {    
    super.initState();
  }

   @override
   Widget build(BuildContext context) {
    Config().init(context);
       return Scaffold(
           appBar: AppBar(title: const Text('Detalhe Paciente'),backgroundColor: Config.primaryColor, centerTitle: true,),
           body: Text(widget.paciente!.nome ?? ''),
       );
  }
}
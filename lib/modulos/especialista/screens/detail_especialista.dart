import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/especialista/model/especialista.dart';
import 'package:flutter_doctor/shared/util/config.dart';

// ignore: must_be_immutable
class DetailEspecialista extends StatefulWidget {

  late   Especialista? especialista;
   DetailEspecialista({ Key? key,  required this.especialista }) : super(key: key);

  @override
  State<DetailEspecialista> createState() => _DetailEspecialistaState();
}

class _DetailEspecialistaState extends State<DetailEspecialista> {

   @override
   Widget build(BuildContext context) {
      Config().init(context);
       return Scaffold(
           appBar: AppBar(title: const Text('Detalhe Paciente'),backgroundColor: Config.primaryColor, centerTitle: true,),
           body: Text(widget.especialista!.nome ?? ''),
       );
  }
}
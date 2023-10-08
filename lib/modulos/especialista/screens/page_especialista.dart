import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/especialista/model/especialista.dart';
import 'package:flutter_doctor/modulos/especialista/screens/detail_especialista.dart';
import 'package:flutter_doctor/modulos/especialista/screens/especialista_form.dart';
import 'package:flutter_doctor/modulos/especialista/service/especialista_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';

class PageEspecialista extends StatefulWidget {

  const PageEspecialista({ super.key });

  @override
  State<PageEspecialista> createState() => _PageEspecialistaState();
}

class _PageEspecialistaState extends State<PageEspecialista> {

    @override
  void initState() {
    super.initState();
    getEspecialistas();
  }



  List<Especialista> especialistas = List.empty();
  Future<void> getEspecialistas() async {
    await EspecialistaService.getPorProfissional().then((value) {
      setState(() {
        especialistas = value;
      });
    }).catchError((onError) {
      return;
    });
  }

   @override
   Widget build(BuildContext context) {
       Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Especialista'),
        centerTitle: true,
        backgroundColor: Config.primaryColor,
        actions: [
         IconButton(
            icon: const Icon(Icons.add,size: 35,),
            tooltip: 'Cadastrar Especialista',
            onPressed: () {
              Get.to( EspecialistaForm());
            },
          ), 
        ],
      ),
      body: especialistas.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Config.primaryColor),
            )
          : ListView.builder(
              itemCount: especialistas.length,
              itemBuilder: (context, index) {
                return ListTile(
                    title: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                  height: 80,
                  child: GestureDetector(
                    child:  Card(
                      elevation: 5,
                      color: Colors.white,
                      child: Row(
                        children: [
                         
                          Flexible(
                              child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 15, vertical: 10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(especialistas[index].nome ?? '',
                                    style: const TextStyle(
                                      color: Config.secundColor,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold)),                               
                                                            
                              ],
                            ),
                          ))
                        ],
                      ),
                    ),
                    onTap: () {
                       Get.to(()  =>  DetailEspecialista(especialista: especialistas[index],));
                    }, //redirection doctor detail
                  ),
                )

                    // Adicione mais detalhes do paciente conforme necessário
                    );
              },
            ),
    );
  }
}
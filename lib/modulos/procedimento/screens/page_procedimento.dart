// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/procedimento/model/procedimento.dart';
import 'package:flutter_doctor/modulos/procedimento/screens/procedimento_form.dart';
import 'package:flutter_doctor/modulos/procedimento/service/procedimento_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';
import 'package:brasil_fields/brasil_fields.dart';

class PageProcedimento extends StatefulWidget {
  static const String routNamed = "/page-procedimento";

  const PageProcedimento({super.key});

  @override
  State<PageProcedimento> createState() => _PageProcedimentoState();
}

class _PageProcedimentoState extends State<PageProcedimento> {
  @override
  void initState() {
    super.initState();
    getProcedimentos();
  }

  List<Procedimento> procedimentos = List.empty();
  Future<void> getProcedimentos() async {
    await ProcedimentoService.getProcedimentos().then((value) {
      setState(() {
        procedimentos = value;
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
        title: const Text('Procedimentos'),
        centerTitle: true,
        backgroundColor: Config.primaryColor,
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              size: 35,
            ),
            tooltip: 'Cadastrar Procedimento',
            onPressed: () {
              Get.to(ProcedimentoForm());
            },
          ),
        ],
      ),
      body: procedimentos.isEmpty
          ? const Center(
              child: CircularProgressIndicator(color: Config.primaryColor),
            )
          : ListView.builder(
              itemCount: procedimentos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: GestureDetector(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      height: 150,
                      child: Card(

                        elevation: 15,
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
                                  Text(procedimentos[index].descricao ?? '',
                                      style: const TextStyle(
                                          color: Config.secundColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
                                           const SizedBox(height: 20),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        
                                        Text('Particular: ' + UtilBrasilFields.obterReal(double.parse(procedimentos[index].valorParticular)),
                                          style: const TextStyle(
                                              color: Config.secundColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                         Text('Plano: ' + UtilBrasilFields.obterReal(double.parse(procedimentos[index].valorConvenio)),
                                          style: const TextStyle(
                                              color: Config.secundColor,
                                              fontSize: 14,
                                              fontWeight: FontWeight.bold)),
                                      ],
                                    ),
                                     const SizedBox(height: 20),
                                     Text('Convênio: '+ procedimentos[index].convenio!,
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
                    ),
                    onTap: () async {
                      var result = await Get.to(ProcedimentoForm(
                        procedimento: procedimentos[index],
                      ));
                      if (result['status']) {
                        Get.snackbar(
                            "sucesso", "cadastro realizado com sucesso!");
                      }
                    },
                  ),
                  // Adicione mais detalhes do paciente conforme necessário
                );
              },
            ),
    );
  }
}

// ignore_for_file: invalid_use_of_protected_member

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/livroCaixa/model/livro_caixa.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/livro_caixa_form.dart';
import 'package:flutter_doctor/modulos/livroCaixa/state/livro_caixa_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:flutter_doctor/shared/util/util.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class PageReceita extends StatefulWidget {
 
  const PageReceita({super.key});

  @override
  State<PageReceita> createState() => _PageReceitaState();
}

class _PageReceitaState extends State<PageReceita> {
  final LivroCaixaController controller = Get.put(LivroCaixaController());
  var listaReceitas = [].obs;
  String mes ='';
  @override
  void initState() {
    listaReceitas.value = controller.list.value.where((livro) => livro.tipoMovimentacao == 'RECEITA').toList();
    mes = controller.mes.value;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 120,
        title:  Padding(
          padding: const EdgeInsets.only(right:55),
          child: Column(
            children: [
              const Text("Receitas",style: TextStyle(fontSize: 16)),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Total :", style: TextStyle(fontSize: 14),),
                  const SizedBox(width: 10,),
                  Text(UtilBrasilFields.obterReal(controller.receita.value), style: const TextStyle(
                                                      fontSize: 14, color: Colors.white)),                   
                ],
              ),
               const SizedBox(height: 10,),
              Text(mes , style: const TextStyle(fontSize: 14),),
            ],
          ),
        ),
        centerTitle: true,
        
      ),
      body:   SingleChildScrollView(
        child: Card(
           elevation: 5,
          child: Column(            
                  children: [
                    const ListTile(
                      title: Center(child: Text('Detalhamento')),
                    ),
                    Container(
                      width: Get.width,
                      height: Get.height*0.7,
                      child: ListView.builder(
                        itemCount: listaReceitas.value.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: GestureDetector(
                              onTap: () => Get.to(()=> LivroCaixaForm(tipo: "Receita",livroCaixa: listaReceitas[index],)),
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                decoration: const BoxDecoration(
                                  border: Border(
                                    bottom: BorderSide(color: Colors.black12, width: 1.0),
                                    ),                        
                                    ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          '${listaReceitas.value[index].banco}',
                                          style: const TextStyle(
                                              fontSize: 12, color: Colors.black38),
                                        ),
                                        Text(
                                            '${listaReceitas.value[index].descricao}',  style: const TextStyle(
                                                fontSize: 16, color: Colors.black54)),
                                        Text(
                                            '${listaReceitas.value[index].formaPagamento}',
                                            style: const TextStyle(
                                                fontSize: 12, color: Colors.black38)),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Column(
                                          children: [
                                            Text(Util.converterFormatoDataApiLivro(listaReceitas.value[index].dtTransacao), style: const TextStyle(
                                                    fontSize: 9, color: Colors.black45)),
                                            Text(UtilBrasilFields.obterReal(listaReceitas.value[index].valor), style: const TextStyle(
                                                    fontSize: 12, color: Colors.black54)),
                                          ],
                                        ),                             
                                       
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
          
        ),
      ),
        
    );
  }

}
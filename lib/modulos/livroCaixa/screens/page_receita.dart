// ignore_for_file: invalid_use_of_protected_member

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/livroCaixa/model/livro_caixa.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/components/appbar_filter.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/livro_caixa_form.dart';
import 'package:flutter_doctor/modulos/livroCaixa/state/livro_caixa_controller.dart';
import 'package:flutter_doctor/shared/state/splash_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:flutter_doctor/shared/util/util.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PageReceita extends StatefulWidget {
  const PageReceita({super.key});

  @override
  State<PageReceita> createState() => _PageReceitaState();
}

class _PageReceitaState extends State<PageReceita> {
  final LivroCaixaController controller = Get.put(LivroCaixaController());
 static final SplashController loaderController = Get.put(SplashController());
  
  @override
  void initState() {  
    
    super.initState();
  }
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        toolbarHeight: 120,
        title: Padding(
          padding: const EdgeInsets.only(right: 55),
          child: Column(
            children: [
              const Text("Receitas", style: TextStyle(fontSize: 16)),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Total :",
                    style: TextStyle(fontSize: 14),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Obx(() => Text(
                      UtilBrasilFields.obterReal(controller.receita.value),
                      style:
                          const TextStyle(fontSize: 14, color: Colors.white))),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const AppbarFilter()
            ],
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child:   Obx(() => Card(
          
          child: loaderController.isLoader.value ?  Center(
              child: LoadingAnimationWidget.staggeredDotsWave(                   
                   color: Colors.green,
                   size: 100
                ),
                ) : Column(
            children: [
              const ListTile(
                title: Center(child: Text('Detalhamento')),
              ),
              Container(
                width: Get.width,
                height: Get.height * 0.7,
                child: ListView.builder(
                  itemCount: controller.listaReceitas.value.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: GestureDetector(
                        onTap: () => Get.to(() => LivroCaixaForm(
                              tipo: "Receita",
                              livroCaixa: controller.listaReceitas[index],
                            )),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            border: Border(
                              bottom:
                                  BorderSide(color: Colors.black12, width: 1.0),
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
                                    '${controller.listaReceitas.value[index].banco}',
                                    style: const TextStyle(
                                        fontSize: 12, color: Colors.black38),
                                  ),
                                  Text(
                                      '${controller.listaReceitas.value[index].descricao}',
                                      style: const TextStyle(
                                          fontSize: 16, color: Colors.black54)),
                                  Text(
                                      '${controller.listaReceitas.value[index].formaPagamento}',
                                      style: const TextStyle(
                                          fontSize: 12, color: Colors.black38)),
                                ],
                              ),
                              Row(
                                children: [
                                  Column(
                                    children: [
                                      Text(
                                          Util.converterFormatoDataApiLivro(
                                              controller.listaReceitas
                                                  .value[index].dtTransacao),
                                          style: const TextStyle(
                                              fontSize: 9,
                                              color: Colors.black45)),
                                      Text(
                                          UtilBrasilFields.obterReal(
                                              controller.listaReceitas.value[index].valor),
                                          style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.black54)),
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
        )
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          Get.to(() => LivroCaixaForm(
                tipo: 'Receita',
              ));
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

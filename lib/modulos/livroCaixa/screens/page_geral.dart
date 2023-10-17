// ignore_for_file: invalid_use_of_protected_member

import 'dart:ffi';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/modulos/contaCorrente/scrrens/form_conta_corrente.dart';
import 'package:flutter_doctor/modulos/contaCorrente/service/service_conta_corrente.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_despesas.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_receita.dart';
import 'package:flutter_doctor/modulos/livroCaixa/state/livro_caixa_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:easy_pie_chart/easy_pie_chart.dart';
import 'package:get/get.dart';

class PageGeral extends StatefulWidget {
  const PageGeral({super.key});

  @override
  State<PageGeral> createState() => _PageGeralState();
}

class _PageGeralState extends State<PageGeral> {
  final LivroCaixaController controller = Get.put(LivroCaixaController());
  @override
  void initState() {
    super.initState();
    getContas();
  }

  List<ContaCorrente> contas = List.empty();
  Future<void> getContas() async {
    await ServiceContaCorrente.getContas().then((value) {
      setState(() {
        contas = value;
        controller.listConta.value = value;
        contas.sort(
            (a, b) => a.banco!.toLowerCase().compareTo(b.banco!.toLowerCase()));
      });
    }).catchError((onError) {
      return;
    });
  }

  Future<bool> _submitDelete(ContaCorrente conta, int index) async {
    bool result = await ServiceContaCorrente.deletar(conta.id as String);
    if (result) {
      controller.removerConta(index);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 0, right: 0, top: 5),
          child: Column(
            children: [
              Card(
                elevation: 5,
                child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: Config.widtSize * 0.98,
                    height: Config.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Row(
                            children: [
                              Text('Visão Geral',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const PageReceita());
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .green, // Cor de fundo desejada
                                            borderRadius: BorderRadius.circular(
                                                50), // Opcional: Adiciona bordas arredondadas
                                          ),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.add,
                                              size: 20,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Receita',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() => Text(
                                    UtilBrasilFields.obterReal(
                                        controller.receita.value),
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      Get.to(() => const PageDespesas());
                                    },
                                    child: Row(
                                      children: [
                                        Container(
                                          width: 35,
                                          height: 35,
                                          decoration: BoxDecoration(
                                            color: Colors
                                                .red, // Cor de fundo desejada
                                            borderRadius: BorderRadius.circular(
                                                50), // Opcional: Adiciona bordas arredondadas
                                          ),
                                          child: IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.remove,
                                              size: 20,
                                            ),
                                            color: Colors.white,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        const Text(
                                          'Despesa',
                                          style: TextStyle(
                                              fontSize: 15,
                                              color: Colors.black54),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Obx(() => Text(
                                    UtilBrasilFields.obterReal(
                                        controller.despesa.value),
                                    textAlign: TextAlign.end,
                                    style: const TextStyle(
                                        fontSize: 15, color: Colors.black54),
                                  ))
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors
                                              .black54, // Cor de fundo desejada
                                          borderRadius: BorderRadius.circular(
                                              50), // Opcional: Adiciona bordas arredondadas
                                        ),
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: const Icon(
                                            Icons.real_estate_agent,
                                            size: 20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                      const Text(
                                        'Saldo',
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.black54),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              Obx(() => Text(
                                    UtilBrasilFields.obterReal(
                                        controller.saldo),
                                    textAlign: TextAlign.end,
                                    style: controller.saldo > 0
                                        ? const TextStyle(
                                            fontSize: 15, color: Colors.blue)
                                        : const TextStyle(
                                            fontSize: 15, color: Colors.red),
                                  ))
                            ],
                          ),
                        ),
                      ],
                    )),
              ),
              buildContaList(),
              const SizedBox(
                height: 5,
              ),
              Card(
                  elevation: 5,
                  child: Container(
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                    width: Config.widtSize * 0.98,
                    height: Config.height / 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Despesa por Categoria"),
                        const SizedBox(height: 20),
                        Obx(() => EasyPieChart(
                              size: 120,
                              pieType: PieType.fill,
                              children: [
                                PieData(
                                    value: controller.variavel.value ?? 50,
                                    color: Colors.yellow.shade600),
                                PieData(
                                    value: controller.fixa.value ?? 50,
                                    color: Colors.cyan),
                              ],
                            )),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.cyan,
                                ),
                                Text("Fixas")
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.circle,
                                  color: Colors.yellow,
                                ),
                                Text("Variaveis")
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildContaList() {
    return contas.isEmpty
        ? const Center(
            child: CircularProgressIndicator(color: Config.primaryColor),
          )
        : Obx(() => SingleChildScrollView(
              child: Card(
                elevation: 5,
                child: Column(
                  children: [
                    const ListTile(
                      title: Center(child: Text('Contas Corrente')),
                    ),
                    SizedBox(
                      width: Config.widtSize * 0.98,
                      height: Config.height / 5,
                      child: ListView.builder(
                        itemCount: controller.listConta.value.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Icon(
                                  Icons.account_balance_sharp,
                                  size: 15,
                                ),
                                Text(
                                    '${controller.listConta.value[index].banco}',
                                    style: const TextStyle(fontSize: 14)),
                                    const SizedBox(width: 15,),
                                     Text(
                                      UtilBrasilFields.obterReal(controller
                                          .listConta.value[index].saldo),
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                   
                                    IconButton(
                                        onPressed: () async {
                                          var conta = await Get.to(
                                              CadastroContaCorrente(
                                            tipo: "Editar",
                                            contaCorrente: controller
                                                .listConta.value[index],
                                          ));
                                          ContaCorrente result =
                                              conta['conta'] as ContaCorrente;
                                          controller.atualizarConta(
                                              index, result);

                                          Get.snackbar("",
                                              "Dados Atualizados com sucesso!",
                                              backgroundColor: Colors.green,
                                              colorText: Colors.white);
                                        },
                                        icon: const Icon(
                                          Icons.edit,
                                          color: Config.primaryColor,
                                          size: 20,
                                        )),
                                    IconButton(
                                        onPressed: () async {
                                          showDialog(
                                            context: Get.context!,
                                            builder: (BuildContext context) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Confirmar Exclusão'),
                                                content: const Text(
                                                    'Tem certeza que deseja excluir esta conta?'),
                                                actions: <Widget>[
                                                  TextButton(
                                                    child:
                                                        const Text('Cancelar'),
                                                    onPressed: () {
                                                      Get.back(); // Fecha o AlertDialog
                                                    },
                                                  ),
                                                  TextButton(
                                                    child:
                                                        const Text('Confirmar'),
                                                    onPressed: () async {
                                                      Get.back();
                                                      if (controller.listConta
                                                              .value.length ==
                                                          1) {
                                                        Get.snackbar("Atenção",
                                                            "Você não pode excluir a sua única conta, crie outra e depois exclua essa novamente!",
                                                            backgroundColor:
                                                                Colors.amber,
                                                            colorText:
                                                                Colors.white,
                                                            duration:
                                                                const Duration(
                                                                    seconds:
                                                                        8));
                                                      } else {
                                                        var response =
                                                            await _submitDelete(
                                                                controller
                                                                    .listConta
                                                                    .value[index],
                                                                index);
                                                        if (response) {
                                                          Get.snackbar("Pronto",
                                                              "Conta Arquivada com sucesso!",
                                                              backgroundColor:
                                                                  Colors.green,
                                                              colorText:
                                                                  Colors.white);
                                                        } else {
                                                          Get.snackbar(
                                                              "Atenção",
                                                              "Error!",
                                                              backgroundColor:
                                                                  Colors.red,
                                                              colorText:
                                                                  Colors.white);
                                                        }
                                                      }

                                                      // Fecha o AlertDialog
                                                    },
                                                  ),
                                                ],
                                              );
                                            },
                                          );
                                        },
                                        icon: const Icon(
                                          Icons.delete_outline,
                                          color: Colors.red,
                                        ),
                                        ),
                                  ],
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }
}

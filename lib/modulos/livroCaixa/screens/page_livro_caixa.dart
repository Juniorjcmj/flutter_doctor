import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/livro_caixa_form.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_despesas.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_geral.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_receita.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';

class PageLivroCaixa extends StatefulWidget {
  const PageLivroCaixa({super.key});

  @override
  State<PageLivroCaixa> createState() => _PageLivroCaixaState();
}

class _PageLivroCaixaState extends State<PageLivroCaixa> {
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Config.primaryColor,
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.account_balance,
                size: 35,
              ),
              child: Text('Geral'),
            ),
            Tab(
              icon: Icon(
                Icons.paid,
                size: 35,
              ),
              child: Text('Receitas'),
            ),
            Tab(
              icon: Icon(
                Icons.paid_outlined,
                size: 35,
              ),
              child: Text('Despesas'),
            )
          ]),
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: TabBarView(children: [
            Center(
              child: PageGeral(),
            ),
            Center(
              child: PageReceita(),
            ),
            Center(
              child: PageDespesas(),
            ),
          ]),
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primaryColor[700],
          onPressed: () {
            _exibirBottomSheet();
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}

void _exibirBottomSheet() {
  Get.bottomSheet(
    Container(
      padding: const EdgeInsets.all(25),
      height: 200,
      color: Colors.white,
      child: Column(
        children: [
          ListTile(
            title: Row(
              children: [
                Container(
                   decoration: BoxDecoration(
                    color: Colors.black12, // Cor de fundo desejada
                    borderRadius: BorderRadius.circular(50), // Opcional: Adiciona bordas arredondadas
                     ),
                  child: IconButton(
                    onPressed: () { Get.to(LivroCaixaForm(tipo: "Receita",)); },
                    icon: const Icon(
                      Icons.add,
                      size: 30,
                    ),
                    color: Colors.green,
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Text('Receita')),
              ],
            ),
            onTap: () {
              // Adicione a lógica para cadastrar despesa aqui
              Get.to(LivroCaixaForm(tipo: "Receita",)); // Fecha o BottomSheet
            },
          ),
          const SizedBox(height: 20,),
          ListTile(
            title: Row(
              children: [
                Container(
                   decoration: BoxDecoration(
                    color: Colors.black12, // Cor de fundo desejada
                    borderRadius: BorderRadius.circular(50), // Opcional: Adiciona bordas arredondadas
                     ),
                  child: IconButton(
                    onPressed: () { Get.to(LivroCaixaForm(tipo: "Despesa",));},
                    icon: const Icon(
                      Icons.remove,
                      size: 30,
                    ),
                    color: Colors.red,
                  ),
                ),
                const SizedBox(width: 20,),
                Container(
                    height: 30,
                    decoration: const BoxDecoration(
                      border: Border(
                        bottom: BorderSide(
                          color: Colors.black12, // Cor da borda
                          width: 1.0, // Largura da borda
                        ),
                      ),
                    ),
                    child: const Text('Despesa')),
              ],
            ),
            onTap: () {
              // Adicione a lógica para cadastrar despesa aqui
              Get.to(LivroCaixaForm(tipo: "Despesa",));// Fecha o BottomSheet
            },
          ),
        ],
      ),
    ),
  );
}

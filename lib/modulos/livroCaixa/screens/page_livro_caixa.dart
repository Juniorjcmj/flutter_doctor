import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/contaCorrente/scrrens/form_conta_corrente.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/livro_caixa_form.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_despesas.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_geral.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_receita.dart';
import 'package:flutter_doctor/modulos/livroCaixa/service/livro_caixa_service.dart';
import 'package:flutter_doctor/modulos/livroCaixa/state/livro_caixa_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class PageLivroCaixa extends StatefulWidget {
  const PageLivroCaixa({super.key});

  @override
  State<PageLivroCaixa> createState() => _PageLivroCaixaState();
}

class _PageLivroCaixaState extends State<PageLivroCaixa> {

final LivroCaixaController listController = Get.put(LivroCaixaController()); 

int index = 0;


@override
void initState() {   
    super.initState();
    index = DateTime.now().month;   
  }

  Future<void> getOperacoes(int numeroDoMes) async {

  DateTime primeiroDiaDoMes = DateTime(DateTime.now().year, numeroDoMes, 1);
  DateTime ultimoDiaDoMes = DateTime(DateTime.now().year, numeroDoMes + 1, 0);

var obj = {
  "descricao": "",
  "origem": "",
  "status": true,
  "formaPagamento": "",
  "classificacao": "",
  "tipoMovimentacao": "",
  "dataInicio": DateFormat('dd/MM/yyyy HH:mm:ss').format(primeiroDiaDoMes.toLocal()),
  "dataFim": DateFormat('dd/MM/yyyy HH:mm:ss').format(ultimoDiaDoMes.toLocal()),
  "idContaCorrente": ""
};
    await LivroCaixaService.filtroAvancado(obj).then((value) {      
      listController.atualizarLista(value);              
    }).catchError((onError) {
      return;
    });
  }

    String obterNomeDoMes(int numeroDoMes) {
     DateTime primeiroDiaDoMes = DateTime(DateTime.now().year, numeroDoMes, 1);     
     return  DateFormat('MMMM','pt-BR').format(primeiroDiaDoMes).toUpperCase();
    }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          
          backgroundColor: Config.primaryColor,
          elevation: 5,
          toolbarHeight: 120,
         title:  Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(onPressed: () {
              setState(() {
                if(index > 1){
                 index--;               
                 getOperacoes(index);
                }           
                
              });
            }, icon: const Icon(Icons.chevron_left)),
              Center(child:  Text(obterNomeDoMes(index), style: const TextStyle(fontSize: 15),)),

          IconButton(onPressed: () {
               setState(() {
                if(index < 12){
                 index++;
                 getOperacoes(index);
                }           
                
              });
            }, icon: const Icon(Icons.chevron_right)),
         ]) ,
         centerTitle: true,

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
                Icons.add_circle_rounded,
                size: 35,
              ),
              child: Text('Receitas'),
            ),
            Tab(
              icon: Icon(
                Icons.remove_circle_rounded,
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
          backgroundColor: Config.primaryColor,
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
      height: 280,
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
                Expanded(
                  child: Container(
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
                ),
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
                Expanded(
                  child: Container(
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
                ),
              ],
            ),
            onTap: () {
              // Adicione a lógica para cadastrar despesa aqui
              Get.to(LivroCaixaForm(tipo: "Despesa",));// Fecha o BottomSheet
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
                    onPressed: () { },
                    icon: const Icon(
                      Icons.account_balance,
                      size: 30,
                    ),
                    color: Colors.blue,
                  ),
                ),
                const SizedBox(width: 20,),
                Expanded(
                  child: Container(
                      height: 30,
                      decoration: const BoxDecoration(
                        border: Border(
                          bottom: BorderSide(
                            color: Colors.black12, // Cor da borda
                            width: 1.0, // Largura da borda
                          ),
                        ),
                      ),
                      child: const Text('Conta')),
                ),
              ],
            ),
            onTap: () {

              Get.to(CadastroContaCorrente(tipo: "Cadastrar",));
              // Adicione a lógica para cadastrar despesa aqui
              // Fecha o BottomSheet
            },
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/contaCorrente/scrrens/form_conta_corrente.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/components/appbar_filter.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/livro_caixa_form.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/page_geral.dart';
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
    getOperacoes(index);
  }

  Future<void> getOperacoes(int numeroDoMes) async {

  DateTime primeiroDiaDoMes = DateTime(DateTime.now().year, numeroDoMes, 1);
  DateTime ultimoDiaDoMes = DateTime(DateTime.now().year, numeroDoMes + 1, 0);

    var obj = {
       "dataInicio": DateFormat('dd/MM/yyyy HH:mm:ss').format(primeiroDiaDoMes.toLocal()),
       "dataFim": DateFormat('dd/MM/yyyy HH:mm:ss').format(ultimoDiaDoMes.toLocal()),  
    };
    await LivroCaixaService.filtroAvancado(obj).then((value) {      
      listController.atualizarLista(value);              
    }).catchError((onError) {
      return;
    });
  }

    String obterNomeDoMes(int numeroDoMes) {
     DateTime primeiroDiaDoMes = DateTime(DateTime.now().year, numeroDoMes, 1);    
     String mes =   DateFormat('MMMM','pt-BR').format(primeiroDiaDoMes).toUpperCase();
     listController.atualizarMes(mes);
     return mes;
    }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return  Scaffold(
        appBar: AppBar(
          
          backgroundColor: Config.primaryColor,
          elevation: 5,
          toolbarHeight: 120,
         title:  const Padding(
           padding: EdgeInsets.only(right:55),
           child: AppbarFilter()
         ) ,
         centerTitle: true,         
          
        ),
        body: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child:  PageGeral()
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Config.primaryColor,
          onPressed: () {
            _exibirBottomSheet();
          },
          child: const Icon(Icons.add),
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
                    onPressed: () async{
                       bool result = await Get.to(LivroCaixaForm(tipo: "Receita",));                 
                    if(result){
                      Get.snackbar("Receita", "Cadastrada com sucesso!",backgroundColor: Colors.green, colorText: Colors.white);
                    } 
                        },
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
            onTap: ()async {
              // Adicione a lógica para cadastrar despesa aqui
             bool result = await Get.to(LivroCaixaForm(tipo: "Receita",));                 
                    if(result){
                      Get.snackbar("Receita", "Cadastrada com sucesso!",backgroundColor: Colors.green, colorText: Colors.white);
                    } // Fecha o BottomSheet
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
                    onPressed: ()async {
                    bool result =  await Get.to(LivroCaixaForm(tipo: "Despesa",));   
                    if(result){
                      Get.snackbar("Despesa", "Cadastrada com sucesso!", backgroundColor: Colors.green, colorText: Colors.white);
                    }                 
                    },
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
            onTap: ()async {
              // Adicione a lógica para cadastrar despesa aqui
              bool result = await  Get.to(LivroCaixaForm(tipo: "Despesa",));// Fecha o BottomSheet
               if(result){
                      Get.snackbar("Despesa ", "Cadastrada com sucesso!", backgroundColor: Colors.green, colorText: Colors.white);
                    }  
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
            onTap: ()async {

           var result =  await Get.to(CadastroContaCorrente(tipo: "Cadastrar",));
            if(result){
                      Get.snackbar("Banco ", "Cadastrado com sucesso!", backgroundColor: Colors.green, colorText: Colors.white);
                    }  
              // Adicione a lógica para cadastrar despesa aqui
              // Fecha o BottomSheet
            },
          ),
        ],
      ),
    ),
  );
}

import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/modulos/livroCaixa/model/livro_caixa.dart';
import 'package:get/get.dart';


class LivroCaixaController extends GetxController {
  // Defina o estado da sua entidade LivroCaixa
  var livroCaixa = LivroCaixa(
    id: '',
    descricao: '',
    valor: 0.0,
    origem: '',
    dtTransacao: '',
    formaPagamento: '',
    tipoMovimentacao: '',
    classificacao: '',    
  ).obs;

  var list = [].obs;
  var listConta = <ContaCorrente>[].obs;

  var receita = 0.0.obs;
  var despesa = 0.0.obs;
 

  double get saldo => receita.value - despesa.value;

  var fixa = 0.0.obs;
  var variavel = 0.0.obs;

  var mes = 'mes'.obs;

    var listaReceitas = [].obs;
    var listaDespesas = [].obs;

  void atualizarMes(String valor){
    mes.value = valor;
    update();
  }

  // Método para atualizar o estado da entidade LivroCaixa
  void atualizarLivroCaixa(LivroCaixa novoLivroCaixa) {
    livroCaixa.value = novoLivroCaixa;
  }

  void atualizarLista(List<LivroCaixa> lista){
     list.value = lista;
    listaReceitas.value = list.value
        .where((livro) => livro.tipoMovimentacao == 'RECEITA')
        .toList();
    listaDespesas.value = list.value
        .where((livro) => livro.tipoMovimentacao == 'DESPESA')
        .toList();

      update();
  }

  void atualizarListaContaCorrente(List<ContaCorrente> lista){
    listConta.value = lista;
  }
  void atualizarConta(int index, ContaCorrente novaConta) {
    listConta[index] = novaConta;
    update(); // Atualiza a UI
  }
  void removerConta(int index) {
    listConta.removeAt(index);
    update(); // Atualiza a UI
  }
   void adicionarReceita(double valor) {
    receita.value += valor;
  }

  void adicionarDespesa(double valor) {
    despesa.value += valor;
  }
    void zerarValores() {
    receita.value = 0.0;
    despesa.value = 0.0;
    fixa.value = 0.0;
    variavel.value = 0.0;
  }

    void adicionarFixa(double valor) {
    fixa.value += valor;
    update();
  }

  void adicionarVariavel(double valor) {
    variavel.value += valor;
    update();
  }
  
  // Adicione outros métodos e lógica de gerenciamento de estado aqui conforme necessário
}

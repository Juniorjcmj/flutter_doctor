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

  // Método para atualizar o estado da entidade LivroCaixa
  void atualizarLivroCaixa(LivroCaixa novoLivroCaixa) {
    livroCaixa.value = novoLivroCaixa;
  }

  void atualizarLista(List<LivroCaixa> lista){
     list.value = lista;
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
  
  // Adicione outros métodos e lógica de gerenciamento de estado aqui conforme necessário
}

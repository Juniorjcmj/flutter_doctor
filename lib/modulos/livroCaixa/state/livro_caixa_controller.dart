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

  // Método para atualizar o estado da entidade LivroCaixa
  void atualizarLivroCaixa(LivroCaixa novoLivroCaixa) {
    livroCaixa.value = novoLivroCaixa;
  }
  
  // Adicione outros métodos e lógica de gerenciamento de estado aqui conforme necessário
}

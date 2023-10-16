import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';

class LivroCaixa {
  dynamic id;
  String? descricao;
  double? valor;
  String? origem;
  bool? status;
  String? dtTransacao;
  String? formaPagamento;
  String? tipoMovimentacao;
  String? classificacao;
  String? idContacorrente;
  String? banco;


  LivroCaixa({
     this.id,
     this.descricao,
     this.valor,
     this.origem,
    this.status = false,
     this.dtTransacao,
     this.formaPagamento,
     this.tipoMovimentacao,
     this.classificacao,
     this.idContacorrente,
     this.banco
    
  });

  factory LivroCaixa.fromMap(Map<String, dynamic> map) {
    
    return LivroCaixa(
      id: map['id'],
      descricao: map['descricao'],
      valor: map['valor'],
      origem: map['origem'],
      status: map['status'] ?? false,
      dtTransacao: map['dtTransacao'],
      formaPagamento: map['formaPagamento'],
      tipoMovimentacao: map['tipoMovimentacao'],
      classificacao: map['classificacao'],     
      idContacorrente: map['idContacorrente'],
      banco: map['banco'],
     
    );
  }
}

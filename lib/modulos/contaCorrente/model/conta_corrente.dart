

class ContaCorrente {
  late String? id;
  late String? banco;
  late double? saldo;

 ContaCorrente();

 ContaCorrente.fromJson(Map<dynamic, String> map){

  id = map['id'];
  banco = map['banco'];
  saldo = double.parse( map['saldo'] as String);
 }
}
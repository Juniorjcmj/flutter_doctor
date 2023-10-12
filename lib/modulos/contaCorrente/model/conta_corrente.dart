

class ContaCorrente {
  late String? id;
  late String? banco;
  late dynamic saldo;

 ContaCorrente();

 ContaCorrente.fromJson(Map<String, dynamic> map){

  id = map['id'].toString();
  banco = map['banco'];
  saldo = map['saldo']; 
 }
}
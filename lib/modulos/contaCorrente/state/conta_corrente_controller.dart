import 'package:get/get.dart';

class ContaCorrenteController extends GetxController {
  var id = ''.obs;
  var banco = ''.obs;
  var saldo = 0.0.obs;

  void cadastrarContaCorrente(String id, String banco, double saldo) {
    this.id.value = id;
    this.banco.value = banco;
    this.saldo.value = saldo;
  }
}

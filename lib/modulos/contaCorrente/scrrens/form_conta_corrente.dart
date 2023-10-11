import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';

import 'package:flutter_doctor/modulos/contaCorrente/state/conta_corrente_controller.dart';

class CadastroContaCorrente extends StatelessWidget {
  final ContaCorrenteController controller = Get.put(ContaCorrenteController());

  final TextEditingController idController = TextEditingController();
  final TextEditingController bancoController = TextEditingController();
  final TextEditingController saldoController = TextEditingController();

  void _cadastrar() {
    String id = idController.text;
    String banco = bancoController.text;
    double saldo = double.parse(saldoController.text);

    controller.cadastrarContaCorrente(id, banco, saldo);
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Cadastro de Conta Corrente'),backgroundColor: Config.primaryColor, ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [           
            TextField(
              controller: bancoController,
              decoration: const InputDecoration(
                              border: UnderlineInputBorder(),                              
                              icon: Icon(Icons.account_balance, ),
                              hintText: '',
                              labelText: 'Banco *',
                            ),
            ),
            TextField(
              controller: saldoController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                              border: UnderlineInputBorder(),                              
                              icon: Icon(Icons.attach_money),
                              hintText: '',
                              labelText: 'Saldo *',
                            ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(              
              onPressed: _cadastrar,
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

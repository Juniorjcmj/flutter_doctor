import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doctor/components/row_formatters.dart';
import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/modulos/contaCorrente/service/service_conta_corrente.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/livro_caixa_form.dart';
import 'package:flutter_doctor/modulos/procedimento/screens/procedimento_form.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';

import 'package:flutter_doctor/modulos/contaCorrente/state/conta_corrente_controller.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class CadastroContaCorrente extends StatefulWidget {
  late String tipo;
  late ContaCorrente? contaCorrente;
  CadastroContaCorrente({super.key, required this.tipo, this.contaCorrente});
  @override
  State<CadastroContaCorrente> createState() => _CadastroContaCorrenteState();
}

class _CadastroContaCorrenteState extends State<CadastroContaCorrente> {
  bool _isLoading = false;

  final ContaCorrenteController controller = Get.put(ContaCorrenteController());

  final _formKey = GlobalKey<FormState>(); 

  final TextEditingController bancoController = TextEditingController();

  final TextEditingController saldoController = TextEditingController();

 

  Future<Map<String, dynamic>> _submitForm() async {
    // if (_formKey.currentState!.validate()) {
      Map<String, dynamic> dados = {
        "banco": bancoController.text,
        "saldo": saldoController.text,
      };

      if (widget.contaCorrente != null && widget.contaCorrente!.id != null) {
        dados.addAll({"id": widget.contaCorrente!.id});
      }else{
        dados.addAll({"id":null});
      }
      Map<String, dynamic> result = await ServiceContaCorrente.cadastrar(dados);
      return result;
  //  }
   // return {};
  }

  @override
  void initState() {
    super.initState();

    if (widget.contaCorrente != null) {
      bancoController.text = widget.contaCorrente?.banco ?? '';
      saldoController.text = widget.contaCorrente?.saldo.toString() ?? '';
  }
  }
  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.tipo),
        centerTitle: true,
        backgroundColor: Config.primaryColor,
        actions: [
          TextButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true; // Inicia o indicador de carregamento
                });
                Map<String, dynamic> response = await _submitForm();
                if (response['status']) {
                  setState(() {
                    _isLoading = false;
                    // Inicia o indicador de carregamento
                  });
                  //ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      dismissDirection: DismissDirection.startToEnd,
                      backgroundColor: Config.primaryColor,
                      content: SizedBox(
                          height: 40,
                          child: Center(
                              child: Icon(
                            Icons.check,
                            size: 50,
                            color: Colors.white,
                          ))),
                    ),
                  );

                  Get.back(result: response);
                } else {
                  setState(() {
                    _isLoading = false;
                  });
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      backgroundColor: Colors.red,
                      content: Text('Não foi possivél cadastrar Paciente!'),
                    ),
                  );
                }
              },
              child: const Text(
                "Salvar",
                style: TextStyle(color: Colors.white, fontSize: 16),
              )
              )
      
        ]
      ),
      body: _isLoading
          ? Center(
              child: LoadingAnimationWidget.staggeredDotsWave(
                  color: Config.primaryColor, size: 100),
            ) // Mostra o indicador de carregamento enquanto o login está em andamento
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  TextField(
                    controller: bancoController,
                    decoration: const InputDecoration(
                      border: UnderlineInputBorder(),
                      icon: Icon(
                        Icons.account_balance,
                      ),
                      hintText: '',
                      labelText: 'Banco *',
                    ),
                  ),
                  const SizedBox(height: 20),
                  RowFormatters(
                    controller: saldoController,
                    label: "Saldo",
                    formatter: CentavosInputFormatter(),
                    decoration: const InputDecoration(
                      labelText: 'Valor*',
                      icon: Icon(Icons.paid_outlined),
                      border: UnderlineInputBorder(),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/livroCaixa/service/livro_caixa_service.dart';
import 'package:flutter_doctor/modulos/livroCaixa/state/livro_caixa_controller.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';

class AppbarFilter extends StatefulWidget {
  const AppbarFilter({super.key});

  @override
  State<AppbarFilter> createState() => _AppbarFilterState();
}

class _AppbarFilterState extends State<AppbarFilter> {
  @override
  void initState() {
    super.initState();
    index = DateTime.now().month;
    getOperacoes(index);
    obterNomeDoMes(index);
  }

  final LivroCaixaController listController = Get.put(LivroCaixaController());

  int index = 0;

  Future<void> getOperacoes(int numeroDoMes) async {
    DateTime primeiroDiaDoMes = DateTime(DateTime.now().year, numeroDoMes, 1);
    DateTime ultimoDiaDoMes = DateTime(DateTime.now().year, numeroDoMes + 1, 0);

    listController.atualizarMes(obterNomeDoMes(numeroDoMes));

    var obj = {
      "dataInicio":
          DateFormat('dd/MM/yyyy HH:mm:ss').format(primeiroDiaDoMes.toLocal()),
      "dataFim":
          DateFormat('dd/MM/yyyy HH:mm:ss').format(ultimoDiaDoMes.toLocal()),
    };
    await LivroCaixaService.filtroAvancado(obj).then((value) {
      listController.atualizarLista(value);
    }).catchError((onError) {
      return;
    });
  }

  String obterNomeDoMes(int numeroDoMes) {
    DateTime primeiroDiaDoMes = DateTime(DateTime.now().year, numeroDoMes, 1);
    String mes =
        DateFormat('MMMM', 'pt-BR').format(primeiroDiaDoMes).toUpperCase();
    listController.atualizarMes(mes);
    return mes;
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
      IconButton(
          onPressed: () {
            setState(() {
              if (index > 1) {
                index--;
                getOperacoes(index);
              }
            });
          },
          icon: const Icon(Icons.chevron_left)),
      Obx(() => Text(
            listController.mes.value,
            style: const TextStyle(fontSize: 15),
          )),
      IconButton(
          onPressed: () {
            setState(() {
              if (index < 12) {
                index++;
                getOperacoes(index);
              }
            });
          },
          icon: const Icon(Icons.chevron_right)),
    ]);
  }
}

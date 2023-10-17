// ignore_for_file: must_be_immutable

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doctor/modulos/contaCorrente/model/conta_corrente.dart';
import 'package:flutter_doctor/modulos/contaCorrente/service/service_conta_corrente.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/components/custom_dropdawnButtomformfield.dart';
import 'package:flutter_doctor/shared/util/util.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'package:flutter_doctor/components/row_formatters.dart';
import 'package:flutter_doctor/modulos/livroCaixa/model/livro_caixa.dart';
import 'package:flutter_doctor/modulos/livroCaixa/service/livro_caixa_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';

class LivroCaixaForm extends StatefulWidget {
  late String tipo;
  late LivroCaixa? livroCaixa;

  LivroCaixaForm({super.key, required this.tipo, this.livroCaixa});

  @override
  State<LivroCaixaForm> createState() => _LivroCaixaFormState();
}

class _LivroCaixaFormState extends State<LivroCaixaForm> {
  String selectedContaId = '';

  bool isLoading = false;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorController = TextEditingController();
  final TextEditingController _dataController = TextEditingController();
  final TextEditingController _classificacaoController =
      TextEditingController();
  final TextEditingController _tipoMovimentacaoController =
      TextEditingController();
  final TextEditingController _formaPagamentoController =
      TextEditingController();
  final TextEditingController _idContaCorrente = TextEditingController();

  Future<Map<String, dynamic>> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> dados = {
        "descricao": _descricaoController.text,
        "valor": _valorController.text,
        "dtTransacao": Util.converterFormatoData(_dataController.text),
        "classificacao": widget.tipo == "Receita" ? "NA" : _classificacaoController.text,
        "tipoMovimentacao": widget.tipo.toUpperCase(),
        "formaPagamento": _formaPagamentoController.text,
        "status": true,
        "origem": "Conta corrente",
        "idContaCorrente": _idContaCorrente.text
      };

      if (widget.livroCaixa != null && widget.livroCaixa!.id != null) {
        dados.addAll({"id": widget.livroCaixa!.id});
      }
      Map<String, dynamic> result =
          await LivroCaixaService.cadastrarLivroCaixa(dados);
      return result;
    }
    return {};
  }

  String dropdownvalue = 'DINHEIRO';
  var items = [
    'DINHEIRO',
    'DÉBITO',
    'CRÉDITO',
    'PIX',
    'TED',
    'DOC',
    'CHEQUE',
    'BOLETO',
    'CONVÊNIO'
  ];
  String dropdownvalueClassificacao = 'FIXA';
  var itemsClassificacao = [
    'FIXA',
    'VARIÁVEL',
  ];

  List<ContaCorrente> contas = List.empty();
  Future<void> getContas() async {
    await ServiceContaCorrente.getContas().then((value) {
      setState(() {
        contas = value;
        contas.sort(
            (a, b) => a.banco!.toLowerCase().compareTo(b.banco!.toLowerCase()));
      });
    }).catchError((onError) {
      return;
    });
  }

  @override
  void initState() {
    super.initState();
    getContas();
    if (widget.livroCaixa != null) {
      _descricaoController.text = widget.livroCaixa?.descricao ?? '';
      _valorController.text =  UtilBrasilFields.obterReal(widget.livroCaixa?.valor as double,decimal: 2).replaceAll(RegExp(r'[a-zA-Z\$]'), '')  ?? '';
      
      _dataController.text = widget.livroCaixa?.dtTransacao.toString()?? '';
      if( _dataController.text.contains('-')){
        var picotado = _dataController.text.split('-');
         _dataController.text = "${picotado[2]}/${picotado[1]}/${picotado[0]}";
      }
      _classificacaoController.text = widget.livroCaixa?.classificacao ?? '';
      _tipoMovimentacaoController.text =
          widget.livroCaixa?.tipoMovimentacao ?? '';
      _formaPagamentoController.text = widget.livroCaixa?.formaPagamento ?? '';
      _idContaCorrente.text = widget.livroCaixa?.idContacorrente ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.tipo?.toString() ?? ''),
        backgroundColor: widget.tipo == 'Receita'? Colors.green : Colors.red,
        actions: [
          TextButton(
              onPressed: ()async {
                setState(() {
                  isLoading = true;
                });
             var result = await _submitForm();
             setState(() {
               isLoading = false;
             });
             if(result['status']){
             Get.back(result: true);                           
              
             }else{
               Get.snackbar("Error", "Operação não foi realizada!", backgroundColor: Colors.red, colorText: Colors.white);
             }
              },
              child: const Text(
                "Salvar",
                style: TextStyle(color: Colors.white, fontSize: 16),
              ))
        ],
      ),
      body:isLoading  ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _descricaoController,   
                 
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    icon: Icon(Icons.sort),
                    hintText: '',
                    labelText: 'Descrição *',
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),
                RowFormatters(
                    decoration: const InputDecoration(
                      labelText: 'Valor*',
                      icon: Icon(Icons.paid_outlined),
                      border: UnderlineInputBorder(),
                    ),
                    controller: _valorController,
                    label: 'Valor',
                    formatter: CentavosInputFormatter()),
                const SizedBox(height: 25),
                TextFormField(
                  onTap: () async {
                    final data = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2018),
                      lastDate: DateTime(2040),
                      locale: const Locale('pt', 'BR'),
                    );
                    if (data != null) {
                      final datapt = DateFormat('dd/MM/yyyy').format(data);
                      _dataController.text = datapt;
                    }
                  },
                  controller: _dataController,
                  decoration: const InputDecoration(
                      labelText: 'Data*',
                      border: UnderlineInputBorder(),
                      icon: Icon(
                        Icons.calendar_month,
                        size: 35,
                      )),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Campo obrigatório';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 25),

               _dropformapagamento(),
                
                const SizedBox(
                  height: 25,
                ),               

                widget.tipo == "Despesa" ? _dropclassicicacaoDespesa(): const SizedBox(),
                
                const SizedBox(
                  height: 25,
                ),
                _dropConta()
              ],
            ),
          ),
        ),
      ),
    );
  }

   _dropformapagamento() {
     return CumstomDropDownFieldForm(
      items: items,
      labelText: "Selecione Forma de Pagamento*",
      prefixIcon:  const Icon( Icons.payment, size: 25,color: Colors.black38,),
      onChanged: (value) {       
        setState(() {
            dropdownvalue = value;
            _formaPagamentoController.text = dropdownvalue;
             });
      },
      );
  
  }

  _dropclassicicacaoDespesa() {
    return   CumstomDropDownFieldForm(
      items: itemsClassificacao,
      labelText: "Selecione a classificação da despesa**",
      prefixIcon:  const Icon( Icons.account_balance_sharp, size: 25,color: Colors.black38,),
      onChanged: (value) {
        setState(() {
             dropdownvalueClassificacao = value;
            _classificacaoController.text =
            dropdownvalueClassificacao;
             });
      },
      );

  }

  DropdownButtonFormField<String> _dropConta() {
    return DropdownButtonFormField(
      items: contas
          .map((e) => DropdownMenuItem(
              value: e.id!,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(
                    e.banco as String,
                    style: const TextStyle(color: Colors.black38, fontSize: 20),
                  ),
                ],
              )))
          .toList(),
      onChanged: (val) {
        _idContaCorrente.text = val as String;
      },
      decoration: const InputDecoration(
          labelText: "Selecione a conta*",
          prefixIcon: Icon(
            Icons.account_balance_sharp,
            size: 25,
            color: Colors.black38,
          ),
          border: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.black38))),
    );
  }
}

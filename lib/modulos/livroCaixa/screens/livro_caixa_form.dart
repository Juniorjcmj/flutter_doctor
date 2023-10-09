import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doctor/modulos/livroCaixa/model/livro_caixa.dart';
import 'package:flutter_doctor/modulos/livroCaixa/service/livro_caixa_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:intl/intl.dart';

class LivroCaixaForm extends StatefulWidget {

  late String tipo;
  late LivroCaixa? livroCaixa;

   LivroCaixaForm({ super.key,required this.tipo, this.livroCaixa });

  @override
  State<LivroCaixaForm> createState() => _LivroCaixaFormState();
}

class _LivroCaixaFormState extends State<LivroCaixaForm> {

   final _formKey = GlobalKey<FormState>();
    TextEditingController _descricaoController = TextEditingController();
   final TextEditingController _valorController = TextEditingController();
   final TextEditingController _dataController = TextEditingController();
   final TextEditingController _classificacaoController = TextEditingController();
   final TextEditingController _tipoMovimentacaoController = TextEditingController();
   final TextEditingController _formaPagamentoController = TextEditingController();

    Future<Map<String, dynamic>> _submitForm() async {
    if (_formKey.currentState!.validate()) {

       Map<String, dynamic> dados = {
        "descricao": _descricaoController.text,
        "valor": _valorController.text,
        "dtTransacao": _dataController.text,
        "classificacao": _classificacaoController.text,
        "tipoMovimentacao": widget.tipo.toUpperCase(),
         "formaPagamento": _formaPagamentoController.text, 
         "status": true,
         "origem": "Conta corrente"       
      };   

      if (widget.livroCaixa != null && widget.livroCaixa!.id != null) {
              dados.addAll({"id": widget.livroCaixa!.id});
            }
      Map<String, dynamic> result = await LivroCaixaService.cadastrarLivroCaixa(dados);
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
    'VARIAVEL',    
  ];

  @override
void initState() {    
    super.initState();

    if(widget.livroCaixa != null){
        _descricaoController.text = widget.livroCaixa?.descricao ?? '';
        _valorController.text = widget.livroCaixa?.valor.toString() ?? '';
        _dataController.text =  widget.livroCaixa?.dtTransacao.toString() ?? '';
        _classificacaoController.text = widget.livroCaixa?.classificacao ?? '';
        _tipoMovimentacaoController.text =widget.livroCaixa?.tipoMovimentacao ?? '';
        _formaPagamentoController.text = widget.livroCaixa?.formaPagamento ?? '';
    }
  }

   @override
   Widget build(BuildContext context) {
    Config().init(context);
       return Scaffold(
           appBar: AppBar(
            centerTitle: true,
            title:  Text(widget.tipo?.toString() ?? '' ),
            backgroundColor: Config.primaryColor,
            actions: [
              IconButton(onPressed: () {
                
              }, icon: const Icon(Icons.save, size: 35,))
            ],
            ),
           body:  SingleChildScrollView(
                 child: Padding( 
                  padding: const EdgeInsets.all(16.0),
                  child: Form(
                     key: _formKey,
                    child: Column(
                      children: [
                          TextFormField(
                          controller: _descricaoController,
                          decoration: const InputDecoration(labelText: 'Descrição'),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Campo obrigatório';
                            }
                            return null;
                          },
                        ),
                      const SizedBox(height: 10),
                      RowFormatters(
                        controller: _valorController,
                        label: 'Valor', 
                        formatter: CentavosInputFormatter()
                        ),

                                const SizedBox(height: 10),                 
                      TextFormField(
                        onTap:  () async {
                          final data = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2040),
                            locale:const Locale('pt', 'BR'),
                          );
                         if (data != null) {
                          final datapt = DateFormat('dd/MM/yyyy').format(data);
                          _dataController.text = datapt;                         
                            }
                          },
                        controller: _dataController,
                        decoration: const InputDecoration(
                          labelText: 'Data',
                          suffixIcon:Icon(
                                Icons.calendar_month,
                                color: Config.primaryColor,
                                size: 35,
                              )
                              ),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                      ),
                        const SizedBox(height: 10),
            
                      Container(
                        height: 60,
                        width: Config.widtSize * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(),
                            
                          ),
                        child:  DropdownButton(
                            
                            borderRadius: BorderRadius.circular(20),
                            // Initial Value
                            value: dropdownvalue,
                      
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                      
                            // Array list of items
                            items: items.map((String items) {
                              return DropdownMenuItem(                            
                                value: items,
            
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Center(
                                    child: Text(
                                      items,
                                      style: const TextStyle(color: Config.secundColor),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalue = newValue!;
                                _formaPagamentoController.text = dropdownvalue;
                              });
                            },
                          ),
                       
                      ),
                      const SizedBox(height: 10,),
                      
                        Container(
                        height: 60,
                        width: Config.widtSize * 0.9,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: Border.all(),
                            
                          ),
                        child: DropdownButton(
                            
                            borderRadius: BorderRadius.circular(20),
                            // Initial Value
                            value: dropdownvalueClassificacao,
                      
                            // Down Arrow Icon
                            icon: const Icon(Icons.keyboard_arrow_down),
                      
                            // Array list of items
                            items: itemsClassificacao.map((String items) {
                              return DropdownMenuItem(                            
                                value: items,
            
                                child: Container(
                                  padding: const EdgeInsets.all(15),
                                  child: Center(
                                    child: Text(
                                      items,
                                      style: const TextStyle(color: Config.secundColor),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                            // After selecting the desired option,it will
                            // change button value to selected value
                            onChanged: (String? newValue) {
                              setState(() {
                                dropdownvalueClassificacao = newValue!;
                                _classificacaoController.text = dropdownvalueClassificacao;
                              });
                            },
                          ),
                       
                      ),
                      
                      
                      ],
                      ),
                      ),
                  ),
           ),
       );
  }
}


class RowFormatters extends StatelessWidget {
  final String label;
  final TextInputFormatter formatter;
  final TextEditingController controller;

  const RowFormatters(
      {super.key, required this.label, required this.formatter, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(label: Text(label)),
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
        formatter,
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doctor/modulos/procedimento/model/procedimento.dart';
import 'package:flutter_doctor/modulos/procedimento/service/procedimento_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class ProcedimentoForm extends StatefulWidget {

   static const String routNamed = "/procedimento-form";

   late Procedimento? procedimento = Procedimento();

   ProcedimentoForm({Key? key,
    this.procedimento,
  }) : super(key: key);

  @override
  State<ProcedimentoForm> createState() => _ProcedimentoFormState();
}

class _ProcedimentoFormState extends State<ProcedimentoForm> {
 bool _isLoading = false;
 Procedimento procedimento = Procedimento();

    final _formKey = GlobalKey<FormState>();

  // Controladores
  final TextEditingController _descricaoController = TextEditingController();
  final TextEditingController _valorConvenioController = TextEditingController();
  final TextEditingController _valorParticularController = TextEditingController();
  final TextEditingController _convenioController = TextEditingController();
  final TextEditingController _classificacaoController = TextEditingController();

  // Função para submissão do formulário
 Future<Map<String, dynamic>> _submitForm() async {
    if (_formKey.currentState!.validate()) {

       Map<String, dynamic> dados = {
        "descricao": _descricaoController.text,
        "valorConvenio": _valorConvenioController.text,
        "valorParticular": _valorParticularController.text,
        "convenio": _convenioController.text,
        "classificacao": _classificacaoController.text,
        
      };   
      if (widget.procedimento != null && widget.procedimento!.id != null) {
              dados.addAll({"id": widget.procedimento!.id});
            }
      Map<String, dynamic> result = await ProcedimentoService.cadastrar(dados);
      return result;
     
    }
     return {};
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        title: const Text('Cadastro de Procedimento'),
        actions: [
           IconButton(
                    icon: const Icon(
                      Icons.save,
                      size: 35,
                    ),
                    tooltip: 'Cadastrar Procedimento',
                    onPressed: () async {
                      setState(() {
                        _isLoading = true; // Inicia o indicador de carregamento
                      });
                      Map<String, dynamic> response = await _submitForm();
                      if (response['status']) {
                        setState(() {
                          _isLoading =
                              false; // Inicia o indicador de carregamento
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
                            content:
                                Text('Não foi possivél cadastrar Paciente!'),
                          ),
                        );
                      }
                    },
                  ),
        ],
      ),
      body: Padding(
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
              TextFormField(
                controller: _valorConvenioController,
                decoration: const InputDecoration(labelText: 'Valor Convênio'),
                keyboardType: TextInputType.text,
                
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _valorParticularController,
                decoration: const InputDecoration(labelText: 'Valor Particular'),
                keyboardType: TextInputType.text,
               
                  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Campo obrigatório';
                  }
                  return null;
                },             
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _convenioController,
                decoration: const InputDecoration(labelText: 'Convênio'),
              ),
              const SizedBox(height: 10),
              TextFormField(
                controller: _classificacaoController,
                decoration: const InputDecoration(labelText: 'Classificação'),
              ),
              const SizedBox(height: 20),
             
            ],
          ),
        ),
      ),
    );
  }
}
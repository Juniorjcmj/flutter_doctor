import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_doctor/modulos/especialista/model/especialista.dart';
import 'package:flutter_doctor/modulos/especialista/service/especialista_service.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../shared/util/config.dart';
import '../../../components/custom_textfield.dart';

class EspecialistaForm extends StatefulWidget {
  static const String routNamed = "/especialista-form";

  late Especialista? especialista = Especialista();

   EspecialistaForm({   Key? key,
    this.especialista,
  }) : super(key: key);

  @override
  State<EspecialistaForm> createState() => _EspecialistaFormState();
}

class _EspecialistaFormState extends State<EspecialistaForm> {
 bool _isLoading = false;


 @override
  void initState() {
      if (widget.especialista != null) {
      _nomeController.text = widget.especialista?.nome ?? "";
      _bairroController.text = widget.especialista?.bairro ?? "";
      _numeroRegistroController.text = widget.especialista?.cro ?? "";
      _celularController.text = widget.especialista?.celular ?? "";
      _cepController.text = widget.especialista?.cep ?? "";
      _cidadeController.text = widget.especialista?.cidade ?? "";
      _especialidadeController.text = widget.especialista?.especialidade ?? "";
      _cpfController.text = widget.especialista?.cpf ?? "";
      _emailController.text = widget.especialista?.email ?? "";     
      _idadeController.text = widget.especialista?.idade.toString() ?? "";
      _ruaController.text = widget.especialista?.rua ?? "";
      _ufController.text = widget.especialista?.uf ?? "";
      _senhaController.text = widget.especialista?.senha ?? "";     
      _idController.text = widget.especialista?.id.toString() ?? "";
    }
    super.initState();
  }
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _especialidadeController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _numeroRegistroController = TextEditingController();


    Future<Map<String, dynamic>> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> dados = {
        "nome": _nomeController.text,
        "especialidade": _especialidadeController.text,
        "cro": _numeroRegistroController.text,
        "cpf": _cpfController.text,
        "genero": "",
        "idade": _idadeController.text,
        "email": _emailController.text,
        "senha": _senhaController.text,
        "celular": _celularController.text,
        "whatsapp": _whatsappController.text,
        "ativo": true,
        "rua": _ruaController.text,
        "bairro": _bairroController.text,
        "cidade": _cidadeController.text,
        "uf": _ufController.text,
        "cep": _cepController.text,
        "cor": "#32a852",
      };
      if (widget.especialista != null && widget.especialista!.id != null) {
        dados.addAll({"id": widget.especialista!.id});
      }
      Map<String, dynamic> result =
          await EspecialistaService.cadastrarEspecialista(dados);
      return result;
    }
    return {};
    }

  Future<void> buscarEnderecoPorCEP(String cep) async {
    Map<String, dynamic> data = await EspecialistaService.buscarEnderecoPorCEP(cep);
    if (data['erro'] == null) {
      setState(() {
        _ruaController.text = data['logradouro'];
        _bairroController.text = data['bairro'];
        _cidadeController.text = data['localidade'];
        _ufController.text = data['uf'];
      });
    } else {
      Get.snackbar("Error", "cep inválido");
    }
  }
 @override
  Widget build(BuildContext context) {
    Config().init(context);
    return  _isLoading
        ? Center(
            child: LoadingAnimationWidget.staggeredDotsWave(
                color: Config.primaryColor, size: 100),
          ) // Mostra o indicador de carregamento enquanto o login está em andamento
        : WillPopScope(
            onWillPop: () async {
              Get.back(result: false);
              return true;
            },
            child: Scaffold(
      appBar: AppBar(
        backgroundColor:Config.primaryColor ,
        title: const Text('Cadastro de Especialista'),
        centerTitle: true,
              actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.save,
                      size: 35,
                    ),
                    tooltip: 'Cadastrar Especialista',
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
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
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
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[             
                      const SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextFormField(
                          controller: _nomeController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor, insira um nome.';
                            }
                            return null; // Retorna null se a validação passar
                          },
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade300),
                            ),
                            fillColor: Colors.grey.shade100,
                            filled: true,
                            labelText: 'Nome',
                            hintText: 'Nome',
                            hintStyle: TextStyle(color: Colors.grey[500]),
                          ),
                        ),
                      ),
              const SizedBox(height: 15,),
                  CustomTextField(
                    controller: _especialidadeController,
                    hintText: 'Especialidade',
                    obscureText: false,
                  ),
               const SizedBox(height: 15,),
                CustomTextField(
                controller: _numeroRegistroController,
                hintText: 'Nº Registro',
        
                obscureText: false,
              ),
               const SizedBox(height: 15,),
              CustomTextField(
                controller: _cpfController,
                hintText: 'CPF',
                obscureText: false,
              ),
               const SizedBox(height: 15,),
              CustomTextField(
                controller: _idadeController,
                hintText: 'Idade',
                obscureText: false,
              ),
               const SizedBox(height: 15,),
              CustomTextField(
                controller: _emailController,
                hintText: 'Email',
                obscureText: false,
              ),
               const SizedBox(height: 15,),
              CustomTextField(
                controller: _senhaController,
                hintText: 'Senha',
                obscureText: true,
              ),
               const SizedBox(height: 15,),
              CustomTextField(
                controller: _celularController,
                hintText: 'Celular',
                obscureText: false,
              ),
               const SizedBox(height: 15,),
              CustomTextField(
                controller: _whatsappController,
                hintText: 'Whatsapp',
                obscureText: false,
              ),
               const SizedBox(height: 15,), 
                 Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: TextField(
                          controller: _cepController,
                          obscureText: false,
                          decoration: InputDecoration(
                              enabledBorder: const OutlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    BorderSide(color: Colors.grey.shade300),
                              ),
                              fillColor: Colors.grey.shade100,
                              filled: true,
                              labelText: 'CEP',
                              hintText: 'CEP',
                              hintStyle: TextStyle(color: Colors.grey[500])),
                          onChanged: (cep) {
                            if (cep.length == 8) {
                              buscarEnderecoPorCEP(cep);
                            }
                          },
                        ),
                      ), 
                             
               const SizedBox(height: 15,), 
              CustomTextField(
                controller: _ruaController,
                hintText: 'Rua',
                obscureText: false,
              ),
               const SizedBox(height: 15,), 
              CustomTextField(
                controller: _bairroController,
                hintText: 'Bairro',
                obscureText: false,
              ),
               const SizedBox(height: 15,), 
              CustomTextField(
                controller: _cidadeController,
                hintText: 'Cidade',
                obscureText: false,
              ),
               const SizedBox(height: 15,), 
              CustomTextField(
                controller: _ufController,
                hintText: 'UF',
                obscureText: false,
              ),
                        
              const SizedBox(height: 20.0),
             
            ],
          ),
        ),
      ),
            )
    );
  }
}



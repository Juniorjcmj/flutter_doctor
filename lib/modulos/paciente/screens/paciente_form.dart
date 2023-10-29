import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/modulos/paciente/service/paciente_service.dart';
import 'package:flutter_doctor/modulos/paciente/state/paciente_controller.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../../../shared/util/config.dart';
import '../../../components/custom_textfield.dart';

// ignore: must_be_immutable
class PacienteForm extends StatefulWidget {
  static const String routNamed = "/paciente-form";

  late Paciente? paciente = Paciente();

  PacienteForm({
    Key? key,
    this.paciente,
  }) : super(key: key);

  @override
  State<PacienteForm> createState() => _PacienteFormState();
}

class _PacienteFormState extends State<PacienteForm> {

  PacienteController controller = Get.put(PacienteController());

  bool _isLoading = false;
  Paciente pacienteForm = Paciente();
  String? _selectedGender;

  final _formKey = GlobalKey<FormState>();
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _convenioController = TextEditingController();
  final TextEditingController _generoController = TextEditingController();
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
  final TextEditingController _carteirinhaController = TextEditingController();

  @override
  void initState() {
    if (widget.paciente != null) {
      _nomeController.text = widget.paciente?.nome ?? "";
      _bairroController.text = widget.paciente?.bairro ?? "";
      _carteirinhaController.text = widget.paciente?.carteirinha ?? "";
      _celularController.text = widget.paciente?.celular ?? "";
      _cepController.text = widget.paciente?.cep ?? "";
      _cidadeController.text = widget.paciente?.cidade ?? "";
      _convenioController.text = widget.paciente?.convenio ?? "";
      _cpfController.text = widget.paciente?.cpf ?? "";
      _emailController.text = widget.paciente?.email ?? "";
      _generoController.text = widget.paciente?.genero ?? "";
      _idadeController.text = widget.paciente?.idade.toString() ?? "";
      _ruaController.text = widget.paciente?.rua ?? "";
      _ufController.text = widget.paciente?.uf ?? "";
      _senhaController.text = widget.paciente?.senha ?? "";
      _selectedGender = widget.paciente?.genero;
      _idController.text = widget.paciente?.id.toString() ?? "";
    }
    super.initState();
  }

  Future<Map<String, dynamic>> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> dados = {
        "nome": _nomeController.text,
        "convenio": _convenioController.text,
        "carteirinha": _carteirinhaController.text,
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
      if (widget.paciente != null && widget.paciente!.id != null) {
        dados.addAll({"id": widget.paciente!.id});
      }
      Map<String, dynamic> result =
          await controller.cadastrarPaciente(dados);
      return result;
    }
    return {};
  }

  Future<void> buscarEnderecoPorCEP(String cep) async {
    Map<String, dynamic> data = await controller.buscarEnderecoPorCEP(cep);

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
    return _isLoading
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
                backgroundColor: Config.primaryColor,
                title: const Text('Cadastro de Pacientes'),
                centerTitle: true,
                actions: [
                  IconButton(
                    icon: const Icon(
                      Icons.save,
                      size: 35,
                    ),
                    tooltip: 'Cadastrar Paciente',
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
                      const SizedBox(
                        height: 15,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _convenioController,
                        hintText: 'Convênio',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _carteirinhaController,
                        hintText: 'Carteirinha',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _cpfController,
                        hintText: 'CPF',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _idadeController,
                        hintText: 'Idade',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _emailController,
                        hintText: 'Email',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _senhaController,
                        hintText: 'Senha',
                        obscureText: true,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _celularController,
                        hintText: 'Celular',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _whatsappController,
                        hintText: 'Whatsapp',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _ruaController,
                        hintText: 'Rua',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _bairroController,
                        hintText: 'Bairro',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      CustomTextField(
                        controller: _cidadeController,
                        hintText: 'Cidade',
                        obscureText: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
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
            ));
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_doctor/model/pessoa.dart';
import 'package:flutter_doctor/services/paciente_service.dart';
import 'package:flutter_doctor/utils/config.dart';

import 'autocomplete_widget.dart';

class ConsultaForm extends StatefulWidget {
  @override
  _ConsultaFormState createState() => _ConsultaFormState();
}

class _ConsultaFormState extends State<ConsultaForm> {
  @override
  void initState() {
    super.initState();
    getPacientes();
  }

  @override
  void dispose() {
    super.dispose();
  }

  //Buscando lista de pacientes
  List<Paciente> pacientes = List.empty();
  Future<void> getPacientes() async {
    await PacienteService.getPacientes().then((value) {
      setState(() {
        pacientes = value;
      });
    }).catchError((onError) {
      return;
    });
  }

  final _formKey = GlobalKey<FormState>();
  TextEditingController pacienteController = TextEditingController();
  TextEditingController dentistaController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController inicioController = TextEditingController();
  TextEditingController terminoController = TextEditingController();
  TextEditingController observacaoController = TextEditingController();

  late Paciente pacienteSelecionado;

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Aqui você pode enviar os dados para o backend
      // Utilize os controllers para acessar os valores dos campos
      // pacienteController.text, dentistaController.text, etc.
    }
  }

  //Implementação do auto complete
  Future<Iterable<Paciente>> getSuggestions(String query) async {
    return pacientes
        .where((paciente) =>
            paciente.nome!.toLowerCase().contains(query.toLowerCase()))
        // .map((paciente) => paciente.nome!)
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Config.primaryColor,
        centerTitle: true,
        title: const Text('Cadastro de Consulta'),
      ),
      body: pacientes.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: ListView(
                  children: <Widget>[
                    AutocompleteWidget<Paciente>(
                      options: pacientes,
                      displayStringForOption: (Paciente paciente) =>
                          paciente.nome!,
                      onSelected: (Paciente paciente) {
                        pacienteSelecionado = paciente;
                      },
                      buildListTile: (Paciente paciente) => ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(paciente.nome!),
                        subtitle: Text(paciente.email ?? ""),
                      ),
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: dentistaController,
                      decoration: const InputDecoration(labelText: 'Dentista'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: tipoController,
                      decoration: const InputDecoration(labelText: 'Tipo'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: dataController,
                      decoration: const InputDecoration(labelText: 'Data'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: inicioController,
                      decoration: const InputDecoration(labelText: 'Início'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: terminoController,
                      decoration: const InputDecoration(labelText: 'Término'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 10),
                    TextFormField(
                      controller: observacaoController,
                      decoration:
                          const InputDecoration(labelText: 'Observação'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Campo obrigatório';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Config.primaryColor),
                      onPressed: _submitForm,
                      child: const Text('Salvar'),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

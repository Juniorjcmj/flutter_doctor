import 'package:flutter/material.dart';
import 'package:flutter_doctor/model/paciente.dart';
import 'package:flutter_doctor/services/paciente_service.dart';
import 'package:flutter_doctor/utils/config.dart';

import '../model/especialista.dart';
import '../services/especialista_service.dart';
import 'autocomplete_widget.dart';

class ConsultaForm extends StatefulWidget {
  const ConsultaForm({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ConsultaFormState createState() => _ConsultaFormState();
}

class _ConsultaFormState extends State<ConsultaForm> {
  @override
  void initState() {
    super.initState();
    getPacientes();
    getEspecialistas();
  }

  @override
  void dispose() {
    super.dispose();
  }
  //Buscando lista de especialistas
  List<Especialista> especialistas = List.empty();
  Future<void> getEspecialistas() async {
    await EspecialistaService.getPorProfissional().then((value) {
      setState(() {
        especialistas = value;
      });
    }).catchError((onError) {
      return;
    });
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
   late Especialista especialistaSelecionado;

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
                    const SizedBox(height: 10,),
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
                      inputDecoration: InputDecoration(
                  hintText: 'Buscar',
                  labelText: 'Buscar',
                  alignLabelWithHint: true,                 
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {                         
                        });
                      },
                      icon: const Icon(
                              Icons.person_add_rounded,
                              color: Config.secundColor,
                              size: 35,
                            )
                          
                            ),
                            ),
                    ),
                    const SizedBox(height: 10,),
                     AutocompleteWidget<Especialista>(
                      options: especialistas,
                      displayStringForOption: (Especialista especialista) =>
                          especialista.nome!,
                      onSelected: (Especialista especialista) {
                        especialistaSelecionado = especialista;
                      },
                      buildListTile: (Especialista especialista) => ListTile(
                        leading: const Icon(Icons.person),
                        title: Text(especialista.nome!),
                        subtitle: Text(especialista.email ?? ""),
                      ),
                      inputDecoration: InputDecoration(
                  hintText: 'Buscar',
                  labelText: 'Buscar',
                  alignLabelWithHint: true,                 
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {                         
                        });
                      },
                      icon: const Icon(
                              Icons.person_add_rounded,
                              color: Config.secundColor,
                              size: 35,
                            )
                          
                            ),
                            ),
                    ),
                    const SizedBox(height: 10),
                   
                   
                         // Tipo
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

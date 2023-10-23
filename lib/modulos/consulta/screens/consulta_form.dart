// ignore_for_file: public_member_api_docs, sort_constructors_first, use_build_context_synchronously
import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/livroCaixa/screens/components/custom_dropdawnButtomformfield.dart';
import 'package:flutter_doctor/modulos/paciente/state/paciente_controller.dart';
import 'package:flutter_doctor/shared/state/splash_controller.dart';
import 'package:flutter_doctor/shared/util/util.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:flutter_doctor/modulos/especialista/screens/especialista_form.dart';
import 'package:flutter_doctor/modulos/paciente/screens/paciente_form.dart';
import 'package:flutter_doctor/model/consulta.dart';
import 'package:flutter_doctor/modulos/paciente/model/paciente.dart';
import 'package:flutter_doctor/modulos/paciente/service/paciente_service.dart';
import 'package:flutter_doctor/shared/util/config.dart';

import '../../especialista/model/especialista.dart';
import '../service/consulta_service.dart';
import '../../especialista/service/especialista_service.dart';
import '../../../components/autocomplete_widget.dart';

class ConsultaForm extends StatefulWidget {
  static const String routNamed = "/consulta-form";

  late DateTime? dataConsulta;
  late TimeOfDay? horaConsulta;
  late Consulta? consulta;

  ConsultaForm({Key? key, this.dataConsulta, this.horaConsulta, this.consulta})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _ConsultaFormState createState() => _ConsultaFormState();
}

class _ConsultaFormState extends State<ConsultaForm> {
  ConsultaService service = Get.put(ConsultaService());
  final SplashController _splashController = Get.put(SplashController());

  Consulta consultaForm = Consulta();
  bool _isLoading = false;

  Paciente pacienteSelecionado = Paciente();
  Especialista especialistaSelecionado = Especialista();

  @override
  void initState() {
    super.initState();
    getPacientes();
    getEspecialistas();

    if (widget.dataConsulta != null && widget.horaConsulta != null) {
      //dataController.text = DateFormat(DateFormat.YEAR_MONTH_DAY, 'pt_Br').format(widget.dataConsulta!);
      dataController.text =
          DateFormat('dd/MM/yyyy').format(widget.dataConsulta!);
      inicioController.text =
          '${widget.horaConsulta!.hour.toString().padLeft(2, '0')}:${widget.horaConsulta!.minute.toString().padLeft(2, '0')}';
    }

    tipoController.text = "Primeira vez";

    if (widget.consulta != null && widget.consulta!.id != null) {
      pacienteController.text = widget.consulta!.nomePaciente;
      dentistaController.text = widget.consulta!.nomeDentista;
      pacienteSelecionado.id = int.parse(widget.consulta!.pacienteId);
      especialistaSelecionado.id = int.parse(widget.consulta!.dentistaId);
      consultaForm = widget.consulta!;
    } else {
      consultaForm.nomeDentista = "Especilista";
      consultaForm.nomePaciente = "Paciente";
      widget.consulta = Consulta();
      widget.consulta!.confirmado = 'false';
    }
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

  String dropdownvalue = 'Primeira vez';
  var items = [
    'Primeira vez',
    'Revisão',
    'Avaliação',
    'Tratamento',
    'Urgência',
    'Procedimento'
  ];

  final _formKey = GlobalKey<FormState>();
  TextEditingController pacienteController = TextEditingController();
  TextEditingController dentistaController = TextEditingController();
  TextEditingController tipoController = TextEditingController();
  TextEditingController dataController = TextEditingController();
  TextEditingController inicioController = TextEditingController();
  TextEditingController terminoController = TextEditingController();
  TextEditingController observacaoController = TextEditingController();

  Future<bool> _submitForm() async {
    bool response = false;
    TimeOfDay horaInicial = const TimeOfDay(hour: 12, minute: 00);
    TimeOfDay horaFinal = const TimeOfDay(hour: 12, minute: 00);
    if (inicioController.text.isNotEmpty) {
      horaInicial = TimeOfDay(
          hour: int.parse(inicioController.text.split(':')[0]),
          minute: int.parse(inicioController.text.split(':')[1]));
    } else if (widget.horaConsulta != null && inicioController.text.isEmpty) {
      horaInicial = widget.horaConsulta!;
    }

    int minutosAdicionais = 30;
    int minutosTotais = horaInicial.minute + minutosAdicionais;
    if (minutosTotais >= 60) {
      horaFinal =
          TimeOfDay(hour: horaInicial.hour + 1, minute: minutosTotais % 60);
    } else {
      horaFinal = TimeOfDay(hour: horaInicial.hour, minute: minutosTotais);
    }

    DateTime dateInicial = DateTime(
        int.parse(dataController.text.split('/')[2]),
        int.parse(dataController.text.split('/')[1]),
        int.parse(dataController.text.split('/')[0]),
        int.parse(horaInicial.hour.toString().padLeft(2, '0')),
        int.parse(horaInicial.minute.toString().padLeft(2, '0')));

    DateTime datefinal = DateTime(
        int.parse(dataController.text.split('/')[2]),
        int.parse(dataController.text.split('/')[1]),
        int.parse(dataController.text.split('/')[0]),
        int.parse(horaFinal.hour.toString().padLeft(2, '0')),
        int.parse(horaFinal.minute.toString().padLeft(2, '0')));

    if (_formKey.currentState!.validate()) {
      Map<String, dynamic> dados = {
        "id": consultaForm.id,
        "start": Util.formatarDataHoraUtc(dateInicial, horaInicial),
        "end": Util.formatarDataHoraUtc(datefinal, horaFinal),
        "valor": "0.0",
        "tipo": tipoController.text,
        "observacao": observacaoController.text,
        "pacienteId": pacienteSelecionado.id,
        "dentistaId": especialistaSelecionado.id
      };

      response = await ConsultaService.cadastrarConsulta(dados);
    }
    return response;
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
                title: const Text("Cadastro de Consultas"),
                centerTitle: true,
              ),
              body: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: _formKey,
                  child: ListView(
                    children: <Widget>[
                      const SizedBox(
                        height: 10,
                      ),
                      AutocompleteWidget<Paciente>(
                        options: pacientes,
                        displayStringForOption: (Paciente paciente) =>
                            paciente.nome!,
                        onSelected: (Paciente paciente) {
                          pacienteSelecionado = paciente;
                          return null;
                        },
                        buildListTile: (Paciente paciente) => ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(paciente.nome!),
                          subtitle: Text(paciente.email ?? ""),
                        ),
                        inputDecoration: InputDecoration(
                          hintText: consultaForm.nomePaciente,
                          labelText: consultaForm.nomePaciente,
                          border: const UnderlineInputBorder(),
                          alignLabelWithHint: true,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                // showDialog(
                                //     context: context,
                                //     builder: (context) =>  PacienteForm());
                                // setState(() {});
                                var response = await Get.to(PacienteForm());
                                Paciente result =
                                    response['Paciente'] as Paciente;
                                setState(() {
                                  consultaForm.nomePaciente =
                                      result.nome as String;
                                  pacienteSelecionado.id = result.id;
                                });
                              },
                              icon: const Icon(
                                Icons.person_add_rounded,
                                color: Config.primaryColor,
                                size: 35,
                              )),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      AutocompleteWidget<Especialista>(
                        options: especialistas,
                        displayStringForOption: (Especialista especialista) =>
                            especialista.nome!,
                        onSelected: (Especialista especialista) {
                          especialistaSelecionado = especialista;
                          dentistaController.text = especialista.id.toString();
                          return null;
                        },
                        buildListTile: (Especialista especialista) => ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(especialista.nome!),
                          subtitle: Text(especialista.email ?? ""),
                        ),
                        inputDecoration: InputDecoration(
                          hintText: consultaForm.nomeDentista,
                          labelText: consultaForm.nomeDentista,
                          border: const UnderlineInputBorder(),
                          alignLabelWithHint: true,
                          suffixIcon: IconButton(
                              onPressed: () async {
                                var response = await Get.to(EspecialistaForm());
                                Especialista result =
                                    response['especialista'] as Especialista;
                                setState(() {
                                  consultaForm.nomeDentista =
                                      result.nome as String;
                                  especialistaSelecionado.id = result.id;
                                });
                              },
                              icon: const Icon(
                                Icons.person_add_rounded,
                                color: Config.primaryColor,
                                size: 35,
                              )),
                        ),
                      ),
                      const SizedBox(height: 10),

                      _dropformapagamento(),

                      // Tipo
                      const SizedBox(height: 10),
                      TextFormField(
                        onTap: () async {
                          final data = await showDatePicker(
                            context: context,
                            initialDate: widget.dataConsulta ?? DateTime.now(),
                            firstDate: DateTime(2018),
                            lastDate: DateTime(2040),
                            locale: const Locale('pt', 'BR'),
                          );
                          if (data != null) {
                            final datapt =
                                DateFormat('dd/MM/yyyy').format(data);
                            dataController.text = datapt;
                          }
                        },
                        controller: dataController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Data',
                            suffixIcon: Icon(
                              Icons.calendar_month,
                              color: Config.primaryColor,
                              size: 35,
                            )),
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
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Início',
                            suffixIcon: Icon(
                              Icons.timer_sharp,
                              color: Config.primaryColor,
                              size: 35,
                            )),
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Campo obrigatório';
                          }
                          return null;
                        },
                        onTap: () async {
                          final time = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );

                          if (time != null) {
                            String formattedHour =
                                time.hour.toString().padLeft(2, '0');
                            String formattedMinute =
                                time.minute.toString().padLeft(2, '0');
                            inicioController.text =
                                "$formattedHour:$formattedMinute";
                          }
                        },
                      ),
                      const SizedBox(height: 10),
                      TextFormField(
                        controller: observacaoController,
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Observação'),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Config.primaryColor),
                        onPressed: () async {
                          setState(() {
                            _isLoading =
                                true; // Inicia o indicador de carregamento
                          });
                          bool response = await _submitForm();
                          if (response) {
                            setState(() {
                              _isLoading =
                                  false; // Inicia o indicador de carregamento
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.greenAccent,
                                content:
                                    Text('Consulta cadastrada com sucesso!'),
                              ),
                            );
                            Get.back(result: true);
                          } else {
                            setState(() {
                              _isLoading = false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text(
                                    'Não foi possivél cadastrar consulta!'),
                              ),
                            );
                          }
                        },
                        child: const Text(
                          'SALVAR',
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),

                     

                     Visibility(
                      visible: widget.consulta!.id != null,
                       child: Card(
                         
                     
                          child: SizedBox(
                            height: 90,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        service
                                            .enviarMensagemWhatsapp(widget.consulta!);
                                      },
                                      icon: const FaIcon(
                                        FontAwesomeIcons.whatsapp,
                                        size: 45,
                                        color: Colors.green,
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    const Text(
                                      "WhatsApp",
                                      style: TextStyle(color: Colors.green),
                                    )
                                  ],
                                ),
                                Column(
                                  children: [
                                    IconButton(
                                      onPressed: () async {
                                        _splashController.atualizarLoader(true);
                                        String result = await service
                                            .confirmarConsulta(widget.consulta!);
                                        setState(() {
                                          widget.consulta!.confirmado = result;
                                          _splashController.atualizarLoader(false);
                                          if (bool.parse(
                                              widget.consulta!.confirmado)) {
                                            Get.snackbar('Confirmado!',
                                                "Operação realizada com sucesso",
                                                colorText: Colors.white,
                                                backgroundColor: Colors.green, );
                                          } else {
                                            Get.snackbar('Desconfirmado!',
                                                "Operação realizada com sucesso",
                                                colorText: Colors.white,
                                                backgroundColor: Colors.amber);
                                          }
                                        });
                                      },
                                      icon: _splashController.isLoader.value
                                          ? const FaIcon(
                                              FontAwesomeIcons.spinner,
                                              size: 45,
                                              color: Colors.blue,
                                            )
                                          : bool.parse(widget.consulta!.confirmado)
                                              ? const FaIcon(
                                                  FontAwesomeIcons.personCircleCheck,
                                                  size: 45,
                                                  color: Colors.green,
                                                )
                                              : const FaIcon(
                                                  FontAwesomeIcons.personCircleXmark,
                                                  size: 45,
                                                  color: Colors.red,
                                                ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    bool.parse(widget.consulta!.confirmado)
                                        ? const Text(
                                            "Confirmado",
                                            style: TextStyle(color: Colors.green),
                                          )
                                        : const Text(
                                            "Não Confirmado",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                     ),
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
      labelText: "Selecione Tipo Consulta*",
      prefixIcon: const Icon(
        Icons.toc,
        size: 25,
        color: Colors.blue,
      ),
      onChanged: (value) {
        setState(() {
          dropdownvalue = value;
          tipoController.text = dropdownvalue;
        });
      },
    );
  }
}

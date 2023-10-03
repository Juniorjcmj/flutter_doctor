import 'package:flutter/material.dart';

import '../../../shared/util/config.dart';
import '../../../components/custom_textfield.dart';

class EspecialistaForm extends StatefulWidget {
  static const String routNamed = "/especialista-form";

  const EspecialistaForm({ super.key });

  @override
  State<EspecialistaForm> createState() => _EspecialistaFormState();
}

class _EspecialistaFormState extends State<EspecialistaForm> {


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

 @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Config.primaryColor ,
        title: const Text('Cadastro de Especialista'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
           const SizedBox(height: 15,),         
            CustomTextField(
              controller: _nomeController,
              hintText: 'Nome',
              obscureText: false,
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
              CustomTextField(
              controller: _cepController,
              hintText: 'CEP',
              obscureText: false,
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
            ElevatedButton(
              
              style: ElevatedButton.styleFrom(
                            backgroundColor: Config.primaryColor),
              onPressed: () {
             
              },
              child: const Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}

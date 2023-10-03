import 'package:flutter/material.dart';

import '../../../shared/util/config.dart';
import '../../../components/custom_textfield.dart';

class PacienteForm extends StatefulWidget {

  static const String routNamed = "/paciente-form";

  const PacienteForm({ super.key });

  @override
  State<PacienteForm> createState() => _PacienteFormState();
}

class _PacienteFormState extends State<PacienteForm> {
  final TextEditingController _idController = TextEditingController();
  final TextEditingController _nomeController = TextEditingController();
  final TextEditingController _convenioController = TextEditingController();
  final TextEditingController _cpfController = TextEditingController();
  final TextEditingController _idadeController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _senhaController = TextEditingController();
  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _whatsappController = TextEditingController();
  final TextEditingController _ativoController = TextEditingController();
  final TextEditingController _ruaController = TextEditingController();
  final TextEditingController _bairroController = TextEditingController();
  final TextEditingController _cidadeController = TextEditingController();
  final TextEditingController _ufController = TextEditingController();
  final TextEditingController _cepController = TextEditingController();
  final TextEditingController _dataCriacaoController = TextEditingController();
  final TextEditingController _dataAtualizacaoController = TextEditingController();
  final TextEditingController _corController = TextEditingController();
  final TextEditingController _carteirinhaController = TextEditingController();

 @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor:Config.primaryColor ,
        title: Text('Cadastro de Pacientes'),
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
                  controller: _convenioController,
                  hintText: 'Convênio',
                  obscureText: false,
                ),
             const SizedBox(height: 15,),
              CustomTextField(
              controller: _carteirinhaController,
              hintText: 'Carteirinha',

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
            const SizedBox(height: 15,), 
            CustomTextField(
              controller: _dataCriacaoController,
              hintText: 'Data de Criação',
              obscureText: false,
            ),
             const SizedBox(height: 15,), 
            CustomTextField(
              controller: _dataAtualizacaoController,
              hintText: 'Data de Atualização',
              obscureText: false,
            ),
             const SizedBox(height: 15,), 
            CustomTextField(
              controller: _corController,
              hintText: 'Cor',
              obscureText: false,
            ),
          
            const SizedBox(height: 20.0),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                            backgroundColor: Config.primaryColor),
              onPressed: () {
                // Aqui você pode acessar os dados dos controladores
                // e fazer o que precisar com eles (por exemplo, salvar no banco de dados)
                print('ID: ${_idController.text}');
                print('Nome: ${_nomeController.text}');
                print('Convênio: ${_convenioController.text}');
                // Continue com os demais campos
              },
              child: Text('Cadastrar'),
            ),
          ],
        ),
      ),
    );
  }
}
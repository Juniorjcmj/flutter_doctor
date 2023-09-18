// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_doctor/services/auth_service.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:flutter_svg/svg.dart';

import '../components/custom_button.dart';
import '../components/custom_textfield.dart';

class AlterarSenha extends StatefulWidget {

  static const String routNamed = '/alterar-senha';

  AlterarSenha({super.key});

  @override
  _AlterarSenhaState createState() => _AlterarSenhaState();
}

class _AlterarSenhaState extends State<AlterarSenha> {

  final senhaController = TextEditingController();
  final novaSenhaController = TextEditingController();
   bool obscurePass = true;    
  bool obscurePassConf = true;

  @override
  void initState() {
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 30),
                  SvgPicture.asset(
                    'assets/enviar_mail.svg',
                    width: 200,
                  ),
                  const SizedBox(height: 50),

                  //Bem vindo novamente ao Sistema!
                  Text(
                    'Alteração de senha',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16
                    ),
                  ),
                 
                  const SizedBox(height: 10),
                  //senha textField
                  CustomTextField(
                      controller: senhaController,
                      hintText: 'Nova Senha',
                      obscureText: obscurePass,
                      decorator: InputDecoration(
                    hintText: 'Nova Senha',
                    labelText: 'Nova Senha',
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock_clock_outlined),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePass = !obscurePass;
                        });
                      },
                      icon: !obscurePass
                          ? const Icon(
                              Icons.visibility_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            ),
                    ),
                  ), 
                      
                  ),

                  const SizedBox(height: 10),
                  //nova senha textField
                  CustomTextField(
                      controller: novaSenhaController,
                      hintText: 'Confirmar Nova senha',
                      obscureText: obscurePassConf,   
                      decorator: InputDecoration(
                    hintText: 'Confirmar Senha',
                    labelText: 'Confirmar Senha',
                    alignLabelWithHint: true,
                    prefixIcon: const Icon(Icons.lock_clock_outlined),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePassConf = !obscurePassConf;
                        });
                      },
                      icon: !obscurePass
                          ? const Icon(
                              Icons.visibility_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            ),
                    ),
                  ),                 
                  ),

                  const SizedBox(height: 35),

                  //Botão de enviar
                  CustomButtom(
                    texto: "Enviar",
                    onTap: () async{

                      if(novaSenhaController.text != senhaController.text){
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 197, 8, 8),
                            content: Text('As senhas precisam ser iguais!'),
                          ),
                        );
                      }else{
                            final sucess = await  AuthService.alterarSenha(novaSenhaController.text);
                      if(sucess){
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Config.primaryColor,
                            content: Text('Senha alterada com sucesso'),
                          ),
                        );
                        Navigator.pop(context);
                      }else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Erro ao alterar senha'),
                          ),
                        );
                      }
                      }
                   
                    },
                  ),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

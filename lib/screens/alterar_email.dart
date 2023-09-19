import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../services/auth_service.dart';
import '../utils/config.dart';

class AlterarEmail extends StatefulWidget {
 static const String rounNamed = "alterar-email";
  const AlterarEmail({ super.key });

  @override
  State<AlterarEmail> createState() => _AlterarEmailState();
}

class _AlterarEmailState extends State<AlterarEmail> {

  final emailController = TextEditingController();
  final novaEmailController = TextEditingController();

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
                    'Alteração de Email',
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16
                    ),
                  ),
                 
                  const SizedBox(height: 10),
                  //senha textField
                  CustomTextField(
                      controller: emailController,
                      hintText: 'Novo Email',
                      obscureText: false
                      
                  ),

                  const SizedBox(height: 10),
                  //nova senha textField
                  CustomTextField(
                      controller: novaEmailController,
                      hintText: 'Confirmar Novo Email',
                      obscureText: false,                    
                  ),

                  const SizedBox(height: 35),

                  //Botão de enviar
                  CustomButtom(
                    texto: "Enviar",
                    onTap: () async{

                      if(novaEmailController.text != emailController.text){
                         ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Color.fromARGB(255, 197, 8, 8),
                            content: Text('Os Emais precisam ser iguais!'),
                          ),
                        );
                      }else{
                            final sucess = await  AuthService.trocarEmail(novaEmailController.text);
                      if(sucess){
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            backgroundColor: Config.primaryColor,
                            content: Text('Email alterado com sucesso'),
                          ),
                        );
                        Get.back();
                      }else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Erro ao alterar email'),
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
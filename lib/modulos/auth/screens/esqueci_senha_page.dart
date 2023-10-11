// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../service/auth_service.dart';

class RecuperarSenha extends StatelessWidget {

   static const String routNamed = '/esqueci-senha';

   RecuperarSenha(
       {super.key});

  //text editing controller
  final usernameController = TextEditingController();
 

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return  Scaffold(
        backgroundColor:  Colors.white,
      body:  SafeArea(
          child: SingleChildScrollView(
             child:  Container(
               padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
               child: Center(
             child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
               children: [
                 const SizedBox(height: 30),
                 SvgPicture.asset(
                   'assets/forgot_password.svg',
                   width: 200,
                  
                 ),
                 const  SizedBox(height: 50),

                 //Bem vindo novamente ao Sistema!
                 Text(
                   'Recuperação de Senha!',
                   style: TextStyle(
                       color: Colors.grey[700],
                       fontSize: 16
                   ),
                 ),
                 const SizedBox(height: 25),

                 //username textField
                 CustomTextField(
                     controller: usernameController,
                     hintText: 'Email',
                     obscureText: false
                     
                 ),

                 const SizedBox(height: 10),
                 //password textField              
    

                 //sign in button
                 CustomButtom(
                  texto: "Enviar email ",
                  onTap: () async{
                    final sucess = await  AuthService.recuperarSenha(usernameController.text);
                     if(sucess){
                      ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Config.terciaryColor,
                        content: Text('Email de recuperação enviado, verifique seu email!',
                        
                        ),
                      ),
                    );                   
                    Get.back();
                     }else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Config.terciaryColor,
                        content: Text('Erro ao enviar email de recuperação'),
                      ),
                    );
                  }
                  },
                 
                 ),

                 const SizedBox(height: 35),

                 const SizedBox(height: 50),

                 //não é menbro? registrar!
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Text(
                       'Não tem registro?',
                       style: TextStyle(
                           color: Colors.grey[700]
                       ),
                     ),

                     const SizedBox(width: 4),

                     const Text(
                       "Registrar agora!",
                       style: TextStyle(
                           color: Colors.blue,
                           fontWeight: FontWeight.bold

                       ),
                     )
                   ],
                 )

               ],
             ),
          ),
             ),
          )

      ),

    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_doctor/utils/config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../components/custom_button.dart';
import '../components/custom_textfield.dart';
import '../main_layout.dart';
import '../services/auth_service.dart';
import '../services/local_storage_service.dart';
import 'esqueci_senha_page.dart';

class LoginPage extends StatelessWidget {

   LoginPage(
       {super.key});

  //text editing controller
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  //sing user in method
  Future<void> singUserIn( BuildContext context) async {
  //   bool? resposta = await DesafioMatematica.questionMath(context);
  //  if(resposta!){
  //    MessageCustom.showToast("Resposta certa", MessageType.success, gravity: ToastGravity.TOP);

  //  }else{
  //     MessageCustom.showToast("Resposta errada", MessageType.error, gravity: ToastGravity.TOP);
  //  };
    AuthService.generateToken(
        usernameController.text,
       passwordController.text)
        .then(
            (value) =>
                LocalStorageService().saveDados(value)
                    .then((value) =>  Navigator.push(context,
                    MaterialPageRoute(
                        builder: ((context) => const MainLayout())
                    )
                )
                ),
    )
        .catchError((onError)=> print(onError));
  }
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
                   'assets/login2.svg',
                   width: 200,
                  
                 ),
                 const  SizedBox(height: 50),

                 //Bem vindo novamente ao Sistema!
                 Text(
                   'Seja bem vindo!',
                   style: TextStyle(
                       color: Colors.grey[700],
                       fontSize: 16
                   ),
                 ),
                 const SizedBox(height: 25),

                 //username textField
                 CustomTextField(
                     controller: usernameController,
                     hintText: 'Usuário',
                     obscureText: false
                 ),

                 const SizedBox(height: 10),
                 //password textField
                 CustomTextField(
                     controller: passwordController,
                     hintText: 'Senha',
                     obscureText: true
                 ),

                 
                 //ForgotPassword
                 Padding(
                   padding: const EdgeInsets.symmetric(horizontal: 15.0),
                   child:  Row(
                     mainAxisAlignment: MainAxisAlignment.end,
                     children: [
                       TextButton(                        
                         onPressed: () {
                           Navigator.pushNamed(context, RecuperarSenha.routNamed);
                         }, child: Text( 'Esqueceu a senha?',
                         style: TextStyle(color: Colors.grey[600]),),
                       ),
                     ],
                   ),
                 ),

                 const SizedBox(height: 25),

                 //sign in button
                 CustomButtom(
                  texto: "Entrar",
                   onTap: ()
                   {
                     singUserIn(context);
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

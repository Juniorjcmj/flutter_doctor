import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../../../components/custom_button.dart';
import '../../../components/custom_textfield.dart';
import '../../../main_layout.dart';
import '../service/auth_service.dart';
import 'esqueci_senha_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
   bool _isLoading = false; // Variável para controlar se o login está em andamento
  //text editing controller
  final usernameController = TextEditingController();

  final passwordController = TextEditingController();

  bool obscurePass = true;

  @override
  Widget build(BuildContext context) {
    Config().init(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body:_isLoading
            ?  Center(
              child: LoadingAnimationWidget.staggeredDotsWave(                   
                   color: Config.primaryColor,
                   size: 100
                ),
                ) // Mostra o indicador de carregamento enquanto o login está em andamento
            :  SafeArea(
          child: SingleChildScrollView(
        child: Container(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                SvgPicture.asset(
                  'assets/login3.svg',
                  width: 200,
                ),
                const SizedBox(height: 50),

                //Bem vindo novamente ao Sistema!
                Text(
                  'Seja bem vindo!',
                  style: TextStyle(color: Colors.grey[700], fontSize: 16),
                ),
                const SizedBox(height: 25),

                //username textField
                CustomTextField(
                  controller: usernameController,
                  
                  hintText: 'Usuário',
                  obscureText: false,
                  decorator: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Usuário',
                    labelText: 'Usuário',
                    alignLabelWithHint: true,
                    prefixIcon: Icon(Icons.person_2_outlined),
                    prefixIconColor: Config.primaryColor,
                    suffixIcon: Icon(
                      Icons.person_2_outlined,
                      color: Colors.black38,
                    ),
                  ),
                ),

                const SizedBox(height: 10),
                //password textField
                CustomTextField(
                  controller: passwordController,

                  hintText: 'Senha',
                  obscureText: obscurePass,
                  decorator: InputDecoration(         
                    border: const UnderlineInputBorder(),           
                    hintText: 'Password',
                    labelText: 'Password',
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

                //ForgotPassword
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {
                           Get.to(RecuperarSenha());
                         
                        },
                        child: Text(
                          'Esqueceu a senha?',
                          style: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 25),

                //sign in button
                CustomButtom(
                  texto: "Entrar",
                  onTap: () async { 
                    setState(() {
                          _isLoading = true; // Inicia o indicador de carregamento
                        });
                    if(usernameController.text.isNotEmpty &&  passwordController.text.isNotEmpty){
                         final success = await AuthService
                        .generateToken(usernameController.text, passwordController.text);                      
                          if(success){
                            setState(() {
                               _isLoading = false; // Inicia o indicador de carregamento
                              });
                        Get.off(const MainLayout());
                          }else{
                            setState(() {
                               _isLoading = false; // Inicia o indicador de carregamento
                              });
                            // ignore: use_build_context_synchronously
                          Get.snackbar('Error', "Login ou senha inválido(s)", backgroundColor: Colors.red, colorText: Colors.white);
                          }
                    }else{
                      setState(() {
                               _isLoading = false; // Inicia o indicador de carregamento
                              });
                      Get.snackbar('Error', "Login e senha devem se preenchidos", backgroundColor: Colors.red, colorText: Colors.white);
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
                      style: TextStyle(color: Colors.grey[700]),
                    ),
                    const SizedBox(width: 4),
                    const Text(
                      "Registrar agora!",
                      style: TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      )),
    );
  }
}

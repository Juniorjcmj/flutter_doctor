import 'package:flutter/material.dart';
import 'package:flutter_doctor/components/button.dart';
import 'package:flutter_doctor/main_layout.dart';

import '../../services/auth_service.dart';
import '../../services/local_storage_service.dart';
import '../../utils/config.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool obscurePass = true;

  Future<void> singUserIn( BuildContext context) async {
  //   bool? resposta = await DesafioMatematica.questionMath(context);
  //  if(resposta!){
  //    MessageCustom.showToast("Resposta certa", MessageType.success, gravity: ToastGravity.TOP);

  //  }else{
  //     MessageCustom.showToast("Resposta errada", MessageType.error, gravity: ToastGravity.TOP);
  //  };
    AuthService.generateToken(
        _emailController.text,
        _passwordController.text)
        .then(
            (value) =>
                LocalStorageService().saveDados(value)
                    .then((value) =>  Navigator.push(context,
                    MaterialPageRoute(
                        builder: ((context) => const MainLayout())
                    )
                )
                ),
    );
  }
  

  @override
  Widget build(BuildContext context) {
    return Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            TextFormField(
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              cursorColor: Config.primaryColor,
              decoration: const InputDecoration(
                  hintText: 'Endereço de Email',
                  labelText: 'Email',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.email_outlined),
                  prefixIconColor: Config.primaryColor),
            ),
            Config.spaceSmall,
            TextFormField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: obscurePass,
              cursorColor: Config.primaryColor,
              decoration: InputDecoration(
                  hintText: 'Senha',
                  labelText: 'Senha',
                  alignLabelWithHint: true,
                  prefixIcon: const Icon(Icons.lock_clock_outlined),
                  prefixIconColor: Config.primaryColor,
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          obscurePass = !obscurePass;                          
                        });
                      },
                      icon: obscurePass
                          ? const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            )
                          : const Icon(
                              Icons.visibility_off_outlined,
                              color: Colors.black38,
                            ),
                            ),
                            ),
            ),
            Config.spaceSmall,
            Button(
                width: double.infinity,
                title: 'Entrar',
                disable: false,
                onPressed: () {
                  singUserIn(context);
                 // Navigator.of(context).pushNamed(MainLayout.routName);
                })
          ],
        )
        );
  }
}

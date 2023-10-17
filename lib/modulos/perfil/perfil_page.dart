import 'package:flutter/material.dart';
import 'package:flutter_custom_clippers/flutter_custom_clippers.dart';
import 'package:flutter_doctor/modulos/auth/screens/alterar_email.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:get/get.dart';

import '../../shared/service/local_storage_service.dart';
import '../auth/screens/alterar_senha.dart';

class Perfil extends StatefulWidget {

  static const String routNamed = '/perfil';

  const Perfil({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _PerfilState createState() => _PerfilState();
}

class _PerfilState extends State<Perfil> {

  @override
  void initState() {
    
    super.initState();
     _getNome();
  }

  late String _nome = 'Funcionário';
   final LocalStorageService _storage = LocalStorageService();

   _getNome(){
    _storage.getNome().then((value) {
         setState(() {
           _nome = value.toString();

         });
    });
   }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 300,
        backgroundColor: Colors.transparent,
        elevation: 0,
        flexibleSpace: ClipPath(
          clipper: OvalBottomBorderClipper(),
          child: Container(
            height: 400,
            width: Config.widtSize,
            color: Config.primaryColor,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  _nome,
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),

                const SizedBox(height: 45,),
              
                     const CircleAvatar(
                    radius: 80,
                    backgroundImage:  NetworkImage('https://thumbs.dreamstime.com/b/smiling-medical-doctor-woman-stethoscope-isolated-over-white-background-35552912.jpg'),
                  ),            
                  
                ],
            ),
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  const SizedBox(height: 25),

                  //Bem vindo novamente ao Sistema!
                 
                  const SizedBox(height: 25),

                  //Texto com o email
                  Text(
                   "gmail@mail.com",
                    style: TextStyle(
                        color: Colors.grey[700],
                        fontSize: 16
                    ),
                  ),
                  const SizedBox(height: 35),

                  //Botão para alterar a senha
                  TextButton(
                    onPressed: (){
                      Get.to(AlterarSenha());
                      },
                    child: Text(
                      'Alterar senha',
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 16
                      ),
                    ),
                  ),

                  //Botão para alterar o email
                  TextButton(
                    onPressed: (){                     
                      Get.to(const AlterarEmail());
                    },
                    child: Text(
                      'Alterar email',
                      style: TextStyle(
                          color: Colors.blue[700],
                          fontSize: 16
                      ),
                    ),
                  ),

                  const SizedBox(height: 20,),
                 IconButton(
                  iconSize: 60,
                  onPressed: (){                    
                     Get.back();
                  }, 
                  icon: const Icon(Icons.arrow_back,color: Config.secundColor),
                  )

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

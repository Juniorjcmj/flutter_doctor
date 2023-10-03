
import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';

class CustomButtom extends StatelessWidget {

  final Function()? onTap;
  final String texto;
  
  const CustomButtom({super.key, required this.onTap,  required this.texto});

  @override
  Widget build(BuildContext context) {
    
    Config().init(context);
    return GestureDetector(
       onTap: onTap,

      child: Container(
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(horizontal: 25),
        decoration: BoxDecoration(
            color: Config.primaryColor,
            borderRadius: BorderRadius.circular(8)
        ),
        child: const Center(
          child: Text(
              'Enviar',
               style: TextStyle(
                   color: Colors.white,
                 fontWeight: FontWeight.bold,
                 fontSize: 18

               ),
          ),),
      ),
    );
  }
}

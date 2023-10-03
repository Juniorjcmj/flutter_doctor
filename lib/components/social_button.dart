// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';

class SocialButton extends StatelessWidget {

  const SocialButton({ super.key, required this.social });

  final String social;

   @override
   Widget build(BuildContext context) {

     Config().init(context);

       return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: EdgeInsets.symmetric(vertical: 15),
          side: const BorderSide(width: 1, color: Colors.black)
        ),
        onPressed: (){         
        }, 
        child: SizedBox(
          width: Config.widtSize * 0.4,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Image.asset('assets/$social.png',
              width: 40,
              height: 40,
              ),
              Text(
                social.toUpperCase(),
                style: const TextStyle(
                   color: Colors.black
                )
                )
            ],

            ),
          )
        );
  }
}
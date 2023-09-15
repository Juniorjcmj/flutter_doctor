import 'package:flutter/material.dart';
import 'dart:math';
import 'package:fluttertoast/fluttertoast.dart';

class DesafioMatematica {
  static Future<bool?> questionMath(BuildContext context) async {
    int num1 = Random().nextInt(1) + 1; // Random number between 1 and 10
    int num2 = Random().nextInt(9) + 1;
    int respostaCorreta = num1 + num2;

    TextEditingController _respostaController = TextEditingController();

    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return  AlertDialog(
              alignment: Alignment.center,
              iconPadding:const EdgeInsets.all(0),
              titlePadding:const EdgeInsets.all(0),
              contentPadding:const EdgeInsets.all(0),
              shape:const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(30.0)),
              ),
              content: Container(
                decoration:const BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(60),
                    bottomRight: Radius.circular(20),
                  ),
                  color: Colors.blueGrey,
                ),
                padding:const EdgeInsets.all(30),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Resolva o problema:',
                      style: TextStyle(
                        fontSize: 18,
                        fontFamily: "TitilliumWeb",
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '$num1 + $num2 = ?',
                      style:const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: "TitilliumWeb",
                        color: Colors.white,
                      ),
                    ),
                   const  SizedBox(height: 20),
                    Padding(
                      padding:const  EdgeInsets.symmetric(horizontal: 40),
                      child: TextField(
                        controller: _respostaController,
                        decoration:const InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          prefix: Text("R: "),
                          border: UnderlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(15),
                            ),
                          ),
                          contentPadding:
                          EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green,
                        onPrimary: Colors.white.withOpacity(0.9),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30.0),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        int respostaUsuario =
                            int.tryParse(_respostaController.text) ?? 0;
                        if (respostaUsuario == respostaCorreta) {
                          Navigator.pop(context, true);
                        } else {
                          Navigator.pop(context, false);
                        }
                      },
                      child:const Text(
                        'Verificar resposta',
                        style: TextStyle(fontFamily: "TitilliumWeb"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import '../shared/util/config.dart';

class CustomTextField<T extends Object> extends StatelessWidget {

  final controller;
  final String hintText;
  final bool obscureText;
   final String? labelText;
  
  
  final InputDecoration? decorator;

  const CustomTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    this.labelText,    
    this.decorator
  });

  @override
  Widget build(BuildContext context) {
    Config().init(context);
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 25.0),
      child: TextField(
        controller: controller,  
        textCapitalization: TextCapitalization.words,      
        obscureText: obscureText,
        decoration: decorator ?? InputDecoration(
          labelText: this.labelText ?? this.hintText,
          enabledBorder:const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade300),
          ),
          fillColor: Colors.grey.shade100,
          filled: true,  
          
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[500])
        ),
       
      ),
    );
  }
}

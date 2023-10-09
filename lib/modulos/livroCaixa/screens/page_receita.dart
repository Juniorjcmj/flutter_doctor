import 'package:flutter/material.dart';

class PageReceita extends StatefulWidget {

  const PageReceita({ super.key });

  @override
  State<PageReceita> createState() => _PageReceitaState();
}

class _PageReceitaState extends State<PageReceita> {

   @override
   Widget build(BuildContext context) {
       return  const Scaffold(
           
           body: Center(child: Text('Receitas')),
       );
  }
}
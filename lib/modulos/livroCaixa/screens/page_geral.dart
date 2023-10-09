import 'package:flutter/material.dart';

class PageGeral extends StatefulWidget {

  const PageGeral({ super.key });

  @override
  State<PageGeral> createState() => _PageGeralState();
}

class _PageGeralState extends State<PageGeral> {

   @override
   Widget build(BuildContext context) {
       return const Scaffold(
           
           body: Center(child: Text('Página Geral')),
       );
  }
}
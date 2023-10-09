import 'package:flutter/material.dart';

class PageDespesas extends StatefulWidget {

  const PageDespesas({ super.key });

  @override
  State<PageDespesas> createState() => _PageDespesasState();
}

class _PageDespesasState extends State<PageDespesas> {

   @override
   Widget build(BuildContext context) {
       return  const Scaffold(
           
           body: Center(child: Text('Despesas')),
       );
  }
}
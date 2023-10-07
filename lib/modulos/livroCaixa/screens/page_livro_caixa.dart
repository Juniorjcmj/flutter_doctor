import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';

class PageLivroCaixa extends StatefulWidget {

  const PageLivroCaixa({ super.key });

  @override
  State<PageLivroCaixa> createState() => _PageLivroCaixaState();
}

class _PageLivroCaixaState extends State<PageLivroCaixa> {

   @override
   Widget build(BuildContext context) {
    Config().init(context);
       return Scaffold(
           appBar: AppBar(title: const Text('Livro Caixa'), centerTitle: true,backgroundColor: Config.primaryColor,),
           body: Container(),
       );
  }
}
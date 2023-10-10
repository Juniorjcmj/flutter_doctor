import 'package:flutter/material.dart';
import 'package:flutter_doctor/shared/util/config.dart';
import 'package:easy_pie_chart/easy_pie_chart.dart';


class PageGeral extends StatefulWidget {

  const PageGeral({ super.key });

  @override
  State<PageGeral> createState() => _PageGeralState();
}

class _PageGeralState extends State<PageGeral> {

   @override
   Widget build(BuildContext context) {
    Config().init(context);
       return  Scaffold(
           
           body: Padding(
             padding: const EdgeInsets.only(left: 0, right: 0, top: 40),
             child: Column(
               children: [
                 Card(
                  elevation: 5,
                  child: Container(
                    decoration: const BoxDecoration(                     
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    width: Config.widtSize * 0.98,
                    height: Config.height /4,
                    child:   Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Text('Visão Geral', style: TextStyle(fontSize: 16)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [  
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.green, // Cor de fundo desejada
                                          borderRadius: BorderRadius.circular(50), // Opcional: Adiciona bordas arredondadas
                                          ),
                                        child: IconButton(
                                          onPressed: () { },
                                          icon: const Icon(
                                            Icons.add,
                                            size: 20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                       const Text('Receita', style: TextStyle(fontSize: 15, color: Colors.black54), ),
                                    ],
                                  ),
                                ],
                              ),                             
                              const Text("15.000,00", textAlign: TextAlign.end,style: TextStyle(fontSize: 15, color: Colors.black54),)
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [  
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.red, // Cor de fundo desejada
                                          borderRadius: BorderRadius.circular(50), // Opcional: Adiciona bordas arredondadas
                                          ),
                                        child: IconButton(
                                          onPressed: () { },
                                          icon: const Icon(
                                            Icons.remove,
                                            size: 20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                       const Text('Despesa', style: TextStyle(fontSize: 15, color: Colors.black54), ),
                                    ],
                                  ),
                                ],
                              ),                             
                              const Text("-15.000,00", textAlign: TextAlign.end,style: TextStyle(fontSize: 15, color: Colors.black54),)
                            ],
                          ),
                          ),

                           Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,

                            children: [  
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        width: 35,
                                        height: 35,
                                        decoration: BoxDecoration(
                                          color: Colors.black54, // Cor de fundo desejada
                                          borderRadius: BorderRadius.circular(50), // Opcional: Adiciona bordas arredondadas
                                          ),
                                        child: IconButton(
                                          onPressed: () { },
                                          icon: const Icon(
                                            Icons.real_estate_agent,
                                            size: 20,
                                          ),
                                          color: Colors.white,
                                        ),
                                      ),
                                      const SizedBox(width: 10),
                                       const Text('Saldo', style: TextStyle(fontSize: 15, color: Colors.black54), ),
                                    ],
                                  ),
                                ],
                              ),                             
                              const Text("00.000,00", textAlign: TextAlign.end,style: TextStyle(fontSize: 15, color: Colors.black54),)
                            ],
                          ),
                          ),
                      ],
                    )
                    ),
                  ),
                  const SizedBox(height: 30,),
                    Card(
                  elevation: 5,
                  child: Container(
                    decoration: const BoxDecoration(                     
                      borderRadius: BorderRadius.all(Radius.circular(20))
                    ),
                    width: Config.widtSize * 0.98,
                    height: Config.height /4,
                    child:   Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:  [
                        const Text("Despesa por Categoria"),
                        const SizedBox( height: 20),
                         EasyPieChart(
                          size: 120, 
                                                   
                          pieType: PieType.fill,
                          children: [
                            PieData(value: 30, color: Colors.black12),
                            PieData(value: 50, color: Colors.grey),                           
                          ],
                        ),
                         const Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                           children: [
                             Row(
                                  children: [
                                    Icon(Icons.circle, color: Colors.black12,),
                                    Text("Fixas")
                                  ],
                                ),
                                 Row(
                                  children: [
                                    Icon(Icons.circle, color: Colors.grey,),
                                    Text("Variaveis")
                                  ],
                                ),
                           ],
                         )
                      ],
                    )
                    ),
                  ),
               ],
             ),
           ),
       );
  }
}


// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/consulta/screens/calendar_page.dart';
import 'package:flutter_doctor/shared/screens/home_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainLayout extends StatefulWidget {

 static const String routName = "/main";

  const MainLayout({ super.key });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentPage = 0;
  final PageController _page = PageController();

   @override
   Widget build(BuildContext context) {
       return 
       Scaffold(          
           body: PageView(
            controller: _page,
            onPageChanged: ((value) {
              setState(() {
                //update page index when tab pressed/page
                currentPage = value;
              });
            }),
            children: [
              const HomePage(),
              const TableCalendarPage(),                       
            ],            
           ),
           bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: currentPage,
            onTap:(page){
              setState(() {
                currentPage = page;
                _page.animateToPage(
                  page, 
                  duration: const Duration(microseconds: 500), 
                  curve: Curves.easeInOut);
              });
            },
            items: const <BottomNavigationBarItem> [
                 BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.houseChimneyMedical),
                  label: 'Home'
                  ),
                   BottomNavigationBarItem(
                  icon: FaIcon(FontAwesomeIcons.solidCalendarDays),
                  label: 'Agenda'
                  )
            ]
            ),
       );
  }
}
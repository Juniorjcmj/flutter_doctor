// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:flutter_doctor/main_layout.dart';
import 'package:flutter_doctor/screens/alterar_email.dart';
import 'package:flutter_doctor/screens/atendimento_page.dart';
import 'package:flutter_doctor/screens/calendar_page.dart';
import 'package:flutter_doctor/screens/descontinuado/auth_page.dart';
import 'package:flutter_doctor/screens/descontinuado/calendar_app.dart';
import 'package:flutter_doctor/screens/esqueci_senha_page.dart';
import 'package:flutter_doctor/screens/login_auth.dart';
import 'package:flutter_doctor/screens/perfil_page.dart';
import 'package:flutter_doctor/utils/config.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  //this push navigator
  static final navigatorKey = GlobalKey<NavigatorState>();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Fluter Doctor Demo',
      theme: ThemeData(       
       inputDecorationTheme: const InputDecorationTheme(
        focusColor: Config.primaryColor,
        border: Config.outlineBorder,
        focusedBorder: Config.fucusBorder,
        errorBorder: Config.errorBorder,
        enabledBorder: Config.outlineBorder,
        floatingLabelStyle: TextStyle(color: Config.primaryColor),
        prefixIconColor: Colors.black38,
       ),
       scaffoldBackgroundColor: Colors.white,
       bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Config.primaryColor,
        selectedItemColor: Colors.white,
        showSelectedLabels: true,
        showUnselectedLabels: false,
        unselectedItemColor: Colors.grey.shade700,
        elevation: 10,
        type: BottomNavigationBarType.fixed
        )
      ),
      initialRoute: AuthPage.routName,
      getPages: [
        GetPage(name: '/', page: () => const  LoginPage()),
        GetPage(name:  MainLayout.routName, page: () =>const  MainLayout()),
        GetPage(name: AtendimentoPage.routName, page: () => const AtendimentoPage()),
        GetPage(name: TableCalendarPage.routName, page:() => const TableCalendarPage()),
        GetPage(name: CalendarApp.routNamd, page: () => const CalendarApp(),),
        GetPage(name: RecuperarSenha.routNamed, page: () => RecuperarSenha()),
        GetPage(name: Perfil.routNamed, page: () =>  Perfil()),
        GetPage(name: AlterarEmail.rounNamed, page: () => const AtendimentoPage(),)        
      ],   
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: [
        const Locale('pt', 'BR')
      ],  
    );
  }
}


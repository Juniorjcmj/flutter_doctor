// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_doctor/modulos/consulta/screens/consulta_form.dart';
import 'package:flutter_doctor/modulos/especialista/screens/especialista_form.dart';
import 'package:flutter_doctor/modulos/paciente/screens/paciente_form.dart';
import 'package:flutter_doctor/modulos/procedimento/screens/procedimento_form.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get/get.dart';

import 'package:flutter_doctor/main_layout.dart';
import 'package:flutter_doctor/modulos/auth/screens/alterar_email.dart';
import 'package:flutter_doctor/modulos/consulta/screens/atendimento_page.dart';
import 'package:flutter_doctor/modulos/consulta/screens/calendar_page.dart';
import 'package:flutter_doctor/modulos/descontinuado/calendar_app.dart';
import 'package:flutter_doctor/modulos/auth/screens/esqueci_senha_page.dart';
import 'package:flutter_doctor/modulos/auth/screens/login_auth.dart';
import 'package:flutter_doctor/modulos/perfil/perfil_page.dart';
import 'package:flutter_doctor/shared/util/config.dart';

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
        // ignore: prefer_const_constructors
        datePickerTheme:  DatePickerThemeData(
          backgroundColor: Colors.white,         
        ), 
        timePickerTheme: const TimePickerThemeData(
        backgroundColor: Colors.white, // Cor de fundo do seletor de tempo
       // Cor do texto AM/PM
        // Peso da fonte do AM/PM
      ),    
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
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => const  LoginPage()),
        GetPage(name:  MainLayout.routName, page: () =>const  MainLayout()),
        GetPage(name: AtendimentoPage.routName, page: () => const AtendimentoPage()),
        GetPage(name: TableCalendarPage.routName, page:() => const TableCalendarPage()),
        GetPage(name: CalendarApp.routNamd, page: () => const CalendarApp(),),
        GetPage(name: RecuperarSenha.routNamed, page: () => RecuperarSenha()),
        GetPage(name: Perfil.routNamed, page: () =>  const Perfil()),
        GetPage(name: AlterarEmail.rounNamed, page: () => const AtendimentoPage(),),
        GetPage(name: PacienteForm.routNamed, page: ()=>  PacienteForm()),
        GetPage(name: EspecialistaForm.routNamed, page: ()=>  EspecialistaForm()),
        GetPage(name: ConsultaForm.routNamed, page: ()=>  ConsultaForm()),
        GetPage(name: ProcedimentoForm.routNamed, page: ()=>  ProcedimentoForm())       
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


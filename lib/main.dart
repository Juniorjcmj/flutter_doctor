import 'package:flutter/material.dart';
import 'package:flutter_doctor/main_layout.dart';
import 'package:flutter_doctor/screens/auth_page.dart';
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
    return MaterialApp(
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
      routes: {
        AuthPage.routName:(context) => const AuthPage(),
        MainLayout.routName:(context) =>const  MainLayout()
      },     
    );
  }
}


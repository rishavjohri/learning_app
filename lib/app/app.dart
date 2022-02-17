
import 'package:flutter/material.dart';
import 'package:learning_app/presentation/resources/routes_manager.dart';
import 'package:learning_app/presentation/resources/theme_manager.dart';
import 'package:learning_app/presentation/resources/assets_manager.dart';

class MyApp extends StatefulWidget {
  // const MyApp({ Key? key }) : super(key: key); // default constructor.
  MyApp._internal(); //private named construtor.
  
  int appState = 0;
  
  static final MyApp instance = MyApp._internal(); // single instance ---> singleton.
  
  factory MyApp() => instance;  //factory for the class instance.
  
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // onGenerateRoute: RouteGenerator.getRoute,
      // initialRoute: Routes.splashRoute,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: Routes.splashRoute,
      theme: getApplicationTheme(),
    );
  }
 }
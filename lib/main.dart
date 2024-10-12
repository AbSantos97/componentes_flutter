import 'package:componentes_basicos/src/screens/counter_screen.dart';
import 'package:componentes_basicos/src/static/static_attributes.dart';
import 'package:flutter/material.dart';

void main(){
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,    
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.yellow.shade400,
          brightness: Brightness.dark,
          background: Colors.white,  
          ),
          tabBarTheme: TabBarTheme(
            
        labelColor: Colors.pink[800],
        labelStyle: TextStyle(color: Colors.pink[800]), // color for text
         indicator:  BoxDecoration(
              color:   Colors.white,
              border: Border.all(width: 1),
              shape: BoxShape.circle,
            ),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: Colors.white,
        headerBackgroundColor: Colors.amber.shade400,
        headerHeadlineStyle: StaticAttributesUtils.estiloTitulos(),
        dividerColor: Colors.black,
        headerHelpStyle:  StaticAttributesUtils.estiloTitulos(),
        headerForegroundColor: Colors.black)
      ),
      home: const CounterScreen()
    );
  }
}
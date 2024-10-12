import 'package:componentes_basicos/src/screens/chat_screen.dart';
import 'package:componentes_basicos/src/screens/home_screen.dart';
import 'package:componentes_basicos/src/screens/profile_screen.dart';
import 'package:componentes_basicos/src/screens/search_screen.dart';
import 'package:componentes_basicos/src/widgets/bottom_tab_custom.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {


  const CounterScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 4,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.amber.shade400,
            centerTitle: true,
            title: const Text('ConectaLabores', textAlign: TextAlign.end, style: TextStyle(color: Colors.black87),),
          ),
          body: const TabBarView(
            children: [
              HomeScreen(),
              SearchScreen(),
              ChatScreen(),
              ProfileScreen()
            ],
          ),
          bottomNavigationBar: const CustomBottomNavigator(),
        ),
      );
  }

  void pressButton(){

  }
}
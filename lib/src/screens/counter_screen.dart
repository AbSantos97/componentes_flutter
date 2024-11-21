import 'package:componentes_basicos/src/screens/chat_screen.dart';
import 'package:componentes_basicos/src/screens/home_screen.dart';
import 'package:componentes_basicos/src/screens/profile_screen.dart';
import 'package:componentes_basicos/src/widgets/bottom_tab_custom.dart';
import 'package:flutter/material.dart';

class CounterScreen extends StatelessWidget {


  const CounterScreen({super.key});

 
  @override
  Widget build(BuildContext context) {
    return  DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
           title: const Text('ConectaLabores', textAlign: TextAlign.end, style: TextStyle(color: Colors.black87)),
          ),
          body: const TabBarView(
            children: [
              HomeScreen(),
              ChatScreen(),
              ProfileScreen()
            ],
          ),
          bottomNavigationBar: const CustomBottomNavigator(),
          floatingActionButton: FloatingActionButton(onPressed: () => _botonBusqueda(context),
          backgroundColor: Colors.amber.shade400,
          elevation: 2.0,
          tooltip: "Buscar oficios",
          child: const Icon(Icons.search),
          ),
        ),
      );
  }

  void _botonBusqueda(BuildContext context){
    Navigator.pushNamed(context, "/pagina_busqueda");
  }

  void pressButton(){

  }
}
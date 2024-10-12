import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatelessWidget {
  const CustomBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return  ColoredBox(
      color: Colors.amber.shade400,
      child: const TabBar(
                tabs: [
                  Tab(icon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Icon(
                      Icons.home,color: Colors.black)
                      )
                    ),
                  Tab(icon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Icon(
                      Icons.search,color: Colors.black)
                      )
                    ),
                    Tab(icon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Icon(
                      Icons.chat,color: Colors.black)
                      ),
                    ),
                  Tab(icon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Icon(
                      Icons.perm_contact_calendar,color: Colors.black)
                      )
                    )
                ],
              ),
    );
  }

  void pressButton(){

  }
}
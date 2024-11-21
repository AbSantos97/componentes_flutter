import 'package:flutter/material.dart';

class CustomBottomNavigator extends StatelessWidget {
  const CustomBottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    return  ColoredBox(
      color: Colors.amber.shade400,
      child: TabBar(
                tabs: [
                  const Tab(icon: Padding(
                    padding: EdgeInsets.all(10.0),
                    child:Icon(
                      Icons.home,color: Colors.black)
                      )
                    ),
                    Tab(icon: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child:Badge.count(count: 6,
                      child:const Icon(
                        Icons.chat,color: Colors.black),
                    )
                      ),
                    ),
                  const Tab(icon: Padding(
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